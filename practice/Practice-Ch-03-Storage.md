---
chapter: "3. Storage"
totalQuestions: 18
tiers:
  knowledge: 7
  scenario: 8
  comparison: 3
basedOn: "AWS-SAP-C02-Learning-Material.md §3"
services:
  - S3
  - EBS
  - EFS
  - FSx
  - Storage Gateway
  - Transfer Family
---

# Chapter 3 Practice: 💾 Storage

> **Instructions**: Complete Part A first. Do not scroll past the divider. Once finished, check Part B for answers and explanations.
> **Textbook**: `AWS-SAP-C02-Learning-Material.md`  → Section 3 (S3, EBS, EFS, FSx, Storage Gateway, Transfer Family) + Similar Service Comparison: Storage & Data Transfer

---

# Part A  → Questions

## 🟢 Knowledge Check (7 questions)

### Q3.1

> 🟡 L2-理解 | 🎤🎤 中频面试
A solutions architect needs to store data that is accessed once every few months for auditing purposes, where retrieval times of up to 12 hours are acceptable, and cost must be minimized. Which S3 storage class should be used?

- A. S3 Standard-Infrequent Access (Standard-IA)
- B. S3 Glacier Flexible Retrieval
- C. S3 Glacier Deep Archive
- D. S3 One Zone-Infrequent Access

### Q3.2

> 🟡 L2-理解 | 🎤🎤 中频面试
Which statement about S3 Cross-Region Replication (CRR) is correct?

- A. CRR replicates objects in near real-time and does not require versioning on the destination bucket
- B. CRR requires versioning to be enabled on both the source and destination buckets
- C. CRR replicates existing objects but not new objects after enabling
- D. CRR is a one-time sync operation

### Q3.3

> 🟡 L2-理解 | 🎤🎤 中频面试
A solutions architect needs to provide shared file storage accessible from hundreds of Linux EC2 instances across multiple Availability Zones. The storage must scale automatically and support NFS protocol. Which AWS service should be used?

- A. Amazon S3 mounted as a file system
- B. Amazon EBS with Multi-Attach enabled
- C. Amazon EFS (Elastic File System)
- D. Amazon FSx for Windows File Server

### Q3.4

> 🟢 L1-知识 | 🎤🎤 中频面试
What is the difference between EBS snapshots and EBS volumes in terms of Availability Zone scope?

- A. Both EBS volumes and snapshots are scoped to a single AZ
- B. EBS volumes are AZ-scoped; snapshots are Region-scoped (stored in S3)
- C. EBS volumes are Region-scoped; snapshots are AZ-scoped
- D. Both are Region-scoped

### Q3.5

> 🟡 L2-理解 | 🎤🎤 中频面试
A company needs a managed file transfer service that presents an SFTP interface to business partners, with files stored directly in S3. No EC2 instances should be managed. Which service meets these requirements?

- A. AWS Storage Gateway File Gateway
- B. AWS DataSync
- C. AWS Transfer Family
- D. Amazon FSx for Windows File Server

### Q3.6

> 🟡 L2-理解 | 🎤🎤 中频面试
Which feature of S3 replaces Origin Access Identity (OAI) for restricting S3 bucket access to CloudFront only?

- A. S3 Block Public Access
- B. S3 Access Points
- C. Origin Access Control (OAC)
- D. S3 Object Lock

### Q3.7

> 🟡 L2-理解 | 🎤🎤 中频面试
How does S3 Intelligent-Tiering reduce storage costs?

- A. It compresses objects to reduce their storage size
- B. It automatically moves objects between Frequent and Infrequent access tiers based on access patterns
- C. It deletes objects that haven't been accessed in 30 days
- D. It replicates objects to lower-cost Regions

---

## 🟡 Scenario Analysis (8 questions)

### Q3.8

