---
title: "Lessons Learned — PowerShell 5.1 + Markdown + Emoji"
date: 2026-06-17
tags:
  - aws
  - resource/reference
  - topic/engineering
  - topic/lessons-learned
---

# 踩坑记录：PowerShell 5.1 与 Markdown/Emoji 编码

> 本文件记录在 AWS SAP-C02 学习材料项目中遇到的编码问题、根因和解决方案。
> **目标：下次不再踩同样的坑。**

---

## 🕳️ 坑 #1：`WriteAllText` 写入 emoji 导致乱码

### 现象
- 文件中的 emoji（📝🎤🟢🟡🔴📖📋🔀🗺️）变成 CJK 乱码字符（馃帳、馃煛 等）
- 影响范围：EN 教材 + 14 个练习文件 + 210 个错题文件

### 根因
```powershell
# ❌ 错误写法 — emoji 会损坏
[System.IO.File]::WriteAllText($path, $content, [System.Text.UTF8Encoding]::new($false))
```
- `UTF8Encoding($false)` = 不写入 BOM
- PowerShell 5.1 在字符串→字节转换时，4 字节 UTF-8 emoji 被错误编码
- 读回时变成 U+FFFD（Unicode 替换字符）或 CJK 汉字

### 解决
```powershell
# ✅ 正确写法 — 写入 BOM
[System.IO.File]::WriteAllText($path, $content, [System.Text.UTF8Encoding]::new($true))
```
或使用 `Out-File -Encoding utf8BOM`

### 教训
> **永远用 `UTF8Encoding($true)` 写文件。** `$false`（无 BOM）在 PS 5.1 下会损坏 4 字节 UTF-8 字符。

---

## 🕳️ 坑 #2：字节级替换导致文件尾部被 null 覆盖

### 现象
- 对 EN 教材做 `### ? Appending` → `### 📝 Appending` 替换
- 目标数组长度计算错误，`Array.Copy` 写入越界
- 文件尾部出现大量 `0x00` null 字节，内容永久丢失

### 根因
```powershell
# ❌ 危险操作 — 手写字节数组拷贝极易出错
$nb = [byte[]]::new($b.Length + 2)  # 长度算错
[Array]::Copy($b, 0, $nb, 0, $pos)
[Array]::Copy($newH, 0, $nb, $pos, $newH.Length)
[Array]::Copy($b, $pos+$oldH.Length, $nb, $pos+$newH.Length, $b.Length-$pos-$oldH.Length)  # 长度算错
```

### 解决
```powershell
# ✅ 安全操作 — 永远用 replace_string_in_file
# 让工具处理字节编码，不要手工操作
```
或使用 `File.ReadAllBytes` + PS 字符串替换 + `File.WriteAllBytes` 的完整流程（需仔细验证数组长度）。

### 教训
> **绝对不要手工操作字节数组做字符串替换。** 用 `replace_string_in_file` / `multi_replace_string_in_file` 是唯一安全的方式。如果必须字节操作，需在副本上充分验证。

---

## 🕳️ 坑 #3：`replace_string_in_file` 的 `oldString` 必须完全精确

### 现象
- 替换失败，提示 "Could not find matching text to replace"
- 原因：目标文本中的不可见字符（零宽空格、变体选择器 U+FE0F、不同换行符）不在 oldString 中

### 根因
- 肉眼看起来相同的文本，实际包含不同的 Unicode 组合
- 例如：`🗺️` = U+1F5FA + U+FE0F（2 个码点），但显示为一个字符
- 文件可能混合 CRLF/LF 换行

### 解决
1. 用 `read_file` 读取精确内容（包含 3-5 行上下文）
2. 直接复制粘贴到 `oldString`
3. 不要手动输入 emoji——从源文件复制

### 教训
> **oldString 必须从源文件逐字复制，包含所有不可见字符。** 永远用 `read_file` 获取上下文，手动输入极易失败。

---

## 🕳️ 坑 #4：PowerShell 5.1 不支持 `??` null 合并运算符

### 现象
- 脚本报错：`??` 被解析为语法错误
- 影响脚本：`fix-answer-keys.ps1`、`fix-answers-v2.ps1`、`rebalance-answers.ps1`

