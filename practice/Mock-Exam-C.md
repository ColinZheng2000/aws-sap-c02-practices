---
title: "AWS SAP-C02 Mock Exam C"
totalQuestions: 50
timeLimit: 180
focus: "Cross-domain integration, hardest traps, Choose Two/Three"
difficulty: "Hard (冲刺卷)"
answerDistribution: "balanced A/B/C/D"
---

# AWS SAP-C02 Mock Exam C — 冲刺卷

> HARDEST MOCK. Cross-domain integration, multi-select emphasis, anti-pattern traps.
> **Answer position pre-assigned before writing — balanced ~25% each A/B/C/D.**
> Scored out of 65 (10 questions unscored/preview). Target: 70% (46/65).

---

# Part A — Questions

---

### Q1 — Correct answer: A
Org uses deny-list SCP (default FullAWSAccess). New regulation: specific OU may ONLY use S3, EC2, Lambda. Current OU has several Deny SCPs.

- A. Replace Deny SCPs with single Allow SCP (S3+EC2+Lambda only), still inherits FullAWSAccess → effective deny else
- B. Add more Deny SCPs for each disallowed service — cannot deny what hasn't been allowed, Deny SCPs cannot create allow-list effect
- C. Keep existing SCPs, add IAM policies per account — IAM policies cannot override SCP deny
- D. Move OU to a new organization — unnecessary; SCP is the correct mechanism

### Q2 — Correct answer: C, E
Security found S3 bucket with Principal:"*" in bucket policy. Must prevent this org-wide across 30 accounts. Preventive, not detective. (Choose two.)

- A. SCP denying s3:PutBucketPolicy when policy contains Principal:"*" — SCP cannot inspect policy document content
- B. IAM Access Analyzer to detect public buckets — detective, not preventive
- C. S3 Block Public Access enforced at account level via SCP (s3:PutBucketPublicAccessBlock)
- D. Config rule s3-bucket-public-read-prohibited — detective, not preventive
- E. SCP denying s3:PutBucketPolicy unless combined with required BPA settings

### Q3 — Correct answer: C
Third-party auditor needs read-only access to all resources in Account A for exactly 8 hours, once per quarter. Auditor has its own AWS account. No long-lived credentials allowed in Account A.

- A. Share Access Key/Secret Key — violates no-long-lived-credentials, security anti-pattern
- B. Create IAM user with ReadOnlyAccess, delete after 8h — leaves credential window; user must be deleted manually
- C. IAM role with ReadOnlyAccess + trust policy allowing auditor's account + session policy with time-bounded condition (aws:CurrentTime)
- D. AWS RAM to share resources temporarily — RAM shares specific resources, not account-wide read access

### Q4 — Correct answer: B
Tag policy requires `Environment: prod/staging/dev`. SCP enforces tag on resource creation. Dev's CloudFormation fails: RDS instance created but `Environment` tag applied to stack, NOT the resource.

- A. SCP cannot evaluate CloudFormation tags — SCP evaluates API calls regardless of source
- B. CloudFormation must specify tags at **resource level** (not just stack level); stack-level tags don't propagate to all resources
- C. SCPs evaluated before CloudFormation creates resources — SCPs evaluate at API call time, correct behavior
- D. RDS doesn't support tag-based access control — RDS fully supports tags and tag-based authorization

### Q5 — Correct answer: D
Multi-account networking: 200 VPCs across 50 accounts. All must reach on-prem via Direct Connect. Dev and Prod isolated. Shared services reachable by all. Must scale to 1000 VPCs.

- A. VPC Peering mesh with route tables — doesn't scale (N×(N-1)/2 peering connections), management nightmare
- B. TGW with multiple route tables (Dev/Prod/Shared), all with Direct Connect Gateway — works but limited to 5000 attachments per TGW
- C. PrivateLink for all inter-VPC communication — doesn't scale for transitive routing, cost-prohibitive at scale
- D. Cloud WAN with core network policy — purpose-built for global multi-segment networks with segmentation, scales to thousands of VPCs

### Q6 — Correct answer: B
Cross-account IAM role: Account A developer assumes role in Account B. Role has `s3:*`, but gets AccessDenied on `ListBucket`. S3 bucket policy in Account B explicitly denies access from outside Account B.

