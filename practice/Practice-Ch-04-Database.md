---
chapter: "4. Database"
totalQuestions: 22
tiers:
  knowledge: 8
  scenario: 10
  comparison: 4
basedOn: "AWS-SAP-C02-Learning-Material.md §4"
services:
  - RDS
  - Aurora
  - DynamoDB
  - ElastiCache
  - DocumentDB
  - Redshift
  - OpenSearch
  - DMS
---

# Chapter 4 Practice: 🗄️ Database

> **Instructions**: Complete Part A first. Do not scroll past the divider. Once finished, check Part B for answers and explanations.
> **Textbook**: `AWS-SAP-C02-Learning-Material.md` — Section 4 (RDS, Aurora, DynamoDB, ElastiCache, Other Databases, DMS) + Similar Service Comparison: Database

---

# Part A — Questions

## 🟢 Knowledge Check (8 questions)

### Q4.1
A solutions architect needs a relational database for a production application requiring high availability within a single AWS Region. The database must automatically fail over to a standby in a different Availability Zone with no manual intervention. Which RDS feature provides this?

- A. Read Replicas
- B. Multi-AZ deployment
- C. Cross-Region Read Replica
- D. RDS Proxy

### Q4.2
What is the maximum number of Read Replicas supported by Amazon Aurora?

- A. 5
- B. 10
- C. 15
- D. 20

### Q4.3
A development team needs a NoSQL database that can handle read and write operations in multiple AWS Regions simultaneously, with applications in each Region accessing their local copy. Which DynamoDB feature should be used?

- A. DynamoDB Streams
- B. DynamoDB Accelerator (DAX)
- C. DynamoDB Global Tables
- D. DynamoDB Auto Scaling

### Q4.4
What is Aurora Backtrack, and which Aurora engine does it support?

- A. A feature that rewinds the database to a previous point in time without a restore; supported on Aurora MySQL only
- B. A feature that rewinds the database to a previous point in time without a restore; supported on both Aurora MySQL and Aurora PostgreSQL
- C. A feature that creates an instant clone of the database; supported on Aurora PostgreSQL only
- D. A continuous backup feature with 35-day retention; supported on both engines

### Q4.5
A company is migrating an Oracle database to Amazon Aurora PostgreSQL. The database contains stored procedures, views, and functions that need to be converted. Which tool should be used to convert the database schema?

- A. AWS Database Migration Service (DMS) alone
- B. AWS Schema Conversion Tool (SCT)
- C. AWS DataSync
- D. AWS Application Migration Service (MGN)

### Q4.6
A solutions architect needs a caching layer for a DynamoDB table that is heavily read with millions of reads per second and requires microsecond response times. Which service is purpose-built for this use case?

- A. Amazon ElastiCache for Redis
- B. Amazon ElastiCache for Memcached
- C. DynamoDB Accelerator (DAX)
- D. Amazon CloudFront

### Q4.7
Which database service should a company use if they have an existing MongoDB workload and want to migrate to a fully managed AWS service with minimal application changes?

- A. Amazon DynamoDB with DocumentDB compatibility mode
- B. Amazon DocumentDB
- C. Amazon Aurora with MongoDB compatibility
- D. Amazon RDS for MongoDB

### Q4.8
How are DynamoDB Write Capacity Units (WCU) calculated?

- A. 1 WCU = 1 write per second for an item up to 4 KB
- B. 1 WCU = 1 write per second for an item up to 1 KB
- C. 1 WCU = 1 write per second for an item up to 10 KB
- D. 1 WCU = 10 writes per second for an item up to 1 KB

---

## 🟡 Scenario Analysis (10 questions)

### Q4.9
A company runs a three-tier web application on AWS. The database tier uses RDS for MySQL with a Multi-AZ deployment. During a recent failover test, the application experienced 1–2 minutes of downtime while the standby was promoted to primary.

The company wants to reduce failover time and also reduce the connection overhead from the application's Lambda functions, which frequently open new database connections.

Which combination of changes should the solutions architect recommend?

- A. Switch to Aurora with RDS Proxy
- B. Add Read Replicas and use a weighted DNS routing policy
- C. Switch to DynamoDB with DAX
- D. Deploy the RDS instance on a larger instance type with Provisioned IOPS

