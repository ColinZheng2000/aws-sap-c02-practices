---
title: "AWS SAP-C02 Task Statement Mapping"
description: "Official SAP-C02 exam guide tasks mapped to textbook chapters and practice questions"
tags: [sap-c02, task-statement, exam-guide, mapping]
created: 2026-06-17
---

# SAP-C02 Task Statement → 教材映射

> 将 AWS 官方 SAP-C02 考试指南的 Task Statements 映射到本仓库教材章节和练习题。
> 资料来源：[AWS SAP-C02 Exam Guide](https://d1.awsstatic.com/training-and-certification/docs-sa-pro/AWS-Certified-Solutions-Architect-Professional_Exam-Guide.pdf)

---

## Domain 1: Design Solutions for Organizational Complexity (26%)

| Task Statement | 教材章节 | 练习题 | 关键 AWS 服务 |
|---|---|---|---|
| 1.1 Design multi-account governance | Ch 00 Cross-Cutting | Ch 00 Q1-Q8 | Organizations, SCP, Control Tower, RAM |
| 1.2 Design identity and access management | Ch 06 Security | Ch 06 Q1-Q6 | IAM, Identity Center, AD Connector, permission boundaries |
| 1.3 Design federated access | Ch 06 Security | Ch 06 Q7-Q12 | IAM Identity Center, SAML, Cognito, AD Connector |
| 1.4 Design centralized logging and auditing | Ch 08 Management | Ch 08 Q1-Q5 | CloudTrail, Config, Organization Trail, Audit Manager |
| 1.5 Design cross-account networking | Ch 05 Networking | Ch 05 Q1-Q8 | TGW, PrivateLink, VPC Peering, RAM, Cloud WAN |
| 1.6 Design cost allocation and reporting | Ch 00 Cross-Cutting | Ch 00 Q9-Q14 | Cost Explorer, Budgets, Tag Policies, CUR |
| 1.7 Design security guardrails at scale | Ch 06 Security | Ch 06 Q13-Q18 | SCP, Config rules, Security Hub, GuardDuty |

---

## Domain 2: Design for New Solutions (29%)

| Task Statement | 教材章节 | 练习题 | 关键 AWS 服务 |
|---|---|---|---|
| 2.1 Design compute solutions | Ch 01 Compute | Ch 01 Q1-Q10 | EC2, Lambda, ASG, Placement Groups, Compute Optimizer |
| 2.2 Design container solutions | Ch 02 Containers | Ch 02 Q1-Q10 | ECS, EKS, Fargate, ECR, App Mesh |
| 2.3 Design storage solutions | Ch 03 Storage | Ch 03 Q1-Q18 | S3, EBS, EFS, FSx, Storage Gateway, Backup |
| 2.4 Design database solutions | Ch 04 Database | Ch 04 Q1-Q24 | RDS, Aurora, DynamoDB, ElastiCache, Redshift, DMS |
| 2.5 Design networking solutions | Ch 05 Networking | Ch 05 Q9-Q20 | VPC, TGW, DX, VPN, Route53, GWLB, PrivateLink |
| 2.6 Design serverless solutions | Ch 01 Compute + Ch 07 Integration | Ch 01 Q11-Q20 | Lambda, Step Functions, API GW, AppSync, EventBridge |
| 2.7 Design high-performing architectures | Ch 00 Cross-Cutting | Ch 00 Q15-Q20 | CloudFront, Global Accelerator, ElastiCache, DAX |

---

## Domain 3: Continuous Improvement for Existing Solutions (25%)

| Task Statement | 教材章节 | 练习题 | 关键 AWS 服务 |
|---|---|---|---|
| 3.1 Design monitoring and alerting | Ch 08 Management | Ch 08 Q6-Q10 | CloudWatch, X-Ray, Config, Health, Trusted Advisor |
| 3.2 Design highly available solutions | Ch 00 Cross-Cutting + Ch 01 | Ch 01 Q21-Q25 | Multi-AZ, Auto Scaling, Route53 failover, DRS |
| 3.3 Design disaster recovery solutions | Ch 00 Cross-Cutting | Mock A Q24, Mock B Q32 | DRS, AWS Backup, Aurora Global DB, CloudEndure |
| 3.4 Design backup and restore solutions | Ch 03 Storage + Ch 04 DB | Ch 03 Q13-Q18 | AWS Backup, DLM, S3 replication, RDS automated backups |
| 3.5 Design cost-optimized solutions | Ch 00 Cross-Cutting | Ch 00 Q9-Q14 | Savings Plans, Spot, S3 Intelligent-Tiering, Compute Optimizer |
| 3.6 Troubleshoot and optimize | Ch 08 Management | Ch 08 Q11-Q14 | CloudWatch Logs Insights, X-Ray, VPC Flow Logs |

---

## Domain 4: Accelerate Workload Migration and Modernization (20%)

| Task Statement | 教材章节 | 练习题 | 关键 AWS 服务 |
|---|---|---|---|
| 4.1 Select migration strategy (7 Rs) | Ch 09 Migration | Ch 09 Q1-Q5 | MGN, DMS, DataSync, Snow Family, Migration Hub |
| 4.2 Design application migration | Ch 09 Migration | Ch 09 Q6-Q10 | MGN, VM Import, ADS, Migration Evaluator |
| 4.3 Design data migration | Ch 09 Migration + Ch 03 | Ch 09 Q11-Q14 | DMS, SCT, DataSync, Snow Family, Transfer Family |
| 4.4 Design hybrid/edge solutions | Ch 13 EUC + Ch 01 | Ch 13 Q1-Q7 | Outposts, Snow Family, Local Zones, Wavelength, IoT |
| 4.5 Modernize legacy applications | Ch 09 Migration + Ch 02 | Ch 09 Q6-Q14 | AppStream 2.0, ECS/EKS, Babelfish, SCT, Transfer Family |

---

## Cross-Domain Topics (Appear in 2+ Domains)

| Topic | Domain 1 | Domain 2 | Domain 3 | Domain 4 |
|---|---|---|---|---|
| Organizations / SCP | ✅ 1.1, 1.7 | — | — | — |
| IAM / Identity Center | ✅ 1.2, 1.3 | — | — | — |
| Networking (VPC, TGW, DX) | ✅ 1.5 | ✅ 2.5 | — | — |
| Security (Config, GuardDuty) | ✅ 1.7 | — | ✅ 3.1 | — |
| Cost Optimization | ✅ 1.6 | — | ✅ 3.5 | — |
| Serverless (Lambda, Step Functions) | — | ✅ 2.6 | — | ✅ 4.5 |
| Database (RDS, Aurora, DynamoDB) | — | ✅ 2.4 | ✅ 3.3, 3.4 | ✅ 4.3 |
| Disaster Recovery / Backup | — | — | ✅ 3.3, 3.4 | — |
| Migration (DMS, MGN, Snow) | — | — | — | ✅ 4.1-4.5 |

---

## Study Priority Matrix

> 根据 Domain 权重 × 练习题数量交叉分析，优先复习高密度区域。

| 优先级 | Domain | 练习题数 | Mock 题数 | 建议 |
|---|---|---|---|---|
| 🔴 P0 | Domain 2 (New Solutions) | ~90 Qs | ~25 Qs | 权重最高(29%)，题量最大 |
| 🔴 P0 | Domain 1 (Org Complexity) | ~45 Qs | ~15 Qs | 权重高(26%)，SCP/Org 陷阱多 |
| 🟡 P1 | Domain 3 (Continuous Improvement) | ~40 Qs | ~10 Qs | 权重高(25%)，DR/monitoring 重点 |
| 🟢 P2 | Domain 4 (Migration) | ~36 Qs | ~10 Qs | 权重较低(20%)，但 7 Rs 常考 |