> 🟡 L2-理解 | 🎤🎤 中频面试
A healthcare company stores medical images in S3. New images are accessed frequently for 30 days for diagnosis, then occasionally for 90 days for follow-ups, and must be retained for 7 years for regulatory compliance but are almost never accessed after the first year.

Which S3 lifecycle policy configuration minimizes cost while meeting these access requirements?

- A. Transition to S3 Standard-IA after 30 days, then to Glacier Deep Archive after 90 days
- B. Transition to S3 One Zone-IA after 30 days, then to Glacier Flexible Retrieval after 90 days, then to Glacier Deep Archive after 365 days
- C. Keep in S3 Standard indefinitely with Intelligent-Tiering enabled
- D. Transition to S3 Standard-IA after 30 days, then to Glacier Flexible Retrieval after 120 days, then to Glacier Deep Archive after 365 days

### Q3.9

> 🟡 L2-理解 | 🎤🎤 中频面试
A company needs to migrate 80 TB of on-premises file data from an NFS server to AWS. The migration must complete within 2 weeks, and the on-premises data center has a 1 Gbps internet connection. An initial full transfer followed by incremental syncs of changed data is acceptable.

Which migration approach should be used?

- A. AWS Snowball Edge
- B. AWS DataSync
- C. AWS Storage Gateway File Gateway
- D. S3 Transfer Acceleration with multi-part upload

### Q3.10

> 🟡 L2-理解 | 🎤🎤 中频面试
A company runs a high-performance computing (HPC) workload that processes large datasets stored in S3. The compute cluster requires a POSIX-compliant file system with sub-millisecond latency and the ability to lazily load data from S3 on first access. Which file system should be used?

- A. Amazon EFS
- B. Amazon FSx for Lustre
- C. Amazon FSx for Windows File Server
- D. Amazon EBS with Provisioned IOPS

### Q3.11

> 🟡 L2-理解 | 🎤🎤 中频面试
A company deploys Windows-based virtual desktops using Amazon WorkSpaces. User profile data (documents, settings, application data) must be stored centrally so users can log in to any WorkSpace and access their full profile. The solution must integrate with the company's on-premises Active Directory.

Which AWS service should store the user profiles?

- A. Amazon EFS with NFS mount
- B. Amazon S3 with S3 File Gateway
- C. Amazon FSx for Windows File Server
- D. Amazon EBS snapshots

### Q3.12

> 🟡 L2-理解 | 🎤🎤 中频面试
A solutions architect must ensure that all new EBS volumes in a Region are encrypted at rest by default. The company has hundreds of existing unencrypted volumes. What is the MOST efficient approach?

- A. Manually enable encryption on each existing volume and take new snapshots
- B. Enable EBS encryption by default in the Region; existing volumes are not affected but all new volumes will be encrypted
- C. Use AWS Config to detect unencrypted volumes and use Systems Manager Automation to encrypt them
- D. Delete all existing volumes and recreate them as encrypted

### Q3.13

> 🟡 L2-理解 | 🎤🎤 中频面试
A company wants to provide NFS file shares to on-premises servers with frequently accessed data cached locally. Less frequently accessed data should be automatically tiered to S3. The solution must work with the company's existing NFS clients without modification.

Which hybrid storage solution should be used?

- A. AWS DataSync with scheduled sync
- B. AWS Storage Gateway File Gateway
- C. AWS Transfer Family with SFTP
- D. AWS Direct Connect with Amazon EFS

### Q3.14

> 🟡 L2-理解 | 🎤🎤 中频面试
A company needs to provide a managed FTP service to external partners. Partners will upload files via FTPS (FTP over SSL). The files must be stored in S3 and be immediately processable. The solution must be highly available across multiple AZs.

Which service and configuration should be used?

- A. AWS Transfer Family with S3 backend and FTPS protocol enabled
- B. EC2 instance running vsftpd with an S3 sync cron job
- C. AWS Storage Gateway File Gateway with FTP access
- D. Amazon EFS with a managed FTP front-end

