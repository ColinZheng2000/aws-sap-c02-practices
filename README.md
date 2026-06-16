# AWS SAP-C02 Exam Preparation Toolkit

[English](#english) | [中文](#chinese)

---

<h2 id="english">🇬🇧 English</h2>

## What Is This Repository?

A comprehensive, self-built study toolkit for the **AWS Certified Solutions Architect – Professional (SAP-C02)** exam. This repository contains everything you need to systematically prepare, practice, and track your progress toward certification.

> **Target**: Medical / Industrial industry professionals  
> **Background**: Azure Cloud Operations Engineer (3yr), experienced in Azure DevOps Pipelines & Releases  
> **Status**: Active study — new practice questions and missed-question analyses are continuously added

---

## Repository Structure

```
aws-sap-c02-practices/
├── README.md                                    ← You are here
├── AWS-SAP-C02-Learning-Material.md             ← 📖 Customized textbook (English)
├── AWS-SAP-C02-Learning-Material-CN.md          ← 📖 Customized textbook (Chinese)
├── .github/agents/
│   └── aws-sap-c02-tutor.agent.md              ← 🤖 Custom VS Code Copilot agent
├── practice/
│   ├── Practice-Ch-00-CrossCutting.md           ← 20 questions (🟢🟡🔴 labeled)
│   ├── Practice-Ch-01-Compute.md                ← 25 questions
│   ├── Practice-Ch-02-Containers.md             ← 10 questions
│   ├── Practice-Ch-03-Storage.md                ← 18 questions
│   ├── Practice-Ch-04-Database.md               ← 24 questions
│   ├── Practice-Ch-05-Networking.md             ← 28 questions
│   ├── Practice-Ch-06-Security.md               ← 18 questions
│   ├── Practice-Ch-07-Integration.md            ← 12 questions
│   ├── Practice-Ch-08-Management.md             ← 14 questions
│   ├── Practice-Ch-09-Migration.md              ← 14 questions
│   ├── Practice-Ch-10-Analytics.md              ← 9 questions
│   ├── Practice-Ch-11-MachineLearning.md        ← 5 questions
│   ├── Practice-Ch-12-DevTools.md               ← 7 questions
│   ├── Practice-Ch-13-EUC.md                    ← 7 questions
│   ├── Mock-Exam-A.md                           ← 🧪 50 Qs (balanced A/B/C/D ~25%)
│   ├── Mock-Exam-B.md                           ← 🧪 50 Qs (Networking+Security focus)
│   └── Mock-Exam-C.md                           ← 🧪 50 Qs (Hard: cross-domain traps)
├── Interview-Quick-Reference.md                 ← 🎤 100+ interview topics by frequency
├── Exam-Tactics.md                              ← 🎯 Keyword→service, exclusion rules, traps
├── Architecture-Decision-Trees.md               ← 🔀 Mermaid decision flowcharts (8 trees)
├── Task-Statement-Mapping.md                    ← 🗺️ Official exam guide → chapter mapping
├── New-AWS-Services-2025-2026.md                ← 🆕 New services with SAP-C02 relevance
├── scripts/
│   ├── scan-new-questions.ps1                   ← Scan wrong-answer .md files
│   ├── sync-yaml-counts.ps1                     ← Auto-sync YAML question counts
│   ├── label-practice-questions.ps1             ← Batch-label difficulty+interview tags
│   ├── check-qref-consistency.ps1               ← Verify textbook Q Ref citations
│   └── README.md                                ← Script usage documentation
├── 1.md ~ 300.md                                ← 📝 Wrong-answer collection (~266 files)
└── 999. AI Prompt.md                           ← 📋 Prompt template for question analysis
```

| Directory / File | Description |
|---|---|
| `AWS-SAP-C02-Learning-Material.md` | **Customized textbook (EN)** — 13 service domains, 80+ AWS services, Azure-equivalent mappings, 12 "Similar Service Comparison" sections for common exam traps. Generated from the author's personal wrong-answer collection. |
| `AWS-SAP-C02-Learning-Material-CN.md` | **Customized textbook (中文)** — Same content as above, fully translated to Chinese. Technical terms (AWS services, CLI commands, Azure names) kept in English. |
| `practice/` | **Chapter practice + Mock exams** — 14 chapter files (211 questions) + 3 mock exams (150 questions). Questions labeled with difficulty (🟢🟡🔴) and interview relevance (🎤). Mock exams have balanced answer distribution (A/B/C/D ~25% each). |
| `practice/Mock-Exam-A/B/C.md` | **Full mock exams** — 50 questions each, 120 min. Mock C is the hardest (cross-domain integration, Choose Two/Three, anti-pattern traps). |
| `Interview-Quick-Reference.md` | **Interview prep** — 100+ topics organized by frequency (🎤🎤🎤 high / 🎤🎤 medium / 🎤 low). One-sentence answers + common confusion columns. |
| `Exam-Tactics.md` | **Exam strategy guide** — Keyword→service mapping, exclusion rules, Choose Two patterns, decision trees, number quick-reference. |
| `Architecture-Decision-Trees.md` | **Mermaid决策树** — 8 visual decision flowcharts for common SAP-C02 architecture choices (Compute, Messaging, DB, Storage, Networking, DR, Auth, Migration). |
| `Task-Statement-Mapping.md` | **考纲映射表** — Official SAP-C02 Task Statements mapped to textbook chapters + practice questions + key services. Includes study priority matrix. |
| `New-AWS-Services-2025-2026.md` | **新服务速查** — 2025-2026 new AWS services ranked by SAP-C02 exam relevance (🔴 likely / 🟡 possible / 🟢 unlikely). Includes "old vs new answer" comparison. |
| `.github/agents/` | **VS Code Copilot agent** — "AWS SAP-C02 Tutor" with 📚教材维护模式 for updating textbook from wrong-answer analyses. |
| `scripts/` | **Automation scripts** — 4 PowerShell scripts for scanning, labeling, and validating the repository. See `scripts/README.md`. |
| `1.md ~ 300.md` | **Personal wrong-answer collection** — Detailed analyses: Problem → Services → Correct/Incorrect Options → Knowledge. (~266 files) |
| `999. AI Prompt.md` | **Prompt template** — Standardized format for generating wrong-answer analyses with YAML frontmatter. |

---

## How to Use This Repository

### 1. Read the Textbook
Start with `AWS-SAP-C02-Learning-Material.md` (or the Chinese version). The material is organized by AWS service domain (Compute → Storage → Database → Networking → ...). Each service entry includes:
- 📘 Overview
- 🔄 Azure Equivalent & Bridge (maps to your existing Azure knowledge)
- 📝 Key Exam Facts (distilled from real wrong answers)
- ⚠️ Common Pitfalls
- 🔍 Similar Service Comparison (exam traps)

### 2. Practice After Each Chapter
After reading a textbook section, do the corresponding practice file in `practice/`. Each file has a Part A (questions) and Part B (answers) separated by a clear divider — don't peek at the answers before completing Part A.

### 3. Track Your Progress
Use the **Study Progress Tracker** at the end of the textbook to self-rate your confidence per domain (0/10). Focus your practice on lower-scoring areas.

### 4. Append New Wrong Answers
When you miss a question on an external practice platform:
1. Add the `.md` analysis file to the root folder
2. Update the textbook: add new facts under the relevant service's "Key Exam Facts" and append the question number to "Q Refs"
3. If you discover a new similar-service pair, add it to the Comparison section

### 5. Use the Copilot Agent
Select the **AWS SAP-C02 Tutor** agent in VS Code Copilot. It analyzes questions in the same structured format as your wrong-answer collection and verifies answers against official AWS documentation.

---

## Key Features

| Feature | Description |
|---|---|
| 🧪 **3 Mock Exams** | Full-length mock exams (50 Qs each, 150 total) with balanced A/B/C/D answer distribution. Mock C is the hardest — cross-domain integration, Choose Two/Three emphasis. |
| 🏷️ **Question Labeling** | All 211 practice questions tagged with difficulty level (🟢 L1-Knowledge / 🟡 L2-Understanding / 🔴 L3-Application) and interview relevance (🎤 low/medium/high). |
| 🎯 **Wrong-Answer-Driven** | Every fact in the textbook traces back to a real missed question — not generic exam dump content. Currently 266 analyzed questions across all 4 SAP-C02 exam domains. |
| 🔄 **Azure Bridge** | Every AWS service mapped to its Azure equivalent, with specific notes for Azure DevOps engineers |
| 🔍 **Similar Service Comparison** | 12 dedicated comparison sections covering the most confusing AWS service pairs (e.g., Route 53 Inbound vs Outbound, SQS vs SNS vs EventBridge, ECS vs EKS) |
| 📊 **Progress Tracking** | Domain-by-domain confidence self-rating with question counts |
| 🌐 **Bilingual** | Full textbook available in both English and Chinese |
| 🤖 **AI Tutor Agent** | Custom VS Code Copilot agent for consistent question analysis |
| ➕ **Updatable** | Designed to grow — clear instructions for appending new questions and services |

---

## Exam Coverage

The material and practice questions span all four SAP-C02 exam domains:

| Domain | Weight | Coverage |
|---|---|---|
| **Design Solutions for Organizational Complexity** | ~26% | Multi-account, hybrid DNS, cross-account networking, Organizations/SCP |
| **Design for New Solutions** | ~29% | Compute, storage, database, networking, security, serverless architecture |
| **Continuous Improvement for Existing Solutions** | ~25% | Migration, monitoring, cost optimization, resilience |
| **Accelerate Workload Migration and Modernization** | ~20% | DMS, DataSync, Snow Family, MGN, refactoring strategies |

---

## Requirements

- **Obsidian** (optional): The `.md` files include Obsidian-compatible YAML frontmatter and tags for knowledge graph navigation
- **VS Code + GitHub Copilot**: For using the custom `AWS SAP-C02 Tutor` agent

---

## Disclaimer

This is a personal study repository. The content is generated from the author's own wrong-answer analysis and AWS documentation research. It is not affiliated with or endorsed by Amazon Web Services. Always verify against the official [AWS SAP-C02 Exam Guide](https://aws.amazon.com/certification/certified-solutions-architect-professional/) for the most current exam requirements.

---

## License

MIT — Feel free to use, adapt, and share for your own study purposes.

---

<h2 id="chinese">🇨🇳 中文</h2>

## 这是什么仓库？

一个全面、自主构建的 **AWS Certified Solutions Architect – Professional (SAP-C02)** 考试备考工具包。此仓库包含系统化准备、练习和跟踪认证进度所需的一切。

> **目标行业**：医疗 / 工业  
> **背景**：Azure 云运维工程师（3年），熟悉 Azure DevOps Pipelines 与 Releases  
> **状态**：持续学习中 —— 新的练习题和错题分析会不断添加

---

## 仓库结构

```
aws-sap-c02-practices/
├── README.md                                    ← 你在这里
├── AWS-SAP-C02-Learning-Material.md             ← 📖 定制化教材（英文）
├── AWS-SAP-C02-Learning-Material-CN.md          ← 📖 定制化教材（中文）
├── .github/agents/
│   └── aws-sap-c02-tutor.agent.md              ← 🤖 自定义 VS Code Copilot 智能体
├── practice/
│   ├── Practice-Ch-00-CrossCutting.md           ← 20 题（跨领域概念）
│   ├── Practice-Ch-01-Compute.md                ← 25 题（计算）
│   ├── Practice-Ch-02-Containers.md             ← 10 题（容器）
│   ├── Practice-Ch-03-Storage.md                ← 18 题（存储）
│   ├── Practice-Ch-04-Database.md               ← 26 题（数据库）
│   ├── Practice-Ch-05-Networking.md             ← 30 题（网络）
│   ├── Practice-Ch-06-Security.md               ← 22 题（安全）
│   ├── Practice-Ch-07-Integration.md            ← 12 题（应用集成）
│   ├── Practice-Ch-08-Management.md             ← 14 题（管理与治理）
│   ├── Practice-Ch-09-Migration.md              ← 14 题（迁移）
│   ├── Practice-Ch-10-Analytics.md              ← 9 题（分析）
│   ├── Practice-Ch-11-MachineLearning.md        ← 5 题（机器学习）
│   ├── Practice-Ch-12-DevTools.md               ← 7 题（开发者工具）
│   └── Practice-Ch-13-EUC.md                    ← 7 题（终端用户计算）
├── 1.md ~ 300.md                                ← 📝 个人错题集（约 266 个文件）
└── 999. AI Prompt.md                           ← 📋 AI 分析题目的提示词模板
```

| 目录 / 文件 | 说明 |
|---|---|
| `AWS-SAP-C02-Learning-Material.md` | **定制化教材（英文）**—— 13 个服务域，80+ 项 AWS 服务，Azure 等价映射，12 个"相似服务辨析"章节应对考试陷阱。基于作者个人错题集生成。 |
| `AWS-SAP-C02-Learning-Material-CN.md` | **定制化教材（中文）**—— 内容同上，全中文翻译。技术术语（AWS 服务名称、CLI 命令、Azure 产品名称）保留英文。 |
| `practice/` | **章节课后习题**—— 14 个文件，约 219 道题，分三个层级：🟢 知识检查、🟡 情景分析、🔴 相似服务辨析。每题含答案和详细解析。 |
| `.github/agents/` | **VS Code Copilot 智能体**——"AWS SAP-C02 Tutor" 自定义智能体，用于分析考试题目并输出结构化答案。 |
| `1.md ~ 300.md` | **个人错题集**—— 原始练习题及详细分析，格式为：问题理解 → 服务解释 → 正确/错误选项分析 → 实战知识。（约 266 个文件，持续增长中） |
| `999. AI Prompt.md` | **提示词模板**，用于生成一致的问题分析格式。 |

---

## 如何使用

### 1. 阅读教材
从 `AWS-SAP-C02-Learning-Material.md`（或中文版）开始。教材按 AWS 服务域组织（计算 → 存储 → 数据库 → 网络 → ...）。每个服务条目包含：
- 📘 概述
- 🔄 Azure 对照（映射到你已有的 Azure 知识）
- 📝 考试关键知识点（来自真实错题提炼）
- ⚠️ 常见误区
- 🔍 相似服务辨析（考试陷阱）

### 2. 每章学完后做练习题
阅读教材某一章节后，在 `practice/` 目录中找到对应的练习文件。每个文件分为 A 部分（题目）和 B 部分（答案与解析），中间有明确的分隔线 —— 做完 A 部分前不要偷看答案。

### 3. 跟踪进度
使用教材末尾的**学习进度跟踪表**，按领域自评自信度（0/10 分），重点练习薄弱环节。

### 4. 追加新错题
在外部练习平台上做错题目后：
1. 将 `.md` 分析文件添加到根目录
2. 更新教材：在对应服务的"考试关键知识点"下添加新知识点，并将题号追加到 "Q Refs"
3. 如果发现新的相似服务对比组合，添加到辨析章节

### 5. 使用 Copilot 智能体
在 VS Code Copilot 中选择 **AWS SAP-C02 Tutor** 智能体。它会以与你错题集相同的结构化格式分析题目，并对照官方 AWS 文档验证答案。

---

## 核心特性

| 特性 | 说明 |
|---|---|
| 🎯 **错题驱动** | 教材中每条知识点都追溯到真实错题 —— 非泛泛的考题收集。目前已分析 266 道题目，覆盖 SAP-C02 全部四个考试领域 |
| 🔄 **Azure 对照** | 每项 AWS 服务都映射到其 Azure 等价服务，特别针对 Azure DevOps 工程师 |
| 🔍 **相似服务辨析** | 12 个专题对比章节，覆盖最易混淆的 AWS 服务组合 |
| 📊 **进度跟踪** | 按领域自评自信度，附题目数量统计 |
| 🌐 **双语支持** | 完整教材提供中英文两个版本 |
| 🤖 **AI 导师智能体** | 自定义 VS Code Copilot 智能体，确保问题分析一致性 |
| ➕ **可持续更新** | 设计为可成长 —— 清晰的追加新题和新服务的指引 |

---

## 考试覆盖范围

教材和练习题涵盖 SAP-C02 考试的全部四个领域：

| 领域 | 权重 | 覆盖内容 |
|---|---|---|
| **设计组织复杂性的解决方案** | ~26% | 多账户、混合 DNS、跨账户网络、Organizations/SCP |
| **设计新解决方案** | ~29% | 计算、存储、数据库、网络、安全、Serverless 架构 |
| **持续改进现有解决方案** | ~25% | 迁移、监控、成本优化、弹性 |
| **加速工作负载迁移和现代化** | ~20% | DMS、DataSync、Snow Family、MGN、重构策略 |

---

## 环境要求

- **Obsidian**（可选）：`.md` 文件包含 Obsidian 兼容的 YAML 前置元数据和标签，可用于知识图谱导航
- **VS Code + GitHub Copilot**：用于使用自定义 `AWS SAP-C02 Tutor` 智能体

---

## 免责声明

这是一个个人学习仓库。内容来自作者自己的错题分析和 AWS 文档研究，与 Amazon Web Services 无关联，也未经其认可。请始终对照官方 [AWS SAP-C02 考试指南](https://aws.amazon.com/certification/certified-solutions-architect-professional/) 获取最新的考试要求。

---

## 许可证

MIT —— 可自由使用、改编和分享用于个人学习目的。
