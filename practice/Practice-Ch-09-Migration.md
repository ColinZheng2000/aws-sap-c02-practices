---
chapter: "9. Migration & Transfer"
totalQuestions: 14
tiers:
  knowledge: 5
  scenario: 5
  comparison: 4
basedOn: "AWS-SAP-C02-Learning-Material.md §9"
services:
  - DataSync
  - Snow Family
  - MGN
  - DMS
  - SCT
  - VM Import/Export
  - Application Discovery Service
  - Migration Hub
---

# Chapter 9 Practice: 🚚 Migration & Transfer

> **Instructions**: Complete Part A first. Do not scroll past the divider. Once finished, check Part B for answers.
> **Textbook**: `AWS-SAP-C02-Learning-Material.md`  → Section 9 (DataSync, Snow Family, MGN, Application Discovery Service, Migration Hub, SCT, VM Import/Export, Migration Evaluator) + Similar Service Comparison: Migration

---

# Part A  → Questions

## 🟢 Knowledge Check (5 questions)

### Q9.1

> 🟡 L2-理解 | 🎤🎤 中频面试
A company needs to transfer 500 TB of on-premises data to S3. The internet connection is 100 Mbps and shared with business systems. The transfer must not affect business operations. Which method should be used?

- A. AWS DataSync with bandwidth throttling
- B. AWS Snowball Edge (multiple devices)
- C. S3 Transfer Acceleration with multi-part upload
- D. AWS Direct Connect (dedicated 1 Gbps) installed temporarily

### Q9.2

> 🟡 L2-理解 | 🎤🎤 中频面试
When is AWS Schema Conversion Tool (SCT) required for a database migration using DMS?

- A. For all database migrations, regardless of source and target engine
- B. Only when the source and target database engines are different (heterogeneous migration)
- C. Only when migrating databases larger than 1 TB
- D. Only when migrating from commercial databases to open-source databases

### Q9.3

> 🟡 L2-理解 | 🎤🎤 中频面试
Which migration strategy does AWS Application Migration Service (MGN) implement?

- A. Replatform (modify application for cloud)
- B. Refactor (rewrite application architecture)
- C. Rehost (lift-and-shift  → move servers as-is)
- D. Retire (decommission the application)

### Q9.4

> 🟡 L2-理解 | 🎤🎤 中频面试
A solutions architect needs to discover on-premises servers, map their dependencies, and collect performance metrics before planning a large-scale migration. Which service should be used?

- A. AWS Migration Hub
- B. AWS Application Discovery Service
- C. AWS Trusted Advisor
- D. AWS Compute Optimizer

### Q9.5

> 🟢 L1-知识 | 🎤🎤 中频面试
What is the maximum data transfer speed per AWS DataSync agent?

- A. 1 Gbps
- B. 10 Gbps
- C. 100 Gbps
- D. 500 Mbps

---

## 🟡 Scenario Analysis (5 questions)

### Q9.6

> 🟡 L2-理解 | 🎤🎤 中频面试
A company plans to migrate 50 on-premises servers (Windows and Linux) to AWS. The migration must occur during a 4-hour weekend maintenance window. The servers include file servers, application servers, and two Oracle databases. The company wants minimal changes to servers and minimal migration risk.

Which strategy and tool combination should be used?

- A. Rehost all servers using MGN; manually move databases during the window
- B. Rehost file/app servers using MGN; migrate Oracle databases using DMS with CDC
- C. Replatform all servers to Beanstalk; migrate databases using SCT + DMS
- D. Refactor all applications to Lambda; migrate data to DynamoDB

### Q9.7

> 🟡 L2-理解 | 🎤🎤 中频面试
A company needs to move 15 TB of file data from an on-premises NFS server to Amazon FSx for Windows File Server. The migration must be completed within 48 hours and account for ongoing changes made to the source data during the transfer.

Which service should be used?

- A. AWS Snowball Edge
- B. AWS DataSync with incremental sync
- C. S3 sync command with the `--delete` flag
- D. AWS Storage Gateway File Gateway

### Q9.8

> 🟡 L2-理解 | 🎤🎤 中频面试
A solutions architect needs to migrate a SQL Server database to Aurora PostgreSQL. The SQL Server database has 200 stored procedures, 50 views, and custom data types. Which approach should the architect take FIRST?

- A. Start DMS with CDC to migrate the data immediately
- B. Run SCT to assess schema compatibility and convert SQL Server objects to PostgreSQL
- C. Use DataSync to copy the database files to Aurora
- D. Export all data as CSV and import into Aurora using pgloader

### Q9.9

> 🟡 L2-理解 | 🎤🎤 中频面试
A company's migration project involves 200 servers across 3 data centers. Management needs a single dashboard to track migration progress across all servers and all migration tools (MGN, DMS, DataSync). Which service provides this?

- A. AWS Application Discovery Service
- B. AWS Migration Hub
- C. AWS Systems Manager Fleet Manager
- D. Amazon CloudWatch Dashboard

