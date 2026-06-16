---
title: "AWS SAP-C02 Mock Exam A"
totalQuestions: 50
timeLimit: 120
examDomains:
  DesignForOrganizationalComplexity: 26
  DesignForNewSolutions: 29
  ContinuousImprovement: 25
  AccelerateMigration: 20
answerDistribution: "balanced A/B/C/D ~25%"
---

# AWS SAP-C02 Mock Exam A

> 50 questions, 120 minutes. Simulates SAP-C02 exam conditions.
> **Answer distribution balanced: A=12, B=12, C=12, D=11 (~25% each).**
> Answer key at the end with domain tracking.

---

# Part A - Questions

---

### Q1
A company uses AWS Organizations with OUs. Security requires no Dev OU account can create resources outside us-east-1 and eu-west-1. Must be centrally managed, cannot be overridden by account admins.

- A. Attach an SCP to the Dev OU denying resource creation outside approved Regions
- B. Create IAM policies in each Dev account
- C. Use AWS Config rules to detect non-compliant resources
- D. Deploy CloudFormation StackSets with Region-restrictive policies

### Q2
A company has a centralized TGW connecting 50+ VPCs. PCI-DSS VPCs must be isolated from all other VPCs but still reach on-prem via the VPN attachment on TGW.

- A. Create a new TGW for PCI VPCs and peer it with the main TGW
- B. Remove PCI VPCs from TGW and use VPC Peering to shared services
- C. Use TGW route tables: separate table for PCI VPCs, routes only to VPN attachment
- D. Use NACLs on PCI VPC subnets

### Q3
Marketing team needs read-only access to specific DynamoDB attributes in finance team's table. Separate accounts, same org. Least privilege.

- A. Create IAM role in finance account with dynamodb:Attributes conditions, trust marketing account
- B. Create resource-based policy on the DynamoDB table
- C. Attach SCP to finance OU granting marketing access
- D. Share the table via AWS RAM

### Q4
CloudFormation StackSets deploy baseline template (S3, VPC, IAM roles) to 30 accounts. Prevent deletion of StackSet-created IAM roles.

- A. Add DeletionPolicy: Retain on IAM roles
- B. Create SCP denying iam:DeleteRole
- C. Configure StackSet drift detection alerts
- D. Use Service Catalog instead

### Q5
Finance team needs cost allocation across 200 accounts by business unit. Tag enforcement inconsistent. (Choose two.)

- A. AWS Cost Explorer with hourly granularity
- B. Tag Policies in AWS Organizations
- C. SCPs to deny resource creation without proper tags
- D. AWS Budgets with tag-based filters
- E. CloudFormation StackSets for tagging

### Q6
Regulated industry: PREVENT any S3 bucket in org from becoming public. Preventive and centrally managed.

- A. AWS Config rule s3-bucket-public-read-prohibited
- B. IAM Access Analyzer with SNS alerts
- C. AWS Trusted Advisor S3 permissions check
- D. SCP denying s3:PutBucketPolicy/s3:PutBucketAcl when making bucket public

### Q7
Developer in Account A assumes role in Account B without authorization. Trust policy allows entire Account A. Fix must maintain legitimate access.

- A. Modify trust policy: add sts:ExternalId, restrict Principal to specific roles in Account A
- B. Delete the cross-account role
- C. Attach SCP to Account A denying sts:AssumeRole
- D. Enable CloudTrail alerts on role assumption

### Q8
New multi-account landing zone: automated provisioning, security guardrails, centralized logging, SSO. Least operational overhead.

- A. AWS Organizations + SCPs + custom CloudFormation
- B. AWS Service Catalog + AWS Config + per-account users
- C. AWS Organizations + custom scripts + AD Connector
- D. AWS Control Tower + IAM Identity Center + Organization CloudTrail

### Q9
Share approved CIDR list across all org accounts. Updated monthly. Security groups auto-reference current list.

- A. Store CIDRs in S3 JSON, Lambda per account
- B. Parameter Store with dynamic SG rules
- C. CloudFormation StackSets deploy updated SGs monthly
- D. Customer-managed prefix list, share via AWS RAM, update centrally

### Q10
Temporary S3 read access for debugging. Auto-revoke after 4 hours. Fully auditable. No long-lived credentials.

- A. Create IAM user, delete after 4 hours
- B. Add to IAM group, remove after 4 hours
- C. Pre-signed S3 URL valid for 4 hours
- D. IAM role with session policy limiting to 4 hours, assume via sts:AssumeRole

### Q11
Global serverless web app: NA, Europe, Asia. Lowest latency. Lambda + API Gateway + DynamoDB. Startup budget.

