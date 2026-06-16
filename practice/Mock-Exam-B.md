---
title: "AWS SAP-C02 Mock Exam B"
totalQuestions: 50
timeLimit: 120
focus: "Networking & Security emphasis"
answerDistribution: "balanced A/B/C/D ~25%"
---

# AWS SAP-C02 Mock Exam B

> 50 questions, 120 minutes. Networking & Security emphasis.
> **Answer distribution balanced: A=12, B=12, C=13, D=12 (~25% each).**

---

# Part A - Questions

---

### Q1
Multiple business units, overlapping CIDRs (10.0.0.0/16). Marketing needs to share internal API via private IP only. Least operational overhead.

- A. Create PrivateLink endpoint service backed by NLB
- B. Add secondary CIDRs, peer VPCs with NAT
- C. Deploy Transit Gateway with NAT
- D. Software VPN appliance per VPC

### Q2
Dev OU SCP denies ec2:* outside us-east-1. Developer launches EC2 in us-east-1 but RunInstances denied. Most likely cause?

- A. SCP should use Allow not Deny
- B. IAM policy doesn't grant ec2:RunInstances
- C. SCPs cannot restrict by Region
- D. Root OU SCP denies EC2 globally, inherited by Dev OU

### Q3
Shared S3 dataset in Account A. Teams B/C/D need read access only to own prefix (/teamB/, /teamC/, /teamD/). Minimize per-account config.

- A. S3 Access Points per team with prefix permissions + bucket policy
- B. Create IAM role per team in Account A
- C. S3 pre-signed URLs per request
- D. Replicate data to each account's bucket

### Q4
Prevent developers from creating resources outside us-east-1 and eu-west-1 across 50-account OU. Preventive, centrally managed, cannot be circumvented.

- A. SCP on OU denying all actions with aws:RequestedRegion condition
- B. IAM policies via StackSets to all accounts
- C. Config rules with auto-remediation
- D. Service Catalog constraints

### Q5
Share a Transit Gateway with VPC in another account. Same organization. Simplest approach?

- A. AWS RAM to share TGW with the other account
- B. VPC Peering between the VPCs
- C. Site-to-Site VPN between accounts
- D. Deploy second TGW and peer them

### Q6
Security requires all IAM roles have max session duration of 2 hours. Developers creating roles with 12-hour durations.

- A. SCP denying iam:CreateRole if MaxSessionDuration > 7200
- B. IAM policy condition on each role
- C. Config rule to detect and remediate
- D. CloudFormation StackSets to redeploy roles

### Q7
Centralized logging account. All accounts send CloudTrail to central S3 bucket. Prevent log modification/deletion after delivery.

- A. Organization CloudTrail with delegated admin
- B. S3 bucket policy + S3 Object Lock
- C. Cross-account IAM roles per account
- D. S3 replication from each account

### Q8
100+ accounts. Track spending by ProjectID tag across accounts. Tags inconsistently applied.

- A. Consolidated billing + Cost Explorer with tag filter + Tag Policies
- B. AWS Budgets per account
- C. SCP denying untagged resources
- D. Third-party tools only

### Q9
Developer left company. Immediate access revocation needed. IAM users in 5 accounts + IAM Identity Center.

- A. Disable/delete user in IAM Identity Center
- B. Delete IAM users from each account
- C. Detach all IAM policies
- D. Rotate all access keys

### Q10
Third-party auditor needs read-only S3 access for 24 hours. Has AWS account. No IAM user creation. Auto-expire.

- A. Create IAM user, delete after 24h
- B. Pre-signed URL with 24h expiry
- C. IAM role + trust policy for auditor's account + session duration condition
- D. S3 Access Point with time-bound permissions

### Q11
Real-time IoT dashboard. Thousands of sensors, updates within 2 seconds. Serverless.

- A. SQS -> Lambda -> DynamoDB -> AppSync WS
- B. SNS -> Lambda -> RDS -> API Gateway REST
- C. Kinesis Data Streams -> Lambda -> DynamoDB -> AppSync WS
- D. EventBridge -> Step Functions -> S3 -> CloudFront

### Q12
ECS on Fargate behind ALB under SQL injection attack. Attack consumes all resources. Prevent attacks reaching ECS. Maximize operational efficiency.