### Q4.10
A gaming company has users worldwide. The game backend uses DynamoDB in us-east-1. Users in Asia-Pacific report high latency when reading their game state. The company needs multi-Region read and write capability with the application automatically reading from and writing to the nearest Region.

Which solution should the solutions architect implement?

- A. DynamoDB Cross-Region Read Replicas
- B. DynamoDB Global Tables
- C. DynamoDB Streams with a cross-Region Lambda replicator
- D. DynamoDB Accelerator (DAX) deployed in Asia-Pacific

### Q4.11
A financial services company runs a critical OLTP application on an Aurora MySQL database. The application requires point-in-time recovery to any second within the last 24 hours. Additionally, the database must be able to recover from a Region-wide failure with a Recovery Point Objective (RPO) of approximately 1 second.

Which Aurora features should be configured? (Choose two.)

- A. Aurora Backtrack
- B. Aurora Global Database
- C. Aurora Auto Scaling
- D. Aurora Serverless v2
- E. Automated backups with point-in-time recovery

### Q4.12
A solutions architect needs to migrate a 500 GB on-premises MySQL database to Amazon RDS for MySQL with minimal downtime. The source database must remain operational during the migration, and ongoing changes must be synchronized until the final cutover.

Which migration approach should be used?

- A. Use mysqldump to export data, upload to S3, and import to RDS
- B. Use AWS DataSync to synchronize the database files
- C. Use AWS DMS with ongoing replication (CDC)
- D. Use AWS SCT to convert and migrate the database

### Q4.13
A company stores session state for its web application in ElastiCache for Redis. The application runs in a single AWS Region and must survive an Availability Zone failure without losing session data. Which Redis configuration should be used?

- A. Single-node Redis cluster
- B. Redis cluster with Multi-AZ enabled and automatic failover
- C. Redis cluster with cluster mode enabled across multiple nodes
- D. Redis cluster with in-transit encryption only

### Q4.14
An IoT application ingests sensor data at unpredictable rates — from hundreds of writes per second to millions during peak events. The data model is key-value with JSON documents. The team wants zero capacity planning and automatic scaling.

Which DynamoDB configuration should be used?

- A. DynamoDB with Provisioned Capacity and Application Auto Scaling
- B. DynamoDB with On-Demand Capacity mode
- C. DynamoDB with Reserved Capacity
- D. DynamoDB with DAX for write buffering

### Q4.15
A company is migrating a SQL Server application to AWS. The development team wants to keep using T-SQL but reduce licensing costs. They are open to changing the underlying database engine if the application code changes are minimal.

Which AWS database feature should the solutions architect recommend?

- A. RDS for SQL Server with License Included
- B. RDS for SQL Server with Bring Your Own License (BYOL)
- C. Babelfish for Aurora PostgreSQL
- D. DMS with SCT to convert to RDS for MySQL

### Q4.16
A company's DynamoDB table stores sensitive customer data. The compliance team requires that certain attributes (e.g., customer phone number, email) be accessible only to specific IAM roles, while other attributes (e.g., customer ID, order history) should be accessible to a broader set of roles.

Which DynamoDB security feature enables this?

- A. DynamoDB encryption at rest using KMS
- B. DynamoDB VPC Endpoint policies
- C. IAM policy with fine-grained access control for specific DynamoDB attributes
- D. DynamoDB Streams filtering specific attributes

### Q4.17
A company needs to migrate a 2 TB Oracle database to Amazon Aurora PostgreSQL. The source database uses Oracle-specific features including PL/SQL stored procedures, custom data types, and complex views. The migration must be completed with validated schema conversion before the data migration begins.

Which combination of tools and steps should be used?

- A. DMS only (homogeneous migration mode)
- B. SCT to assess and convert the schema, then DMS with CDC for data migration
- C. DataSync for schema conversion, then DMS for data
- D. VM Import of the Oracle server, then convert to Aurora on EC2

### Q4.18
A company has a 24/7 production Aurora MySQL cluster with steady, predictable traffic. The cluster needs to handle occasional 3x traffic spikes during monthly reporting without over-provisioning. The company also wants to minimize costs during normal operations.

Which Aurora feature should be used?