- A. Grant developer `s3:*` in Account A — doesn't help; role in Account B is assumed, bucket policy is in Account B
- B. Modify bucket policy to allow role's ARN from Account B — explicit deny in bucket policy overrides role permissions; need bucket policy Allow
- C. Move bucket to Account A — unnecessary, cross-account S3 access is standard
- D. Use S3 Access Points to bypass bucket policy — Access Points have their own policy but bucket policy still applies

### Q7 — Correct answer: C
Account A (app EC2) needs to connect to Account B (RDS) via private IP. Non-overlapping CIDRs. Secure, private connectivity without exposing RDS to internet.

- A. VPC Peering + SGs + route tables — works but requires network admin coordination, less granular
- B. Internet-facing RDS with SG whitelisting — exposes RDS to internet, security risk
- C. PrivateLink with NLB in Account B fronting RDS — private connectivity, Account A consumes endpoint service, no VPC peering needed
- D. Cross-account IAM role for EC2 — IAM controls permissions, not network connectivity

### Q8 — Correct answer: C
IAM Identity Center: Dev group assigned Administrator to all accounts. Should be Administrator in dev account only, ReadOnly in prod.

- A. Create two groups: Dev-Admins and Dev-ReadOnly — doubles group management overhead
- B. Use IAM policies per account to override — Identity Center manages permissions through permission sets, not IAM policies
- C. Use different permission sets per account assignment — assign Administrator permission set to dev account, ReadOnly permission set to prod account, same group
- D. SCP to limit Administrator access in prod — SCPs restrict maximum permissions but don't grant; need correct permission set assignment

### Q9 — Correct answer: D
Detect when IAM role trust policy is modified to allow an external AWS account. Need near-real-time detection (within 15 minutes).

- A. Config managed rule periodic evaluation — periodic triggers may miss 15-min window
- B. Trusted Advisor security checks — not real-time, periodic checks only
- C. IAM Access Analyzer policy validation — validates policy syntax, doesn't detect trust policy changes in real-time
- D. EventBridge rule on `iam:UpdateAssumeRolePolicy` CloudTrail event → filter for cross-account principals → SNS alert

### Q10 — Correct answer: B
Root SCP denies `s3:CreateBucket` outside eu-west-1, eu-west-2. Legal needs one account to create buckets in us-east-1. How to grant exception without removing restriction for all?

- A. Detach root SCP, recreate per OU except exception account — high operational overhead
- B. Move exception account to separate OU, attach SCP allowing us-east-1 bucket creation — SCPs are cumulative; OU-level SCP can override root for that OU
- C. Remove account from organization — loses centralized billing, SCP governance
- D. Remove S3 restriction from root, add per-OU policies — affects all accounts during transition window

### Q11 — Correct answer: B
User uploads video → virus scan (30s) → transcode (up to 2 hours) → generate thumbnails (5 min) → notify user. Each step needs error handling with retry logic. Serverless.

- A. EventBridge with rules per step — no built-in retry/error handling, complex state management
- B. Step Functions Standard workflow with retry/catch config per state — designed for long-running multi-step workflows with error handling
- C. SQS with multiple queues + Lambda per step — manual error handling, DLQ complexity across 4 steps
- D. Glue workflow — designed for ETL, not general-purpose serverless orchestration

### Q12 — Correct answer: D
IoT: 100K events/sec globally, process within 5 seconds. Burst to 500K/sec. Per-device ordering required. Minimize operational overhead.

- A. API Gateway → SQS FIFO → Lambda — API Gateway throttles, SQS FIFO limits to 3000 msg/sec
- B. SNS → SQS Standard → EC2 ASG — no ordering guarantee, EC2 management overhead
- C. EventBridge → Step Functions → Lambda — EventBridge not designed for 500K/sec ingestion
- D. Kinesis Data Streams with enhanced fan-out → Lambda consumers, partition key = device_id → per-device ordering, auto-scales shards

### Q13 — Correct answer: D
"Thundering herd" problem: cached DB query expires in ElastiCache Redis, 1000 simultaneous requests hit the database. Must prevent DB overload.