- A. WAF Web ACL + SQL database managed rule group with Block action, associate with ALB
- B. WAF Web ACL with Count mode
- C. WAF Bot Control
- D. IP blocklist + Lambda scraping logs

### Q13
Public API behind ALB needs static IPs for partner firewall. ALB already has WAF.

- A. Replace ALB with NLB + Elastic IPs
- B. Assign Elastic IPs to ALB
- C. Global Accelerator with ALB endpoint, provide GA static IPs
- D. CloudFront in front, provide distribution IP range

### Q14
Synchronous HTTP microservices. Payment slowdown blocks order -> notification. Need decoupling.

- A. Multi-AZ Auto Scaling all services
- B. Circuit breaker with Lambda
- C. SQS queue between each service pair, async processing
- D. API Gateway with request validation

### Q15
Aurora MySQL: RPO < 1 sec, RTO < 1 min. DR Region must serve reads. Which feature?

- A. Aurora Global Database
- B. RDS Multi-AZ with Cross-Region Read Replica
- C. Aurora Read Replicas in second Region
- D. DMS ongoing replication

### Q16
8 PB video archives. Accessed < once/year. 12-hour retrieval OK. 10-year retention. Most cost-effective?

- A. S3 Standard -> Lifecycle to Glacier Deep Archive
- B. S3 Glacier Flexible Retrieval
- C. S3 Glacier Deep Archive
- D. Snowball Edge kept on-prem

### Q17
Game session store: sub-ms latency. Writes once/min/user, reads every API call. Also uses RDS for game data.

- A. DAX - DynamoDB only
- B. RDS Read Replicas
- C. ElastiCache for Redis with Multi-AZ
- D. S3 with CloudFront caching

### Q18
60 TB dataset on-prem -> S3. 100 Mbps internet. Must complete within 10 days. FASTEST?

- A. DataSync over internet
- B. 1 Gbps Direct Connect + transfer
- C. Snowball Edge - copy, ship to AWS
- D. S3 Transfer Acceleration + multipart

### Q19
Global users uploading >100 MB files to S3 are slow. Uses pre-signed URLs + browser upload. Authenticated users only.

- A. Switch to API Gateway S3 proxy
- B. CloudFront with PUT/POST
- C. Enable S3 Transfer Acceleration, use acceleration endpoint for pre-signed URLs, S3 multipart upload
- D. Multi-Region S3 with CRR

### Q20
S3 objects must replicate to another account within 15 minutes of upload. Monitor + alert on SLA breach.

- A. S3 CRR + CloudWatch OperationReplicationTime
- B. S3 Same-Region Replication + Batch Operations
- C. S3 RTC with prefix filter, CloudWatch metrics, EventBridge alerts
- D. DataSync hourly sync

### Q21
HPC simulations: 2 hours each, hundreds simultaneous. Fault-tolerant - can restart. Cost primary concern.

- A. Reserved Instances (3-year)
- B. On-Demand
- C. Spot Instances with Spot Fleet diversification
- D. Compute Savings Plans (1-year)

### Q22
Managed GraphQL API with real-time subscriptions for collaborative app. DynamoDB backend.

- A. API Gateway REST + WebSocket
- B. EventBridge custom event bus
- C. Step Functions Express workflows
- D. AWS AppSync with GraphQL subscriptions

### Q23
Encrypt all EBS volumes in a Region. New volumes auto-encrypted without user specifying encryption.

- A. SCP requiring encrypted:true
- B. Config rule with auto-remediation
- C. CloudFormation template enforcement
- D. Enable EBS encryption by default in EC2 console

### Q24
DynamoDB: 50K reads/sec globally. Asia users 200ms latency, US 5ms. Table in us-east-1.

- A. DAX cluster in us-east-1
- B. ElastiCache cross-region replication
- C. CloudFront in front of DynamoDB
- D. DynamoDB Global Tables with Asia replica

### Q25
Elastic Beanstalk deployment: zero downtime, test before cutover, instant rollback.

- A. All at Once
- B. Rolling deployment
- C. Immutable deployment
- D. Blue/Green via CNAME swap

### Q26
Real-time clickstream: 1M daily visitors. Data available within 60 seconds. Handle traffic spikes.

