---
title: "AWS SAP-C02 Architecture Decision Trees"
description: "Visual decision flowcharts for common SAP-C02 architecture choices"
tags: [architecture, decision-tree, mermaid, sap-c02]
created: 2026-06-17
---

# AWS SAP-C02 Architecture Decision Trees

> Use these flowcharts when faced with "which service to use" questions on the exam.
> Each tree covers the most commonly tested service selection scenarios.

---

## 1. Compute Choice

```mermaid
flowchart TD
    A[Need Compute?] --> B{Long-running?}
    B -->|Yes| C{Stateful or special OS?}
    B -->|No| D{< 15 min runtime?}
    
    C -->|Yes| E[EC2]
    C -->|No| F{Containerized?}
    
    F -->|Yes| G{Manage servers?}
    F -->|No| H[Elastic Beanstalk]
    
    G -->|No| I[ECS Fargate]
    G -->|Yes| J{K8s required?}
    J -->|Yes| K[EKS]
    J -->|No| L[ECS on EC2]
    
    D -->|Yes| M[Lambda]
    D -->|No| N{Batch/ML job?}
    N -->|Yes| O[AWS Batch / SageMaker]
    N -->|No| E
```

**Key Exam Traps:**
- Lambda max 15 min → Step Functions for longer orchestrations
- Fargate = no host access → daemon agents need EC2 launch type
- EKS for K8s ecosystem, ECS for simpler AWS-native orchestration

---

## 2. Messaging & Decoupling

```mermaid
flowchart TD
    A[Need async messaging?] --> B{Message ordering critical?}
    B -->|Yes| C[Kinesis Data Streams or SQS FIFO]
    B -->|No| D{Fan-out to multiple consumers?}
    
    D -->|Yes| E{Same message to all?}
    E -->|Yes| F[SNS + SQS per consumer]
    E -->|No| G[EventBridge]
    
    D -->|No| H{Exactly-once processing?}
    H -->|Yes| I[SQS FIFO]
    H -->|No| J{Cost primary concern?}
    J -->|Yes| K[SQS Standard]
    J -->|No| L{Streaming/replay needed?}
    L -->|Yes| M[Kinesis Data Streams]
    L -->|No| K
```

**Key Exam Traps:**
- SNS = push to many, SQS = pull by one, EventBridge = pattern-based routing
- Kinesis = ordered + replayable + multi-consumer (enhanced fan-out)
- SQS FIFO = 300 msg/s (batch), 3000 msg/s (high throughput mode)

---

## 3. Database Selection

```mermaid
flowchart TD
    A[Need Database?] --> B{Data model?}
    B -->|Relational| C{Managed or self?}
    B -->|Key-Value| D{Need DAX caching?}
    B -->|Document| E[DocumentDB]
    B -->|Graph| F[Neptune]
    B -->|Time-Series| G[Timestream]
    B -->|Ledger| H[QLDB]
    B -->|In-Memory| I{Use case?}
    
    C -->|Managed| J{Engine preference?}
    J -->|MySQL/PostgreSQL| K{Aurora or RDS?}
    K -->|Global/auto-scale| L[Aurora]
    K -->|Simple/no Aurora features| M[RDS]
    J -->|Oracle/SQL Server| N[RDS Custom or RDS]
    J -->|SQL Server→PG migration| O{Minimize code changes?}
    O -->|Yes| P[Babelfish for Aurora]
    O -->|No| Q[SCT + DMS]
    
    D -->|Yes| R[DynamoDB + DAX]
    D -->|No| S{Access patterns predictable?}
    S -->|Yes| T[DynamoDB Provisioned + Auto Scaling]
    S -->|No| U[DynamoDB On-Demand]
    
    I -->|Caching/sessions| V[ElastiCache Redis]
    I -->|Real-time leaderboards| W[ElastiCache Memcached]
    I -->|Redis-compatible with durability| X[MemoryDB]
```

**Key Exam Traps:**
- Aurora Global Database = RPO < 1s, RTO < 1min (cross-Region)
- DynamoDB hot partition → redesign partition key, NOT increase capacity
- DAX = microsecond reads for DynamoDB only (not RDS)
- ElastiCache vs MemoryDB: MemoryDB is durable (multi-AZ transaction log)