- A. Aurora Auto Scaling for Read Replicas
- B. Aurora Serverless v2
- C. Cross-Region Read Replicas
- D. Provisioned IOPS on the cluster volume

---

## 🔴 Similar Service Comparison (4 questions)

### Q4.19
A startup is choosing between RDS and DynamoDB for a new application. The data model includes complex JOINs across multiple tables, requires ACID transactions, and has a predictable access pattern. Which database service should be chosen?

- A. DynamoDB with Global Tables
- B. RDS or Aurora (relational database)
- C. DynamoDB with On-Demand capacity
- D. ElastiCache for Redis as the primary database

### Q4.20
A solutions architect needs to migrate two databases:
1. A MySQL 5.7 database on-premises to RDS for MySQL 8.0 (same engine family)
2. An Oracle 12c database on-premises to Aurora PostgreSQL (different engine family)

Which tools are needed for each migration respectively?

- A. DMS alone for both migrations
- B. DMS alone for MySQL; SCT + DMS for Oracle
- C. SCT for MySQL; DMS alone for Oracle
- D. DataSync for MySQL; DMS for Oracle

### Q4.21
An application requires sub-millisecond latency for session data and can use any caching solution. The database is Amazon RDS for PostgreSQL. Which caching service should be used?

- A. DynamoDB Accelerator (DAX)
- B. Amazon ElastiCache for Redis
- C. Amazon CloudFront
- D. RDS Read Replicas

### Q4.22
A company's DynamoDB table has highly variable traffic, ranging from near-zero at night to hundreds of thousands of reads per second during the day. The pattern is unpredictable. Which capacity mode should be chosen, and why?

- A. Provisioned capacity — it is cheaper regardless of traffic pattern
- B. On-Demand capacity — it automatically scales to handle unpredictable traffic without capacity planning
- C. Reserved capacity — it provides a 72% discount for a 1-year commitment
- D. Provisioned capacity with scheduled auto scaling — it adjusts based on a predefined schedule

---

# Part B — Answers & Explanations

> ⚠️ **STOP HERE.** Complete all questions in Part A before reading below.

---

## 🟢 Knowledge Check — Answers

### A4.1
**Correct: B** — Multi-AZ deployment.

**Why**: Multi-AZ deploys a synchronous standby replica in a different Availability Zone. When the primary instance fails (hardware, AZ outage, or storage failure), RDS automatically fails over to the standby — typically within 60–120 seconds. The database endpoint DNS remains the same, so no application changes are needed.

**Why not the others**:
- **A**: Read Replicas are read-only copies for scaling; they use async replication and cannot automatically fail over — manual promotion is required.
- **C**: Cross-Region Read Replica provides DR across Regions but requires manual promotion (not automatic failover for the primary Region).
- **D**: RDS Proxy manages connection pooling; it does not provide high availability of the database itself.

**📖 Textbook ref**: §4 — RDS, "Multi-AZ: Synchronous standby in different AZ"

---

### A4.2
**Correct: C** — 15.

**Why**: Amazon Aurora supports up to 15 Read Replicas, compared to standard RDS which supports up to 5. The replicas share the same underlying storage layer, enabling fast replica creation (typically minutes) and low replication lag (< 100 ms typical).

**Why not the others**: 5 is the RDS Read Replica limit, not Aurora. 10 and 20 are not the correct limits for any AWS database service.

**📖 Textbook ref**: §4 — Aurora, "Up to 15 replicas"; Similar Service Comparison table, "Scalability" row

---

### A4.3
**Correct: C** — DynamoDB Global Tables.

**Why**: Global Tables provide fully managed multi-active replication — you can read from and write to any replica table in any Region. DynamoDB automatically replicates writes across Regions with eventual consistency (typically < 1 second). Conflict resolution is last-writer-wins. Each Region's application accesses its local table with single-digit millisecond latency.

**Why not the others**:
- **A**: Streams capture item-level changes and are the underlying technology for Global Tables, but Streams alone require custom code to replicate across Regions.
- **B**: DAX is an in-memory cache — it improves read performance within a Region; it does not replicate data across Regions.
- **D**: Auto Scaling adjusts provisioned capacity within a single Region; it does not replicate data.