### Q3.15

> 🟡 L2-理解 | 🎤🎤 中频面试
A company has 500 GB of small log files (average 10 KB each) stored in S3 Standard. Access patterns are unpredictable  → some files are accessed daily, others sit untouched for months. The company wants to optimize costs without analyzing access patterns or creating lifecycle rules.

Which S3 feature should be used?

- A. S3 Standard-IA with a 30-day minimum storage duration
- B. S3 Intelligent-Tiering
- C. S3 One Zone-IA
- D. S3 Glacier Instant Retrieval

---

## 🔴 Similar Service Comparison (3 questions)

### Q3.16

> 🟡 L2-理解 | 🎤🎤 中频面试
A company is choosing between EBS, EFS, and S3 for an application that writes large volumes of log data and needs the data to be queryable by SQL later. Data is written continuously and must be durable against AZ failures. Which storage service should be chosen?

- A. EBS with io2 volumes in a single AZ
- B. EFS mounted to all application instances
- C. S3 with S3 Select or Athena for querying
- D. EBS with frequent snapshots to S3

### Q3.17

> 🟡 L2-理解 | 🎤🎤 中频面试
A solutions architect must transfer 200 TB of genomic data from an on-premises data center to an S3 bucket in AWS. The data center has a 500 Mbps internet connection shared with business-critical applications. The transfer must not impact business operations and should complete as quickly as practical.

Which transfer method should be used?

- A. S3 Transfer Acceleration over the existing internet connection
- B. AWS DataSync agent with bandwidth throttling
- C. AWS Snowball Edge (multiple devices if needed)
- D. AWS Direct Connect (dedicated 1 Gbps)

### Q3.18

> 🟡 L2-理解 | 🎤🎤 中频面试
A company wants to run a Windows application on EC2 that requires shared file storage with SMB protocol support and integration with the company's on-premises Active Directory. Several EC2 instances across two AZs need simultaneous read/write access. Which storage service should be used?

- A. Amazon EFS
- B. Amazon FSx for Windows File Server
- C. Amazon EBS with Multi-Attach
- D. Amazon S3 with a third-party SMB gateway

---

# Part B  → Answers & Explanations

> ⚠️ **STOP HERE.** Complete all questions in Part A before reading below.

---

## 🟢 Knowledge Check  → Answers

### A3.1
**Correct: C**  → S3 Glacier Deep Archive.

**Why**: Glacier Deep Archive is the lowest-cost S3 storage class, designed for long-term retention of data that is rarely accessed. Standard retrieval time is up to 12 hours (Bulk retrieval is 48 hours). It costs approximately $0.00099/GB/month  → about 1/10th the cost of S3 Standard. This is ideal for 7-year audit log retention.

**Why not the others**:
- **A**: Standard-IA is for infrequent access (millisecond retrieval)  → far more expensive than Deep Archive for rarely accessed data.
- **B**: Glacier Flexible Retrieval offers faster retrieval (minutes to hours) at a higher cost than Deep Archive.
- **D**: One Zone-IA stores data in a single AZ (not durable against AZ failure) and is not the cheapest option for archival.

**📖 Textbook ref**: §3  → S3, "Storage Classes: Glacier Deep Archive (12 hrs, cheapest)"

---

### A3.2
**Correct: B**  → CRR requires versioning to be enabled on both the source and destination buckets.

**Why**: S3 CRR automatically replicates new objects (and optionally existing objects) from a source bucket to a destination bucket in a different Region. A prerequisite is that versioning must be enabled on both buckets. Replication is ongoing and near real-time  → it's not a one-time sync.

**Why not the others**:
- **A**: Versioning IS required on the destination bucket as well as the source.
- **C**: With S3 Batch Replication, existing objects CAN be replicated. Without it, only new objects are replicated.
- **D**: CRR is ongoing replication, not one-time. S3 Sync (CLI) is one-time.