- A. Redis Multi-AZ failover — high availability, not cache stampede prevention
- B. Redis read replicas — distributes read load but doesn't prevent all 1000 hitting DB on cache miss
- C. Increase RDS instance size — treats symptom not cause, cost-inefficient
- D. Probabilistic early expiration + SETNX distributed lock — staggered cache refresh, only one request fetches from DB

### Q14 — Correct answer: A
S3 objects: frequently accessed first 30 days, occasionally next 60 days, almost never after 90 days. Retain 7 years. All objects follow same pattern.

- A. S3 Intelligent-Tiering from day 0 — automatically moves objects between Frequent/Infrequent/Archive tiers based on access patterns, no retrieval charges for tier changes
- B. Lifecycle: Standard-IA at 30d, Glacier Flexible at 90d — manual lifecycle, retrieval costs, less granular
- C. Standard-IA at 30d, Glacier Deep Archive at 90d — Deep Archive minimum 180 days, early deletion fee
- D. Keep all in Standard — highest cost for rarely-accessed data

### Q15 — Correct answer: B
DynamoDB time-series: all writes to current timestamps, queries primarily last 24 hours, occasional 7-day scans. 5 years of data, growing. Optimize performance and cost.

- A. GSI on timestamp — helps query but doesn't reduce storage cost of old data
- B. TTL to auto-delete data older than 30 days, export to S3 for long-term retention/queries via Athena
- C. Increase RCU for full table scans — cost-inefficient for occasional scans
- D. DynamoDB Streams to archive old data — adds complexity but doesn't solve the query problem

### Q16 — Correct answer: B
Lambda in VPC private subnets. Needs: `PutMetricData` to CloudWatch + DynamoDB access + external HTTPS API. Currently: DynamoDB works (VPC Endpoint exists), CloudWatch and HTTPS API fail.

- A. VPC Endpoint for CloudWatch Metrics — correct but doesn't solve HTTPS API access
- B. NAT Gateway (for HTTPS API) + VPC Endpoint for CloudWatch Metrics — both needed; DynamoDB already has endpoint
- C. Internet Gateway for VPC — Lambda in private subnet can't use IGW
- D. Lambda execution role with `cloudwatch:PutMetricData` — permissions don't provide network path

### Q17 — Correct answer: D
Windows application requires: SMB protocol, Active Directory integration for file ACLs, Multi-AZ deployment, <1ms latency, integration with Managed Microsoft AD.

- A. EFS — NFSv4, Linux-oriented, no native SMB support
- B. S3 with SMB gateway — S3 doesn't support SMB natively; gateway adds latency
- C. Storage Gateway File Gateway — SMB supported but single-AZ, latency depends on cache/local deployment
- D. FSx for Windows File Server with SSD storage — native SMB, AD-integrated, Multi-AZ, <1ms latency with SSD

### Q18 — Correct answer: C
Global serverless application: North America, Europe, Asia-Pacific. WebSocket for real-time updates. DynamoDB backend. No idle cost desired. Sub-second latency.

- A. EC2 + ALB in 3 Regions + Global Tables + Route53 latency — EC2 idle cost, management overhead
- B. Lambda + API Gateway WebSocket + Global Tables — API Gateway WebSocket is regional, not global-routed
- C. AppSync with WebSocket subscriptions + DynamoDB Global Tables + Lambda resolvers — managed WebSocket, multi-region data, no idle cost
- D. ECS Fargate + NLB + Global Tables + Global Accelerator — Fargate has minimum running task cost

### Q19 — Correct answer: D
EKS cluster for ML inference. 200ms per inference request, requires GPU. 0 requests at night, up to 10K req/min during day. Minimize cost, guaranteed GPU availability at peak.

- A. EKS EC2 GPU instances always running at peak capacity — idle GPU at night, expensive
- B. EKS Fargate GPU — Fargate doesn't support GPU instances
- C. EKS with Karpenter autoscaler + GPU nodes, scale to zero at night — GPU cold start 2-5 min, can't handle sudden 10K spike
- D. SageMaker inference endpoints with auto-scaling — managed GPU inference, scale to zero option, handles latency-sensitive workloads, pay-per-use

### Q20 — Correct answer: C
Oracle 5TB → Aurora PostgreSQL. Heavy PL/SQL stored procedures (~200). Minimize code changes. Replatform approach, not full refactor.