- A. SQS Standard queue
- B. SNS topic + Lambda
- C. EventBridge event bus
- D. Kinesis Data Streams with auto-scaling shards

### Q27
Lambda needs RDS in private subnet + download from public API. Configured in VPC with private subnets.

- A. Internet Gateway attached
- B. VPC Endpoint for RDS
- C. Lambda execution role with ec2:CreateNetworkInterface
- D. NAT Gateway in public subnet + route to NAT GW

### Q28
DynamoDB provisioned: monthly write spike 10x for 2 hours (predictable: 15th). Throttling occurs.

- A. Increase WCU permanently
- B. Switch to On-Demand
- C. Application Auto Scaling with scheduled scaling for 15th
- D. DAX to absorb write bursts

### Q29
Migrate VPC to IPv6. Private instances need outbound IPv6 but NOT reachable from internet.

- A. IPv6 CIDR + ::/0 -> Internet Gateway
- B. IPv6 CIDR + ::/0 -> NAT Gateway
- C. Enable IPv6 on existing NAT GW
- D. IPv6 CIDR + Egress-Only Internet Gateway + ::/0 from private -> EIGW

### Q30
200 VMware VMs to AWS within 60 days. Cannot reinstall apps. Preserve OS, software, configs.

- A. MGN for block-level replication
- B. VM Import/Export - OVF -> S3 -> import-image
- C. DataSync file-level migration
- D. Server Migration Service replication jobs

### Q31
Session data in memory on EC2 behind ALB with sticky sessions. Want stateless for resilience.

- A. Increase sticky session duration
- B. EBS volumes for session persistence
- C. Replace instances less frequently
- D. Store sessions in ElastiCache for Redis, all instances access

### Q32
RDS MySQL single-AZ. 45-min outage when AZ failed. Need automatic failover with minimal data loss.

- A. Read Replicas across AZs
- B. RDS Proxy
- C. Cross-Region Read Replica
- D. Multi-AZ deployment

### Q33
Aurora: 1 writer + 2 replicas. Peak: replicas 100% CPU, writer 30%. Reports time out.

- A. Increase writer size
- B. Aurora Multi-Master
- C. Redshift Spectrum for reports
- D. Aurora Auto Scaling for read replicas

### Q34
EC2 instances 15% avg CPU. Reduce costs without impacting performance.

- A. Trusted Advisor
- B. Cost Explorer
- C. CloudWatch Anomaly Detection
- D. Compute Optimizer - ML recommendations

### Q35
CodeCommit backup in second Region. No native cross-region replication.

- A. AWS Backup CodeCommit support
- B. EventBridge -> CodeBuild: clone, zip, copy to S3 in second Region
- C. DMS ongoing replication
- D. S3 CRR of underlying storage

### Q36
Single NAT GW in one AZ. AZ failure -> 4 hours no internet. Firewall allows only one IP.

- A. Three NAT Gateways with three EIPs
- B. One NAT GW + CloudWatch + Lambda to recreate in another AZ, reassign EIP
- C. Replace with Internet Gateway
- D. Direct Connect for all outbound

### Q37
500 unencrypted EBS snapshots. All new snapshots must be encrypted. Minimize operational effort.

- A. Manually copy each with encryption
- B. Enable EBS encryption by default - new snapshots auto-encrypted
- C. AWS Backup to re-encrypt existing
- D. S3 default encryption for snapshot storage

### Q38
CloudFormation stack fails intermittently: required IAM role missing. Depends on manual role creation.

- A. Add DependsOn to all resources
- B. StackSets with service-managed permissions
- C. Include IAM role in same template with DependsOn
- D. CloudFormation Stack Policies

### Q39
Redshift: month-end query spikes cause slowness. Elastic Resize takes 15 min. Need sub-minute response.

- A. Redshift Spectrum
- B. Concurrency Scaling - transient capacity automatically
- C. Classic Resize with larger nodes
- D. Redshift Data Sharing

### Q40
Single ALB serving HTTP. Security requires HTTPS with valid cert. Auto-renew, minimal management.

- A. KMS - generate SSL certs
- B. ACM - provision and auto-renew TLS certs
- C. Secrets Manager - store cert keys
- D. Third-party CA only