### 根因
- `??` 是 PowerShell 7+ 的特性
- Windows 默认安装 PowerShell 5.1

### 解决
```powershell
# ❌ PS 7+ only
$value = $hash[$key] ?? 0

# ✅ PS 5.1 compatible
$value = if ($hash[$key]) { $hash[$key] } else { 0 }
```

### 教训
> **永远以 PS 5.1 为目标编写脚本。** 不要使用 `??`、`?.`、三元运算符等 PS 7+ 特性。验证脚本时用 `$PSVersionTable.PSVersion` 检查版本。

---

## 🕳️ 坑 #5：`Get-Content -Raw` 和 `-TotalCount` / `-First` 不兼容

### 现象
```powershell
# ❌ 不能同时使用
Get-Content $file -Raw -Encoding UTF8 -First 1
Get-Content $file -Raw -Encoding UTF8 -TotalCount 1
# 报错: 不能在同一命令中指定"Raw"和"TotalCount"参数
```

### 解决
```powershell
# ✅ 只读第一行
Get-Content $file -Encoding UTF8 -TotalCount 1

# ✅ 读全文
Get-Content $file -Raw -Encoding UTF8
```

---

## 🕳️ 坑 #6：Mock 试卷答案 B-bias

### 现象
- Mock A: B 占 57%，Mock B: B 占 71%
- 原因：写题时下意识把正确答案放在 B 位置

### 解决
- 写题前用骰子决定正确答案位置（1=A, 2=B, 3=C, 4=D）
- Mock C 用预先分配位置法构建，从源头平衡
- Mock A/B 通过 `multi_replace_string_in_file` 手工交换选项字母

### 教训
> **写题时必须随机化正确答案位置。** 事后修正极其耗时（Mock B 花了 22 道题的交换操作）。

---

## 🕳️ 坑 #7：Obsidian `graph.json` 颜色分组配置

### 现象
- Graph View 中节点全灰，无颜色分组
- 原因：`graph.json` 的 `colorGroups` 为空

### 解决
```json
{
  "colorGroups": [
    { "query": "tag:#domain/org-complexity", "color": { "a": 1, "rgb": 14739712 } },
    { "query": "tag:#domain/new-solutions", "color": { "a": 1, "rgb": 4550508 } }
  ]
}
```

### 教训
> `graph.json` 的 `query` 字段支持 `tag:#tagname` 语法，不是文件名匹配。颜色用十进制 RGB 值。

---

## 🕳️ 坑 #8：Git Push 代理 127.0.0.1:7892 不稳定

### 现象
- `git push` 失败：`Failed to connect to 127.0.0.1 port 7892`
- Commit 成功，Push 失败

### 解决
- commit 保存在本地，代理恢复后 push
- 可用 `git log --oneline origin/master..HEAD` 查看未推送的 commits

### 教训
> **始终先 commit，push 是附加操作。** 不要等 push 成功才认为工作完成。本地 commits 已经保护了你的工作。

---

## 📋 安全操作清单

| 操作 | ✅ 安全方式 | ❌ 危险方式 |
|------|------------|------------|
| 替换文件内容 | `replace_string_in_file` | 字节数组拷贝 |
| 批量替换 | `multi_replace_string_in_file` | 循环 `WriteAllBytes` |
| 写新文件 | `create_file` | 字节操作 |
| 写含 emoji 的文件 | `WriteAllText($path, $str, UTF8Encoding($true))` | `UTF8Encoding($false)` |
| 读取文件 | `Get-Content -Raw -Encoding UTF8` 或 `read_file` | 二进制读 + 手动解码 |
| PS 脚本兼容性 | 只用 PS 5.1 语法 | `??`、`?.`、三元运算符 |
| 验证修复 | `Select-String` / `grep_search` / 字节扫描 | 盲目相信 |
| Emoji 在脚本中 | 从源文件复制粘贴 | 手动输入 |

---

## 📊 本次会话统计

| 指标 | 数值 |
|------|:--:|
| 修复的 encoding issues | ~3,500+ |
| Git commits | 8 |
| 损坏回滚 | 1（EN 教材字节溢出） |
| 脚本重写 | 4（因 PS 5.1 兼容性） |
| 新增参考文档 | 4 |
| 总耗时 | ~6 hours |