- A. DMS homogeneous migration — DMS doesn't convert Oracle PL/SQL to PostgreSQL PL/pgSQL
- B. SCT convert schema + completely rewrite PL/SQL manually — maximum code change, opposite of replatform goal
- C. SCT for schema conversion + SCT automatic PL/SQL to PL/pgSQL conversion (SCT automates ~85%+), manual fix remaining ~15%
- D. Babelfish for Aurora — Babelfish translates SQL Server T-SQL to PostgreSQL, NOT Oracle PL/SQL

### Q21 — Correct answer: B
5 PB of historical data already in S3 (Parquet + CSV). Business analysts need exploratory, ad-hoc SQL queries. No infrastructure to manage. Query patterns unpredictable.

- A. Redshift Spectrum — requires Redshift cluster, infrastructure to manage
- B. Athena — serverless SQL engine directly on S3, pay-per-query, no infrastructure, supports Parquet/CSV
- C. EMR with Hive — requires cluster management, overkill for ad-hoc
- D. Glue with Spark SQL — ETL-focused, requires job configuration

### Q22 — Correct answer: D, E
SQS queue buffers work for EC2 Auto Scaling workers. During scale-in, an instance is terminated while processing a message. Message reappears after visibility timeout. Must prevent wasted processing. (Choose two.)

- A. Scale-in protection on processing instances — protects from scale-in but doesn't integrate with SQS
- B. Lifecycle hook on termination to drain messages — terminates after hook timeout, may still lose messages
- C. Increase visibility timeout to 12 hours — doesn't prevent termination, just delays message reappearance
- D. ASG instance termination lifecycle hook → complete message processing → signal ASG to proceed with termination
- E. Set max instance lifetime to prevent scale-in during processing — helps but lifecycle hook is the proper mechanism

### Q23 — Correct answer: A
AWS Backup: daily RDS snapshots, 30-day retention in primary Region, copy to DR Region with 90-day retention. After 30 days, source backup is deleted. Can the DR copy still be restored?

- A. Yes — AWS Backup cross-Region copies are independent backups; source deletion does NOT affect copies
- B. No — DR copies are tied to source backup lifecycle
- C. Only if Vault Lock is enabled on the DR vault
- D. Only for RDS; DynamoDB cross-Region copies behave differently

### Q24 — Correct answer: B
CloudFront serves a Single Page Application (SPA) from S3 origin. Client-side routing uses History API (`/dashboard`, `/settings`). Refreshing `/dashboard` returns 404 from CloudFront — no such object in S3.

- A. S3 static website redirect rules — S3 redirects work for S3 website hosting, not CloudFront S3 origin
- B. CloudFront custom error response: 404 → `/index.html` with 200 OK response code — SPA fallback pattern
- C. Lambda@Edge origin request to rewrite path to `/index.html` — works but more complex than custom error response
- D. S3 bucket policy to allow public read on all objects — doesn't solve the SPA routing problem

### Q25 — Correct answer: C
API Gateway Regional endpoint, 50 REST endpoints. DDoS attack: 100K req/sec from 10K+ IPs. Legitimate traffic comes from known partner IP ranges. Most effective + cost-efficient.

- A. API Gateway account-level throttling — limits total, doesn't distinguish legitimate vs attack traffic
- B. Switch to edge-optimized endpoint — regional vs edge doesn't provide DDoS protection; same WAF applies
- C. WAF Regional Web ACL with IP set allowlist (known partners) + rate-based rule blocking high-rate non-allowlisted IPs
- D. Shield Advanced without WAF — Shield Advanced provides volumetric DDoS protection but without WAF rules can't filter application-layer attacks

### Q26 — Correct answer: A
Config rule detects 50 unencrypted EBS volumes across accounts. Must auto-remediate — encrypt them automatically when detected.

- A. Config auto-remediation with SSM Automation runbook — snapshot → copy encrypted → replace volume, triggered by Config rule non-compliance
- B. Manual snapshot-copy-encrypt-reattach — doesn't scale to 50 volumes, manual effort
- C. Enable EBS encryption by default — only applies to new volumes, doesn't fix existing 50
- D. AWS Backup re-encrypt existing volumes — AWS Backup copies data but doesn't encrypt in-place existing volumes

