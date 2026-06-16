# CHANGELOG — AWS SAP-C02 Learning Material

> EN 教材更新记录。CN 同步时以此文件为差异依据。
> 格式遵循 [Keep a Changelog](https://keepachangelog.com/) 原则。

---

## 2026-06-17 — Phase 2: Mock Exams & Quality Improvements

### 新增
- **Mock Exam A/B/C**（3 × 50 题 = 150 题）：模拟真实 SAP-C02 考试
  - Mock A：基础卷，覆盖所有 4 个域，45 题计分
  - Mock B：Networking & Security 重点卷，49 题计分
  - Mock C：冲刺卷（最难），跨域整合 + Choose Two/Three + 反模式陷阱，40 题计分
  - 答案分布已平衡：A/B/C/D 各约占 25%
- **Exam-Tactics.md**：考试策略指南（关键词→服务映射、排除法、Choose Two 决策树）
- **Interview-Quick-Reference.md**：100+ 面试题（按 🎤 频率三级分类，附一句话回答）
- **4 个自动化脚本**：扫描、标签、YAML 同步、Q Ref 一致性检查

### 变更
- **练习题为标签打标**：全部 211 道练习题标注 difficulty（🟢🟡🔴）和 interview relevance（🎤）标签
- **README.md** 统计更新：当前 266 文件、211 练习题、150 Mock 题、3 套 Mock 试卷
- **Mock Exam 答案分布修复**：原 B-bias（Mock A: B=57%, Mock B: B=71%）→ 平衡 ~25% each

### 技术说明
- PowerShell 5.1 编码问题导致脚本修复 Mock 答案分布失败，改为手动 + multi_replace 方式
- 写题教训：必须先随机化正确答案位置（骰子 1-4 → A/B/C/D），再写选项内容

---

## 2026-06-16 — Phase 1 Completion (Baseline)

### EN 教材变更
- **全量更新**：整合 79 个新增错题文件（#132–#300）
- **Ch 00 Cross-Cutting**：新增 7 个 Q Refs（#132, #133, #196, #206, #209, #234, #247）
  - 新增知识点：RPO/RTO→Solution Mapping, DRS vs DLM vs AWS Backup, Savings Plans Decision Matrix, WAF+API Gateway+Shield, Global Accelerator static IP+WAF
- **Ch 01 Compute**：新增 8 个 Q Refs（#195, #204, #209, #225, #233, #273, #275, #298）
  - 新增知识点：Placement Group capacity fix, Attribute-Based Instance Selection, EB Blue/Green CNAME swap
- **Ch 02 Containers**：新增 2 个 Q Refs（#175, #179）
  - 新增知识点：ECR Enhanced Scanning + Inspector automation, EKS+EFS stateful workloads
- **Ch 03 Storage**：新增 6 个 Q Refs（#153, #246, #253, #277, #279, #296）
  - 新增知识点：S3 RTC, S3 Transfer Acceleration+Multipart, EBS default encryption, DLM cross-region, FSx HDD→SSD migration
- **Ch 04 Database**：新增 11 个 Q Refs（#158, #161, #180, #199, #213, #222, #227, #236, #243, #251, #260）
  - 新增知识点：Aurora Write Forwarding, Babelfish detail, DAX vs ElastiCache, Redshift Concurrency Scaling vs Elastic Resize, DMS CDC to S3
- **Ch 05 Networking**：新增 14 个 Q Refs（#132, #135, #143, #152, #162, #206, #217, #218, #235, #250, #255, #276, #287, #291）
  - 新增知识点：IPv6+Egress-Only IGW, API Gateway HTTP+SQS, CloudFront Origin Group failover, Cross-Region PrivateLink, TGW segmentation
- **Ch 06 Security**：新增 12 个 Q Refs（#136, #146, #148, #160, #163, #164, #196, #224, #232, #254, #267, #271, #278）
  - 新增知识点：Access Analyzer+EventBridge, IAM Deny without Organizations, Secrets Manager SSH key rotation, Control Tower+Identity Center
- **Ch 07 Integration**：新增 4 个 Q Refs（#131, #142, #212, #223）
  - 新增知识点：EventBridge pattern matching for microservices, AppSync WebSocket
- **Ch 08 Management**：新增 9 个 Q Refs（#172, #210, #232, #245, #250, #252, #262, #266, #286, #290）
  - 新增知识点：CF Custom Resources, Session Manager+IAM Identity Center, Service Catalog proactive governance
- **Ch 09 Migration**：新增 8 个 Q Refs（#137, #158, #161, #180, #201, #230, #264, #285）
  - 新增知识点：DataSync+EFS+DC, Transfer Family+EFS HA, Migration Evaluator+ADS synergy
- **Ch 10 Analytics**：新增 2 个 Q Refs（#205, #243）
  - 新增知识点：EMR Spot for transient clusters
- **Ch 12 DevTools**：新增 3 个 Q Refs（#134, #208, #225）
  - 新增知识点：CodeCommit cross-Region backup via CodeBuild
- **Ch 13 EUC**：新增 5 个 Q Refs（#149, #153, #219, #259, #295）
  - 新增知识点：Outposts+Snowball Edge hybrid, AppStream legacy .NET migration, Directory Service types
- **Ch 11 ML**：无新增文件

### CN 教材变更
- 与 EN 教材完全同步（14 个章节）
- 技术术语（AWS 服务名、指标名、CLI 命令）保留英文

### 练习文件变更
- **Ch 00**：新增 4 题（Q0.17–Q0.20），20 题（+4）
- **Ch 01**：新增 3 题（Q1.23–Q1.25），25 题（+3）
- **Ch 04**：新增 2 题（Q4.23–Q4.24），24 题（+2）
- **Ch 05**：新增 2 题（Q5.27–Q5.28），28 题（+2）
- **Ch 02, 03, 06–13**：题目数不变

### 元数据变更
- YAML 前端元数据：`total_files: 187 → 266`, `updated: 2026-06-16`
- README.md：中英文统计已更新
- Study Progress Tracker：EN+CN 已更新

### 验证结果
- Phase 15 时效性审计：无过时内容（Launch Configuration→Launch Templates, OAI→OAC, CloudEndure→MGN 均已正确标注）
- 全部练习文件 YAML 计数与实际题目数一致（211 题总计）
- Q#276（Cross-Region PrivateLink）已补全

---

## [模板] YYYY-MM-DD — 简要描述

### EN 教材变更
#### Ch XX: 章节名
- 新增 Q#XXX：{一句话知识点描述}
- 更新 Q Refs：追加 #XXX, #XXX

### CN 教材变更
- 同上，基于 EN CHANGELOG 同步

### 练习文件变更
- Ch XX：新增 QX.XX（{difficulty}）：{一句话描述}

### 元数据变更
- {如有}