### Q9.10

> 🟡 L2-理解 | 🎤🎤 中频面试
A company wants to generate a business case for migrating to AWS. They need TCO comparison, projected savings, and resource mapping from their current on-premises inventory before committing to migration. Which tool should be used?

- A. AWS Pricing Calculator
- B. AWS Migration Evaluator
- C. AWS Trusted Advisor
- D. AWS Compute Optimizer

---

## 🔴 Similar Service Comparison (4 questions)

### Q9.11

> 🟡 L2-理解 | 🎤🎤 中频面试
A company needs to move data from on-premises to AWS. Compare: DataSync vs Storage Gateway. Which should be used for ongoing file access with local caching?

- A. DataSync  → it provides a local cache of S3 data
- B. Storage Gateway File Gateway  → it caches frequently accessed data locally
- C. Either  → they serve the same purpose
- D. DataSync for the initial migration, then Storage Gateway for ongoing access

### Q9.12

> 🟡 L2-理解 | 🎤🎤 中频面试
A solutions architect is choosing between DMS and MGN for a migration project. The project includes application servers (to be moved to EC2) and MySQL databases (to be moved to RDS). Which tools should be used for each?

- A. DMS for both
- B. MGN for both
- C. MGN for application servers; DMS for MySQL databases
- D. DataSync for application servers; SCT for databases

### Q9.13

> 🟡 L2-理解 | 🎤🎤 中频面试
A company migrates an Oracle database to Aurora PostgreSQL. The schema contains PL/SQL stored procedures. Without SCT, what would happen during the DMS migration?

- A. DMS would convert the PL/SQL to PL/pgSQL automatically
- B. DMS would skip the stored procedures and migrate only tables and data
- C. DMS would fail because Oracle is a commercial database
- D. DMS would migrate the procedures but they wouldn't work on PostgreSQL

### Q9.14

> 🟡 L2-理解 | 🎤🎤 中频面试
A company has 200 TB of genomic data to transfer from a remote research facility to AWS S3. The facility has a 50 Mbps satellite internet connection. Which is the FASTEST method to complete this transfer?

- A. S3 Transfer Acceleration with multi-part upload over satellite
- B. Multiple AWS Snowball Edge devices shipped to the facility
- C. AWS DataSync with maximum bandwidth utilization
- D. AWS Direct Connect installed at the remote facility

---

# Part B  → Answers & Explanations

> ⚠️ **STOP HERE.** Complete all questions in Part A before reading below.

---

## 🟢 Knowledge Check  → Answers

### A9.1
**Correct: B**  → AWS Snowball Edge (multiple devices).

**Why**: At 100 Mbps with business traffic overhead, transferring 500 TB would take ~500+ days  → completely impractical. Snowball Edge devices (80 TB each)  → 7 devices handle 500 TB. Physical shipping takes about a week per device, and multiple devices can be used in parallel. This is the standard offline transfer solution for large data volumes over slow connections.

**Why not the others**: DataSync at limited bandwidth takes too long. S3 Transfer Acceleration doesn't increase total bandwidth. Temporary Direct Connect for one-time transfer is not cost-effective.

**📖 Textbook ref**: §9  → Snow Family; §9  → Similar Service Comparison

---

### A9.2
**Correct: B**  → Only when source and target database engines are different (heterogeneous).

**Why**: SCT converts database schema objects (tables, views, stored procedures, functions, data types) between different database engines. For homogeneous migration (MySQL  → RDS MySQL), the schema is compatible and DMS alone suffices. For heterogeneous migration (Oracle  → Aurora PostgreSQL), SCT must convert the schema first.

**📖 Textbook ref**: §9  → SCT, "Heterogeneous Only"

---

### A9.3
**Correct: C**  → Rehost (lift-and-shift).

**Why**: MGN performs block-level continuous replication of entire servers to AWS. The servers are replicated as-is  → same OS, same apps, same configurations. After cutover, they run as EC2 instances with no changes. This is pure rehosting (the "R" in the 7 Rs of migration).

**📖 Textbook ref**: §9  → MGN, "Server-level lift-and-shift (rehost)"

---

### A9.4
**Correct: B**  → AWS Application Discovery Service.

**Why**: Application Discovery Service discovers on-premises servers (OS, specs, installed software), maps network dependencies between servers, and collects performance metrics (CPU, memory, disk, network). This data feeds into Migration Hub for planning. It supports agentless (VMware vCenter) and agent-based (any OS, deeper insights) modes.

**📖 Textbook ref**: §9  → Application Discovery Service

---

### A9.5
**Correct: B**  → 10 Gbps.

**Why**: Each DataSync agent can transfer data at up to 10 Gbps. You can deploy multiple agents for higher aggregate throughput. The agent is a VMware ESXi, Hyper-V, or KVM virtual appliance deployed on-premises.

**📖 Textbook ref**: §9  → DataSync, "Up to 10 Gbps per agent"

---

## 🟡 Scenario Analysis  → Answers