**📖 Textbook ref**: §4 — DynamoDB, "Global Tables: Multi-active"

---

### A4.4
**Correct: A** — Rewinds the database to a previous point in time without a restore; Aurora MySQL only.

**Why**: Aurora Backtrack lets you "rewind" the database to a specific point in time within the backtrack window (up to 72 hours), without requiring a full database restore from a backup. This is dramatically faster than point-in-time recovery (which requires restoring from a snapshot and replaying logs). Backtrack is supported only on Aurora MySQL, not Aurora PostgreSQL.

**Why not the others**:
- **B**: Backtrack is not supported on Aurora PostgreSQL.
- **C**: This describes database cloning, not Backtrack.
- **D**: This describes automated backups, not Backtrack.

**📖 Textbook ref**: §4 — Aurora, "Backtrack: Rewind database WITHOUT restore. Only for Aurora MySQL"

---

### A4.5
**Correct: B** — AWS Schema Conversion Tool (SCT).

**Why**: SCT converts database schema objects — including tables, views, stored procedures, and functions — from one database engine to another. Oracle → PostgreSQL involves different data types, PL/SQL vs PL/pgSQL stored procedures, and different system functions, all of which SCT can automatically convert (with an assessment report showing what needs manual intervention). SCT is used alongside DMS for heterogeneous migrations.

**Why not the others**:
- **A**: DMS alone handles homogeneous (same engine) migrations; for heterogeneous (different engine), it needs SCT for schema conversion first. DMS can migrate data but cannot convert schema objects.
- **C**: DataSync moves files — it has nothing to do with database schema conversion.
- **D**: MGN migrates entire servers (OS + apps + DB), not just the database schema.

**📖 Textbook ref**: §4 — SCT; §9 — Migration, "SCT: Heterogeneous Only"

---

### A4.6
**Correct: C** — DynamoDB Accelerator (DAX).

**Why**: DAX is a fully managed, in-memory cache purpose-built for DynamoDB. It delivers microsecond response times for read-heavy workloads and is a write-through cache (writes go to DynamoDB first, then DAX). It is integrated directly with the DynamoDB API — no application code changes beyond pointing to the DAX cluster endpoint.

**Why not the others**:
- **A**: ElastiCache for Redis works with any database but is not specifically optimized for DynamoDB — it doesn't provide microsecond latency with the DynamoDB API.
- **B**: ElastiCache for Memcached also works with any database but lacks the DynamoDB-specific optimization.
- **D**: CloudFront is a CDN for HTTP/S content, not a database cache.

**📖 Textbook ref**: §4 — DynamoDB, "DAX: In-memory cache — microsecond latency"

---

### A4.7
**Correct: B** — Amazon DocumentDB.

**Why**: Amazon DocumentDB is a fully managed, MongoDB-compatible (3.6, 4.0, and 5.0 API) database service. It is designed specifically for existing MongoDB workloads — applications using MongoDB drivers and tools can connect to DocumentDB with minimal to no code changes.

**Why not the others**:
- **A**: DynamoDB is a different NoSQL model (key-value/document) — not MongoDB-compatible.
- **C**: Aurora does not offer MongoDB compatibility.
- **D**: RDS does not support MongoDB as an engine.

**📖 Textbook ref**: §4 — Other Databases, "DocumentDB: MongoDB-compatible"

---

### A4.8
**Correct: B** — 1 WCU = 1 write per second for an item up to 1 KB.

**Why**: One Write Capacity Unit (WCU) represents one write request per second for an item up to 1 KB in size. If the item is larger (e.g., 1.5 KB), it consumes 2 WCUs. For transactional writes, each item consumes 2 WCUs (one for the write and one for the transaction log).

**Why not the others**:
- **A**: 4 KB is the Read Capacity Unit (RCU) size for strongly consistent reads — not the WCU size.
- **C & D**: These are made-up numbers with no basis in DynamoDB's actual throughput model.

**📖 Textbook ref**: §4 — DynamoDB, "WCU/RCU: 1 WCU = 1 write/sec for 1 KB item"

---

## 🟡 Scenario Analysis — Answers

### A4.9
**Correct: A** — Switch to Aurora with RDS Proxy.

