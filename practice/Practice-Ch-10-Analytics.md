---
chapter: "10. Analytics"
totalQuestions: 9
tiers:
  knowledge: 3
  scenario: 4
  comparison: 2
basedOn: "AWS-SAP-C02-Learning-Material.md §10"
services:
  - Athena
  - EMR
  - Glue
  - QuickSight
  - Kinesis
  - Redshift
  - OpenSearch
---

# Chapter 10 Practice: 📈 Analytics

> **Instructions**: Complete Part A first. Do not scroll past the divider. Once finished, check Part B for answers.
> **Textbook**: `AWS-SAP-C02-Learning-Material.md` — Section 10 (Athena, EMR, Glue, QuickSight, Kinesis)

---

# Part A — Questions

## 🟢 Knowledge Check (3 questions)

### Q10.1
Which AWS service allows you to run standard SQL queries directly on data stored in S3 without loading it into a database?

- A. Amazon Redshift Spectrum
- B. Amazon Athena
- C. Amazon EMR with Hive
- D. AWS Glue

### Q10.2
A data engineering team needs a serverless ETL service that can automatically discover data schemas, catalog metadata, and run Spark-based transformation jobs. Which service should be used?

- A. Amazon Athena
- B. Amazon EMR
- C. AWS Glue
- D. Amazon Kinesis Data Analytics

### Q10.3
How can Amazon EMR reduce costs when processing data stored in S3?

- A. Use EMRFS to access S3 data directly, allowing clusters to be transient (terminate after processing)
- B. Store all data on HDFS on the EMR cluster nodes for faster processing
- C. Use Provisioned IOPS on EMR volumes to reduce I/O costs
- D. Enable EMR automated backups to S3 Glacier

---

## 🟡 Scenario Analysis (4 questions)

### Q10.4
A company's finance team wants to create interactive dashboards showing AWS spending trends across all accounts. The cost data is delivered as Cost and Usage Reports (CUR) to S3 daily. The team needs to query the raw CUR data.

Which combination should be used?

- A. CUR → S3 → Athena → QuickSight
- B. CUR → CloudWatch → Cost Explorer
- C. CUR → Redshift → EMR
- D. CUR → Glue → Kinesis → QuickSight

### Q10.5
A company runs a nightly ETL job that extracts data from S3, transforms it (joining, filtering, aggregating), and loads it back to S3 in Parquet format. The job currently runs on an always-on EMR cluster, but only runs for 2 hours each night.

How can the solutions architect reduce costs?

- A. Switch the EMR cluster to Spot Instances while keeping it always-on
- B. Use a transient EMR cluster — launch it before the job, process data with EMRFS (data in S3), terminate after completion
- C. Migrate the ETL to Amazon Athena which is always serverless
- D. Convert the EMR cluster to use Reserved Instances for cost savings

### Q10.6
A company needs to process real-time clickstream data from a website (50,000 events/second). Multiple teams need to consume this data: (a) the marketing team needs real-time dashboards, (b) the data science team needs to replay events from the last 24 hours for model training, and (c) the operations team needs to archive all events to S3 for long-term storage.

Which service should ingest the clickstream data?

- A. Amazon SQS FIFO queue
- B. Amazon Kinesis Data Streams
- C. Amazon SNS with SQS subscriptions
- D. Amazon EventBridge

### Q10.7
A company stores customer data in S3 and needs to detect and mask personally identifiable information (PII) before making it available to analysts. The ETL process must run on a schedule and handle schema changes automatically.

Which AWS Glue features address these requirements? (Choose two.)

- A. Glue Crawlers to automatically detect schema changes
- B. Glue DataBrew for visual data preparation
- C. Glue Studio for visual ETL job creation
- D. Glue ML transforms (DetectPII, FindMatches) to identify and mask sensitive data
- E. Glue Workflows to orchestrate Lambda functions

---

## 🔴 Similar Service Comparison (2 questions)

### Q10.8
A data analyst needs to run ad-hoc SQL queries on a 2 TB dataset stored in S3. The queries are exploratory and unpredictable — sometimes none for days, sometimes dozens in an hour. Cost must be minimized for idle periods. Which service should be used?

- A. Amazon Redshift provisioned cluster
- B. Amazon EMR with Hive
- C. Amazon Athena
- D. Amazon RDS with S3 integration

### Q10.9
A company receives IoT sensor data at 10,000 records/second. Two consumers need this data: (a) a real-time anomaly detection system (needs < 1 second latency), and (b) a daily batch analytics system (runs once per day). Which services should be used for each consumer respectively?

- A. SQS for both
- B. Kinesis Data Streams for both (each consumer reads independently)
- C. SNS for anomaly detection; SQS for batch analytics
- D. EventBridge for anomaly detection; S3 for batch analytics

---

# Part B — Answers & Explanations

