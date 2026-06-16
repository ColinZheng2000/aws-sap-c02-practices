---
title: "AWS New Services & Features (2025-2026) — SAP-C02 Relevance"
description: "New AWS services and features released since SAP-C02 exam baseline, ranked by exam relevance"
tags: [aws, new-services, sap-c02, 2025, 2026]
created: 2026-06-17
---

# AWS 2025-2026 New Services & SAP-C02 Relevance

> **Context**: SAP-C02 exam launched Nov 2022. AWS releases 100+ features/year.
> This file tracks **exam-relevant** new services that could appear in future exam updates.
> Format: Service → What it is → SAP-C02 angle → 🔴 likely / 🟡 possible / 🟢 unlikely.

---

## 🔴 High Exam Relevance (Likely to Appear)

### 1. Amazon Aurora DSQL
- **What**: Distributed SQL database with active-active multi-Region writes, PostgreSQL-compatible
- **SAP-C02 Angle**: Replace "Aurora Global Database" as the answer for "multi-Region active-active SQL with < 1s latency"
- **Exam Trap**: DSQL vs Aurora Global Database vs DynamoDB Global Tables — DSQL is SQL + multi-writer
- **Related**: Domain 2 (New Solutions), Domain 4 (Migration/Modernization)

### 2. Amazon S3 Tables
- **What**: Apache Iceberg table format in S3, automatic optimization (compaction, snapshot management)
- **SAP-C02 Angle**: Analytics storage choice: S3 Tables vs Redshift vs Athena vs EMR
- **Exam Trap**: "Query S3 data with ACID transactions" → S3 Tables (not just Athena)
- **Related**: Domain 2 (Storage), Domain 3 (Continuous Improvement)

### 3. Amazon SageMaker Lakehouse
- **What**: Unified data and AI platform, combining S3 data lake + SageMaker ML
- **SAP-C02 Angle**: Analytics + ML convergence; simplifies "where to run ML on existing data lake"
- **Exam Trap**: SageMaker Lakehouse vs EMR vs Redshift Spectrum for ML workloads
- **Related**: Domain 2 (New Solutions), Ch 10 Analytics + Ch 11 ML

### 4. Amazon Security Incident Response
- **What**: Automated incident response service integrated with AWS security findings
- **SAP-C02 Angle**: "Detect and respond to security events with minimal ops" → Security Incident Response
- **Exam Trap**: Security Hub + EventBridge (now built-in automated response)
- **Related**: Domain 1 (Org Complexity), Ch 06 Security

---

## 🟡 Moderate Exam Relevance (Possible)

### 5. Amazon Q Developer
- **What**: AI coding assistant for AWS, replaces CodeWhisperer
- **SAP-C02 Angle**: Cost optimization recommendations, code migration assistance
- **Note**: More developer-tool than architecture exam topic

### 6. AWS PrivateLink + Resource Access Manager Integration
- **What**: Cross-account PrivateLink endpoint sharing via RAM
- **SAP-C02 Angle**: Simplifies cross-account service sharing (previously manual)
- **Related**: Domain 1, Ch 05 Networking

### 7. Amazon Bedrock Knowledge Bases & Agents
- **What**: Managed RAG (Retrieval-Augmented Generation) and AI agent orchestration
- **SAP-C02 Angle**: "Build AI chat with company data" → Bedrock Knowledge Bases + S3
- **Exam Trap**: Bedrock vs SageMaker for AI; Bedrock for managed, SageMaker for custom training
- **Related**: Domain 2, Ch 11 ML

### 8. AWS Clean Rooms ML
- **What**: Run ML on shared data without revealing raw data (privacy-preserving ML)
- **SAP-C02 Angle**: "Collaborate on data analytics without sharing underlying data"
- **Related**: Domain 2, Ch 10 Analytics + Ch 11 ML

---

## 🟢 Lower Exam Relevance (Unlikely)

### 9. Amazon Aurora PostgreSQL pgvector
- **What**: Vector embeddings in Aurora PostgreSQL (not new, but enhanced)
- **SAP-C02 Angle**: Niche ML use case; DynamoDB + OpenSearch more common vector answer

### 10. EC2 Trn2 / Inf2 Instances
- **What**: Trainium2 (training) and Inferentia2 (inference) instances
- **SAP-C02 Angle**: "Cost-effective ML inference" → Inf2 instead of GPU
- **Note**: SAP-C02 rarely asks about specific EC2 instance families

### 11. Amazon S3 Metadata Tables
- **What**: Automatically generated metadata tables for S3 objects
- **SAP-C02 Angle**: Simplifies S3 object querying without external catalog

### 12. Amazon MemoryDB Multi-Region
- **What**: Active-active cross-Region Redis-compatible with Multi-Region
- **SAP-C02 Angle**: "Active-active Redis across Regions" → MemoryDB Multi-Region

---

## Quick Update: What Changed vs 2022 Baseline

| 2022 Answer | 2025-2026 Answer | Scenario |
|---|---|---|
| Aurora Global Database | **Aurora DSQL** | Active-active multi-Region SQL with multi-writer |
| S3 + Glue Catalog | **S3 Tables** | Iceberg table format, ACID on S3 |
| SageMaker + S3 | **SageMaker Lakehouse** | Unified lake + ML |
| Security Hub + Lambda | **Security Incident Response** | Automated incident handling |
| S3 + Athena | **S3 Tables + Athena** | Managed Iceberg tables for analytics |

---

## Exam Strategy

1. **If a question seems to have no perfect answer** among traditional services, check if a new 2025-2026 service fits.
2. **The exam is periodically updated**: SAP-C02-C01 (new version) may incorporate these services.
3. **Conservative approach**: Unless you're certain a newer service is on the exam, prefer the established answer. The Well-Architected Framework is more likely to be tested than bleeding-edge features.
4. **When in doubt**: Fall back to the "traditional" answer (e.g., Aurora Global Database over DSQL) — SAP-C02 was designed in 2022.