**Why**: Aurora typically provides faster failover than standard RDS Multi-AZ (often < 30 seconds vs 60–120 seconds for RDS). RDS Proxy pools and shares database connections across Lambda invocations — Lambda functions can reuse connections instead of opening new ones on every invocation, dramatically reducing connection overhead and allowing more concurrent Lambda functions.

**Why not the others**:
- **B**: Read Replicas help with read scaling, not failover speed or connection pooling.
- **C**: DynamoDB is NoSQL — migrating a MySQL application is typically a major refactoring effort, not a quick change.
- **D**: Larger instances and Provisioned IOPS improve performance, not failover time or connection overhead.

**📖 Textbook ref**: §4 — Aurora overview; §4 — RDS Proxy

---

### A4.10
**Correct: B** — DynamoDB Global Tables.

**Why**: Global Tables enable multi-active replication — users in Asia-Pacific can read from and write to the table in the closest Region (e.g., ap-southeast-1) with single-digit millisecond latency. Writes are automatically replicated to other Regions. The application simply points to the DynamoDB endpoint in its own Region. This is the exact use case Global Tables was designed for.

**Why not the others**:
- **A**: DynamoDB does not have "Cross-Region Read Replicas" — that is an RDS concept. Global Tables is the DynamoDB multi-Region feature.
- **C**: Streams with a custom Lambda replicator is a DIY approach that introduces operational overhead — Global Tables is managed.
- **D**: DAX improves read latency within a single Region — it does not solve multi-Region latency for reads and does not solve writes at all.

**📖 Textbook ref**: §4 — DynamoDB, "Global Tables: Multi-active (read/write to any Region)"

---

### A4.11
**Correct: B and E** — Aurora Global Database + Automated backups with point-in-time recovery.

**Why**:
- **B (Global Database)**: Provides cross-Region disaster recovery with < 1 second typical replication lag, achieving the ~1 second RPO. The secondary Region can be promoted to primary in < 1 minute (RTO).
- **E (Automated backups with PITR)**: Aurora automated backups support point-in-time recovery to any second within the retention period (up to 35 days). This satisfies the 24-hour PITR requirement.

**Why not the others**:
- **A**: Backtrack provides fast rewind without restore, but it's only for Aurora MySQL and has a maximum window of 72 hours — it doesn't provide cross-Region DR.
- **C**: Auto Scaling adds read replicas for performance, not DR or PITR.
- **D**: Serverless v2 handles variable capacity, not DR or PITR.

**📖 Textbook ref**: §4 — Aurora, "Global Database" and "Backtrack"

---

### A4.12
**Correct: C** — Use AWS DMS with ongoing replication (CDC).

**Why**: DMS with Change Data Capture (CDC) performs an initial full load of the source database, then continuously replicates ongoing changes. The source database remains fully operational throughout. When ready for cutover, you stop application writes to the source, let DMS catch up the final few transactions, and switch the application to the RDS endpoint. This achieves minimal downtime (minutes rather than hours).

**Why not the others**:
- **A**: mysqldump requires significant downtime — the source must be locked or made read-only during export and import.
- **B**: DataSync moves files — it cannot replicate a live database with ongoing transactions.
- **D**: SCT is for schema conversion between different engines (heterogeneous). MySQL → RDS MySQL is homogeneous — SCT is not needed.

**📖 Textbook ref**: §4 — DMS; §9 — Migration, "DMS: CDC for minimal downtime"

---

### A4.13
**Correct: B** — Redis cluster with Multi-AZ enabled and automatic failover.

**Why**: ElastiCache for Redis with Multi-AZ provides automatic failover — a read replica in a different AZ is automatically promoted to primary if the primary fails or the AZ becomes unavailable. Since Redis with Multi-AZ replicates data to the replica, session data is preserved. The failover process is transparent to the application.

**Why not the others**:
- **A**: A single-node cluster has no replication — losing the node means losing all session data.
- **C**: Cluster mode is for horizontal scaling (partitioning data across shards), not high availability per se.
- **D**: Encryption alone does not provide data durability during an AZ failure.

**📖 Textbook ref**: §4 — ElastiCache, "Redis: Multi-AZ with auto-failover"

---

### A4.14
**Correct: B** — DynamoDB with On-Demand Capacity mode.