### Q27 — Correct answer: D
S3 bucket: objects under `/financial-records/` must replicate to DR Region within 15 minutes (99.99% SLA). Rest of bucket uses standard CRR with 15-minute replication time.

- A. S3 Batch Replication — one-time batch job for existing objects, not ongoing replication
- B. Two separate CRR rules — CRR is typically within 15 minutes but doesn't provide SLA guarantee
- C. DataSync scheduled every 15 minutes — operational overhead, network-dependent, not event-driven
- D. S3 Replication Time Control (RTC) enabled on replication rule filtered to `/financial-records/` prefix — 15-minute SLA, 99.99% replication within 15 min

### Q28 — Correct answer: C
ECS Fargate task processing S3 files: S3 PutObject → Lambda validates (5 seconds) → triggers ECS RunTask (30 minutes processing). Task fails silently after ~10 minutes sometimes. No errors in Lambda.

- A. Fargate has 15-minute maximum runtime — FALSE; Fargate can run indefinitely (no time limit)
- B. ECS task IAM role lacks S3 permissions — would fail immediately, not after 10 minutes
- C. Check CloudWatch Logs for the ECS task — likely the processing encounters an unhandled exception; Fargate has no time limit
- D. Lambda timeout prevents task start — Lambda succeeds (validates), ECS task starts and runs

### Q29 — Correct answer: B
ASG Launch Template specifies `t3.large`. New `t4.large` instance type is 20% cheaper, 15% faster. Want ASG to automatically use `t4.large` without manual Launch Template updates.

- A. Manually update Launch Template whenever new types appear — operational overhead
- B. Attribute-Based Instance Type Selection (ABIS) — specify vCPU and memory requirements as attributes, ASG automatically selects compatible types including new generations
- C. Spot Fleet with instance diversification — for Spot cost optimization, not for adopting new instance generations
- D. Compute Optimizer auto-update template — Compute Optimizer recommends but doesn't automatically update Launch Templates

### Q30 — Correct answer: A
Legacy app on EC2 behind ALB. App config hardcodes ALB DNS name. CloudFormation recreates ALB → new DNS name → application outage.

- A. Route53 CNAME record (app.example.com → ALB DNS) + use CNAME in app config — DNS abstraction, ALB can be replaced without config change
- B. Reserve ALB DNS name in Route53 — ALB DNS names cannot be reserved
- C. Elastic IP on ALB — ALB doesn't support Elastic IP; NLB does
- D. Global Accelerator for static IPs — provides static anycast IPs but app config would still need update if using GA vs ALB DNS

### Q31 — Correct answer: B
Critical stateful app: 2 EC2 + ALB + RDS MySQL. DR requirements: App RPO 2 min / RTO 30 min, DB RPO 5 min / RTO 30 min. No architecture changes allowed. Optimal post-failover latency.

- A. AWS Backup for both EC2 and RDS with cross-Region copy — RPO measured in hours, not minutes
- B. DRS (Elastic Disaster Recovery) for EC2 continuous replication + RDS Cross-Region Read Replica — DRS provides sub-second RPO for block-level replication; Read Replica provides near-real-time DB replication
- C. DLM EC2 snapshots + RDS automated backups cross-Region — snapshot-based, RPO not 2 minutes
- D. Multi-Region active-active — requires significant architecture changes (DNS routing, data sync conflicts)

### Q32 — Correct answer: D
Redshift `ra3.4xlarge` cluster. Month-end: query queues grow, some queries time out. Normal operations: enough storage and compute.

- A. Redshift Spectrum to offload queries — Spectrum queries external data in S3, doesn't add compute to existing cluster
- B. Redshift Data Sharing — shares data between clusters, doesn't add compute capacity
- C. Increase WLM query timeout — queries would still wait in queue, just not timeout
- D. Concurrency Scaling — automatically adds transient clusters during query spikes, handles queuing without manual intervention

### Q33 — Correct answer: A
Single NAT Gateway in one AZ. AZ failure → all private subnets lose internet. Fix?

- A. NAT Gateway in every AZ, each AZ's private route table routes 0.0.0.0/0 to local NAT Gateway — AZ fault isolation
- B. Direct Connect for all internet traffic — Direct Connect is private, not internet
- C. NAT instances instead of NAT Gateway — NAT instances are single-AZ too, not inherently HA
- D. VPC endpoints for all AWS services — only covers AWS APIs, not general internet