**📖 Textbook ref**: §3  → S3, "S3 Replication: CRR requires versioning on both source and destination"

---

### A3.3
**Correct: C**  → Amazon EFS (Elastic File System).

**Why**: EFS is a fully managed NFS file system that is Regional (accessible from any AZ in the Region). It automatically scales as data is added or removed  → no capacity provisioning needed. Hundreds or thousands of EC2 instances can mount the same EFS file system simultaneously. It is Linux-only (NFSv4 protocol).

**Why not the others**:
- **A**: S3 is object storage, not a mountable POSIX file system  → mounting S3 as a file system via third-party tools adds complexity and latency.
- **B**: EBS Multi-Attach (io2 only) supports a limited number of instances within a single AZ.
- **D**: FSx for Windows uses SMB, not NFS  → SMB is for Windows, NFS is for Linux.

**📖 Textbook ref**: §3  → EFS, "Multi-AZ: Regional  → accessible from any AZ"; Similar Service Comparison, "S3 vs EBS vs EFS vs FSx"

---

### A3.4
**Correct: B**  → EBS volumes are AZ-scoped; snapshots are Region-scoped (stored in S3).

**Why**: An EBS volume exists in a single Availability Zone and can only be attached to EC2 instances in that same AZ (except io2 Multi-Attach, which is still AZ-limited). EBS snapshots are stored in Amazon S3 (invisible to you as EBS resources), which is Regionally resilient  → snapshots are available from any AZ in the Region. You can create a new volume from a snapshot in any AZ in the same Region.

**Why not the others**:
- **A**: Snapshots are not AZ-scoped  → they live in S3 and work cross-AZ.
- **C & D**: Both are wrong  → volumes are AZ-scoped, snapshots are Region-scoped.

**📖 Textbook ref**: §3  → EBS, "Azure Bridge: EBS is AZ-scoped"

---

### A3.5
**Correct: C**  → AWS Transfer Family.

**Why**: AWS Transfer Family is a fully managed service that provides SFTP, FTPS, and FTP interfaces backed by S3 (or EFS). No servers to manage  → you configure the endpoint, authenticate users (Service Managed, AD, or custom IdP), and files are stored directly in S3. This is the serverless, managed approach to file transfer.

**Why not the others**:
- **A**: File Gateway presents NFS/SMB shares, not SFTP.
- **B**: DataSync is for bulk data transfer/migration, not an ongoing SFTP service.
- **D**: FSx for Windows provides SMB shares, not SFTP.

**📖 Textbook ref**: §3  → Transfer Family, "Managed SFTP/FTPS/FTP with S3 backend"

---

### A3.6
**Correct: C**  → Origin Access Control (OAC).

**Why**: OAC is the recommended way to restrict S3 bucket access to only CloudFront. It replaces the older Origin Access Identity (OAI) method. OAC supports additional features like SSE-KMS encrypted buckets and granular policy conditions. With OAC, CloudFront uses a signed request that S3 validates, ensuring the S3 bucket URL cannot be accessed directly.

**Why not the others**:
- **A**: Block Public Access prevents all public access  → it doesn't selectively allow CloudFront.
- **B**: Access Points provide named network endpoints with permissions but don't specifically restrict to CloudFront.
- **D**: Object Lock is for WORM (Write Once Read Many) compliance, not access control.

**📖 Textbook ref**: §3  → S3, "S3 + CloudFront: OAC replaces OAI"

---

### A3.7
**Correct: B**  → It automatically moves objects between Frequent and Infrequent access tiers based on access patterns.

**Why**: S3 Intelligent-Tiering monitors access patterns of objects and automatically moves them between the Frequent Access tier and the Infrequent Access tier (and within the Archive Instant Access and Deep Archive Access tiers for the optional asynchronous tiers). If an object is not accessed for 30 consecutive days, it is moved to the Infrequent tier (lower cost). If accessed again, it moves back to Frequent. There are no retrieval fees  → you pay only a small per-object monitoring fee.