**Why**: On-Demand capacity mode automatically scales to handle any volume of traffic — from zero to millions of requests per second — without capacity planning. You pay per request (about 2x the provisioned cost for steady-state workloads). For unpredictable IoT ingestion with extreme peaks, On-Demand eliminates the risk of throttling during surprise events and the overhead of managing auto scaling.

**Why not the others**:
- **A**: Provisioned capacity with auto scaling is cheaper for predictable workloads, but auto scaling reacts to metrics and may not scale fast enough for a sudden million-write spike.
- **C**: Reserved Capacity is a billing discount for provisioned capacity — it doesn't help with unpredictable scaling.
- **D**: DAX is a read cache — it does not buffer or scale writes.

**📖 Textbook ref**: §4 — DynamoDB, "Capacity Modes: Provisioned vs On-Demand"

---

### A4.15
**Correct: C** — Babelfish for Aurora PostgreSQL.

**Why**: Babelfish is a feature of Aurora PostgreSQL that enables SQL Server applications to run with minimal code changes. It provides T-SQL compatibility — stored procedures, functions, data types, and SQL dialect are mostly compatible with SQL Server. This allows the company to switch from SQL Server licensing to the more cost-effective Aurora PostgreSQL, while keeping T-SQL and minimizing application changes.

**Why not the others**:
- **A & B**: These keep the company on SQL Server with its higher licensing costs — the question says they want to reduce licensing costs.
- **D**: DMS + SCT converting to MySQL would require rewriting T-SQL to MySQL dialect — much more code change than Babelfish.

**📖 Textbook ref**: §4 — Aurora, "Babelfish: Run SQL Server applications on Aurora PostgreSQL"

---

### A4.16
**Correct: C** — IAM policy with fine-grained access control for specific DynamoDB attributes.

**Why**: DynamoDB supports attribute-level access control through IAM policies. Using the `dynamodb:Attributes` condition key, you can restrict which attributes (columns) a role can read or write. For example, the `CustomerService` role can read/write customer ID and order history but NOT phone number or email, while the `Admin` role has full access. This is enforced at the DynamoDB API level.

**Why not the others**:
- **A**: Encryption protects data at rest but does not control which IAM roles can see which attributes.
- **B**: VPC Endpoint policies control network-level access, not attribute-level permissions.
- **D**: Streams capture changes — they have nothing to do with access control.

**📖 Textbook ref**: §4 — DynamoDB, "Attribute-Level Access Control"

---

### A4.17
**Correct: B** — SCT to assess and convert the schema, then DMS with CDC for data migration.

**Why**: This is the standard heterogeneous migration pattern: (1) SCT analyzes the source Oracle schema, converts it to Aurora PostgreSQL including stored procedures (PL/SQL → PL/pgSQL), custom data types, and views. It generates an assessment report showing what auto-converted vs. needs manual attention. (2) DMS with CDC performs the data migration with ongoing replication for minimal cutover downtime. Both steps together handle schema + data for a complex Oracle → Aurora PostgreSQL migration.

**Why not the others**:
- **A**: DMS alone cannot convert Oracle schema (PL/SQL, types, views) to PostgreSQL — that requires SCT.
- **C**: DataSync is for files, not database schemas.
- **D**: VM Import brings the entire Oracle server to EC2 — this is rehosting, not migrating to Aurora PostgreSQL.

**📖 Textbook ref**: §4 — DMS and SCT; §9 — Migration, "SCT + DMS for heterogeneous"

---

### A4.18
**Correct: A** — Aurora Auto Scaling for Read Replicas.

**Why**: Aurora Auto Scaling dynamically adjusts the number of Read Replicas based on load. During monthly reporting (3x traffic), Aurora adds replicas to handle the read-heavy reporting workload. During normal operations, it scales back down to the minimum. The application must direct read traffic to the reader endpoint. For write scaling, the compute on the primary may need adjustment, but the 3x spike is described as reporting (typically read-heavy).

**Why not the others**:
- **B**: Aurora Serverless v2 scales compute (ACUs) dynamically — it could handle the spikes but is more appropriate for unpredictable (not predictable monthly) workloads, and may be more expensive than provisioned + auto scaling for steady-state with known peaks.
- **C**: Cross-Region Read Replicas are for global distribution, not handling load spikes.
- **D**: Provisioned IOPS on the cluster volume is not a feature — Aurora storage auto-scales and has distributed IOPS built in.