---

## 4. Storage Class Selection

```mermaid
flowchart TD
    A[Data in S3?] --> B{Access frequency?}
    B -->|Frequent/unknown| C{S3 Intelligent-Tiering}
    B -->|Infrequent but rapid| D[S3 Standard-IA]
    B -->|Infrequent + flexible AZ| E[S3 One Zone-IA]
    B -->|Archive, minutes retrieval| F[S3 Glacier Instant Retrieval]
    B -->|Archive, hours retrieval| G[S3 Glacier Flexible Retrieval]
    B -->|Archive, 12h retrieval| H[S3 Glacier Deep Archive]
    
    C --> I[Auto-moves between tiers]
    I --> J{Monitor for minimum storage charge}
    
    D --> K[Min 30 days, per-GB retrieval fee]
    E --> L[Min 30 days, NOT multi-AZ]
    F --> M[Min 90 days, ms retrieval]
    G --> N[Min 90 days, Expedited/Standard/Bulk]
    H --> O[Min 180 days, cheapest storage]
```

**Key Exam Traps:**
- Intelligent-Tiering has monitoring charge per object → not for trillions of tiny objects
- Lifecycle 30→90→180 day minimums → early delete fees
- S3 RTC = 15 min SLA for replication (compliance use case)
- S3 Object Lock = WORM (compliance/legal hold)

---

## 5. Networking: Connectivity Patterns

```mermaid
flowchart TD
    A[Need network connectivity?] --> B{Between what?}
    B -->|VPC to VPC (same Region)| C{How many VPCs?}
    B -->|VPC to on-prem| D{Bandwidth + SLA?}
    B -->|Cross-Region VPCs| E[TGW peering or Cloud WAN]
    B -->|Service to VPC (private)| F[AWS PrivateLink]
    
    C -->|< 10| G[VPC Peering]
    C -->|> 10| H{AWS Cloud WAN or TGW?}
    H -->|Global segmentation| I[Cloud WAN]
    H -->|Single Region| J[Transit Gateway]
    
    D -->|< 1 Gbps + best effort| K[Site-to-Site VPN]
    D -->|> 1 Gbps + SLA| L[AWS Direct Connect]
    D -->|DC backup| M[VPN as backup to DC]
    
    F --> N{Consumer in another account?}
    N -->|Yes| O[Endpoint service + RAM]
    N -->|No| P[Interface Endpoint]
```

**Key Exam Traps:**
- VPC Peering = no transitive routing, 1:1 relationship
- TGW = transitive, route tables for segmentation
- PrivateLink = unidirectional, consumer→provider, no overlapping CIDR issue
- Cloud WAN = global SD-WAN for multi-Region VPC networks
- NAT Gateway is per-AZ; for HA deploy one per AZ

---

## 6. Disaster Recovery Strategy

```mermaid
flowchart TD
    A[DR Requirements?] --> B{RPO?}
    B -->|< 1 second| C{RTO?}
    B -->|Minutes| D{RTO?}
    B -->|Hours| E{RTO?}
    B -->|Days| F[Backup & Restore]
    
    C -->|< 1 min| G[Multi-Region Active-Active]
    C -->|Minutes| H[Pilot Light or Warm Standby]
    
    D -->|< 30 min| I[DRS continuous replication]
    D -->|Hours| J[Warm Standby]
    
    E -->|< 4 hours| K[Pilot Light]
    E -->|> 4 hours| L[Backup & Restore]
    
    F --> M[RTO = 24h+ typical]
    G --> N[Route53 + Multi-Region + Global DB]
    H --> O[Pre-provisioned minimal infra]
    I --> P[AWS Elastic Disaster Recovery]
    J --> Q[Scaled-down full stack running]
    K --> R[Core services running, scale on event]
```

**Key Exam Traps:**
- DRS = continuous block-level replication, RPO ~seconds, RTO ~minutes
- AWS Backup = snapshot-based, RPO measured in hours
- Aurora Global Database = RPO < 1s, RTO < 1min for DB only
- Multi-AZ ≠ DR (same Region); Cross-Region Read Replica ≠ automatic failover
- Pilot Light = data replicated + minimal compute; Warm Standby = scaled-down full stack