**Why not the others**:
- **A**: Intelligent-Tiering does not compress data.
- **C**: Intelligent-Tiering does not delete data.
- **D**: Intelligent-Tiering does not replicate data.

**📖 Textbook ref**: §3  → S3, "S3 Intelligent-Tiering: Auto-moves based on access patterns"

---

## 🟡 Scenario Analysis  → Answers

### A3.8
**Correct: D**  → Transition to S3 Standard-IA after 30 days, then to Glacier Flexible Retrieval after 120 days, then to Glacier Deep Archive after 365 days.

**Why**: The access pattern maps to storage classes:
- **0 → 0 days**: Frequent diagnostic access  → keep in S3 Standard (not mentioned as a transition  → it starts here).
- **30 → 20 days**: Occasional follow-up access (milliseconds retrieval acceptable)  → Standard-IA.
- **120 days →  year**: Accessed occasionally (minutes to hours retrieval acceptable)  → Glacier Flexible Retrieval.
- **> 1 year**: Regulatory retention, almost never accessed  → Glacier Deep Archive (cheapest).

The transitions match: Standard  → Standard-IA at 30 days  → Glacier Flexible at 120 days  → Deep Archive at 365 days.

**Why not the others**:
- **A**: Skips the Flexible Retrieval tier  → going directly to Deep Archive at 90 days is too aggressive when data is still occasionally accessed.
- **B**: One Zone-IA is not durable against AZ failure  → inappropriate for medical records requiring durability. Plus, Flexible Retrieval at 90 days is too soon  → data is accessed until 120 days.
- **C**: Intelligent-Tiering is for unpredictable access  → this access pattern is predictable (time-based).

**📖 Textbook ref**: §3  → S3, "Storage Classes" continuum; §3  → Common Pitfalls

---

### A3.9
**Correct: B**  → AWS DataSync.

**Why**: DataSync is designed for online data transfer between on-premises and AWS (S3, EFS, FSx). With a 1 Gbps connection, transferring 80 TB would take approximately 8 →  days at full utilization (80 TB × 8 bits/byte ÷ 1 Gbps  → 178 hours), which fits within the 2-week window. DataSync supports incremental sync after the initial full transfer. Bandwidth throttling prevents saturation of the shared connection.

**Why not the others**:
- **A**: Snowball Edge is for > 10 TB when the network is too slow or expensive  → 1 Gbps can handle 80 TB within the timeframe.
- **C**: Storage Gateway provides ongoing access, not one-time migration.
- **D**: S3 Transfer Acceleration improves upload speed over long distances but doesn't provide the scheduling, throttling, and incremental sync features needed.

**📖 Textbook ref**: §3  → Similar Service Comparison, "S3 CRR vs DataSync vs Storage Gateway vs Snow Family"; §9  → Migration, "DataSync: Online file transfer"

---

### A3.10
**Correct: B**  → Amazon FSx for Lustre.

**Why**: FSx for Lustre is purpose-built for HPC workloads. Key features matching the scenario: (1) sub-millisecond latencies, (2) POSIX-compliant file system, (3) seamless S3 integration  → it can "lazy load" data from S3 on first access, meaning the Lustre file system appears to contain all S3 objects, but data is pulled from S3 only when accessed. This is ideal for HPC processing of S3 datasets.

**Why not the others**:
- **A**: EFS is NFS-based and designed for general-purpose shared storage  → it doesn't offer sub-millisecond latency or the S3 lazy-load integration.
- **C**: FSx for Windows uses SMB protocol and is designed for Windows workloads, not Linux HPC.
- **D**: EBS is block storage for single instances (except io2 Multi-Attach, which is AZ-limited)  → not shared across an HPC cluster.

**📖 Textbook ref**: §3  → FSx, "FSx for Lustre: Sub-millisecond latencies, integrates with S3 (lazy load data)"

---