- A. Lambda+APIGW in 3 Regions, DynamoDB Global Tables, Route 53 latency routing
- B. Deploy all in us-east-1, use CloudFront
- C. Deploy all in us-east-1, use Global Accelerator
- D. EC2 in 3 Regions behind ALBs

### Q12
Millions of IoT messages daily. Bursts: 50K/sec peak, near zero overnight. 200ms processing each. Minimize cost + ops.

- A. EC2 Auto Scaling with Spot, SQS buffering
- B. ALB -> ECS on Fargate
- C. Kinesis Data Streams with 50 shards, EC2 consumers
- D. API Gateway HTTP -> SQS -> Lambda

### Q13
Monte Carlo simulation: 45 min/job, 16 vCPU, 256 GB RAM. Weekly. Results in 4 hours. MOST cost-effective compute?

- A. On-Demand EC2 in Cluster Placement Group
- B. AWS Lambda with 10 GB memory
- C. EC2 Spot Instances with Spot Fleet diversification
- D. Reserved EC2 (3-year, All Upfront)

### Q14
Order service publishes "OrderPlaced". Must trigger inventory, notification, analytics. Each processes independently.

- A. SQS FIFO queue
- B. SNS topic (fan-out to SQS queues per service)
- C. Step Functions state machine
- D. EventBridge custom event bus

### Q15
500 TB rarely accessed logs, 7-year compliance. Accessed once/year. 12-hour retrieval OK. Most cost-effective?

- A. S3 Standard -> Lifecycle to Glacier Deep Archive after 90 days
- B. S3 Glacier Flexible Retrieval for all
- C. EBS Cold HDD (sc1)
- D. Storage Gateway Tape Gateway

### Q16
Web app on EC2 behind ALB. Flash sales: 15x traffic in 2 min. Stateless. Step scaling causes 5-min delay.

- A. Target tracking scaling on request count per target
- B. Pre-warm instances before flash sales
- C. Scheduled scaling based on calendar
- D. Larger instance types

### Q17
Store app config: DB strings, API endpoints, feature flags. Some encrypted. Hierarchical paths.

- A. Systems Manager Parameter Store (String + SecureString)
- B. Secrets Manager for all config
- C. KMS with S3 encrypted config files
- D. Environment variables in Lambda/EC2

### Q18
Containerized app: 24/7 steady traffic. Host-level monitoring agent (kernel metrics) required. Uses Docker Compose.

- A. ECS on Fargate
- B. Elastic Beanstalk Docker platform
- C. Lambda with container image
- D. ECS on EC2 with daemon service for monitoring

### Q19
Media pipeline: virus scan (30s) -> transcode (20-40min) -> thumbnails (10s) -> notify. Handle errors with retry at each step.

- A. Step Functions (Standard) with retry/catch
- B. EventBridge with rules per step
- C. SQS with multiple queues
- D. Glue workflow

### Q20
Migrate on-prem VMware VM to AWS. Preserve OS configs and software. 48-hour deadline.

- A. DataSync to replicate VM files
- B. SSM Agent + AWS Backup to create AMI
- C. MGN continuous replication
- D. Export OVF -> S3 -> aws ec2 import-image with vmimport role

### Q21
[Unscored] DynamoDB: 100 reads/sec normal, 10K reads/sec 4hr/month. Unpredictable. Most cost-effective capacity?

- A. Provisioned 100 RCU, manual increase
- B. On-Demand capacity mode
- C. Provisioned + Application Auto Scaling target tracking
- D. Reserved capacity 10K RCU (3-year)

### Q22
HPC cluster for CFD. Lowest inter-node latency for MPI. Hundreds of instances launch simultaneously.

- A. Spread placement group across AZs
- B. No placement group
- C. Partition placement group with 7 partitions
- D. Cluster placement group in single AZ with ENA

### Q23
Public REST API under DDoS: 50K req/sec from thousands of IPs. Block attack, allow legitimate partner IPs. (Choose two.)

- A. WAF IP set allowlist + rate-based rule
- B. API Gateway throttling to 100 req/sec
- C. API Gateway resource policy restricting to partner IPs
- D. Shield Advanced for DDoS cost protection
- E. CloudFront with geo-restriction

### Q24
Stateful EC2 app. DR: app RPO 2 min, RTO 30 min. No significant architecture changes.

- A. AWS Backup with 2-hour schedule + cross-region copy
- B. DLM with 2-hour snapshot schedule
- C. Elastic Disaster Recovery (DRS) continuous replication
- D. EC2 ASG in second Region warm standby

### Q25
[Unscored] Aurora MySQL: RPO < 1 sec, RTO < 1 min. Secondary Region must serve reads during normal ops.

- A. RDS Multi-AZ
- B. RDS Cross-Region Read Replica
- C. Aurora Global Database
- D. Aurora Backtrack