---

## 7. Authorization & Access Control

```mermaid
flowchart TD
    A[Need access control?] --> B{Scope?}
    B -->|Single account| C{IAM Policy type?}
    B -->|Multi-account (Org)| D{Central governance?}
    B -->|External (cross-account)| E[IAM Role + Trust Policy]
    B -->|Public/external users| F[Cognito / Identity Pools]
    
    C -->|User/group/role| G[Identity-based policy]
    C -->|S3/SQS/KMS etc| H[Resource-based policy]
    C -->|VPC-level| I[NACL + Security Groups]
    
    D -->|Preventative guardrails| J[SCP]
    D -->|Tag enforcement| K[Tag Policies]
    D -->|Service restrictions| L[SCP with condition keys]
    D -->|Detective| M[Config + Audit Manager]
    
    E --> N{External ID needed?}
    N -->|Yes (3rd party)| O[sts:ExternalId condition]
    N -->|No (same org)| P[Trust principal: account ARN]
```

**Key Exam Traps:**
- SCPs don't grant permissions — they only restrict maximum permissions
- Resource-based policies can grant cross-account access without role assumption
- IAM policy evaluation: explicit DENY > SCP DENY > resource DENY > ALLOW
- Permission boundaries = limit what IAM entity can do (not cross-account)

---

## 8. Migration Strategy Selection (7 Rs)

```mermaid
flowchart TD
    A[Migration needed?] --> B{Can modify app?}
    B -->|No| C{Can run as-is?}
    B -->|Yes, minor| D{New platform?}
    B -->|Yes, major| E[Refactor / Re-architect]
    
    C -->|Yes| F[Rehost - MGN / VM Import]
    C -->|No| G[Retire or Retain]
    
    D -->|Containers| H[Replatform - ECS/EKS]
    D -->|Managed DB| I[Replatform - RDS/Aurora]
    D -->|SaaS alternative| J[Repurchase]
    
    E --> K{DB change?}
    K -->|Oracle→PostgreSQL| L[SCT + DMS CDC]
    K -->|SQL Server→PostgreSQL| M[Babelfish]
    K -->|Monolith→Microservices| N[Strangler Fig + DDD]
    
    F --> O[Fastest, least change]
    H --> I
    I --> P[Minimal downtime via CDC]
    J --> Q[Migrate to SaaS, e.g., SFTP→Transfer Family]
```

**Key Exam Traps:**
- MGN = continuous block replication (rehost), agent-based
- DMS = database only; SCT = schema conversion
- DataSync = file-level; Snow Family = physical transfer for large datasets
- Replatform ≠ Refactor: replatform = minor changes (OS→containers), refactor = major (monolith→microservices)

---

## Quick Reference: Service → Answer Mapping

| If you see... | Think... |
|---|---|
| "preventive, centrally managed" | SCP |
| "detect public S3 bucket" | IAM Access Analyzer |
| "auto-remediate unencrypted EBS" | Config + SSM Automation |
| "serverless, no idle cost, real-time" | Lambda + AppSync/DynamoDB |
| "sub-second failover, static IP" | Global Accelerator |
| "slow DNS failover (TTL issue)" | Global Accelerator or CloudFront Origin Group |
| "RPO < 1s, RTO < 1min for DB" | Aurora Global Database |
| "RPO seconds, RTO minutes for EC2" | DRS (Elastic Disaster Recovery) |
| "block public S3 at org level" | SCP + S3 Block Public Access |
| "temporary credentials, no IAM users" | IAM Role + sts:AssumeRole |
| "overlapping CIDRs, private sharing" | PrivateLink |
| "1000 VPCs, global, segmented" | Cloud WAN |
| "thundering herd on Redis" | Probabilistic early expiration |
| "DynamoDB hot partition" | Redesign partition key |
| "cost allocation, tag inconsistency" | Tag Policies + Cost Explorer |
| "find optimal EC2 type from metrics" | Compute Optimizer |