### Q41
ASG step scaling: 7 min to add instances during flash sale, causing 5xx. App boots in 60 seconds.

- A. Target tracking scaling with lower target
- B. Pre-bake AMIs to reduce boot time
- C. Over-provision to 200% peak
- D. Larger instances

### Q42
Aurora manual weekly snapshots. Data corruption 3 days after last snapshot. 3 days data loss.

- A. Increase manual snapshot frequency
- B. Enable automated backups with PITR
- C. Aurora Backtrack
- D. Application-level write-ahead logging

### Q43
500 on-prem servers to AWS over 12 months. No inventory docs. Assess phase first. (Choose two.)

- A. Application Discovery Service
- B. Migration Evaluator
- C. DMS
- D. MGN
- E. Snowball Edge

### Q44
8 TB Oracle -> Aurora PostgreSQL. < 1 hour cutover. Source operational during migration.

- A. DataSync -> S3 -> Aurora
- B. DMS full load + CDC, cutover during window
- C. SCT schema conversion -> DMS full load + CDC -> cutover
- D. Native Data Pump export -> S3 -> import

### Q45
Legacy .NET Framework with Windows Auth. Cannot containerize. Reduce infrastructure management.

- A. EC2 Windows + Auto Scaling + AD Connector
- B. AppStream 2.0 + AD integration
- C. Elastic Beanstalk .NET on Windows
- D. Lambda .NET runtime

### Q46
Factory sites: limited internet. Need local ML quality inspection. Operate offline, sync when connected.

- A. Outposts
- B. Snowball Edge Compute + IoT Greengrass
- C. Local Zones
- D. Wavelength

### Q47
SFTP with 200 trading partners. Migrate to managed AWS service with S3, existing configs, high availability.

- A. EC2 SFTP servers in ASG
- B. Transfer Family SFTP + S3 backend, Multi-AZ with EIP failover
- C. Storage Gateway File Gateway
- D. S3 pre-signed URLs

### Q48
CI/CD pipeline: GitHub -> build -> test -> deploy EC2 with canary (10->30->100%, 30 min) + auto-rollback on alarm.

- A. CodeCommit -> CodeBuild -> CodeDeploy
- B. CodePipeline (GitHub) -> CodeBuild -> CodeDeploy (canary traffic shifting)
- C. CodeBuild -> CodeDeploy -> CloudFormation
- D. Step Functions -> Lambda -> EC2

### Q49
On-prem file server: NFS share with hot data cached locally, cold data tiered to S3 Glacier Deep Archive.

- A. DataSync scheduled sync
- B. Storage Gateway File Gateway with S3 Lifecycle
- C. EFS with Direct Connect
- D. Transfer Family SFTP

### Q50
On-prem AD must authenticate WorkSpaces, EC2 Windows, and AWS Console access. Do NOT replicate AD to AWS.

- A. AWS Managed Microsoft AD
- B. AD Connector - proxies to on-prem AD
- C. Simple AD
- D. IAM Identity Center external SAML only

---

# Part B - Answer Key

> Answer distribution intentionally balanced: A~12, B~13, C~13, D~12 (single-letter answers).

| Q | Ans |
|---|-----|
| 1 | A |
| 2 | D |
| 3 | A |
| 4 | A |
| 5 | A |
| 6 | A |
| 7 | A |
| 8 | A |
| 9 | A |
| 10 | C |
| 11 | C |
| 12 | A |
| 13 | C |
| 14 | C |
| 15 | A |
| 16 | C |
| 17 | C |
| 18 | C |
| 19 | C |
| 20 | C |
| 21 | C |
| 22 | D |
| 23 | D |
| 24 | D |
| 25 | D |
| 26 | D |
| 27 | D |
| 28 | C |
| 29 | D |
| 30 | A |
| 31 | D |
| 32 | D |
| 33 | D |
| 34 | D |
| 35 | B |
| 36 | B |
| 37 | B |
| 38 | C |
| 39 | B |
| 40 | B |
| 41 | A |
| 42 | B |
| 43 | A,B |
| 44 | C |
| 45 | B |
| 46 | B |
| 47 | B |
| 48 | B |
| 49 | B |
| 50 | B |

> **Answer distribution: A=12, B=12, C=13, D=12 (balanced ~25% each).** ✅