### Q26
Synchronous HTTP calls between microservices. Payment slowdown cascades to order -> inventory.

- A. Vertical scaling
- B. Multi-AZ with Auto Scaling
- C. Introduce SQS between services to decouple
- D. Retry logic with exponential backoff

### Q27
Temporary auditable SSH for auditors. No long-lived keys. All access logged.

- A. Secrets Manager for SSH keys
- B. EC2 Instance Connect - temporary key via API, CloudTrail logged
- C. Session Manager with S3 logging
- D. Create IAM users per auditor

### Q28
Elastic Beanstalk Blue/Green: test before cutover, instant rollback, zero downtime.

- A. All-at-Once deployment
- B. Rolling deployment
- C. Immutable deployment
- D. Separate environment, validate, swap CNAME via Route 53

### Q29
On-prem MySQL 60 TB. 100 Mbps internet. Migrate to Aurora MySQL us-east-1. FASTEST?

- A. DMS over internet
- B. 1 Gbps Direct Connect + DMS
- C. Snowball Edge -> S3 -> DMS to Aurora
- D. DataSync to accelerate internet transfer

### Q30
Legacy app on EC2 + ASG + ALB. Manual instance replacement -> automate with minimal transition downtime.

- A. Delete ALB, create new ASG + ALB
- B. Create ASG, attach to EXISTING ALB, attach existing EC2 to ASG
- C. Delete all EC2, let ASG launch replacements
- D. Replace ALB with NLB

### Q31
FSx for Windows (HDD, 16 MBps) for WorkSpaces profiles. Login times unacceptable. Fix with least admin effort.

- A. AWS Backup -> restore to new FSx with SSD + 32 MBps, update DNS alias
- B. Change storage type to SSD in console
- C. DataSync agent on EC2 to copy
- D. Shadow copies via PowerShell

### Q32
Thousands of EC2 over-provisioned by 30%. Identify optimal types based on actual utilization.

- A. Trusted Advisor Cost Optimization
- B. Compute Optimizer - ML-based rightsizing
- C. Cost Explorer RI recommendations
- D. CloudWatch custom metrics

### Q33
Single NAT Gateway in one AZ. AZ failure -> all private instances lose internet. Firewall only allows single IP.

- A. Three NAT Gateways sharing one EIP
- B. One NAT GW + CloudWatch + Lambda to recreate in another AZ, reassign EIP
- C. Replace with NAT Instance
- D. Transit Gateway centralized egress

### Q34
5 years app logs in S3 Standard. 98% only accessed in first 30 days. Must retain. Most cost-effective lifecycle?

- A. Transition Standard-IA at 30 days, Glacier Deep Archive at 90 days
- B. Keep all in S3 Standard
- C. Glacier Deep Archive immediately
- D. S3 Intelligent-Tiering

### Q35
[Unscored] DynamoDB: 500 WCU, 1000 RCU. Monthly RCU spike to 8000 (predictable: first Monday). Throttling.

- A. Increase RCU to 8000 permanently
- B. Switch to On-Demand
- C. Application Auto Scaling with scheduled scaling
- D. Add DAX cluster

### Q36
CloudFormation test env stack: 45 min. Frequent spin-up/tear-down. Base infra always same, only app changes.

- A. Nested stacks: shared infra once, deploy app stacks per test
- B. StackSets for faster deployment
- C. Switch to Terraform
- D. Increase CloudFormation limits

### Q37
200 unencrypted EBS volumes. All NEW volumes must be encrypted at rest. Zero user action.

- A. SCP requiring encrypted:true
- B. Enable EBS encryption by default in Region settings
- C. Config rule + SSM remediation
- D. CloudFormation StackSet

### Q38
Memory leak: instances unhealthy after 3-5 days. Grace period 5 min. App takes 8 min to start.

- A. Grace period 300s, EC2 health check
- B. Grace period 600s, ELB health check (app-level)
- C. Grace period 0s, ELB
- D. Disable health checks

### Q39
EMR: 10 TB weekly, 8hr/weekend. Data in S3 via EMRFS. All On-Demand. Most cost savings without data loss risk?

- A. Reserved for ALL nodes (1-year)
- B. Spot for task nodes, On-Demand/Reserved for core nodes
- C. Spot for all nodes including core
- D. EC2 Spot Fleet only

### Q40
Aurora MySQL: 3 read replicas. Month-end: replicas 100% CPU, writer 40%. Reports time out. Predictable.

- A. Increase replica instance size
- B. Aurora Auto Scaling for read replicas
- C. Aurora Multi-Master
- D. ElastiCache in front of Aurora

### Q41
[Unscored] CodeCommit repo backup in second Region. No built-in cross-region replication.