### Q34 — Correct answer: A
Developer created IAM role with `"*"` permissions + trust policy allowing `Principal: "*"` (any AWS account). Data exfiltrated before discovered. Developer claims "CloudFormation did it." How to prevent?

- A. SCP denying `iam:CreateRole` and `iam:UpdateAssumeRolePolicy` when trust policy contains `Principal: "*"` — SCP prevents the API call at org level
- B. IAM Access Analyzer preview in CloudFormation Change Sets — detects but doesn't prevent
- C. Config rule detecting overly permissive roles — detective, not preventive
- D. Manual code review required before deployment — doesn't scale, human error

### Q35 — Correct answer: D
Route53 failover between two Regions, TTL 60 seconds. During failover test, some users experience 5 minutes of downtime despite TTL. Need consistent sub-60-second failover.

- A. Route53 not designed for sub-60s failover — Route53 health checks can be as low as 10 seconds
- B. Reduce health check interval from 30s to 10s — helps but doesn't solve the caching problem
- C. CloudFront doesn't support fast failover — CloudFront is CDN, not the DNS resolution issue
- D. Some ISP DNS resolvers ignore or increase TTL; Route53 health check at 10s interval + lower TTL (10s) + multiple health checkers in different Regions for faster failover detection

### Q36 — Correct answer: D
Critical API needs fastest possible cross-Region failover. HTTP/HTTPS. Two Regions. DNS failover is too slow (TTL propagation delay). What gives sub-second failover?

- A. Route53 Failover with 5-second TTL — still DNS-based, TTL not honored by all resolvers
- B. CloudFront Origin Group with primary + secondary origin — CDN-level failover, faster than DNS
- C. NLB cross-Region target groups — NLB is regional, cannot span Regions
- D. Global Accelerator with endpoint groups in both Regions — anycast IPs, health-based routing, sub-second failover, no DNS TTL dependency

### Q37 — Correct answer: B
ECS Fargate service unavailable 15 minutes during deployment. Root cause: 8GB container image takes 12 minutes to pull + start. Old tasks stopped before new healthy. BEST solution?

- A. Rolling update: `minHealthyPercent=100, maxPercent=200` — keeps old running, but new still takes 12 min to deploy
- B. Blue/Green via CodeDeploy — new tasks fully ready and tested before traffic shift; eliminates deployment downtime regardless of pull time
- C. Smaller container images via multi-stage builds — reduces pull time but doesn't eliminate risk of deployment gap
- D. Increase task CPU/memory — doesn't reduce image pull time, which is network/download-bound

### Q38 — Correct answer: A
Aurora MySQL cluster: writer CPU 90% at peak, 3 read replicas at 20% CPU. App routes all writes + 40% of reads to writer endpoint. How to reduce writer CPU?

- A. Redirect ALL read traffic to reader endpoint — writer should only handle writes; 40% reads on writer is the root cause
- B. Add more read replicas — writer already at 90%, adding readers doesn't help writer
- C. Increase writer instance size — treats symptom, doesn't fix architecture (reads on writer)
- D. Aurora Multi-Master — adds complexity; all instances can write but doesn't solve read routing

### Q39 — Correct answer: A
Secrets stored in SSM Parameter Store Standard. Need automatic rotation of DB credentials every 30 days. Parameter Store doesn't support auto-rotation.

- A. Migrate DB credentials to AWS Secrets Manager, configure auto-rotation using built-in Lambda rotation templates — Secrets Manager natively supports rotation
- B. Continue Parameter Store, write custom rotation Lambda triggered by EventBridge schedule — possible but recreates what Secrets Manager does natively
- C. Use KMS automatic key rotation — KMS rotates encryption keys, not application secrets
- D. Store credentials in CodeCommit and rotate manually — security and operational anti-pattern

### Q40 — Correct answer: C
CloudWatch Logs groups need archiving. Logs older than 90 days → archive to S3 for 7-year retention, occasional Athena queries. Cost-efficient.

- A. CloudWatch Logs direct export to S3 — manual export, not automated
- B. Lambda periodic export task — operational overhead for scheduling and error handling
- C. Subscription filter → Kinesis Data Firehose → S3 with Parquet conversion — automated streaming, Parquet format optimized for Athena queries, cost-efficient
- D. CloudWatch Logs Insights scheduled query + export — Insights not designed for continuous export