**📖 Textbook ref**: §4 — Aurora, "Auto Scaling: Read replicas auto-scale based on load"

---

## 🔴 Similar Service Comparison — Answers

### A4.19
**Correct: B** — RDS or Aurora (relational database).

**Why**: The workload explicitly requires complex JOINs across multiple tables, ACID transactions, and has a predictable access pattern. These are classic relational database requirements. DynamoDB is a NoSQL key-value/document store that does not support complex JOINs or native ACID transactions across multiple items/tables (it supports transactions within a single table and across tables, but not the complex multi-table JOINs that are fundamental to relational databases).

**Why not the others**:
- **A & C**: DynamoDB is not suitable for complex JOINs — data must be modeled to avoid JOINs entirely.
- **D**: ElastiCache is an in-memory cache, not a primary database for persistent, transactional data.

**📖 Textbook ref**: §4 — Similar Service Comparison, "RDS vs Aurora vs DynamoDB" — Data model row

---

### A4.20
**Correct: B** — DMS alone for MySQL; SCT + DMS for Oracle.

**Why**: MySQL 5.7 → MySQL 8.0 (RDS) is a homogeneous migration — the source and target engines are the same family. DMS handles the data migration alone (schema is compatible). Oracle 12c → Aurora PostgreSQL is a heterogeneous migration — different engines with incompatible schemas. SCT must convert the Oracle schema (PL/SQL, data types, etc.) to PostgreSQL first, then DMS migrates the data.

**Why not the others**:
- **A**: DMS alone cannot handle heterogeneous (Oracle → PostgreSQL) — schema conversion is needed.
- **C**: Reversed — SCT is needed for the heterogeneous migration (Oracle), not the homogeneous one (MySQL).
- **D**: DataSync is not a database migration tool.

**📖 Textbook ref**: §4 — Similar Service Comparison, "DMS vs DataSync vs SCT"; §4 — SCT, "Heterogeneous Only"

---

### A4.21
**Correct: B** — Amazon ElastiCache for Redis.

**Why**: ElastiCache works with ANY database or application. It connects to RDS for PostgreSQL, caches query results and session data, and provides sub-millisecond response times. Redis supports rich data structures ideal for session management (hashes, strings with TTL). It is the universal caching solution for relational databases.

**Why not the others**:
- **A**: DAX is purpose-built for DynamoDB ONLY — it cannot cache data from RDS, Aurora, or any other database.
- **C**: CloudFront caches HTTP/S content at the edge — not database query results or sessions.
- **D**: Read Replicas are read-only copies of the database — they do not provide sub-millisecond caching and are for read scaling, not caching.

**📖 Textbook ref**: §4 — Similar Service Comparison, "ElastiCache vs DAX vs CloudFront Caching"

---

### A4.22
**Correct: B** — On-Demand capacity — it automatically scales to handle unpredictable traffic without capacity planning.

**Why**: On-Demand mode is designed for workloads with unpredictable traffic patterns. It instantly scales to accommodate any volume (up to virtually unlimited throughput) — no provisioning, no auto scaling policies, no throttling when traffic exceeds provisioned capacity. The trade-off is cost: On-Demand is approximately 2x the price of fully utilized provisioned capacity for steady-state workloads.

**Why not the others**:
- **A**: Provisioned is cheaper for steady/predictable workloads — but this scenario is explicitly unpredictable.
- **C**: Reserved capacity is a billing discount on provisioned capacity — it still requires capacity planning.
- **D**: Scheduled auto scaling requires a PREDICTABLE schedule — the scenario says unpredictable.

**📖 Textbook ref**: §4 — DynamoDB, "Capacity Modes"; §4 — Similar Service Comparison, "Serverless" row for DynamoDB

---

> **📊 Chapter 4 Summary**: 8 Knowledge + 10 Scenario + 4 Comparison = 22 questions
> 
> **Next**: If you missed any questions, review the corresponding section in `AWS-SAP-C02-Learning-Material.md` and add the Q number to your missed question tracker.