- A. Elastic Disaster Recovery
- B. AWS Backup cross-region copy
- C. EventBridge -> CodeBuild: clone, zip, copy to S3 in second Region
- D. DMS ongoing replication

### Q42
CodeDeploy in-place rolling caused 30-min outage. Bug discovered, rollback too slow.

- A. All-at-Once
- B. Rolling with 50% batch
- C. Blue/Green - replace fleet, swap traffic
- D. Canary with linear shifting

### Q43
Migrate 200 on-prem servers to AWS. No docs. Assess phase first. (Choose two.)

- A. Application Discovery Service - agent-based mapping
- B. Migration Hub - track progress
- C. Migration Evaluator - business case + TCO
- D. Server Migration Service
- E. DMS

### Q44
40 TB on-prem file server -> AWS within 2 weeks. 500 Mbps internet.

- A. DataSync over internet
- B. Snowball Edge - copy, ship to AWS
- C. Storage Gateway File Gateway
- D. Direct Connect + DataSync

### Q45
Legacy .NET Framework on Windows Server 2012. Cannot modify. Managed service, minimal ops.

- A. EC2 Windows with Auto Scaling
- B. Containerize on ECS Windows
- C. Elastic Beanstalk .NET on Windows
- D. AppStream 2.0 - stream to users

### Q46
2 TB Oracle -> Aurora PostgreSQL. Minimize downtime. Source stays operational.

- A. DMS alone
- B. SCT schema conversion + DMS full load + CDC
- C. DataSync + SCT
- D. Native export/import

### Q47
Manufacturing: keep apps on-prem (data residency, <1ms latency). Factory sites: limited network. Consistent AWS dev experience.

- A. Local Zones + Wavelength
- B. Migrate all to nearest compliant Region
- C. Outposts (on-prem DC) + Snowball Edge Compute (factories)
- D. Snowball Edge Storage for all

### Q48
[Unscored] Legacy FTP -> managed SFTP with S3, Multi-AZ HA, existing partner configs work.

- A. S3 pre-signed URLs
- B. Transfer Family SFTP endpoint + S3 backend
- C. EFS + self-managed SFTP on EC2
- D. Storage Gateway File Gateway

### Q49
Security account in org. Get notified within 5 min when ANY S3 bucket in ANY account becomes public.

- A. S3 Event Notifications on all buckets
- B. IAM Access Analyzer in security account + EventBridge -> SNS
- C. Config rule in all accounts
- D. CloudTrail monitoring across org

### Q50
Monolith -> microservices gradually. Shared PostgreSQL. Start with "orders" module getting own DB.

- A. DynamoDB for all
- B. Aurora with multiple DB instances
- C. RDS PostgreSQL (existing) + separate RDS/Aurora per microservice
- D. Redshift for all

---

# Part B - Answer Key

> Complete all 75 questions before checking. Score out of 65 scored (10 unscored excluded).

| Q | Ans | Domain |
|---|-----|--------|
| 1 | A | 1 |
| 2 | C | 1 |
| 3 | A | 1 |
| 4 | A | 1 |
| 5 | B,C | 1 |
| 6 | D | 1 |
| 7 | A | 1 |
| 8 | D | 1 |
| 9 | D | 1 |
| 10 | D | 1 |
| 11 | A | 2 |
| 12 | D | 2 |
| 13 | C | 2 |
| 14 | D | 2 |
| 15 | A | 2 |
| 16 | A | 2 |
| 17 | A | 2 |
| 18 | D | 2 |
| 19 | A | 2 |
| 20 | D | 2 |
| 21 | C | 2 |
| 22 | D | 2 |
| 23 | A,D | 2 |
| 24 | C | 2 |
| 25 | C | 2 |
| 26 | C | 2 |
| 27 | B | 2 |
| 28 | D | 2 |
| 29 | C | 2 |
| 30 | B | 3 |
| 31 | A | 3 |
| 32 | B | 3 |
| 33 | B | 3 |
| 34 | A | 3 |
| 35 | C | 3 |
| 36 | A | 3 |
| 37 | B | 3 |
| 38 | B | 3 |
| 39 | B | 3 |
| 40 | B | 3 |
| 41 | C | 3 |
| 42 | C | 3 |
| 43 | A,C | 4 |
| 44 | B | 4 |
| 45 | D | 4 |
| 46 | B | 4 |
| 47 | C | 4 |
| 48 | B | 4 |
| 49 | B | 4 |
| 50 | C | 4 |

> **Answer distribution: A=12, B=12, C=12, D=11 (balanced ~25% each).** ✅
> Unscored: Q21, Q25, Q35, Q41, Q48. Scored total: 45 questions.