### A9.6
**Correct: B**  → Rehost file/app servers using MGN; migrate Oracle databases using DMS with CDC.

**Why**: MGN provides block-level replication for servers (file + app)  → it can be set up in advance and cut over during the maintenance window. DMS with CDC migrates the Oracle databases with ongoing replication  → the initial full load is done in advance, and CDC catches up ongoing changes, enabling rapid cutover. Since it's Oracle  → EC2 (not Aurora), SCT isn't needed if staying on Oracle.

**📖 Textbook ref**: §9  → MGN + DMS

---

### A9.7
**Correct: B**  → AWS DataSync with incremental sync.

**Why**: DataSync can transfer 15 TB well within 48 hours at typical speeds (at 1 Gbps, ~33 hours). Incremental sync handles changes made during the transfer  → after the initial full sync, DataSync only transfers changed files, keeping source and destination consistent until cutover. DataSync supports FSx for Windows File Server as a destination.

**📖 Textbook ref**: §9  → DataSync, "Incremental Transfer"

---

### A9.8
**Correct: B**  → Run SCT to assess schema compatibility and convert SQL Server objects to PostgreSQL FIRST.

**Why**: SCT assessment should always come first for heterogeneous migrations. It analyzes the SQL Server schema, identifies what can be auto-converted, what needs manual intervention (e.g., T-SQL stored procedures  → PL/pgSQL), and generates a conversion report. Based on the report, you decide whether Babelfish (for T-SQL compatibility) or full SCT conversion is the right path. Data migration with DMS comes after schema conversion.

**📖 Textbook ref**: §9  → SCT, "Assessment Report"

---

### A9.9
**Correct: B**  → AWS Migration Hub.

**Why**: Migration Hub is the central dashboard for migration tracking. It aggregates status from multiple migration tools (MGN, DMS, DataSync, and partner tools) across multiple servers and locations, providing a single pane of glass for migration progress across the entire portfolio.

**📖 Textbook ref**: §9  → Migration Hub

---

### A9.10
**Correct: B**  → AWS Migration Evaluator.

**Why**: Migration Evaluator is a free tool that analyzes your on-premises inventory (server specs, utilization data) and generates a detailed business case: TCO comparison (on-prem vs. AWS), projected annual savings, and resource mapping (which AWS services/instance types match your existing servers). This is specifically for pre-migration business case generation.

**📖 Textbook ref**: §9  → Migration Evaluator

---

## 🔴 Similar Service Comparison  → Answers

### A9.11
**Correct: B**  → Storage Gateway File Gateway caches frequently accessed data locally.

**Why**: Storage Gateway File Gateway provides ongoing NFS/SMB file shares backed by S3, with a local cache for hot data. This is for ongoing hybrid access  → not one-time migration. DataSync is for migration/sync (one-time or recurring), not ongoing access with local caching.

**📖 Textbook ref**: §9  → Similar Service Comparison; §3  → Storage Gateway

---

### A9.12
**Correct: C**  → MGN for application servers; DMS for MySQL databases.

**Why**: MGN migrates entire servers (OS + apps)  → perfect for application servers being moved to EC2 as-is. DMS migrates databases with CDC  → perfect for MySQL  → RDS with minimal downtime. DMS cannot migrate application servers (it's for databases). MGN can technically migrate servers with databases too, but DMS provides more database-specific features (schema validation, ongoing replication).

**📖 Textbook ref**: §9  → Similar Service Comparison, "DMS: Database" vs "MGN: Server-level"

---

### A9.13
**Correct: D**  → DMS would migrate the procedures but they wouldn't work on PostgreSQL.

**Why**: DMS migrates schema objects as-is  → it doesn't convert them. If you use DMS without SCT for Oracle  → PostgreSQL, the PL/SQL stored procedures would be created in PostgreSQL, but they would fail because PostgreSQL uses PL/pgSQL, not PL/SQL. SCT is essential for converting stored procedures between different database languages.

**📖 Textbook ref**: §9  → SCT; §4  → SCT, "Heterogeneous Only: SCT converts stored procedures"

---

### A9.14
**Correct: B**  → Multiple AWS Snowball Edge devices shipped to the facility.

**Why**: At 50 Mbps for 200 TB, online transfer would take ~370 days. Snowball Edge (80 TB each)  → 3 devices handle 200 TB. Physical shipping (round trip: order  → receive  → fill  → ship back  → AWS loads data) takes ~1 →  weeks per batch. Multiple devices in parallel can transfer all 200 TB in roughly 2 →  weeks total  → orders of magnitude faster than the satellite link.

**📖 Textbook ref**: §9  → Snow Family, "> 10 TB, slow/expensive network  → Snowball Edge"

---

> **📊 Chapter 9 Summary**: 5 Knowledge + 5 Scenario + 4 Comparison = 14 questions
> 
> **Next**: If you missed any questions, review the corresponding section in `AWS-SAP-C02-Learning-Material.md` and add the Q number to your missed question tracker.