> ⚠️ **STOP HERE.** Complete all questions in Part A before reading below.

---

## 🟢 Knowledge Check — Answers

### A10.1
**Correct: B** — Amazon Athena.

**Why**: Athena is a serverless interactive query service that runs standard SQL directly on S3 data. No infrastructure to manage, no data loading required. You define a table schema (using CREATE EXTERNAL TABLE) and query CSV, JSON, Parquet, ORC, and Avro files in place. Pay-per-query ($5/TB scanned).

**Why not the others**: Redshift Spectrum also queries S3 but requires a Redshift cluster. EMR with Hive requires cluster management. Glue is for ETL, not ad-hoc querying.

**📖 Textbook ref**: §10 — Athena, "Serverless SQL queries on S3 data"

---

### A10.2
**Correct: C** — AWS Glue.

**Why**: Glue provides: (1) Crawlers that scan S3 and automatically discover schemas, populating the Glue Data Catalog. (2) The Data Catalog serves as a central metadata repository. (3) Glue Jobs run on Apache Spark (serverless) for ETL transformations. All serverless — no cluster management.

**📖 Textbook ref**: §10 — Glue

---

### A10.3
**Correct: A** — EMRFS allows direct S3 access, enabling transient clusters.

**Why**: EMRFS (EMR File System) lets EMR read/write directly from S3 as if it were HDFS. This decouples compute from storage — you can terminate the EMR cluster after processing, and the data remains in S3. Transient clusters (create → process → terminate) dramatically reduce costs for periodic batch jobs vs. always-on clusters.

**📖 Textbook ref**: §10 — EMR, "EMRFS" and "Transient Clusters"

---

## 🟡 Scenario Analysis — Answers

### A10.4
**Correct: A** — CUR → S3 → Athena → QuickSight.

**Why**: This is the standard cost analytics pipeline: CUR delivers cost data to S3 as CSV/Parquet files. Athena queries this data directly in S3 using SQL. QuickSight connects to Athena as a data source, importing data into SPICE for fast interactive dashboards. All serverless — pay per query + QuickSight per-session pricing.

**📖 Textbook ref**: §10 — Athena + QuickSight; §8 — CUR

---

### A10.5
**Correct: B** — Use transient EMR cluster with EMRFS.

**Why**: An always-on cluster running 2 hours/night wastes ~91% of its cost. With EMRFS, data stays in S3. A transient cluster starts fresh, processes for 2 hours, and terminates — you only pay for 2 hours of compute per day. This is massive cost savings for periodic batch jobs without changing the ETL logic.

**📖 Textbook ref**: §10 — EMR, "Transient Clusters: Huge cost savings"

---

### A10.6
**Correct: B** — Amazon Kinesis Data Streams.

**Why**: Kinesis is purpose-built for this: (1) Ingest 50K events/sec (scale shards accordingly). (2) Multiple independent consumers — marketing reads for dashboards, data science replays from 24h ago (Kinesis supports up to 365-day retention), operations uses Kinesis Data Firehose to archive to S3. Each consumer reads at its own pace from its own position in the stream.

**📖 Textbook ref**: §10 — Kinesis; §7 — Similar Service Comparison

---

### A10.7
**Correct: A and D** — Glue Crawlers + Glue ML transforms.

**Why**: Crawlers automatically detect new tables, columns, and schema changes when S3 data evolves. Glue ML transforms include `DetectPII` (identify columns containing PII like names, SSNs, emails) and `FindMatches` (deduplicate records). These are built-in, no custom ML model needed. Together, they handle automatic schema adaptation and sensitive data detection.

**📖 Textbook ref**: §10 — Glue, "Crawlers" and "Sensitive Data: DetectPII"

---

## 🔴 Similar Service Comparison — Answers

### A10.8
**Correct: C** — Amazon Athena.

**Why**: Athena is ideal for ad-hoc, unpredictable SQL queries. You pay only for data scanned — zero cost when not querying. Redshift (provisioned) charges hourly whether you query or not. EMR requires cluster startup time and charges for running instances. For exploratory analysis with idle periods, Athena's serverless model is the most cost-effective.

**📖 Textbook ref**: §10 — Athena, "vs Glue: Athena = query (ad-hoc, interactive)"

---

### A10.9
**Correct: B** — Kinesis Data Streams for both consumers.

**Why**: Kinesis supports multiple independent consumers reading from the same stream. The real-time anomaly detection consumer reads from the LATEST position (sub-second processing). The batch consumer reads from the TRIM_HORIZON once per day, processing 24 hours of accumulated data. Both consume the same stream independently — no duplication needed.

**📖 Textbook ref**: §10 — Kinesis, "Multi-consumer, per-consumer pacing"; §7 — Similar Service Comparison

---

> **📊 Chapter 10 Summary**: 3 Knowledge + 4 Scenario + 2 Comparison = 9 questions