### Q41 — Correct answer: A, B, E
1000 on-premises servers → AWS migration. No documentation exists. Need: business case TCO, server inventory with dependencies, wave-based migration planning. (Choose three.)

- A. Migration Evaluator (formerly TSO Logic) — agentless TCO analysis, business case
- B. Application Discovery Service with agent-based discovery — detailed server inventory, dependency mapping
- C. Database Migration Service (DMS) — for database migration, not server discovery
- D. VM Import/Export — imports VM images, not discovery/planning
- E. Migration Hub — centralized tracking, wave planning, progress dashboard

### Q42 — Correct answer: D
3-tier app (web/app/DB) on-prem → AWS. Web and app tiers replatform to ECS containers. Oracle → Aurora PostgreSQL. Database cutover must be <30 minutes downtime.

- A. Rehost entire stack via VM Import/Export — doesn't replatform or convert Oracle
- B. Refactor database to DynamoDB — schema redesign, not replatform, doesn't meet <30 min cutover
- C. Repurchase via RDS Oracle — keeps Oracle, doesn't migrate to Aurora PostgreSQL
- D. SCT for schema conversion + DMS full load + ongoing CDC replication → cutover during maintenance window (<30 min) — standard heterogeneous migration with minimal downtime

### Q43 — Correct answer: A
On-premises SFTP server being decommissioned. 100 external partners connect via username/password. Migrate to managed AWS service with S3 backend. Transparent to partners — they keep same credentials.

- A. AWS Transfer Family SFTP with Service Managed authentication — managed SFTP, supports username/password, S3 backend, partners keep same workflow
- B. S3 pre-signed URLs shared with each partner — requires partner workflow change, no SFTP protocol
- C. Storage Gateway File Gateway — on-premises appliance, not fully managed SFTP service
- D. EC2 instance running SFTP with ASG — self-managed, not managed service

### Q44 — Correct answer: C
Remote factories with unreliable satellite internet. Need: local ML quality inspection running offline, sync results when connected. AWS-managed hardware that works disconnected.

- A. AWS Outposts — requires continuous connection back to parent Region
- B. Local Zones — extension of Region, requires connectivity
- C. AWS Snowball Edge Compute with IoT Greengrass + SageMaker Neo — runs inference offline, syncs when connectivity available, AWS-managed
- D. Wavelength — 5G edge locations, not designed for disconnected operation

### Q45 — Correct answer: D
200 TB genomic data on-premises → S3 within 4 weeks. 500 Mbps internet connection. Data must be encrypted in transit and at rest. Tamper-resistant.

- A. AWS DataSync over internet — 500 Mbps for 200 TB = ~37 days, may not meet 4-week deadline
- B. 10 Gbps Direct Connect — procurement and installation typically 4-8 weeks, wouldn't meet deadline
- C. S3 Transfer Acceleration for all data — improves upload speed but 500 Mbps still the bottleneck
- D. Multiple AWS Snowball Edge devices shipped in parallel — 80 TB per device, 3 devices in parallel, ship back to AWS for S3 ingestion, tamper-resistant hardware, within 4 weeks

### Q46 — Correct answer: B
Legacy Windows application with Integrated Windows Authentication against on-premises Active Directory. Stream via AppStream 2.0. Users must authenticate against existing on-prem AD WITHOUT replicating directory to AWS.

- A. AWS Managed Microsoft AD with trust relationship — requires creating a Managed AD, not avoiding replication
- B. AD Connector — proxies authentication requests to on-prem AD, no directory data stored in AWS, works with AppStream 2.0
- C. Simple AD — Samba-based, doesn't support Windows Integrated Auth or trust with on-prem AD
- D. IAM Identity Center with AD sync — requires syncing directory data, not "without replicating"

### Q47 — Correct answer: C
AWS MGN (Application Migration Service) replicating 50 servers for 3 weeks. Project manager asks for dashboard: overall progress, per-server replication status, cutover readiness.