### A3.11
**Correct: C**  → Amazon FSx for Windows File Server.

**Why**: FSx for Windows provides fully managed Windows file shares (SMB protocol) that integrate with on-premises Active Directory. Combined with FSLogix profile containers, you can store user profiles on FSx  → users can log in to any WorkSpace and their profile is mounted from the central FSx share. This is the native AWS solution for Windows profile management with WorkSpaces.

**Why not the others**:
- **A**: EFS is NFS (Linux), not SMB (Windows)  → WorkSpaces (Windows) needs SMB.
- **B**: S3 File Gateway is for hybrid access, not a native file system for WorkSpaces profiles.
- **D**: EBS snapshots are backup  → not shared file storage accessible simultaneously from multiple WorkSpaces.

**📖 Textbook ref**: §3  → FSx, "FSx for Windows: Used with WorkSpaces for user profiles"; §13  → WorkSpaces, "FSx for User Profiles"

---

### A3.12
**Correct: B**  → Enable EBS encryption by default in the Region; existing volumes are not affected but all new volumes will be encrypted.

**Why**: "EBS encryption by default" is a Region-level setting. Once enabled, all new EBS volumes and snapshots created in that Region are automatically encrypted at rest using the specified KMS key. Existing unencrypted volumes are not retroactively encrypted  → this is important because encrypting an existing volume requires creating an encrypted snapshot and restoring it, which involves downtime.

**Why not the others**:
- **A**: Manually encrypting hundreds of volumes individually is not efficient.
- **C**: This is a valid approach for encrypting existing volumes, but the question asks for the most efficient approach to ensure new volumes are encrypted  → that's simply enabling the default setting.
- **D**: Deleting and recreating causes unacceptable downtime and data loss risk.

**📖 Textbook ref**: §3  → EBS, "Encryption by Default: Can be enabled per Region"

---

### A3.13
**Correct: B**  → AWS Storage Gateway File Gateway.

**Why**: File Gateway provides NFS (and SMB) file shares to on-premises servers. It caches frequently accessed data on the local gateway appliance (low latency for hot data) while automatically tiering infrequently accessed data to S3. The on-prem NFS clients see a standard NFS share  → no modifications needed. S3 Lifecycle policies can further reduce costs by transitioning cold data to Glacier storage classes.

**Why not the others**:
- **A**: DataSync is for migration/sync, not ongoing access with local caching.
- **C**: Transfer Family provides SFTP/FTPS/FTP  → not NFS shares.
- **D**: Direct Connect provides network connectivity, not a file storage service.

**📖 Textbook ref**: §3  → Storage Gateway, "File Gateway: NFS/SMB shares backed by S3"

---

### A3.14
**Correct: A**  → AWS Transfer Family with S3 backend and FTPS protocol enabled.

**Why**: Transfer Family supports FTP, FTPS (FTP over SSL), and SFTP protocols natively. With S3 as the backend, files uploaded by partners are stored directly in S3 and immediately available for processing. Transfer Family is Multi-AZ (via Elastic IP failover). This is a fully managed service  → no EC2 instances to manage.

**Why not the others**:
- **B**: Self-managed EC2 with vsftpd requires OS patching, scaling, and HA management  → more operational overhead.
- **C**: File Gateway provides NFS/SMB, not FTP/S protocols.
- **D**: EFS does not natively provide an SFTP or FTPS interface.

**📖 Textbook ref**: §3  → Transfer Family, "Managed SFTP/FTPS/FTP service" and "Highly Available: Multi-AZ deployment"

---

### A3.15
**Correct: B**  → S3 Intelligent-Tiering.

**Why**: The scenario has two key requirements: (1) unpredictable access patterns, and (2) no desire to analyze patterns or create lifecycle rules. Intelligent-Tiering is designed for exactly this  → it automatically moves objects between Frequent and Infrequent tiers based on actual access patterns, with no management overhead. However, the student should note that with 10 KB average object size and the per-object monitoring fee (~$0.0025/1000 objects), 500 GB of 10 KB files = ~50 million objects, resulting in ~$125/month in monitoring fees. This is an important cost consideration, but the question asks specifically about the feature designed for this use case.

**Why not the others**:
- **A**: Standard-IA has a 30-day minimum storage duration  → if files are accessed within 30 days, you pay retrieval costs. It requires lifecycle rules.
- **C**: One Zone-IA doesn't survive AZ failure and still requires lifecycle rules.
- **D**: Glacier Instant Retrieval is for long-term archive with instant access  → too expensive for potentially frequently accessed data.

**📖 Textbook ref**: §3  → S3, "S3 Intelligent-Tiering" and "Common Pitfalls"

---

## 🔴 Similar Service Comparison  → Answers

### A3.16
**Correct: C**  → S3 with S3 Select or Athena for querying.

**Why**: S3 is Regionally resilient (survives AZ failure), handles continuous writes of any volume, and is cost-effective for log data. S3 Select lets you run SQL queries directly on objects (retrieving only the needed data), and Athena lets you run full SQL queries on S3 data without loading it into a database. This combination is ideal for logging  → querying workflows.

**Why not the others**:
- **A**: EBS in a single AZ does not survive AZ failure.
- **B**: EFS is shared but far more expensive per GB than S3 for log storage. It's also Linux-only (NFS).
- **D**: EBS with snapshots adds complexity (snapshot scheduling, management) and doesn't provide native SQL querying.

**📖 Textbook ref**: §3  → Similar Service Comparison, "S3 vs EBS vs EFS vs FSx"; §10  → Athena

---

### A3.17
**Correct: C**  → AWS Snowball Edge (multiple devices if needed).

**Why**: At 500 Mbps with business traffic, transferring 200 TB would take ~37 days at maximum speed, and you can't use the full bandwidth without impacting business operations. Snowball Edge (80 TB per device)  → 3 devices can handle 200 TB in parallel. The physical transfer (ship  → AWS  → data loaded to S3) takes about a week per device. This is far faster than online transfer and doesn't impact business internet.

**Why not the others**:
- **A**: S3 Transfer Acceleration helps with latency but not bandwidth  → you're still limited by the 500 Mbps pipe.
- **B**: DataSync with throttling would take even longer with reduced bandwidth.
- **D**: Installing Direct Connect for a one-time 200 TB migration is not cost-effective and takes weeks to provision.

**📖 Textbook ref**: §3  → Similar Service Comparison, "S3 CRR vs DataSync vs Storage Gateway vs Snow Family"; §9  → Snow Family, "> 10 TB, slow/expensive network"

---

### A3.18
**Correct: B**  → Amazon FSx for Windows File Server.

**Why**: FSx for Windows provides native SMB protocol support, integrates with on-premises Active Directory (either directly or via AD Connector), and supports Multi-AZ deployment for high availability. Multiple EC2 instances across two AZs can mount the same FSx file system simultaneously via SMB. This is the native, managed Windows shared storage solution on AWS.

**Why not the others**:
- **A**: EFS uses NFS (Linux), not SMB (Windows)  → it cannot serve as native Windows shared storage.
- **C**: EBS Multi-Attach is for io2 volumes in a single AZ  → limited to a small number of instances.
- **D**: A third-party SMB gateway on EC2 adds management overhead and potential performance bottlenecks vs. a native managed service.

**📖 Textbook ref**: §3  → FSx, "FSx for Windows: SMB, DFS, Active Directory integration"; Similar Service Comparison, "S3 vs EBS vs EFS vs FSx"

---

> **📊 Chapter 3 Summary**: 7 Knowledge + 8 Scenario + 3 Comparison = 18 questions
> 
> **Next**: If you missed any questions, review the corresponding section in `AWS-SAP-C02-Learning-Material.md` and add the Q number to your missed question tracker.