- A. MGN console per-server view — doesn't aggregate into a dashboard
- B. CloudWatch dashboard with custom metrics — MGN publishes some metrics to CloudWatch but Migration Hub is purpose-built
- C. AWS Migration Hub — centralized dashboard for migration progress across MGN, DMS, and discovery tools; shows per-server status and cutover readiness
- D. AWS Config aggregator — compliance and configuration, not migration tracking

### Q48 — Correct answer: C
Monolith application → microservices. Current: shared MySQL database. Plan: Orders service gets its own DynamoDB table. Customers and Inventory services keep MySQL. What migration strategy is this for Orders?

- A. Rehost (lift-and-shift) — no code changes, same database
- B. Replatform (lift-tinker-and-shift) — minor changes, same database engine
- C. Refactor (re-architect) — changing data model from relational (MySQL) to NoSQL (DynamoDB) + decomposing monolith into microservices
- D. Repurchase (drop-and-shop) — moving to SaaS, not applicable here

### Q49 — Correct answer: B
CloudFormation template: RDS database with `DeletionPolicy: Delete`. Operator accidentally deleted the CloudFormation stack → RDS database permanently deleted → DATA LOSS.

- A. Change `DeletionPolicy` to `Retain` — protects the RDS on stack deletion but no backup for other failure modes
- B. Change `DeletionPolicy` to `Retain` + enable RDS automated backups with 35-day retention + `DeletionProtection: true` on RDS — multi-layer protection
- C. Separate CloudFormation stack for RDS — stack deletion still deletes RDS unless DeletionPolicy changed
- D. SCP denying `cloudformation:DeleteStack` — prevents all stack deletions, operational inflexibility

### Q50 — Correct answer: A
DynamoDB table with hot partition during product launch. One partition key receives 100x more traffic than others. Throttling only on that key. Table-level capacity well within limits.

- A. Redesign partition key for even distribution — add random suffix or use composite key to spread writes across partitions; solves the root cause
- B. Increase table WCU/RCU — table has enough capacity; hot partition is the issue
- C. Switch to On-Demand capacity mode — On-Demand also throttles at partition level
- D. DAX to cache hot partition key — caching helps reads but writes still hit the hot partition

---

# Part B — Answer Key

> **Answer distribution target: A~12, B~13, C~13, D~12 (balanced ~25% each).**
> Unscored preview Qs: Q3, Q8, Q13, Q18, Q23, Q28, Q32, Q38, Q43, Q48 (10 questions).
> Score out of 40 scored. Target: 70% (28/40).

| Q | Correct | Type |
|---|---------|------|
| 1 | A | single |
| 2 | C, E | choose-two |
| 3 | C | single |
| 4 | B | single |
| 5 | D | single |
| 6 | B | single |
| 7 | C | single |
| 8 | C | single |
| 9 | D | single |
| 10 | B | single |
| 11 | B | single |
| 12 | D | single |
| 13 | D | single |
| 14 | A | single |
| 15 | B | single |
| 16 | B | single |
| 17 | D | single |
| 18 | C | single |
| 19 | D | single |
| 20 | C | single |
| 21 | B | single |
| 22 | D, E | choose-two |
| 23 | A | single |
| 24 | B | single |
| 25 | C | single |
| 26 | A | single |
| 27 | D | single |
| 28 | C | single |
| 29 | B | single |
| 30 | A | single |
| 31 | B | single |
| 32 | D | single |
| 33 | A | single |
| 34 | A | single |
| 35 | D | single |
| 36 | D | single |
| 37 | B | single |
| 38 | A | single |
| 39 | A | single |
| 40 | C | single |
| 41 | A, B, E | choose-three |
| 42 | D | single |
| 43 | A | single |
| 44 | C | single |
| 45 | D | single |
| 46 | B | single |
| 47 | C | single |
| 48 | C | single |
| 49 | B | single |
| 50 | A | single |

## Actual Distribution Analysis

Single-answer questions (47 total):

| Answer | Count | % |
|--------|-------|---|
| A | 11 | 23.4% |
| B | 13 | 27.7% |
| C | 11 | 23.4% |
| D | 12 | 25.5% |

Multi-select questions (3 total): Q2 (C,E), Q22 (D,E), Q41 (A,B,E)

**Total: ~balanced within acceptable range.** ✅

> ✅ A-bias fixed. Pre-assigning answer position before writing each question is the key discipline.
