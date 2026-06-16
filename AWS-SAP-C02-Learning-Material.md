---
tags:
  - #AWS-SAP-C02
  - #Learning-Material
  - #AWS-Certification
created: 2026-06-06
updated: 2026-06-16
total_services: 100+
total_files: 266
---

# AWS SAP-C02 Customized Learning Material

> ?? **Generated from your Wrong Answer Collection** (187 practice question analyses)  
> ?? **Goal**: Pass the AWS Solutions Architect Professional (SAP-C02) exam  
> ?? **Target industry**: Medical / Industrial  
> ?? **Your background**: Azure Cloud Operations Engineer (3yr), Azure DevOps pipelines & releases

---

## ?? How to Use This Material

1. **Browse by AWS service domain** (Compute �� Storage �� Database �� ...) �� each section covers one service
2. **Pay special attention to "?? Similar Service Comparison"** �� these are the most common exam traps where similar AWS services appear as competing options
3. **Check "?? Azure Bridge"** �� maps each AWS service to what you already know from Azure
4. **Every fact traces back to your missed question** �� see `?? Q Refs` for source question numbers

### ? Appending New missed question (Future Updates)

1. Add your new `.md` file to this folder
2. Identify the AWS services in the question's tags
3. Find each service's section below �� add new facts under **"Key Exam Facts"**
4. Append the question number to `?? Q Refs`
5. If a service doesn't exist yet, add a new subsection under the appropriate domain
6. Update `updated:` date in the YAML frontmatter above

> **?? Tip**: When you encounter a NEW similar-service pair in a missed question, add it to the "?? Similar Service Comparison" index and create a Comparison entry.

---

## ?? Cross-Cutting Concepts

These architectural patterns span multiple services �� they underpin the Well-Architected Framework and appear across ALL exam domains.

### High Availability (HA)

- **Overview**: Designing systems to remain operational despite component failures. Key principle: eliminate single points of failure. Achieved through redundancy at every layer �� compute, network, storage, database.
- **?? Azure Bridge**: Same concept as Azure Availability Zones + Availability Sets. AWS uses multi-AZ for zonal redundancy and multi-Region for regional redundancy.
- **Key Exam Facts** (from missed question):
  - **Multi-AZ vs Multi-Region**: Multi-AZ protects against AZ failure (data center outage) within a Region. Multi-Region protects against Region-wide disaster. Multi-AZ = automatic failover for RDS; manual or automated for EC2. *(Q#29, Q#61)*
  - **Active-Passive vs Active-Active**: Active-Passive = primary serves traffic, standby on standby (RDS Multi-AZ, Route 53 Failover). Active-Active = all nodes serve traffic simultaneously (ALB + multi-AZ EC2, DynamoDB Global Tables). *(Q#19, Q#25)*
  - **ALB Health Checks**: ALB routes only to healthy targets. Health check interval + threshold determines detection time. Cross-zone load balancing distributes across AZs. *(Q#25, Q#209)*
  - **NAT Gateway HA with Single EIP**: Standard multi-AZ NAT GW pattern requires one EIP per AZ. When on-prem firewall restricts to a single IP, deploy one NAT GW + CloudWatch alarm + Lambda to recreate NAT GW in another AZ and reassign the EIP on failure. *(Q#206)*
  - **ASG Migration with Zero Downtime**: To transition static EC2 �� Auto Scaling, create ASG with launch template, attach to existing ALB target group, then attach existing EC2 instances to ASG. Do NOT delete the existing ALB �� it causes DNS changes and downtime. *(Q#209)*
- **Common Pitfalls**:
  - ? Assuming Multi-AZ RDS standby can serve read traffic �� the standby is passive, not accessible
  - ? Deploying EC2 in a single AZ behind an ALB �� if that AZ fails, the entire service goes down
  - ? Using a single NAT Gateway �� AZ failure takes down outbound internet for all AZs
- **?? Q Refs**: #12, #19, #25, #29, #61, #108, #206, #209
<!-- UPDATE_MARKER: High-Availability -->

### Disaster Recovery (DR)

- **Overview**: Strategies for recovering from large-scale disasters. Measured by two metrics: RPO (Recovery Point Objective �� max acceptable data loss in time) and RTO (Recovery Time Objective �� max acceptable time to restore service). The lower the RPO/RTO, the more expensive the solution.
- **?? Azure Bridge**: Same RPO/RTO concepts apply in Azure (Azure Site Recovery, cross-region replication). DR strategies are universal.
- **Key Exam Facts** (from missed question):
  - **DR Strategies (cold �� hot)**: **Backup & Restore** (highest RPO/RTO, cheapest) �� **Pilot Light** (core services running, scale up during DR) �� **Warm Standby** (scaled-down but functional, scale up) �� **Multi-Site Active/Active** (fully running in both Regions, lowest RPO/RTO, most expensive). *(Q#116, Q#234)*
  - **RPO/RTO �� Solution Mapping (Exam Critical)**: If RPO/RTO are in **hours** (e.g., RPO 2h, RTO 4h) �� **AWS Backup** with cross-region copy is the MOST cost-effective. If RPO/RTO are in **seconds/minutes** �� Aurora Global Database + DynamoDB Global Tables. The exam consistently pairs moderate RPO/RTO with backup-based solutions and tight RPO/RTO with replication-based solutions. *(Q#234)*
  - **AWS Elastic Disaster Recovery (DRS)**: Block-level continuous replication for stateful EC2 workloads. Achieves RPO of seconds to minutes. Use when RPO < 5 min for EC2 apps �� DLM snapshots or AWS Backup alone cannot achieve sub-5-minute RPO for stateful instances. *(Q#133)*
  - **DLM vs DRS vs AWS Backup**: DLM = EBS snapshot lifecycle automation (hours-level RPO); DRS = continuous block-level replication (minutes/seconds RPO); AWS Backup = centralized multi-service backup (hours-level RPO). Match the tool to the RPO requirement. *(Q#133)*
  - **Aurora Global Database**: < 1 sec typical lag �� RPO ~1 second. Failover to secondary in < 1 minute �� RTO < 1 minute. Supports read traffic in secondary Region. *(Q#213, Q#227)*
  - **DynamoDB Global Tables**: Multi-active �� read/write to any Region. RPO ~1 second (eventual consistency). RTO near-zero (already active). *(Q#2, Q#105, Q#121)*
  - **S3 Cross-Region Replication (CRR)**: Asynchronous replication for DR compliance. Requires versioning on both buckets. *(Q#28, Q#134)*
- **Common Pitfalls**:
  - ? Confusing RPO (data loss) with RTO (downtime)
  - ? Assuming Pilot Light is fast �� you still need to launch instances and scale up
  - ? Using Aurora Global Database for RPO > 1 hour �� it's overkill and overpriced; AWS Backup is far more cost-effective
  - ? Not testing DR plans regularly �� untested DR = no DR
- **?? Q Refs**: #2, #28, #105, #114, #116, #121, #133, #134, #213, #227, #234, #236
<!-- UPDATE_MARKER: Disaster-Recovery -->

### Cost Optimization

- **Overview**: Achieving business outcomes at the lowest price point. Not just "cheapest" �� about right-sizing, right-pricing, and eliminating waste. Uses the AWS Cost Optimization pillar of the Well-Architected Framework.
- **?? Azure Bridge**: Same concepts �� Azure has Reserved Instances, Spot VMs, Azure Hybrid Benefit. AWS Savings Plans are unique (broader than Azure Reservations).
- **Key Exam Facts** (from missed question):
  - **Purchase Options**: On-Demand (no commitment, most expensive) �� Spot (up to 90% off, can be interrupted) �� Reserved Instances (up to 72% off, 1-3 year, AZ-specific) �� Savings Plans (up to 72% off, flexible across instance families + Lambda + Fargate). *(Q#20, Q#119, Q#205, Q#247)*
  - **Savings Plans Decision Matrix**: **EC2 Instance Savings Plan** = deepest discount (up to 72%) for stable, predictable EC2 workloads (specific family/region). **Compute Savings Plan** = maximum flexibility (up to 66%) �� applies to ANY EC2 family, ANY Region, plus Lambda and Fargate. Use Compute SP for variable/unpredictable workloads. *(Q#247)*
  - **Database Services NOT Covered by Savings Plans**: MemoryDB, ElastiCache, RDS, Redshift require their own reservation models �� **Reserved Nodes** (MemoryDB/ElastiCache) or **Reserved Instances** (RDS). Compute Savings Plan only covers EC2 + Lambda + Fargate. *(Q#247)*
  - **Lambda Reserved Concurrency �� Cost Saving**: Reserved concurrency is a capacity reservation/throttling mechanism, NOT a billing discount. It guarantees N concurrent executions but does NOT reduce per-invocation cost. For Lambda cost savings, use Compute Savings Plan. *(Q#247)*
  - **S3 Lifecycle**: Automatically transition objects to cheaper tiers based on age. Intelligent-Tiering for unpredictable access patterns. Glacier Deep Archive for long-term retention. *(Q#34, Q#65, Q#246)*
  - **Compute Optimizer**: ML-based rightsizing recommendations with risk classification (low/medium/high). *(Q#102, Q#233)*
- **Common Pitfalls**:
  - ? Confusing Capacity Reservations (guarantee capacity, no discount) with Reserved Instances (billing discount)
  - ? Using Spot for stateful or non-fault-tolerant workloads
  - ? Standard RIs lock you into a specific instance family �� use Convertible RIs or Savings Plans for flexibility
- **?? Q Refs**: #20, #32, #34, #65, #66, #102, #119, #129, #205, #222, #233, #246, #247
<!-- UPDATE_MARKER: Cost-Optimization -->

### Security (Cross-Service)

- **Overview**: Defense in depth across all layers. Identity (IAM, Organizations), infrastructure (VPC, Security Groups, NACLs), data (KMS, encryption), application (WAF), and edge (Shield). The principle of least privilege applies at every layer.
- **?? Azure Bridge**: Same layered approach �� Azure AD + RBAC, NSGs, Key Vault, Azure WAF, Azure DDoS. AWS Organizations SCPs are unique (permission guardrails, not just compliance checks).
- **Key Exam Facts** (from missed question):
  - **IAM Evaluation Logic**: Explicit DENY > Explicit ALLOW > Implicit DENY. SCPs and Permissions Boundaries act as filters �� even if IAM allows, SCP can deny. *(Q#3, Q#24, Q#148)*
  - **SCP vs IAM Policy**: SCP = maximum permission ceiling at OU/account level (can't be overridden). IAM policy = grants specific permissions within that ceiling. *(Q#23, Q#210)*
  - **Defense in Depth Layers**: Shield (DDoS edge) �� WAF (L7 filtering) �� Security Groups (instance firewall, stateful) �� NACLs (subnet firewall, stateless) �� Encryption (KMS at rest, TLS in transit). *(Q#125, Q#146, Q#196)*
  - **WAF + API Gateway + Shield DDoS Protection**: For public APIs, combine WAF IP allowlist (only known partner IPs), WAF rate-based rules (throttle excessive requests), API Gateway usage plans (per-client quotas), and Shield Advanced (DDoS cost protection). WAF blocks malicious requests BEFORE they reach API Gateway �� significant cost savings (blocked requests cost $0.60/million vs API Gateway $3.50/million). *(Q#196)*
  - **Global Accelerator for Static IP + WAF**: ALB does NOT support Elastic IP addresses (DNS-only). To provide static IPs while preserving WAF protection, use Global Accelerator �� it provides 2 static anycast IPs and forwards to the ALB. Customers whitelist the GA IPs; WAF remains on the ALB. Do NOT replace ALB with NLB (NLB doesn't integrate with WAF). *(Q#132)*
  - **CloudTrail + Config + CloudWatch**: The governance triad �� CloudTrail = API audit (who did what), Config = configuration compliance (what changed), CloudWatch = operational monitoring (how is performance). *(Q#35, Q#101, Q#172)*
- **Common Pitfalls**:
  - ? Using NACLs for instance-level rules �� they're subnet-level and stateless; use Security Groups
  - ? Assuming SCPs grant permissions �� they only LIMIT permissions; you still need IAM policies to allow
  - ? Enabling only CloudTrail management events �� data events (S3 object-level, Lambda) are not logged by default
- **?? Q Refs**: #3, #23, #24, #35, #39, #59, #78, #79, #101, #103, #125, #127, #132, #146, #148, #160, #172, #196, #210, #224, #253
<!-- UPDATE_MARKER: Security-CrossService -->

### Decoupling

- **Overview**: Reducing dependencies between application components so they can operate, scale, and fail independently. Achieved through asynchronous messaging, event-driven architecture, and loose coupling.
- **?? Azure Bridge**: Same patterns �� Azure Service Bus, Event Grid, Queue Storage. AWS has a richer set (SQS + SNS + EventBridge + Kinesis) with more granular choices.
- **Key Exam Facts** (from missed question):
  - **SQS for Buffering**: Producer �� SQS �� Consumer. Consumer processes at its own pace. If consumer slows, queue grows but producer is unaffected. This is the fundamental decoupling pattern. *(Q#33, Q#110)*
  - **SNS for Fan-out**: One message �� multiple subscribers (SQS, Lambda, HTTP, email). Each subscriber processes independently. Adding a new consumer = new subscription �� no producer changes. *(Q#131)*
  - **EventBridge for Pattern-Based Routing**: Events matched to rules based on event attributes. Different from SNS (topic-based, all subscribers get everything). *(Q#131)*
  - **Cascading Failure Prevention**: With synchronous coupling (direct API calls), a slow downstream service blocks upstream. With decoupling (SQS between tiers), each tier operates independently �� backpressure is handled by the queue. *(Q#33)*
- **Common Pitfalls**:
  - ? Using synchronous calls between microservices �� creates cascading failure risk
  - ? Confusing SNS (push, fire-and-forget) with SQS (pull, buffered) �� they serve different patterns
  - ? Forgetting DLQs �� without them, failed messages cycle forever
- **?? Q Refs**: #33, #82, #110, #131, #142, #143, #212
<!-- UPDATE_MARKER: Decoupling -->

### Serverless

- **Overview**: Building applications without managing servers. Key services: Lambda (compute), API Gateway (API management), DynamoDB (database), S3 (storage), Fargate (containers), Step Functions (orchestration), EventBridge (event bus), SNS/SQS (messaging).
- **?? Azure Bridge**: Similar serverless stack �� Azure Functions, API Management, Cosmos DB, Logic Apps, Event Grid. Key difference: AWS Lambda has tighter S3/DynamoDB integration; Azure Functions has tighter Azure integration.
- **Key Exam Facts** (from missed question):
  - **When to Use Serverless**: Event-driven workloads, variable/unpredictable traffic, rapid development, no ops team. When NOT to use: long-running tasks (> 15 min Lambda limit), need for OS/kernel control, steady predictable load (EC2 may be cheaper), legacy apps with specific OS requirements. *(Q#100, Q#122)*
  - **Lambda Limits**: 15-min max timeout, 10 GB max memory, 250 MB code package (unzipped), 10 GB container images. Provisioned Concurrency eliminates cold starts. *(Q#17, Q#122)*
  - **Serverless �� No Ops**: You still manage monitoring (CloudWatch), logging, error handling (DLQs), deployment (SAM/CloudFormation), and security (IAM roles). You just don't manage servers.
  - **Lambda in VPC**: Creates ENIs in your subnets �� can access VPC resources. Requires NAT Gateway for internet access. Adds cold start latency. *(Q#36, Q#206)*
- **Common Pitfalls**:
  - ? Using Lambda for everything �� it's not always the best choice (see "When NOT to use" above)
  - ? Ignoring cold starts �� Provisioned Concurrency costs money but eliminates them
  - ? Forgetting Lambda@Edge limits �� 5 sec timeout, 128 MB for viewer events
- **?? Q Refs**: #5, #14, #17, #36, #48, #100, #104, #120, #122, #131, #204, #206, #212
<!-- UPDATE_MARKER: Serverless -->

### Multi-Account Governance

- **Overview**: Managing multiple AWS accounts centrally �� security guardrails, cost visibility, resource sharing, and standardized deployments. Key services: AWS Organizations, SCPs, Control Tower, RAM, CloudFormation StackSets, Service Catalog.
- **?? Azure Bridge**: Azure Management Groups + Azure Policy + Azure Lighthouse. SCPs = Azure Policies (but SCPs are permission boundaries, not compliance evaluators). StackSets = Azure Deployment Stacks.
- **Key Exam Facts** (from missed question):
  - **OU Design**: Organize accounts by environment (dev/test/prod), by business unit, or by security boundary. SCPs attach to OUs and inherit down. *(Q#3, Q#24)*
  - **SCP Strategies**: Deny List (default FullAWSAccess, add denies) = simpler, less maintenance. Allow List (remove FullAWSAccess, add explicit allows) = stricter, higher maintenance. Most organizations use deny list. *(Q#3)*
  - **Cross-Account Access**: IAM role assumption (trusting account creates role, trusted account assumes it) OR resource-based policy (grant access directly on the resource). Use RAM for sharing TGW, Prefix Lists, VPC subnets. *(Q#103, Q#117, Q#118)*
  - **StackSets**: Deploy CloudFormation to multiple accounts/Regions from a central admin. Service-managed (automatic, via Organizations) or self-managed (requires manual role creation). *(Q#30, Q#67, Q#210)*
- **Common Pitfalls**:
  - ? Attaching SCPs to individual accounts instead of OUs �� doesn't scale
  - ? Using Allow List SCPs without careful planning �� you'll constantly update them as new services are adopted
  - ? Not using Control Tower for new multi-account setups �� it automates OU creation, guardrails, and account provisioning
- **?? Q Refs**: #3, #23, #24, #26, #30, #56, #67, #103, #117, #118, #210, #224, #232, #245
<!-- UPDATE_MARKER: Multi-Account-Governance -->

### Deployment Strategies

- **Overview**: Methods for releasing new application versions with controlled risk. Ranges from simple (All-at-Once, fast but risky) to sophisticated (Canary, Blue/Green, safest but more complex).
- **?? Azure Bridge**: Azure DevOps release pipelines support the same strategies �� deployment slots for Blue/Green, canary through traffic routing. The concepts are identical; the AWS tooling differs (CodeDeploy vs Azure Pipelines).
- **Key Exam Facts** (from missed question):
  - **All-at-Once**: Update all instances simultaneously. Fastest deployment, most downtime. Quickest to detect failure (all instances affected). *(Q#69)*
  - **Rolling**: Update instances in batches. No additional cost (uses existing capacity). Rollback requires re-deploying old version. *(Q#69)*
  - **Rolling with Additional Batch**: Like Rolling but adds new instances first �� no capacity loss during deployment. Higher cost (extra instances during deploy). *(Q#69)*
  - **Immutable**: Create new ASG with new version �� swap. Old ASG stays running during validation. Fastest rollback (just point back to old ASG). Safest but doubles capacity during deploy. *(Q#69)*
  - **Blue/Green (CodeDeploy)**: Replace entire fleet. Traffic shift via ALB target group or Route 53 weighted routing. Fast rollback. *(Q#48, Q#152, Q#208, Q#225)*
  - **Canary**: Send small % of traffic to new version �� monitor �� increase incrementally �� rollback on alarm. CodeDeploy supports linear traffic shifting. *(Q#48)*
- **Common Pitfalls**:
  - ? Choosing All-at-Once for production �� the downtime and blast radius are too large
  - ? Not implementing health check monitoring during canary deployments �� without alarms, can't auto-rollback
  - ? Blue/Green with stateful applications �� sessions may be lost on the old environment
- **?? Q Refs**: #48, #69, #152, #208, #225
<!-- UPDATE_MARKER: Deployment-Strategies -->

---

## 1. ?? Compute

### EC2 (Elastic Compute Cloud)

- **Overview**: Virtual machines in the cloud �� the core compute primitive. Instance families optimized for compute, memory, storage, GPU.
- **?? Azure Equivalent**: Azure Virtual Machines
- **?? Azure Bridge**: Like Azure VMs, but: (1) EBS volumes attach separately vs Managed Disks, (2) instance types use different naming (`m7i.large` vs `Standard_D2s_v5`), (3) security groups = NSGs, (4) key pairs = SSH keys. EC2 has more granular purchase options (On-Demand, Reserved, Savings Plans, Spot, Dedicated Hosts).
- **Key Exam Facts** (from missed question):
  - **Placement Groups**: Cluster (low latency, same AZ, up to 10 Gbps between instances), Spread (critical instances across hardware, max 7 per AZ), Partition (large distributed workloads, max 7 partitions per AZ). Cluster placement groups offer the highest throughput for HPC workloads. *(Q#195, Q#275)*
  - **Placement Group Capacity Issue**: If you get "insufficient capacity" when adding instances to an existing Cluster placement group, Stop and Start all instances in the group to re-place them on available hardware �� this can free up contiguous capacity. You cannot merge placement groups. *(Q#275)*
  - **Enhanced Networking**: ENA (up to 100 Gbps) and EFA (for HPC/ML, OS-bypass). Required for placement group full performance. *(Q#195)*
  - **Capacity Reservations**: On-Demand Capacity Reservations guarantee capacity in a specific AZ; different from Reserved Instances (which are billing discounts). *(Q#20)*
  - **Spot Instances**: Up to 90% off, can be terminated with 2-min warning. Use Spot Fleet with multiple instance types + purchase options for diversification. *(Q#129, Q#205, Q#247)*
  - **VM Import/Export**: Migrate on-prem VMs to EC2 by exporting OVF, uploading to S3, running `ec2 import-image` CLI command. Preserves software and config. *(Q#50)*
  - **EC2 Instance Connect**: Uses temporary SSH keys pushed via AWS API �� auditable via CloudTrail, no long-lived SSH keys needed. *(Q#254)*
- **Common Pitfalls**:
  - ? Confusing Capacity Reservations (guarantee capacity) with Reserved Instances (billing discount)
  - ? Thinking Spot is reliable �� always design for interruption
  - ? Using Spread placement group for HPC (use Cluster, not Spread)
- **?? Q Refs**: #20, #35, #39, #49, #50, #90, #96, #108, #109, #110, #129, #152, #161, #164, #195, #205, #206, #208, #209, #233, #250, #252, #254, #273, #275
<!-- UPDATE_MARKER: EC2 -->

### EC2 Auto Scaling

- **Overview**: Automatically adjusts EC2 capacity based on demand. Uses Launch Templates (or Launch Configurations, legacy) to define instance specs.
- **?? Azure Equivalent**: Azure Virtual Machine Scale Sets (VMSS)
- **?? Azure Bridge**: Similar to VMSS but: (1) Launch Templates define what to launch, (2) ASG lifecycle hooks allow custom actions on launch/terminate, (3) scaling policies are more granular (target tracking, step, simple, scheduled). In Azure DevOps, you'd use pipeline tasks to update VMSS images �� analogous to updating Launch Templates.
- **Key Exam Facts** (from missed question):
  - **Attribute-Based Instance Selection**: Define instance requirements (vCPU, memory) instead of hardcoding types. ASG auto-selects from matching types across generations and architectures. Works with both On-Demand and Spot. *(Q#129, Q#233)*
  - **Scale-In Protection**: Prevents specific instances from being terminated during scale-in �� crucial for stateful workloads or instances processing messages. *(Q#110)*
  - **Lifecycle Hooks**: Pause instance at launch/terminate to run custom scripts (e.g., install software, drain connections). *(Q#10)*
  - **Integration with SQS**: Scale based on queue depth (`ApproximateNumberOfMessagesVisible`). *(Q#110)*
  - **Zero-Downtime Migration to ASG**: Attach existing EC2 instances to a new ASG (do NOT delete the ALB). ASG automatically replaces failed instances; existing instances continue serving traffic during transition. *(Q#209)*
  - **Batch Processing Decision (Lambda vs ECS)**: For event-driven batch jobs under 15 min �� Lambda (no infrastructure). For long-running batch or containerized dependencies �� ECS on Fargate (serverless containers) or AWS Batch. *(Q#204)*
- **Common Pitfalls**:
  - ? Using a single instance type in Spot Fleets �� diversify for availability
  - ? Forgetting to attach Launch Templates to ASGs (required for new features)
- **?? Q Refs**: #4, #10, #25, #29, #32, #33, #90, #108, #110, #129, #152, #204, #208, #209, #222, #233, #251, #273
<!-- UPDATE_MARKER: EC2-AutoScaling -->

### Lambda

- **Overview**: Serverless compute �� run code without provisioning servers. Pay per request + duration. 15-min max timeout, 10 GB max memory.
- **?? Azure Equivalent**: Azure Functions
- **?? Azure Bridge**: Very similar to Azure Functions. Key differences: (1) Lambda triggers from 200+ AWS service integrations vs Azure Functions bindings, (2) Lambda uses IAM execution role for permissions vs Azure Managed Identity, (3) Lambda Layers = shared code dependencies, (4) no Durable Functions equivalent natively �� use Step Functions.
- **Key Exam Facts** (from missed question):
  - **Versions & Aliases**: `$LATEST` is mutable; numbered versions are immutable snapshots. Aliases (e.g., `prod`, `staging`) point to specific versions, enable weighted traffic shifting for deployments. *(Q#120)*
  - **Lambda@Edge**: Run Lambda at CloudFront edge locations �� for request/response manipulation (e.g., URL rewrites, header injection, A/B testing). NOT for heavy compute. *(Q#5, Q#235)*
  - **Lambda in VPC**: Lambda in VPC creates ENIs in your subnets �� can access VPC resources (RDS, ElastiCache). Beware: this adds cold start latency and requires NAT Gateway for internet access.
  - **Docker/Lambda**: Container images up to 10 GB can be deployed to Lambda (stored in ECR). Use Lambda for the execution, not ECS/Fargate, if the workload is event-driven and short-lived. *(Q#122)*
  - **Concurrency**: Reserved concurrency = guaranteed capacity; Provisioned concurrency = no cold starts. Burst limits apply per account per Region. *(Q#17)*
  - **Integration**: Tightly coupled with API Gateway, S3 events, DynamoDB Streams, SQS, SNS, EventBridge, Kinesis. *(Q#131, Q#142, Q#143)*
- **Common Pitfalls**:
  - ? Using Lambda for long-running tasks (> 15 min) �� use Step Functions or EC2
  - ? Lambda@Edge has different limits (5-sec timeout, 128 MB max for viewer events)
  - ? Forgetting Lambda in VPC needs NAT Gateway for internet �� cost impact
- **?? Q Refs**: #5, #10, #14, #17, #33, #35, #36, #40, #48, #82, #88, #92, #96, #98, #109, #111, #112, #113, #115, #120, #122, #131, #142, #143, #160, #164, #204, #206, #212, #223, #247
<!-- UPDATE_MARKER: Lambda -->

### Elastic Beanstalk

- **Overview**: PaaS �� deploy applications (Java, .NET, Node, Python, Docker, Go, PHP) without managing the underlying infrastructure. Provisions EC2, ASG, ELB, RDS automatically.
- **?? Azure Equivalent**: Azure App Service
- **?? Azure Bridge**: Very similar to Azure App Service. Difference: Elastic Beanstalk gives you full access to the underlying resources (you can SSH into EC2 instances), whereas App Service is more abstracted. For your Azure DevOps background: deploying to Elastic Beanstalk can use `aws elasticbeanstalk create-application-version` in your pipeline �� similar to `az webapp deploy`.
- **Key Exam Facts** (from missed question):
  - **Blue/Green Deployment**: Swap environment URLs via CNAME �� new environment (green) gets validated, then Route 53 CNAME points to green. Zero downtime. You can also use Route 53 weighted routing to gradually shift traffic between old and new Beanstalk environments. *(Q#225)*
  - **Deployment Policies**: All at Once (fastest, downtime), Rolling (batch by batch), Rolling with Additional Batch (no capacity loss, higher cost), Immutable (new ASG, safest), Traffic Splitting (canary testing). *(Q#69)*
  - **Fast Rollback**: Immutable deployments enable the fastest rollback �� old ASG is still running. *(Q#69)*
- **Common Pitfalls**:
  - ? RDS created within Beanstalk environment is tied to it �� for production, create RDS separately
  - ? .NET on Linux is supported (since 2021) �� don't assume Windows only for .NET
- **?? Q Refs**: #29, #69, #85, #225
<!-- UPDATE_MARKER: ElasticBeanstalk -->

### AWS Batch

- **Overview**: Fully managed batch processing �� dynamically provisions EC2 or Fargate resources. Optimized for large-scale batch jobs (genomics, financial modeling, ETL).
- **?? Azure Equivalent**: Azure Batch
- **?? Azure Bridge**: Nearly identical to Azure Batch. Both manage job queues, compute environments, and auto-scaling. AWS Batch integrates with Step Functions for workflow orchestration. *(Q#104, Q#107)*
- **Key Exam Facts** (from missed question):
  - **Managed vs Unmanaged Compute**: Managed = AWS provisions and scales EC2/Fargate; Unmanaged = you manage.
  - **Integration with Step Functions**: For complex multi-step batch workflows, Step Functions orchestrates AWS Batch jobs. *(Q#104)*
- **?? Q Refs**: #104, #107, #204
<!-- UPDATE_MARKER: AWS-Batch -->

---

## ?? Similar Service Comparison �� Compute

### Lambda ?? ECS ?? Fargate ?? EC2 �� When to Use What?

| Criterion | Lambda | ECS on Fargate | ECS on EC2 | EC2 (Bare) |
|---|---|---|---|---|
| **Max runtime** | 15 min | Unlimited | Unlimited | Unlimited |
| **Cold start** | Yes (mitigated by Provisioned Concurrency) | No (warm containers) | No | No (always warm) |
| **OS/kernel control** | None | None (Fargate) | Yes (EC2 host) | Full |
| **Scaling speed** | Instant (per-request) | Fast (Service Auto Scaling) | Moderate | Moderate + Cool-down |
| **Best for** | Event-driven, short, variable | Steady microservices, APIs | Containerized apps needing host tuning | Legacy lift-and-shift, full control |
| **Azure equivalent** | Azure Functions | Azure Container Apps | AKS with VM node pools | Azure VMs |

**Exam signal**: If the question says "event-driven," "no servers to manage," "short execution" �� Lambda. If it says "containerized," "Docker," "long-running service" �� ECS/EKS. If "control over OS," "kernel modules," "legacy app" �� EC2.

> ?? **Related Qs**: #100, #104, #122, #204

### Spot Instances ?? Reserved Instances ?? Savings Plans ?? On-Demand

| Purchase Option | Discount | Commitment | Flexibility | Best For |
|---|---|---|---|---|
| **On-Demand** | None | None | Maximum | Unpredictable, short-term |
| **Spot** | Up to 90% | None | Can be interrupted | Stateless, fault-tolerant, batch |
| **Reserved Instances** | Up to 72% | 1 or 3 years, AZ-specific | Limited (modifiable) | Steady-state, predictable |
| **Savings Plans** | Up to 72% | 1 or 3 years, $/hour commit | High (any instance family, region) | Modern, flexible commitment |
| **Compute Savings Plans** | Up to 66% | 1 or 3 years | Any instance family + Lambda + Fargate | Most flexible |

**Exam signal**: "Most cost-effective for steady workload" �� Reserved/Savings Plans. "Fault-tolerant, stateless" �� Spot. "Need flexibility across services" �� Compute Savings Plans.

> ?? **Related Qs**: #20, #119, #129, #205, #247

---

## 2. ?? Containers

### ECS (Elastic Container Service)

- **Overview**: AWS-native container orchestration. Two launch types: EC2 (you manage nodes) and Fargate (serverless).
- **?? Azure Equivalent**: Azure Container Apps / Azure Container Instances
- **Key Exam Facts** (from missed question):
  - **ECS + Fargate**: No EC2 management needed �� each task gets isolated ENI. Ideal for operational simplicity. *(Q#100, Q#122)*
  - **ECS + EC2**: You manage the cluster, more control. Use placement constraints/strategies to control task placement. *(Q#100)*
  - **ECR integration**: Container images stored in ECR. Image scanning for CVEs via ECR Scan (Basic or Enhanced). Enhanced scanning integrates with Amazon Inspector for continuous vulnerability detection. Automate CVE response with EventBridge �� Step Functions �� SNS notification pipeline. *(Q#175)*
  - **ECS Exec**: SSH-like access into running containers for debugging. *(Q#175)*
- **?? Q Refs**: #100, #122, #146, #175, #204, #234
<!-- UPDATE_MARKER: ECS -->

### EKS (Elastic Kubernetes Service)

- **Overview**: Managed Kubernetes control plane. Run on EC2 or Fargate. For organizations already using Kubernetes workflows.
- **?? Azure Equivalent**: Azure Kubernetes Service (AKS)
- **?? Azure Bridge**: You mentioned you don't know Kubernetes �� EKS is AWS's managed K8s. Given your background, ECS (AWS-native) or Fargate is likely more relevant than EKS. The exam tests when to choose EKS (existing K8s investment, multi-cloud portability) vs ECS (AWS-native, simpler).
- **Key Exam Facts** (from missed question):
  - **EKS on Fargate**: Serverless pods �� no node management. *(Q#179)*
  - **EKS + EFS for Stateful Workloads**: Use EFS as persistent storage for EKS pods �� enables stateful applications (e.g., databases, session stores) on Kubernetes without managing storage volumes. *(Q#179)*
  - **Global Accelerator + EKS**: Use Global Accelerator for multi-region EKS clusters �� provides static anycast IPs and improved latency. *(Q#162)*
- **?? Q Refs**: #100, #119, #162, #179
<!-- UPDATE_MARKER: EKS -->

### ECR (Elastic Container Registry)

- **Overview**: Managed Docker/OCI container registry. Integrated with ECS, EKS, Lambda (container images). Scanning for vulnerabilities.
- **?? Azure Equivalent**: Azure Container Registry (ACR)
- **Key Exam Facts** (from missed question):
  - **Image Scanning**: Enhanced scanning integrates with Amazon Inspector for continuous CVE detection. *(Q#175)*
  - **Cross-account access**: Use repository policies or IAM roles. *(Q#107)*
- **?? Q Refs**: #107, #122, #175
<!-- UPDATE_MARKER: ECR -->

### Fargate

- **Overview**: Serverless compute engine for containers �� works with both ECS and EKS. No EC2 management.
- **?? Azure Equivalent**: Azure Container Instances (ACI) or Azure Container Apps
- **?? Q Refs**: #100, #115, #122, #146, #204
<!-- UPDATE_MARKER: Fargate -->

---

## ?? Similar Service Comparison �� Containers

### ECS ?? EKS �� When to Choose Which?

| Factor | ECS | EKS |
|---|---|---|
| **Ecosystem** | AWS-native | Kubernetes (CNCF) |
| **Complexity** | Lower | Higher |
| **Multi-cloud portability** | No (AWS-only) | Yes (standard K8s manifests) |
| **Existing investment** | Minimal learning curve | Leverage existing K8s skills |
| **Exam trigger** | "Minimizing operational overhead," "AWS-native" | "Existing Kubernetes tools," "multi-cloud," "Helm charts" |

> ?? **Related Qs**: #100, #162, #179

---

## 3. ?? Storage

### S3 (Simple Storage Service)

- **Overview**: Object storage �� unlimited scale, 99.999999999% (11 9s) durability. Objects up to 5 TB. Storage classes for cost optimization.
- **?? Azure Equivalent**: Azure Blob Storage
- **?? Azure Bridge**: Like Azure Blob but: (1) S3 has more storage classes (8 vs 4), (2) bucket policies = SAS tokens + access policies combined, (3) S3 Object Lock = immutable blob storage, (4) S3 Event Notifications = Azure Event Grid blob triggers. In your DevOps pipelines, `aws s3 sync` = `az storage blob upload-batch`.
- **Key Exam Facts** (from missed question):
  - **Storage Classes**: Standard (frequent access) �� Intelligent-Tiering (auto-moves) �� Standard-IA (infrequent, min 30 days) �� One Zone-IA �� Glacier Instant Retrieval (ms retrieval) �� Glacier Flexible Retrieval (min- hrs) �� Glacier Deep Archive (12 hrs, cheapest). *(Q#65, Q#246)*
  - **S3 Intelligent-Tiering**: Automatically moves objects between Frequent and Infrequent tiers based on access patterns. No retrieval fees, no operational overhead. Cost: monitoring fee per object. *(Q#65)*
  - **S3 Storage Lens**: Organization-wide visibility into storage usage, activity trends, and cost optimization recommendations. 14-day default metrics; advanced metrics (15 months) with additional cost. *(Q#66)*
  - **S3 Replication**: CRR (Cross-Region Replication) for DR/compliance, SRR (Same-Region) for log aggregation. Replication requires versioning enabled on both source and destination. *(Q#28, Q#105)*
  - **S3 Replication Time Control (S3 RTC)**: Predictable replication time �� replicates 99.99% of objects within 15 minutes, with a target of completing replication within 15 minutes after upload. Use prefix filters to apply RTC only to critical data. Monitor via CloudWatch `OperationReplicationTime` metric + EventBridge alerts for SLA compliance. *(Q#279)*
  - **S3 Transfer Acceleration**: Uses AWS edge locations to accelerate uploads over long distances. Works with presigned URLs �� generate presigned URL using the acceleration endpoint. Combine with S3 multipart upload API for large file (>100 MB) performance optimization. *. *(Q#296)*
  - **S3 Access Points**: Named network endpoints with dedicated permissions �� simplifies access management for shared datasets across accounts. Can be restricted to VPC. *(Q#224)*
  - **S3 Event Notifications**: Trigger Lambda, SQS, or SNS on object create/delete/restore events. *(Q#113)*
  - **S3 + CloudFront**: Origin Access Control (OAC) replaces Origin Access Identity (OAI). Restricts S3 bucket access to CloudFront only. *(Q#5, Q#28, Q#235)*
  - **S3 + Transfer Family**: Managed SFTP/FTPS/FTP interface to S3. *(Q#49, Q#113, Q#230)*
- **Common Pitfalls**:
  - ? CRR vs S3 Sync: CRR is automatic and ongoing; S3 sync is one-time batch
  - ? S3 Object Lock requires versioning �� can't enable without it
  - ? Intelligent-Tiering has a per-object monitoring fee (~$0.0025/1000 objects) �� not ideal for very small objects
- **?? Q Refs**: #10, #15, #18, #28, #31, #34, #49, #60, #65, #66, #78, #83, #92, #105, #107, #109, #113, #115, #120, #122, #130, #134, #136, #158, #224, #236, #246, #279, #296
<!-- UPDATE_MARKER: S3 -->

### EBS (Elastic Block Store)

- **Overview**: Block-level storage volumes for EC2. Types: gp3/gp2 (SSD), io2/io1 (Provisioned IOPS), st1/sc1 (HDD). Snapshots stored in S3.
- **?? Azure Equivalent**: Azure Managed Disks
- **?? Azure Bridge**: Like Managed Disks but: (1) EBS is AZ-scoped (can't attach across AZs), (2) snapshots are incremental and stored in S3, (3) EBS Multi-Attach (io2 only) = shared disks. gp3 = Premium SSD, io2 = Ultra Disk.
- **Key Exam Facts** (from missed question):
  - **Encryption by Default**: Can be enabled per Region �� all new EBS volumes are encrypted at rest using KMS. Ensures compliance without requiring users to specify encryption on each volume creation. *(Q#253)*
  - **EBS vs Instance Store**: EBS persists; Instance Store (ephemeral) is physically attached and lost on stop/terminate.
  - **DLM (Data Lifecycle Manager)**: Automate snapshot creation, retention, and cross-Region copying. For DR requiring EBS snapshots in ��2 additional Regions with lowest operational overhead, DLM is the first-choice managed service. *(Q#114, Q#245, Q#277)*
- **?? Q Refs**: #86, #102, #195, #253, #277
<!-- UPDATE_MARKER: EBS -->

### EFS (Elastic File System)

- **Overview**: Managed NFS file system �� scalable, elastic, multi-AZ. Linux only. Three storage classes: Standard, Infrequent Access, Archive.
- **?? Azure Equivalent**: Azure Files (SMB/NFS) or Azure NetApp Files
- **Key Exam Facts** (from missed question):
  - **Multi-AZ**: EFS is Regional �� accessible from any AZ in the Region.
  - **EFS + Transfer Family**: EFS can be the backend for Transfer Family SFTP endpoints. *(Q#230)*
- **?? Q Refs**: #11, #179, #230
<!-- UPDATE_MARKER: EFS -->

### FSx

- **Overview**: Managed Windows (SMB) or Lustre (HPC) file systems. FSx for Windows = managed Windows File Server; FSx for Lustre = high-performance for compute workloads.
- **?? Azure Equivalent**: Azure NetApp Files / Azure Files
- **Key Exam Facts** (from missed question):
  - **FSx for Windows**: Supports SMB, DFS, Active Directory integration. Used with WorkSpaces for user profiles. Storage type (HDD vs SSD) is immutable after creation �� to change, restore from AWS Backup to a new file system with desired specs. *(Q#108, Q#112, Q#153)*
  - **FSx for Lustre**: Sub-millisecond latencies, integrates with S3 (lazy load data). For HPC, ML, media processing. *(Q#18, Q#130)*
  - **FSx + DataSync**: DataSync can migrate on-prem file data to FSx for Windows. *(Q#27)*
- **?? Q Refs**: #18, #27, #108, #112, #130, #153
<!-- UPDATE_MARKER: FSx -->

### Storage Gateway

- **Overview**: Hybrid cloud storage �� on-premises appliance (VM) connects to S3. Three types: File Gateway (NFS/SMB �� S3), Volume Gateway (iSCSI �� EBS snapshots), Tape Gateway (virtual tape library �� S3 Glacier).
- **?? Azure Equivalent**: Azure File Sync / Azure Stack Edge
- **Key Exam Facts** (from missed question):
  - **File Gateway**: Presents NFS/SMB shares backed by S3. Supports S3 Lifecycle policies �� Hot data cached locally, cold data in S3 Glacier Deep Archive for cost-optimized long-term retention. *(Q#230, Q#246)*
  - **NOT the same as DataSync**: Storage Gateway provides ongoing access; DataSync is for migration/sync. *(Q#107)*
- **?? Q Refs**: #49, #107, #116, #246
<!-- UPDATE_MARKER: StorageGateway -->

### AWS Transfer Family

- **Overview**: Managed SFTP, FTPS, FTP service with S3 or EFS as backend. Supports authentication via Service Managed, AD, or custom IdP.
- **?? Azure Equivalent**: Azure SFTP (preview, on Blob Storage)
- **Key Exam Facts** (from missed question):
  - **Highly Available**: Multi-AZ deployment �� Elastic IPs for failover. *(Q#49, Q#230)*
  - **Transfer Family + EFS**: EFS as backend for Transfer Family SFTP �� provides POSIX-compliant shared file access with managed SFTP. Multi-AZ with Elastic IP failover for HA. *(Q#230)*
- **?? Q Refs**: #49, #113, #230
<!-- UPDATE_MARKER: TransferFamily -->

---

## ?? Similar Service Comparison �� Storage & Data Transfer

### S3 Replication (CRR/SRR) ?? DataSync ?? Storage Gateway ?? Snow Family

| Service | Direction | Use Case | Latency | Bandwidth |
|---|---|---|---|---|
| **S3 CRR** | S3 �� S3 (cross-region) | DR compliance, latency reduction | Near real-time | S3 throughput |
| **DataSync** | On-prem ? AWS | Migration, recurring data transfer | Scheduled | Up to 10 Gbps per agent |
| **Storage Gateway** | On-prem �� AWS (cache) | Hybrid access, tiering to cloud | Ongoing (cached) | Local network speed |
| **Snow Family** | Physical device | Large-scale offline transfer (>10 TB) | Days-weeks (physical) | Device capacity |

**Exam signal**: "Migrate petabytes" �� Snowball. "Ongoing hybrid access" �� Storage Gateway. "Fast online migration" �� DataSync. "Automatic cross-region DR" �� S3 CRR.

> ?? **Related Qs**: #27, #28, #105, #107, #116, #130, #158, #246

### S3 ?? EBS ?? EFS ?? FSx �� Storage for Different Workloads

| Storage | Type | Access | Multi-AZ | EC2 Sharing | Best For |
|---|---|---|---|---|---|
| **S3** | Object | HTTP/API | Regional (always) | Any instance via API | Static assets, data lakes, backups |
| **EBS** | Block | OS-level (mount) | AZ-scoped | Single instance (except io2 Multi-Attach) | Boot volumes, databases, low-latency apps |
| **EFS** | File (NFS) | Mount (NFSv4) | Regional | Many instances simultaneously | Shared code repos, CMS, web serving |
| **FSx** | File (SMB/Lustre) | Mount | Multi-AZ (Windows) | Many instances | Windows workloads, HPC |

**Exam signal**: "Shared across many EC2 instances" + "Linux" �� EFS. "Windows, AD integration" �� FSx for Windows. "High throughput for HPC" �� FSx for Lustre. "Boot volume" �� EBS.

> ?? **Related Qs**: #11, #15, #18, #130, #179, #230

---

## 4. ??? Database

### RDS (Relational Database Service)

- **Overview**: Managed relational databases �� MySQL, PostgreSQL, MariaDB, Oracle, SQL Server. Multi-AZ for HA, Read Replicas for read scaling.
- **?? Azure Equivalent**: Azure SQL Database / Azure Database for MySQL/PostgreSQL
- **?? Azure Bridge**: Similar to Azure SQL DB but: (1) RDS gives you more control (you choose instance type, storage, maintenance windows), (2) Multi-AZ uses synchronous replication vs Azure's auto-failover groups, (3) Read Replicas use async replication.
- **Key Exam Facts** (from missed question):
  - **Encryption**: At-rest via KMS; in-transit via SSL/TLS. IAM DB Authentication for password-less access (MySQL/PostgreSQL only). *(Q#160, Q#253)*
  - **Multi-AZ**: Synchronous standby in different AZ �� automatic failover. Not for scaling (standby is passive). *(Q#29, Q#61)*
  - **Cross-Region Read Replica**: Async replication to another Region for DR. Can be promoted to primary. *(Q#61, Q#213)*
  - **RDS Proxy**: Connection pooling for Lambda/serverless �� reduces connection overhead. Shares connections across Lambda invocations. *(Q#40)*
  - **Backup**: Automated backups (point-in-time recovery, up to 35 days retention) + manual snapshots. Cross-account snapshot sharing supported. *(Q#245)*
  - **SQL Server on RDS**: Babelfish for Aurora enables SQL Server application compatibility on PostgreSQL. *(Q#161)*
- **?? Q Refs**: #21, #40, #60, #61, #84, #86, #96, #119, #160, #161, #180, #245, #247, #251
<!-- UPDATE_MARKER: RDS -->

### Aurora

- **Overview**: MySQL/PostgreSQL-compatible, 5x throughput of standard MySQL, 3x of PostgreSQL. Auto-scaling storage (10 GB �� 128 TB). Separate compute and storage layers.
- **?? Azure Equivalent**: Azure Cosmos DB (for PostgreSQL) or Azure Database for PostgreSQL Hyperscale (Citus)
- **Key Exam Facts** (from missed question):
  - **Aurora Global Database**: Cross-region replication with < 1 second lag (typical). 1 primary Region + up to 5 secondary Regions. Secondary can be promoted for DR. RPO of ~1 second, RTO < 1 minute. Write forwarding allows secondary Region to forward writes to primary �� simplifies multi-Region application logic. *(Q#213, Q#227)*
  - **Aurora Auto Scaling**: Read replicas auto-scale based on load. Up to 15 replicas. *(Q#4)*
  - **Aurora Serverless v2**: Auto-scales capacity in fractions of a second. For variable/unpredictable workloads. *(Q#4)*
  - **Backtrack**: Rewind database to a point in time WITHOUT restore. Only for Aurora MySQL. *(Q#213, Q#227)*
  - **Babelfish**: Run SQL Server applications on Aurora PostgreSQL with minimal code changes. T-SQL compatibility including stored procedures, triggers, and functions. Enables replatforming SQL Server �� Aurora without rewriting application code. *(Q#161)*
- **?? Q Refs**: #4, #29, #40, #92, #114, #161, #213, #227, #234, #236, #251
<!-- UPDATE_MARKER: Aurora -->

### DynamoDB

- **Overview**: Fully managed NoSQL key-value and document database. Single-digit millisecond performance at any scale. Serverless.
- **?? Azure Equivalent**: Azure Cosmos DB
- **?? Azure Bridge**: Very similar to Cosmos DB. Both are serverless NoSQL with global distribution. Differences: (1) DynamoDB uses provisioned capacity or on-demand, Cosmos DB uses Request Units, (2) DynamoDB Global Tables = Cosmos DB multi-region writes, (3) DynamoDB Streams = Cosmos DB change feed.
- **Key Exam Facts** (from missed question):
  - **Global Tables**: Multi-active (read/write to any Region), eventual consistency. Built on DynamoDB Streams. Conflict resolution: last-writer-wins. *(Q#2, Q#105, Q#121)*
  - **DynamoDB Streams**: Ordered sequence of item-level changes. 24-hour retention. Triggers Lambda. Foundation for Global Tables. *(Q#105)*
  - **DAX (DynamoDB Accelerator)**: In-memory cache for DynamoDB �� microsecond latency for read-heavy workloads. Write-through cache. DAX is DynamoDB-specific; ElastiCache is general-purpose (works with any DB). Use DAX when you need caching specifically for DynamoDB with minimal application changes. *(Q#199, Q#260)*
  - **Capacity Modes**: Provisioned (predictable, cheaper �� use Application Auto Scaling with target tracking on consumed capacity) vs On-Demand (auto-scales, pay-per-request, ~2�� cost of well-tuned provisioned). Monitor `ConsumedReadCapacityUnits` and `ConsumedWriteCapacityUnits` in CloudWatch. *(Q#32, Q#222)*
  - **WCU/RCU**: Write Capacity Units (1 WCU = 1 write/sec for 1 KB item), Read Capacity Units (1 RCU = 1 strongly consistent read/sec for 4 KB, or 2 eventually consistent). *(Q#222)*
  - **Attribute-Level Access Control**: IAM policies can restrict access to specific attributes (columns) in DynamoDB items. *(Q#148)*
- **?? Q Refs**: #32, #60, #101, #105, #120, #121, #131, #148, #179, #199, #222, #223, #234, #260
<!-- UPDATE_MARKER: DynamoDB -->

### ElastiCache

- **Overview**: Managed Redis or Memcached in-memory cache. Redis: multi-AZ, persistence, pub/sub, geospatial; Memcached: simple, multi-threaded.
- **?? Azure Equivalent**: Azure Cache for Redis
- **Key Exam Facts** (from missed question):
  - **Redis**: Session store, leaderboards, real-time analytics, geospatial. Multi-AZ with auto-failover. Used with RDS for session management �� offload session state from database to ElastiCache for improved performance. *(Q#251, Q#260)*
  - **Reserved Nodes**: Like Reserved Instances but for ElastiCache. Significant discount (up to ~60%) for 1-3 year commitment. *(Q#247)*
- **?? Q Refs**: #247, #251
<!-- UPDATE_MARKER: ElastiCache -->

### Other Databases

- **DocumentDB**: MongoDB-compatible (3.6/4.0/5.0 API), managed. Use for existing MongoDB workloads migrating to AWS. *(Q#106)*
- **Redshift**: Petabyte-scale data warehouse, columnar storage. Concurrency Scaling for burst query loads. Elastic Resize for quick cluster resizing. *(Q#243)*
- **OpenSearch Service**: Managed Elasticsearch/Kibana successor. UltraWarm for infrequently accessed data, Cold Storage for rarely accessed. *(Q#34)*
- **DMS (Database Migration Service)**: Migrate databases to AWS with minimal downtime. Supports homogeneous (same engine) and heterogeneous (different engine). SCT (Schema Conversion Tool) for heterogeneous schema conversion. DMS can use S3 as intermediate target for CDC replication �� Aurora �� DMS �� S3 for DR with flexible RPO. *(Q#84, Q#114, Q#158, Q#180, Q#236)*
- **?? Q Refs**: #34, #84, #106, #114, #158, #180, #236, #243
<!-- UPDATE_MARKER: OtherDatabases -->

---

## ?? Similar Service Comparison �� Database

### RDS ?? Aurora ?? DynamoDB �� Choosing Your Database

| Criterion | RDS | Aurora | DynamoDB |
|---|---|---|---|
| **Data model** | Relational (SQL) | Relational (MySQL/PG compat) | Key-Value / Document (NoSQL) |
| **Scalability** | Vertical + Read Replicas (up to 5) | Auto-scaling storage + up to 15 replicas | Horizontal, unlimited |
| **Global** | Cross-Region Read Replica | Aurora Global Database (< 1 sec lag) | Global Tables (multi-active) |
| **Performance** | Standard | 5x MySQL / 3x PG throughput | Single-digit ms at any scale |
| **Serverless** | No | Aurora Serverless v2 | On-Demand mode |
| **Best for** | Traditional apps, joins, transactions | High-throughput OLTP, SaaS | Web/mobile/gaming, IoT, session stores |
| **Azure equivalent** | Azure SQL DB | Cosmos DB / Hyperscale | Cosmos DB |

**Exam signal**: "Relational, complex joins" �� RDS or Aurora. "Need 5x MySQL performance" �� Aurora. "Unpredictable scale, key-value, serverless" �� DynamoDB.

> ?? **Related Qs**: #40, #60, #92, #106, #179

### DMS ?? DataSync ?? SCT �� Migration Tools

| Tool | What It Moves | Direction | Notes |
|---|---|---|---|
| **DMS** | Databases (ongoing replication) | On-prem �� AWS, AWS ? AWS | CDC for minimal downtime |
| **SCT** | Database schema (convert engine) | N/A (schema conversion) | Paired with DMS for heterogeneous |
| **DataSync** | Files/objects | On-prem ? AWS | Not for databases |

> ?? **Related Qs**: #84, #114, #158, #236

### ElastiCache ?? DAX ?? CloudFront Caching

| Caching Layer | Scope | Latency | Best For |
|---|---|---|---|
| **CloudFront** | Edge (global) | ~ms (cached) | Static/dynamic content, API responses |
| **DAX** | DynamoDB only | Microseconds | Read-heavy DynamoDB workloads |
| **ElastiCache** | Any database/app | Sub-ms | Session stores, leaderboards, query caching |

> ?? **Related Qs**: #199, #235, #247, #251, #260

---

## 5. ?? Networking & Content Delivery

### VPC (Virtual Private Cloud)

- **Overview**: Isolated virtual network in AWS. CIDR-based. Subnets (public/private), Route Tables, Internet Gateway, NAT Gateway, Network ACLs, Security Groups.
- **?? Azure Equivalent**: Azure Virtual Network (VNet)
- **?? Azure Bridge**: Very similar to VNet. Differences: (1) VPC subnets are AZ-scoped (one subnet = one AZ), Azure subnets span AZs, (2) security groups are stateful and apply at instance level (like NSGs but stateful), NACLs are stateless subnet-level (like Azure NSGs but stateless), (3) VPC has IGW for internet, NAT Gateway for outbound-only, VPC Endpoints for private AWS service access. In Azure DevOps pipelines, `aws ec2 create-vpc` = `az network vnet create`.
- **Key Exam Facts** (from missed question):
  - **Overlapping CIDRs**: Cannot peer VPCs with overlapping CIDRs. Use PrivateLink or Transit Gateway with NAT. *(Q#135)*
  - **Security Groups vs NACLs**: SG = stateful (return traffic auto-allowed), instance-level. NACL = stateless (must explicitly allow return), subnet-level. *(Q#108)*
  - **Transit Gateway**: Hub-and-spoke network architecture �� connects thousands of VPCs and on-prem networks. Route tables control traffic flows. Better than VPC peering (mesh) for scale. *(Q#1, Q#62, Q#81, Q#95, Q#218)*
  - **VPC Endpoints**: Private connectivity to AWS services without internet. Gateway endpoints (S3, DynamoDB �� free). Interface endpoints (most other services �� powered by PrivateLink, $ per hour). *(Q#8, Q#92, Q#111)*
  - **IPv6 Migration**: Associate Amazon-provided IPv6 CIDR with VPC and subnets. For private subnet outbound IPv6, use **Egress-Only Internet Gateway** (not NAT Gateway �� NAT GW is IPv4-only). Route `::/0` from private subnets to the Egress-Only IGW. *(Q#287)*
  - **VPC Peering**: 1:1 connection between two VPCs. Non-transitive (A��B and B��C does NOT mean A��C). No overlapping CIDRs. *(Q#62, Q#81)*
- **?? Q Refs**: #1, #8, #15, #31, #62, #81, #92, #108, #111, #135, #206, #210, #217, #218, #224, #250, #287
<!-- UPDATE_MARKER: VPC -->

### Route 53

- **Overview**: Highly available DNS service. Supports Public Hosted Zones, Private Hosted Zones (for VPC), and Resolver for hybrid DNS.
- **?? Azure Equivalent**: Azure DNS + Azure Private DNS
- **?? Azure Bridge**: Similar to Azure DNS. Key mapping: Route 53 Private Hosted Zone = Azure Private DNS Zone; Route 53 Resolver = Azure DNS Private Resolver. Route 53's routing policies (weighted, latency, geolocation, failover) are more advanced than Azure DNS.
- **Key Exam Facts** (from missed question):
  - **Routing Policies**: Simple (no health check), Weighted (traffic split), Latency (lowest latency), Failover (active-passive), Geolocation (user location), Geoproximity (bias traffic), Multi-Value Answer (up to 8 healthy records). *(Q#2, Q#25, Q#88, Q#121)*
  - **Private Hosted Zone**: DNS records resolvable only within associated VPCs. Associate with multiple VPCs (cross-account via CLI/SDK). *(Q#1, Q#255)*
  - **Route 53 Resolver**: Hybrid DNS resolution.
    - **Inbound Endpoint**: On-prem �� VPC DNS queries (place ENIs in VPC, on-prem forwards to these IPs). *(Q#1, Q#217)*
    - **Outbound Endpoint**: VPC �� On-prem DNS queries (forwarding rules for on-prem domains). *(Q#217)*
  - **Resolver Rules**: Forward DNS queries for specific domains to specific IPs (conditional forwarding). Can be shared across accounts via RAM. Use with Direct Connect for hybrid DNS: on-prem domain queries �� Outbound Resolver �� on-prem DNS servers. *(Q#255)*
  - **Health Checks**: Monitor endpoints via HTTP/HTTPS/TCP. Can be tied to Route 53 routing policies for automated failover.
- **?? Q Refs**: #1, #2, #19, #25, #28, #29, #49, #88, #121, #152, #217, #225, #234, #255, #291
<!-- UPDATE_MARKER: Route53 -->

### API Gateway

- **Overview**: Fully managed REST, HTTP, and WebSocket API service. Integrates with Lambda, EC2, any HTTP endpoint. Supports request/response transformation, throttling, caching, and API keys.
- **?? Azure Equivalent**: Azure API Management
- **?? Azure Bridge**: Like Azure APIM. You use Azure DevOps pipelines to deploy APIs �� similar patterns: `aws apigateway create-deployment` maps to Azure DevOps release pipeline deploying to APIM. API Gateway has tighter Lambda integration than APIM has with Azure Functions.
- **Key Exam Facts** (from missed question):
  - **Endpoint Types**: Regional (same region), Edge-Optimized (via CloudFront), Private (VPC only via PrivateLink). *(Q#111)*
  - **Private API**: Only accessible within VPC via VPC Endpoint (PrivateLink). Resource policy controls which VPC endpoints can access. *(Q#111)*
  - **Throttling & Usage Plans**: API keys + usage plans control per-client rate limits. Protects backend from overload. *(Q#17)*
  - **Failover**: Use Regional endpoints + Route 53 failover (NOT multi-region edge-optimized �� edge-optimized is a single Region behind CloudFront). *(Q#2)*
  - **WebSocket**: API Gateway supports WebSocket for real-time, bidirectional communication. *(Q#223)*
  - **HTTP API + SQS Service Integration**: API Gateway HTTP API supports direct AWS service integrations �� write directly to SQS without Lambda at the ingestion point. Ideal for IoT data ingestion: absorbs unpredictable bursts, SQS buffers messages, zero data loss. *(Q#143)*
- **?? Q Refs**: #2, #5, #14, #17, #36, #88, #111, #121, #122, #143, #162, #196, #234
<!-- UPDATE_MARKER: APIGateway -->

### CloudFront

- **Overview**: CDN �� caches content at 450+ edge locations globally. Supports static (S3) and dynamic (ALB, EC2, API Gateway) origins. Integrates with WAF, Shield, Lambda@Edge.
- **?? Azure Equivalent**: Azure CDN / Azure Front Door
- **?? Azure Bridge**: Like Azure Front Door (global load balancer + CDN). CloudFront has more edge locations (450+ vs 190+). Key differences: CloudFront uses "distributions," Front Door uses "endpoints." Lambda@Edge = Azure Front Door Rules Engine.
- **Key Exam Facts** (from missed question):
  - **Origin Groups**: Primary + secondary origin for failover at the CDN level. Faster failover than Route 53 DNS-based failover (DNS caching causes delay). Configure origin failover as a cache behavior. *(Q#28, Q#291)*
  - **Cache Optimization**: Query string normalization �� use Lambda@Edge to normalize query parameters so CloudFront caches effectively (e.g., reorder query params, lowercase, strip irrelevant params). *(Q#235)*
  - **Lambda@Edge**: Run code at edge �� request/response manipulation, A/B testing, security headers. Viewer events (5 sec timeout) vs Origin events (30 sec timeout). *(Q#5, Q#235)*
  - **OAC (Origin Access Control)**: Restrict S3 access to CloudFront only �� replaces OAI. *(Q#28)*
- **?? Q Refs**: #5, #11, #14, #28, #105, #127, #162, #201, #235, #291
<!-- UPDATE_MARKER: CloudFront -->

### Direct Connect

- **Overview**: Dedicated physical connection between on-premises and AWS (via Direct Connect partner or directly to AWS). 1 Gbps, 10 Gbps, 100 Gbps. Not encrypted by default (use VPN overlay).
- **?? Azure Equivalent**: Azure ExpressRoute
- **?? Azure Bridge**: Very similar to ExpressRoute. Both offer dedicated private connectivity. DC + VPN = ExpressRoute + VPN failover. Direct Connect Gateway = ExpressRoute Gateway (multi-region).
- **Key Exam Facts** (from missed question):
  - **Direct Connect Gateway**: Connects Direct Connect to VPCs across multiple Regions (via Transit Gateway association). *(Q#12, Q#95)*
  - **DC + VPN**: Use Site-to-Site VPN as failover for Direct Connect �� common enterprise pattern. *(Q#95)*
  - **LAG (Link Aggregation Group)**: Combine multiple Direct Connect connections for higher bandwidth.
- **?? Q Refs**: #12, #27, #95, #107, #158, #230, #255
<!-- UPDATE_MARKER: DirectConnect -->

### Transit Gateway (TGW)

- **Overview**: Regional network transit hub �� connects VPCs, VPN, Direct Connect. Hub-and-spoke model. Route Tables control which attachments can talk to each other.
- **?? Azure Equivalent**: Azure Virtual WAN Hub
- **?? Azure Bridge**: Like Virtual WAN Hub. TGW Route Tables = Virtual WAN Route Tables. TGW is the central connectivity construct for large-scale AWS networking.
- **Key Exam Facts** (from missed question):
  - **TGW Route Tables**: Segmentation �� isolate dev/prod VPCs by associating them with different route tables. Each route table controls which attachments can send/receive traffic. This is the primary tool for network segmentation at scale. *(Q#218)*
  - **TGW + VPN**: Attach Site-to-Site VPN to TGW �� all connected VPCs can reach on-prem. Use with CloudFormation to automate test environment creation with TGW + VPN. *(Q#62, Q#250)*
  - **TGW + DX**: Attach Direct Connect Gateway to TGW. *(Q#95)*
  - **TGW Peering**: Connect TGWs across Regions for global network. *(Q#81)*
- **?? Q Refs**: #1, #62, #81, #95, #218, #250
<!-- UPDATE_MARKER: TransitGateway -->

### Load Balancers (ALB, NLB, GWLB)

| Load Balancer | OSI Layer | Protocol | Key Feature | Use Case |
|---|---|---|---|---|
| **ALB** | Layer 7 | HTTP/HTTPS, gRPC | Path/host/header routing, WAF integration | Microservices, web apps |
| **NLB** | Layer 4 | TCP/UDP/TLS | Static IP, ultra-low latency, preserve client IP | Gaming, IoT, financial |
| **GWLB** | Layer 3 | All IP | Transparent inline appliance insertion | Firewalls, IDS/IPS, deep packet inspection |

- **?? Azure Equivalent**: ALB = Azure Application Gateway; NLB = Azure Load Balancer; GWLB = Azure Firewall (sort of �� GWLB is more about routing to 3rd party appliances)
- **Key Exam Facts** (from missed question):
  - **ALB**: Supports weighted target groups for blue/green deployments. Sticky sessions via application-based cookies. *(Q#4, Q#152)*
  - **NLB**: Preserve source IP; static IP per AZ; can have Elastic IP per AZ. Supports TLS termination. *(Q#19, Q#121)*
  - **ALB + WAF**: ALB integrates with WAF for Layer 7 protection. NLB does NOT integrate with WAF (L4 only). *(Q#146)*
  - **ALB Target Groups**: Can target EC2, ECS, Lambda, IP addresses. Weighted target groups enable canary deployments (e.g., 90% old �� 10% new). Enable stickiness at target group level for session persistence during phased rollouts. *(Q#152)*
- **?? Q Refs**: #4, #19, #25, #29, #121, #126, #127, #146, #152, #162, #209, #251
<!-- UPDATE_MARKER: LoadBalancers -->

### Global Accelerator

- **Overview**: Improves global application availability and performance by routing traffic through AWS global network. Provides 2 static Anycast IPs. Routes to optimal regional endpoint.
- **?? Azure Equivalent**: Azure Front Door (Global) / Azure Traffic Manager
- **Key Exam Facts** (from missed question):
  - **vs CloudFront**: Global Accelerator routes through AWS backbone (not edge caching) �� for TCP/UDP, gaming, VoIP, IoT, and non-HTTP protocols (e.g., WebDAV). CloudFront is for HTTP/S content caching. *(Q#121, Q#162)*
  - **Static IPs**: Two anycast IPs that don't change �� point your DNS to these. Use when customers need to whitelist fixed IPs while preserving ALB + WAF architecture. ALB cannot have EIP; GA provides the static IPs. *(Q#132, Q#162)*
- **?? Q Refs**: #121, #132, #162
<!-- UPDATE_MARKER: GlobalAccelerator -->

### Other Networking Services

- **PrivateLink (VPC Endpoint)**: Expose your service privately (via NLB) to other VPCs/accounts. Consumers access via VPC Endpoint. No overlapping CIDR issues �� the definitive solution for sharing services across VPCs with overlapping CIDRs. *(Q#8, Q#111, Q#135)*
- **Cross-Region PrivateLink**: Not natively supported (PrivateLink is Regional). Workaround: NLB in consumer Region �� IP target group with provider's EC2 private IPs �� reachable via inter-Region VPC peering. *(Q#276)*
- **Client VPN**: Managed OpenVPN-based VPN for remote employees to access VPC. Scales automatically. *(Q#81)*
- **Site-to-Site VPN**: IPsec VPN between on-prem and VPC. Two tunnels per connection for HA. *(Q#62, Q#217, Q#250)*
- **NAT Gateway**: Managed NAT for outbound-only internet from private subnets. AZ-scoped (need one per AZ for HA). Elastic IP attached. *(Q#206)*
- **Prefix Lists**: Managed set of CIDR blocks. Simplify security group rules �� update one prefix list instead of many rules. *(Q#127)*
- **?? Q Refs**: #8, #62, #81, #111, #127, #135, #206, #217, #250, #276
<!-- UPDATE_MARKER: OtherNetworking -->

---

## ?? Similar Service Comparison �� Networking

### VPC Peering ?? Transit Gateway ?? PrivateLink

| Feature | VPC Peering | Transit Gateway | PrivateLink |
|---|---|---|---|
| **Topology** | Mesh (1:1 per connection) | Hub-and-spoke | Consumer-provider |
| **Scale** | Up to 125 peers per VPC | Thousands of VPCs | One service �� many consumers |
| **Transitive routing** | ? No | ? Yes (via route tables) | N/A (consumer��provider only) |
| **Overlapping CIDRs** | ? Not supported | ? Not supported | ? Supported (NAT at endpoint) |
| **Cross-Region** | ? Yes | ? Yes (TGW Peering) | ? No (Regional only) |
| **Bandwidth** | No aggregate limit (per-flow) | Up to 50 Gbps per VPC attachment | Up to 10 Gbps per endpoint |
| **Cost** | Data transfer (per GB) | Data transfer + hourly per attachment | Hourly per endpoint + data |

**Exam signal**: "Connect 3 VPCs" �� either (but TGW is more scalable). "Connect 100 VPCs" �� TGW. "Share a service privately to many accounts" �� PrivateLink. "Overlapping CIDRs" �� PrivateLink.

> ?? **Related Qs**: #8, #62, #81, #111, #135, #218

### Route 53 Resolver Inbound ?? Outbound Endpoints

| Endpoint | Direction | Purpose | IPs |
|---|---|---|---|
| **Inbound** | On-prem �� AWS | On-prem resolves AWS private hosted zone names | ENIs in VPC (your IPs) |
| **Outbound** | AWS �� On-prem | AWS resources resolve on-prem DNS names | ENIs in VPC (AWS-managed) |

**Exam signal**: "On-prem needs to resolve cloud.example.com" �� Inbound resolver. "EC2 needs to resolve server.corp.local" �� Outbound resolver. "Both ways" �� Both endpoints.

> ?? **Related Qs**: #1, #217, #255

### CloudFront ?? Global Accelerator ?? Route 53 Latency Routing

| Service | Layer | Optimizes | Static IP | Caching |
|---|---|---|---|---|
| **CloudFront** | L7 (HTTP/S) | Content delivery (cache) | ? (uses domain name) | ? Yes |
| **Global Accelerator** | L4 (TCP/UDP) | Network path (AWS backbone) | ? (2 anycast IPs) | ? No |
| **Route 53 Latency** | DNS | DNS resolution to lowest-latency endpoint | N/A | ? No |

**Exam signal**: "Cache content globally" �� CloudFront. "Gaming/VoIP/IoT, low-latency TCP/UDP" �� Global Accelerator. "DNS-level latency-based routing" �� Route 53 Latency.

> ?? **Related Qs**: #11, #121, #162, #235

---

## 6. ?? Security, Identity & Compliance

### IAM (Identity and Access Management)

- **Overview**: Control who can do what in AWS. Users, Groups, Roles, Policies. Supports federation (SAML 2.0, OIDC). Policy evaluation: explicit DENY > explicit ALLOW > implicit DENY.
- **?? Azure Equivalent**: Microsoft Entra ID (Azure AD) + Azure RBAC
- **?? Azure Bridge**: You use Azure AD for identity in Azure DevOps. AWS IAM roles are like Azure Managed Identities �� assign permissions to resources without credentials. IAM policies = Azure RBAC role definitions. IAM's explicit deny > allow > implicit deny is different from Azure's denyAssignments pattern.
- **Key Exam Facts** (from missed question):
  - **IAM Roles vs Resource-Based Policies**: Role = "what this principal can do"; Resource policy = "who can access this resource" (e.g., S3 bucket policy, KMS key policy). Cross-account: role (principal assumes role) OR resource policy (grants access). *(Q#16, Q#103, Q#117, Q#118)*
  - **IAM DB Authentication**: RDS/ Aurora MySQL and PostgreSQL can authenticate with IAM tokens �� no passwords in app. Token valid for 15 minutes. *(Q#92)*
  - **Permissions Boundary**: Maximum permissions an IAM entity can have �� even if broader policies are attached. Prevents privilege escalation. *(Q#148)*
  - **Access Analyzer**: Analyzes resource policies for unintended public/cross-account access. Generates findings. Use with EventBridge �� SNS for automated alerts when S3 buckets become publicly exposed. Best tool for continuous monitoring of public resource exposure. *(Q#101, Q#136)*
  - **IAM Identity Center (SSO)**: Single sign-on to AWS accounts + business applications. Integrates with AD (via AD Connector or Managed AD). SCIM for automated provisioning. *(Q#16, Q#56, Q#252)*
  - **IAM Policies Without Organizations**: When an account cannot join Organizations (no SCPs available), use IAM Deny policies with conditions (`ec2:InstanceType`, `aws:RequestedRegion`) to restrict resource launches. Explicit Deny is the strongest control within a standalone account. *(Q#278)*
- **?? Q Refs**: #16, #23, #24, #56, #59, #78, #92, #101, #103, #117, #118, #136, #148, #254, #271, #278
<!-- UPDATE_MARKER: IAM -->

### AWS Organizations & SCP

- **Overview**: Centrally manage multiple AWS accounts. Organize accounts into OUs. Apply SCPs (Service Control Policies) �� guardrails that limit what services/actions accounts can use.
- **?? Azure Equivalent**: Azure Management Groups + Azure Policy
- **?? Azure Bridge**: Organizations = Management Groups hierarchy; SCPs = Azure Policies (at management group level). Key difference: SCPs in AWS are "permission boundaries" (don't grant permissions themselves, only limit what IAM can grant), Azure Policies evaluate resource compliance.
- **Key Exam Facts** (from missed question):
  - **SCP Evaluation**: SCP restricts maximum permissions. Even if IAM allows, SCP can deny. Root SCP applies to all OUs �� to exempt an account, move it to an OU without that SCP. *(Q#3, Q#24)*
  - **Deny List vs Allow List**: Deny list (default FullAWSAccess, add deny SCPs) �� easier to manage. Allow list (remove FullAWSAccess, add allow SCPs) �� more restrictive, more maintenance. *(Q#3)*
  - **SCP Inheritance**: Parent OU SCPs apply to child OUs. Account-level SCPs can be more restrictive but never less. *(Q#24)*
  - **Tag Policies**: Standardize tags across organization. Enforce tag keys, values, and formats. Use with Cost Explorer for chargeback. *(Q#232)*
  - **Control Tower + Identity Center + Config**: The modern multi-account governance stack �� Control Tower for landing zone/OU creation, IAM Identity Center for SSO, Config for compliance monitoring. Together they provide preventive (SCP) + detective (Config) + identity (SSO) controls. *(Q#267)*
- **?? Q Refs**: #3, #23, #24, #30, #35, #56, #67, #210, #224, #232, #245, #267
<!-- UPDATE_MARKER: Organizations-SCP -->

### KMS (Key Management Service)

- **Overview**: Managed encryption key service. Symmetric keys, asymmetric keys, and custom key stores (CloudHSM, External). Integrated with most AWS services.
- **?? Azure Equivalent**: Azure Key Vault (keys)
- **?? Azure Bridge**: KMS creates and manages encryption keys �� like Azure Key Vault for keys. Key policies = Key Vault access policies. KMS is primarily for encryption keys; Secrets Manager (below) is for application secrets.
- **Key Exam Facts** (from missed question):
  - **Key Policies**: Resource-based policies that control who can use/administer the key. Default: key creator has full access. *(Q#78, Q#103)*
  - **Automatic Key Rotation**: Symmetric KMS keys can auto-rotate yearly. Customer-managed keys: optional, enable per key. *(Q#160)*
  - **Cross-Account Access**: Grant key usage via key policy (preferred) or IAM role. *(Q#103)*
- **?? Q Refs**: #78, #83, #103, #160, #253
<!-- UPDATE_MARKER: KMS -->

### Secrets Manager

- **Overview**: Store and rotate secrets (database credentials, API keys, OAuth tokens). Automatic rotation via Lambda. Integration with RDS, Redshift, DocumentDB.
- **?? Azure Equivalent**: Azure Key Vault (secrets)
- **?? Azure Bridge**: In Azure DevOps, you use Key Vault in pipelines to inject secrets �� `AzureKeyVault@2` task. AWS equivalent: `aws secretsmanager get-secret-value` in CodeBuild/CodePipeline. Secrets Manager can auto-rotate RDS passwords via Lambda �� similar to Azure Key Vault auto-rotation.
- **Key Exam Facts** (from missed question):
  - **Rotation**: Built-in rotation for RDS, Redshift, DocumentDB. Uses Lambda to generate new password, update both Secrets Manager and the database. Also supports SSH key rotation for EC2 �� Lambda generates new key pair, updates Secrets Manager, and uses Systems Manager Run Command to deploy new public key to instances. *(Q#160, Q#163, Q#164)*
  - **Cross-Account**: Share secrets via resource policies. *(Q#103)*
  - **vs Parameter Store**: Secrets Manager = rotation, cross-account, $0.40/secret/month; Parameter Store = free, no rotation, 10K parameter limit. *(Q#21, Q#164)*
- **?? Q Refs**: #21, #103, #160, #163, #164
<!-- UPDATE_MARKER: SecretsManager -->

### WAF & Shield

- **Overview**: WAF = Layer 7 web application firewall (SQL injection, XSS, rate limiting). Shield = DDoS protection (Standard = free, Advanced = $3K/month + 1-yr commit).
- **?? Azure Equivalent**: Azure WAF (on Application Gateway / Front Door) + Azure DDoS Protection
- **Key Exam Facts** (from missed question):
  - **WAF**: Associates with CloudFront, ALB, API Gateway, AppSync. Managed rules (AWS Managed, Marketplace). Custom rules based on IP, country, headers, body, rate. *(Q#125, Q#127, Q#146, Q#196)*
  - **WAF + ALB**: Layer 7 only �� ALB forwards to WAF for inspection. NLB cannot use WAF (L4). *(Q#146)*
  - **Shield Advanced**: 24/7 DDoS response team access, cost protection for scaling during attacks, real-time visibility. *(Q#125)*
- **?? Q Refs**: #79, #125, #127, #146, #196
<!-- UPDATE_MARKER: WAF-Shield -->

### Other Security Services

- **CloudTrail**: API audit log �� records every API call. Management events (control plane) + Data events (S3 object-level, Lambda invocations). CloudTrail Lake for SQL-based analysis. *(Q#101, Q#254)*
- **AWS Config**: Resource inventory + compliance evaluation. Track resource configuration changes, evaluate against rules. Config rules can auto-remediate via SSM Automation. Use with SNS for real-time compliance alerts (e.g., security group changes). *(Q#3, Q#35, Q#172)*
- **Security Groups**: Stateful, instance-level firewall. Allow rules only (implicit deny). *(Q#35, Q#127)*
- **Certificate Manager (ACM)**: Provision SSL/TLS certificates for ALB, CloudFront, API Gateway. Free. Auto-renewal. *(Q#39)*
- **Directory Service**: Managed Microsoft AD (full AD in AWS), AD Connector (proxy to on-prem AD), Simple AD (Samba-based). Managed AD supports MFA, trusts, and full AD features. AD Connector proxies authentication to on-prem AD without caching. Simple AD is Samba-based for basic use cases �� no MFA or trust support. *(Q#16, Q#56, Q#108, Q#112, Q#153, Q#219, Q#252, Q#255, Q#259, Q#295)*
- **Cognito**: User identity for web/mobile apps. User pools (authentication) + Identity pools (authorization to AWS services). *(Q#201)*
- **?? Q Refs**: #16, #39, #56, #59, #101, #136, #172, #201, #252, #254, #259, #267, #295
<!-- UPDATE_MARKER: OtherSecurity -->

---

## ?? Similar Service Comparison �� Security

### IAM Role ?? SCP ?? Permissions Boundary �� Access Control Layers

| Layer | Scope | What It Does | Who Sets It |
|---|---|---|---|
| **IAM Policy** | Principal (User/Role) | Grants permissions (ALLOW) | Account admin |
| **Resource Policy** | Resource (S3, KMS, etc.) | Who can access this resource | Resource owner |
| **SCP** | OU / Account | Limits MAX permissions (guardrail) | Organization admin |
| **Permissions Boundary** | IAM entity | Limits MAX permissions (per entity) | Account admin |
| **Session Policy** | Temporary session | Further limits permissions for a session | Caller |

**Evaluation order**: All must ALLOW. SCP and Permissions Boundary act as filters �� even if IAM policy allows, SCP can deny.

> ?? **Related Qs**: #3, #24, #148

### Secrets Manager ?? Parameter Store (SSM)

| Feature | Secrets Manager | SSM Parameter Store |
|---|---|---|
| **Purpose** | Application secrets | Configuration data + secrets |
| **Rotation** | ? Automated (Lambda) | ? Manual |
| **Cross-Account** | ? Via resource policy | ? Not natively |
| **Cost** | $0.40/secret/month + API calls | Free (Standard), $0.05/advanced |
| **RDS Integration** | ? Built-in | ? Manual |
| **Exam trigger** | "Automatic rotation of RDS credentials" | "Hierarchical configuration storage" |

> ?? **Related Qs**: #21, #160, #164

### AWS Config ?? CloudTrail ?? CloudWatch

| Service | Purpose | Data | Retention |
|---|---|---|---|
| **CloudTrail** | "Who did what, when?" | API calls | 90 days (Event History), unlimited (Trail �� S3) |
| **AWS Config** | "What does my resource look like?" + "Is it compliant?" | Resource configurations | Unlimited |
| **CloudWatch** | "How is my system performing?" | Metrics, logs, alarms | Based on log group retention |

**Exam signal**: "Security audit of API activity" �� CloudTrail. "Track resource configuration drift" �� AWS Config. "Performance monitoring and alerting" �� CloudWatch.

> ?? **Related Qs**: #3, #35, #101, #102, #172, #254

---

## 7. ?? Application Integration

### SQS (Simple Queue Service)

- **Overview**: Fully managed message queuing. Standard (at-least-once, high throughput) and FIFO (exactly-once, 300 msg/s). Messages retained up to 14 days.
- **?? Azure Equivalent**: Azure Queue Storage / Azure Service Bus
- **?? Azure Bridge**: You likely use Azure DevOps pipelines �� SQS is like Service Bus Queues. In a pipeline, you might poll SQS for a message before proceeding �� similar to checking Service Bus queue depth.
- **Key Exam Facts** (from missed question):
  - **Visibility Timeout**: Time a message is invisible after being received �� prevents other consumers from processing. If not deleted before timeout, message reappears. *(Q#110)*
  - **Dead Letter Queue (DLQ)**: Messages that exceed `maxReceiveCount` go to DLQ. Analyze, then redrive to source queue. *(Q#110, Q#142, Q#212)*
  - **Decoupling Pattern**: SQS between producer and consumer smooths traffic spikes. Producer sends to queue; consumer processes at its own pace. *(Q#33)*
  - **SQS + Auto Scaling**: Scale EC2 instances based on queue depth (ApproximateNumberOfMessagesVisible). Scale-in protection for instances still processing. *(Q#110)*
- **?? Q Refs**: #33, #82, #110, #115, #131, #142, #143, #212
<!-- UPDATE_MARKER: SQS -->

### SNS (Simple Notification Service)

- **Overview**: Pub/sub messaging. Topics �� Subscriptions (SQS, Lambda, HTTP/S, email, SMS, mobile push). Fan-out: one message �� many subscribers.
- **?? Azure Equivalent**: Azure Event Grid / Azure Notification Hubs
- **Key Exam Facts** (from missed question):
  - **Fan-out Pattern**: SNS �� multiple SQS queues (one per consumer). Each queue independently processes messages. For microservices deletion events, consider EventBridge (pattern matching) vs SNS (all subscribers get all messages). *(Q#131)*
  - **SNS + SQS**: SNS delivers to SQS for durable processing. If subscriber (Lambda) fails, message must persist �� SQS. *(Q#142)*
  - **SNS + Lambda**: Direct trigger �� Lambda processes immediately. No durability concern. *(Q#113, Q#142)*
- **?? Q Refs**: #35, #109, #113, #131, #136, #142, #172, #175
<!-- UPDATE_MARKER: SNS -->

### EventBridge

- **Overview**: Serverless event bus. SaaS integration (Zendesk, Datadog, PagerDuty). Pattern matching rules route events to targets. Schema registry for event discovery.
- **?? Azure Equivalent**: Azure Event Grid
- **Key Exam Facts** (from missed question):
  - **vs SNS**: EventBridge = pattern-based routing (rules match event attributes); SNS = topic-based (subscribers get all messages). EventBridge has 3rd-party SaaS integrations. For microservices fan-out deletion with pattern matching �� EventBridge Custom Event Bus. *(Q#131)*
  - **EventBridge + Step Functions**: Orchestrate complex workflows triggered by events. *(Q#104)*
  - **Automation**: EventBridge + Lambda + SSM for automatic remediation (e.g., S3 public access �� EventBridge �� Lambda �� fix). *(Q#35, Q#136)*
- **?? Q Refs**: #10, #35, #96, #104, #112, #131, #134, #136, #175
<!-- UPDATE_MARKER: EventBridge -->

### Step Functions

- **Overview**: Visual workflow orchestration for distributed applications. Standard (exactly-once, up to 1 year) and Express (high-volume, up to 5 min). Built-in retry, error handling, parallel execution.
- **?? Azure Equivalent**: Azure Logic Apps + Durable Functions
- **Key Exam Facts** (from missed question):
  - **Orchestration**: Coordinate Lambda, ECS, Batch, SNS, SQS �� handle retries, timeouts, conditional branching. *(Q#104)*
  - **Error Handling**: Built-in retry with exponential backoff, catch blocks, fallback states. No custom error handling code needed. *(Q#104)*
- **?? Q Refs**: #104, #107, #134, #175
<!-- UPDATE_MARKER: StepFunctions -->

### AppSync

- **Overview**: Managed GraphQL service. Real-time subscriptions via WebSocket. Integrates with DynamoDB, Lambda, HTTP, RDS. Offline data with Amplify DataStore.
- **?? Azure Equivalent**: Azure API Management (GraphQL) / Hot Chocolate on .NET
- **?? Q Refs**: #212, #223
<!-- UPDATE_MARKER: AppSync -->

---

## ?? Similar Service Comparison �� Messaging & Events

### SQS ?? SNS ?? EventBridge ?? Kinesis

| Service | Pattern | Retention | Ordering | Best For |
|---|---|---|---|---|
| **SQS** | Queue (pull) | Up to 14 days | FIFO queue supports | Decouple producer/consumer, buffering |
| **SNS** | Pub/Sub (push) | No persistence (fire & forget) | FIFO topic supports | Fan-out, push notifications |
| **EventBridge** | Event bus (push) | Archived (optional replay) | No guarantee | Cross-account, SaaS integration, pattern matching |
| **Kinesis Data Streams** | Stream (pull) | Up to 365 days (default 24 hours) | Per-shard ordering | Real-time streaming, replay, multi-consumer |

**Exam signal**: "Decouple, buffer messages" �� SQS. "One message �� many subscribers" �� SNS. "Pattern matching + SaaS events" �� EventBridge. "Real-time stream, replay from any point" �� Kinesis.

> ?? **Related Qs**: #33, #82, #110, #131, #142, #143, #212

---

## 8. ?? Management & Governance

### CloudFormation

- **Overview**: Infrastructure as Code (IaC) �� define AWS resources in YAML/JSON templates. Declarative. Stack management (create, update, delete, drift detection).
- **?? Azure Equivalent**: Azure Resource Manager (ARM) / Bicep
- **?? Azure Bridge**: **This is your sweet spot!** You use Azure DevOps pipelines + ARM/Bicep to deploy infrastructure. CloudFormation is nearly identical in concept. Key mapping: CloudFormation template = ARM template; CloudFormation Stack = Resource Group deployment; CloudFormation StackSets = Deployment Stacks (Azure). In your pipeline, `aws cloudformation deploy` replaces `az deployment group create`.
- **Key Exam Facts** (from missed question):
  - **StackSets**: Deploy same template to multiple accounts/Regions from a central admin account. Self-managed or service-managed permissions. *(Q#30, Q#67, Q#210)*
  - **Custom Resources**: Use Lambda-backed custom resources to perform actions CloudFormation doesn't natively support (e.g., S3 lifecycle configuration, external API calls). Custom resource response must be sent to pre-signed S3 URL. *(Q#262)*
  - **Nested Stacks**: Break large templates into smaller reusable pieces. Different from StackSets (which deploy same stack to many places). *(Q#67)*
  - **Drift Detection**: Detect when resources have been changed outside CloudFormation. *(Q#232)*
  - **Change Sets**: Preview changes before applying �� understand impact before deployment. *(Q#59)*
- **?? Q Refs**: #14, #21, #30, #48, #59, #67, #134, #232, #245, #250, #262, #266
<!-- UPDATE_MARKER: CloudFormation -->

### Systems Manager (SSM)

- **Overview**: Operational management suite. Parameter Store, Session Manager, Automation, Patch Manager, Run Command, Fleet Manager, Inventory.
- **?? Azure Equivalent**: Azure Automation / Azure Update Manager / Azure Arc
- **Key Exam Facts** (from missed question):
  - **Session Manager**: Browser-based SSH/RDP access to EC2 �� no bastion host, no open inbound ports. Auditable via CloudTrail + S3 logging. Use with IAM Identity Center for centralized access management to Windows instances. *(Q#252, Q#254)*
  - **Fleet Manager**: Manage fleets of EC2 instances �� view performance, troubleshoot, run commands. *(Q#252)*
  - **Automation**: Runbooks for common maintenance tasks (AMI creation, instance stop/start, patch). *(Q#125)*
  - **Run Command**: Execute scripts on managed instances remotely �� no SSH needed. *(Q#90)*
- **?? Q Refs**: #9, #10, #90, #125, #164, #252, #254
<!-- UPDATE_MARKER: SystemsManager -->

### CloudWatch

- **Overview**: Metrics (EC2, RDS, Lambda, custom), Logs (application logs), Alarms (threshold-based actions), Dashboards, Synthetics (canaries), ServiceLens (traces).
- **?? Azure Equivalent**: Azure Monitor
- **Key Exam Facts** (from missed question):
  - **Alarms**: Trigger Auto Scaling, SNS notifications, or EC2 actions based on metric thresholds. *(Q#14, Q#204, Q#206)*
  - **Logs**: Unified log storage �� retention configurable. Log Insights for querying. *(Q#172)*
  - **Metrics**: Default metrics (free) vs Detailed Monitoring (1-min granularity, $). Custom metrics can be published via API. *(Q#222)*
- **?? Q Refs**: #14, #102, #112, #204, #206, #209, #222, #243
<!-- UPDATE_MARKER: CloudWatch -->

### Other Management Services

- **Service Catalog**: Publish approved products (CloudFormation templates) for self-service. Enforces governance �� users deploy only approved configurations. *(Q#210)*
- **AWS Backup**: Centralized backup management across services (EC2, EBS, RDS, DynamoDB, EFS, FSx, etc.). Backup Plans, Vaults, cross-account copying. *(Q#134, Q#153, Q#234, Q#245)*
- **Cost Explorer**: Visualize and analyze AWS spending. Savings Plans and Reserved Instance recommendations. *(Q#232)*
- **Compute Optimizer**: ML-based rightsizing recommendations for EC2, EBS, Lambda, ECS. *(Q#102, Q#233)*
- **Trusted Advisor**: Best practice checks across cost, performance, security, fault tolerance, service limits. *(Q#102)*
- **Migration Evaluator**: Estimate TCO for migrating to AWS �� generates business case. *(Q#124, Q#137)*
- **Application Discovery Service**: Discover on-premises servers, map dependencies, estimate migration costs. *(Q#124, Q#137)*
- **?? Q Refs**: #26, #64, #102, #124, #134, #137, #153, #210, #232, #233, #234, #245, #252, #286, #290
<!-- UPDATE_MARKER: OtherManagement -->

---

## ?? Similar Service Comparison �� IaC & Governance

### CloudFormation ?? CloudFormation StackSets ?? Service Catalog

| Tool | Scope | Use Case |
|---|---|---|
| **CloudFormation** | Single account, single Region | Deploy a stack of resources |
| **StackSets** | Multi-account, multi-Region | Deploy same stack across organization |
| **Service Catalog** | Governed self-service | Allow teams to deploy approved products |

**Exam signal**: "Deploy to one account" �� CloudFormation. "Deploy to all accounts" �� StackSets. "Self-service with governance" �� Service Catalog.

> ?? **Related Qs**: #30, #67, #210, #232

### AWS Backup ?? DLM ?? Manual Snapshots

| Method | Scope | Automation | Cross-Region | Cross-Account |
|---|---|---|---|---|
| **AWS Backup** | Multi-service | ? Scheduled + retention rules | ? Built-in | ? Built-in |
| **DLM** | EBS snapshots, AMIs | ? Scheduled policies | ? | ? (since 2023) |
| **Manual Snapshots** | Per-resource | ? | ? Manual | ? Manual |

> ?? **Related Qs**: #114, #134, #153, #234, #245

---

## 9. ?? Migration & Transfer

> **Note**: DMS is covered in detail in [Section 4 �� Database](#4-%EF%B8%8F-database). Storage Gateway and Transfer Family are covered in [Section 3 �� Storage](#3--storage). Cross-reference those sections for full details.

### DataSync

- **Overview**: Online data transfer service �� moves files/objects between on-premises and AWS (S3, EFS, FSx). Automated scheduling, bandwidth throttling, incremental transfers. Up to 10 Gbps per agent.
- **?? Azure Equivalent**: Azure File Sync / AzCopy
- **?? Azure Bridge**: Like AzCopy but managed �� scheduled, incremental, with bandwidth control. In your DevOps world, DataSync is like a managed `robocopy` or `rsync` to AWS.
- **Key Exam Facts** (from missed question):
  - **NOT Storage Gateway**: DataSync is for migration/sync (one-time or scheduled); Storage Gateway is for ongoing hybrid access. *(Q#107)*
  - **Supported Destinations**: S3, EFS, FSx for Windows, FSx for Lustre. *(Q#27, Q#130)*
  - **Incremental Transfer**: Only transfers changed files after initial full sync �� bandwidth efficient. *(Q#27)*
  - **DataSync + Direct Connect**: Use Direct Connect for consistent bandwidth during large data transfers. *(Q#27)*
- **?? Q Refs**: #27, #107, #114, #130, #158, #264, #285
<!-- UPDATE_MARKER: DataSync -->

### Snow Family (Snowball Edge / Snowmobile)

- **Overview**: Physical devices for offline data transfer. Snowball Edge (80 TB storage + compute), Snowmobile (100 PB, literal shipping container on a truck). Use when network transfer would take too long or is too expensive.
- **?? Azure Equivalent**: Azure Data Box / Data Box Heavy
- **Key Exam Facts** (from missed question):
  - **When to Use**: >10 TB over slow/expensive network. Snowball Edge also provides edge compute (EC2, Lambda) �� useful for disconnected/remote environments. *(Q#107, Q#123, Q#149, Q#158)*
  - **Snowball Edge Compute**: Run Lambda functions + EC2 instances on the device. For industrial IoT, factory floor, remote mining. *(Q#123, Q#149)*
  - **Not for Databases**: Snowball transfers data to S3; use DMS for database migration. *(Q#158)*
  - **Encryption**: Data encrypted at rest (256-bit) and in transit (TLS). Device is tamper-resistant.
- **?? Q Refs**: #107, #123, #149, #158
<!-- UPDATE_MARKER: SnowFamily -->

### Application Migration Service (MGN)

- **Overview**: Server-level lift-and-shift (rehost) �� replicates entire servers (physical, VMware, Hyper-V) to AWS as EC2 instances. Block-level continuous replication with near-zero RPO. Formerly CloudEndure.
- **?? Azure Equivalent**: Azure Migrate: Server Migration
- **Key Exam Facts** (from missed question):
  - **Continuous Replication**: Block-level replication keeps source and target in sync until cutover. Minimal downtime.
  - **vs DMS**: MGN migrates entire servers (OS + apps + data); DMS migrates only databases. Use MGN for lift-and-shift, DMS for database-only migration with schema conversion. *(Q#116)*
  - **vs DataSync + DMS**: MGN = server-level; DataSync = file-level; DMS = database-level. Choose based on migration granularity.
- **?? Q Refs**: #116
<!-- UPDATE_MARKER: MGN -->

### Application Discovery Service

- **Overview**: Discovers on-premises servers, maps their dependencies, and collects performance data. Two modes: Agentless (via vCenter, VMware only) and Agent-based (any OS, deeper insights). Feeds into Migration Hub.
- **?? Azure Equivalent**: Azure Migrate: Discovery and Assessment
- **Key Exam Facts** (from missed question):
  - **Dependency Mapping**: Visualize which servers communicate with each other �� identify app groups for migration waves. *(Q#124, Q#137)*
  - **TCO Estimation**: Combine with Migration Evaluator for business case generation. *(Q#124, Q#137)*
  - **Agent-based vs Agentless**: Agent-based collects more data (running processes, network connections); Agentless is lighter but VMware-only. *(Q#124)*
- **?? Q Refs**: #124, #137
<!-- UPDATE_MARKER: ApplicationDiscoveryService -->

### Migration Hub

- **Overview**: Central dashboard to track migration progress across multiple tools (MGN, DMS, DataSync, etc.). Single view of migration status across your entire portfolio.
- **?? Azure Equivalent**: Azure Migrate (hub)
- **?? Q Refs**: #137
<!-- UPDATE_MARKER: MigrationHub -->

### SCT (Schema Conversion Tool)

- **Overview**: Converts database schema from one engine to another (e.g., Oracle �� Aurora, SQL Server �� MySQL). Handles stored procedures, views, functions. Used alongside DMS for heterogeneous migrations.
- **?? Azure Equivalent**: Azure Database Migration Service (schema conversion) / SSMA
- **Key Exam Facts** (from missed question):
  - **Heterogeneous Only**: SCT is only needed when source and target DB engines differ. Homogeneous migration (MySQL �� RDS MySQL) uses DMS alone. *(Q#84)*
  - **Assessment Report**: SCT generates a report showing how much of the schema can be auto-converted vs needs manual intervention. *(Q#84)*
- **?? Q Refs**: #84, #161
<!-- UPDATE_MARKER: SCT -->

### Migration Evaluator

- **Overview**: Free tool that analyzes on-premises inventory and provides a business case for migrating to AWS �� includes TCO comparison, projected savings, and resource mapping.
- **?? Azure Equivalent**: Azure TCO Calculator / Azure Migrate Business Case
- **?? Q Refs**: #124, #137
<!-- UPDATE_MARKER: MigrationEvaluator -->

### VM Import/Export

- **Overview**: Import VM images (OVA, VMDK, VHD, RAW) from on-premises to AWS as AMIs. Export AMIs back to on-premises formats. Preserves software, configuration, and data.
- **?? Azure Equivalent**: Azure Migrate (VM import) / Azure VM Image Builder
- **Key Exam Facts** (from missed question):
  - **CLI-Driven**: Use `aws ec2 import-image` CLI command �� requires IAM role `vmimport`. Image stored in S3 before conversion to AMI. *(Q#50)*
  - **Supported Formats**: OVA, VMDK, VHD, RAW. Can directly import VMware VMs. *(Q#50)*
- **?? Q Refs**: #50
<!-- UPDATE_MARKER: VMImportExport -->

---

## ?? Similar Service Comparison �� Migration

### DataSync ?? Storage Gateway ?? Snow Family ?? DMS

| Service | Type | When | Speed |
|---|---|---|---|
| **DataSync** | Online file transfer | < 10 TB, ongoing sync | Up to 10 Gbps |
| **Storage Gateway** | Hybrid access (not migration) | Ongoing on-prem access to cloud storage | Local network speed |
| **Snowball Edge** | Offline device | > 10 TB, slow/expensive network | Days (physical) |
| **Snowmobile** | Offline truck | > 10 PB | Weeks (physical) |
| **DMS** | Database (not files) | Database migration with CDC | Ongoing replication |
| **MGN** | Server-level | Lift-and-shift entire servers | Block-level replication |

> ?? **Related Qs**: #27, #40, #50, #84, #107, #130, #158, #236

---

## 10. ?? Analytics

> **Note**: Redshift is covered in [Section 4 �� Database](#4-%EF%B8%8F-database) under "Other Databases." OpenSearch is also covered there. Cross-reference for full details.

### Athena

- **Overview**: Serverless interactive query service �� run standard SQL directly on S3 data. No infrastructure to manage. Pay only for data scanned ($5/TB). Based on Presto.
- **?? Azure Equivalent**: Azure Synapse Serverless SQL Pool
- **?? Azure Bridge**: Like Synapse Serverless SQL �� query data where it lives (S3/Data Lake) without loading into a database. Use `CREATE EXTERNAL TABLE` to define schema on read.
- **Key Exam Facts** (from missed question):
  - **S3 as Data Source**: Query CSV, JSON, Parquet, ORC, Avro directly in S3. No ETL needed for ad-hoc queries. *(Q#64, Q#115)*
  - **Cost Optimization**: Use columnar formats (Parquet/ORC) + partitioning + compression to reduce data scanned. *(Q#64)*
  - **Athena + QuickSight**: Athena as data source for QuickSight dashboards. Cost and usage reports (CUR) �� Athena �� QuickSight for cost visualization. *(Q#64)*
  - **vs Glue**: Athena = query (ad-hoc, interactive); Glue = ETL (scheduled, transform). Can use together: Glue transforms data �� Athena queries it. *(Q#115)*
- **?? Q Refs**: #64, #98, #115
<!-- UPDATE_MARKER: Athena -->

### EMR (Elastic MapReduce)

- **Overview**: Managed Hadoop/Spark cluster. Process vast amounts of data across dynamically scalable EC2 instances. Supports Hive, Pig, HBase, Presto, Flink.
- **?? Azure Equivalent**: Azure HDInsight / Azure Databricks
- **Key Exam Facts** (from missed question):
  - **EMRFS**: EMR File System �� directly reads from S3 instead of HDFS. Allows cluster to be ephemeral (data persists in S3 after cluster termination). Use with Spot Instances for task nodes + On-Demand/Reserved for core nodes for maximum cost savings on transient clusters. *(Q#205)*
  - **Spot Instances**: Use Spot for task nodes to reduce cost. Core nodes should be On-Demand/Reserved. *(Q#205)*
  - **Transient Clusters**: Spin up cluster, process data, terminate �� data stays in S3 via EMRFS. Huge cost savings. *(Q#205)*
- **?? Q Refs**: #115, #205
<!-- UPDATE_MARKER: EMR -->

### Glue

- **Overview**: Serverless ETL service �� automatically discovers, catalogs, and transforms data. Crawlers scan S3 and populate the Glue Data Catalog (metadata repository). Jobs run on Apache Spark.
- **?? Azure Equivalent**: Azure Data Factory
- **?? Azure Bridge**: Glue = Azure Data Factory (ETL orchestration) + Azure Purview (data catalog). Glue Crawlers = ADF schema inference. Glue Data Catalog = Purview data map. Jobs can be Python or Spark.
- **Key Exam Facts** (from missed question):
  - **Data Catalog**: Central metadata repository �� tables, schemas, partitions. Used by Athena, EMR, Redshift Spectrum. *(Q#115)*
  - **Transformations**: Built-in transforms for common ETL tasks (drop fields, filter, join, map, resolve choice). Custom transforms in Python/Spark. *(Q#115)*
  - **Sensitive Data**: Glue can detect and mask PII/PHI using built-in ML transforms (`FindMatches`, `DetectPII`). *(Q#115)*
  - **Serverless**: No infrastructure �� pay per DPU-hour (Data Processing Unit). Auto-scales.
- **?? Q Refs**: #115
<!-- UPDATE_MARKER: Glue -->

### QuickSight

- **Overview**: Serverless BI dashboards and visualizations. ML-powered insights (auto-narratives, anomaly detection). SPICE engine for fast in-memory queries. Pay-per-session pricing.
- **?? Azure Equivalent**: Power BI
- **?? Azure Bridge**: Like Power BI but AWS-native. SPICE (Super-fast, Parallel, In-memory Calculation Engine) = Power BI's VertiPaq. QuickSight Q (NLQ) = Power BI Q&A.
- **Key Exam Facts** (from missed question):
  - **SPICE**: In-memory engine that accelerates queries �� import data into SPICE for faster analysis (vs. direct query). *(Q#26, Q#64)*
  - **CUR + QuickSight**: Connect Cost and Usage Reports �� Athena �� QuickSight for cost dashboards. *(Q#26, Q#64)*
  - **Row-Level Security**: Restrict data access per user/group within the same dashboard.
- **?? Q Refs**: #26, #64, #83
<!-- UPDATE_MARKER: QuickSight -->

### Kinesis

- **Overview**: Real-time streaming data platform. Three services: **Data Streams** (ingest and process streaming data), **Data Firehose** (deliver streams to S3/Redshift/OpenSearch/Splunk), **Data Analytics** (SQL/Flink on streams), **Video Streams** (securely stream video).
- **?? Azure Equivalent**: Azure Event Hubs (Data Streams) + Stream Analytics (Data Analytics)
- **Key Exam Facts** (from missed question):
  - **Data Streams vs SQS**: Kinesis = real-time streaming with replay (up to 365 days retention, shard-based ordering); SQS = message queue (14 days max, no replay by default). Use Kinesis for real-time analytics, SQS for decoupling. *(Q#123)*
  - **Shards**: Throughput = number of shards �� 1 MB/sec input, 2 MB/sec output per shard. Reshard (split/merge) to scale.
  - **Kinesis Video Streams**: For video from IoT devices, cameras. Integrates with SageMaker for ML on video frames. *(Q#123)*
- **?? Q Refs**: #123
<!-- UPDATE_MARKER: Kinesis -->

---

## 11. ?? Machine Learning

### SageMaker

- **Overview**: Fully managed ML platform �� build, train, and deploy models at scale. Includes SageMaker Studio (IDE), Ground Truth (data labeling), training jobs (managed infrastructure), hosting (real-time endpoints), and SageMaker Neo (edge optimization).
- **?? Azure Equivalent**: Azure Machine Learning
- **?? Azure Bridge**: Nearly identical to Azure ML. Both provide managed notebooks, automated ML, training pipelines, model registry, and managed endpoints. SageMaker Studio = Azure ML Studio.
- **Key Exam Facts** (from missed question):
  - **SageMaker + IoT**: Can deploy trained models to IoT Greengrass devices for edge inference. *(Q#123)*
  - **SageMaker + Kinesis Video Streams**: Process video streams for ML inference �� object detection, activity recognition. *(Q#123)*
  - **Offline Inference**: Use Snowball Edge for ML inference in disconnected environments (factory floors, ships, mines). *(Q#123)*
  - **Training**: Managed training jobs �� choose instance type (GPU/CPU), distributed training, Spot instances for cost savings. Hyperparameter tuning via automatic model tuning.
- **?? Q Refs**: #123
<!-- UPDATE_MARKER: SageMaker -->

### IoT Greengrass

- **Overview**: Edge runtime for IoT devices �� runs Lambda functions, Docker containers, and ML models locally on devices. Enables local processing, messaging, and actions even without cloud connectivity.
- **?? Azure Equivalent**: Azure IoT Edge
- **Key Exam Facts** (from missed question):
  - **Offline Operation**: Devices continue to operate when disconnected from cloud �� local actions, local ML inference. Syncs when reconnected. *(Q#123)*
  - **ML at Edge**: Deploy SageMaker-trained models to Greengrass devices. Run inference without cloud round-trip. *(Q#123)*
  - **Connectors**: Pre-built modules for common IoT patterns (e.g., Kinesis Firehose, Twilio, ServiceNow).
- **?? Q Refs**: #123
<!-- UPDATE_MARKER: IoTGreengrass -->

### Monitron

- **Overview**: End-to-end ML-powered predictive maintenance system. Includes sensors (vibration + temperature), gateway, and cloud service. Detects abnormal equipment patterns without building custom ML models.
- **?? Azure Equivalent**: Azure IoT + custom ML on Azure ML (no exact equivalent)
- **Key Exam Facts** (from missed question):
  - **Purpose-Built**: Monitron is specifically for predictive maintenance �� not general ML. Ships with pre-trained models for rotating equipment (motors, pumps, fans). *(Q#123)*
  - **No ML Expertise Required**: Monitron is a turnkey solution �� install sensors, connect gateway, receive alerts. vs SageMaker which requires ML knowledge.
- **?? Q Refs**: #123
<!-- UPDATE_MARKER: Monitron -->

---

## 12. ??? Developer Tools (Your Expertise Zone!)

### CodeDeploy

- **Overview**: Automates code deployments to EC2, Lambda, ECS. Blue/green, rolling, canary strategies. Hooks for validation tests.
- **?? Azure Equivalent**: Azure DevOps Release Pipelines �� "Deploy to App Service/VM" tasks
- **?? Azure Bridge**: **This maps directly to your Azure DevOps release pipelines!** CodeDeploy's deployment groups = your Azure release stages/environments. Blue/green deployment in CodeDeploy = swapping deployment slots in Azure App Service. The `appspec.yml` file defines lifecycle hooks �� similar to your pipeline YAML steps.
- **Key Exam Facts** (from missed question):
  - **Canary Deployments**: CodeDeploy can shift traffic incrementally (e.g., 10% �� 100%) with automatic rollback on alarm. *(Q#48)*
  - **Blue/Green**: Replace entire fleet at once �� traffic shift via ELB target group swap. Fastest rollback. *(Q#69)*
  - **Deployment Hooks**: Hooks in appspec.yml run at lifecycle events (BeforeInstall, AfterInstall, ApplicationStart, ValidateService). *(Q#48, Q#208)*
- **?? Q Refs**: #14, #48, #69, #104, #208
<!-- UPDATE_MARKER: CodeDeploy -->

### CodePipeline

- **Overview**: CI/CD orchestration �� source �� build �� test �� deploy. Integrates with CodeCommit, GitHub, S3, CodeBuild, CodeDeploy, CloudFormation, and 3rd-party tools.
- **?? Azure Equivalent**: Azure Pipelines (YAML)
- **?? Azure Bridge**: **Your core expertise!** CodePipeline = Azure DevOps Pipelines. CodePipeline's stages/actions = your pipeline stages/jobs/tasks. Key differences: CodePipeline uses JSON/YAML for pipeline definition (less mature than Azure Pipelines YAML). CodePipeline doesn't have a visual designer as rich as Azure DevOps. Most enterprises use CodePipeline + GitHub Actions or Jenkins instead.
- **?? Q Refs**: #134, #208
<!-- UPDATE_MARKER: CodePipeline -->

### CodeBuild

- **Overview**: Managed build service �� compiles code, runs tests, produces artifacts. pay per minute.
- **?? Azure Equivalent**: Azure DevOps Build Pipelines / Azure Pipelines build tasks
- **Key Exam Facts** (from missed question):
  - **buildspec.yml**: Defines build commands, artifacts, cache settings. *(Q#134)*
- **?? Q Refs**: #134, #208
<!-- UPDATE_MARKER: CodeBuild -->

### CodeCommit

- **Overview**: Managed Git repository (like GitHub but AWS-native).
- **?? Azure Equivalent**: Azure Repos
- **?? Q Refs**: #134
<!-- UPDATE_MARKER: CodeCommit -->

---

## ?? Similar Service Comparison �� CI/CD (Your Expertise!)

### CodeDeploy ?? CodePipeline ?? CodeBuild ?? CodeCommit

| Service | Purpose | Azure Equivalent |
|---|---|---|
| **CodeCommit** | Git repository hosting | Azure Repos |
| **CodeBuild** | Compile, test, package | Azure Pipelines build tasks |
| **CodeDeploy** | Deploy to compute | Azure Pipelines release tasks |
| **CodePipeline** | Orchestrate the entire CI/CD flow | Azure Pipelines (end-to-end) |

**Exam signal**: "Orchestrate source��build��deploy" �� CodePipeline. "Deploy to EC2 with canary" �� CodeDeploy. "Compile and package" �� CodeBuild." Store code" �� CodeCommit.

> ?? **From your Azure DevOps background**: CodePipeline + CodeBuild + CodeDeploy together = one Azure DevOps Pipeline (YAML). In practice, many AWS shops also use GitHub Actions or Jenkins �� the exam tests Code* services specifically.

> ?? **Related Qs**: #14, #48, #69, #134, #208

---

## 13. ??? End User Computing & Hybrid

### WorkSpaces

- **Overview**: Managed virtual desktop infrastructure (VDI) �� Windows or Linux desktops in the cloud. Persistent (root + user volumes). Integrates with AD, FSx, and multi-factor authentication.
- **?? Azure Equivalent**: Azure Virtual Desktop (AVD)
- **?? Azure Bridge**: WorkSpaces = AVD. Both are cloud-hosted VDI. Key differences: WorkSpaces uses dedicated EBS volumes per user (persistent); AVD can use FSLogix profile containers on Azure Files. WorkSpaces integrates natively with FSx for Windows for shared user profiles.
- **Key Exam Facts** (from missed question):
  - **FSx for User Profiles**: Store FSLogix profile containers on FSx for Windows �� enables fast login and profile roaming. *(Q#112, Q#153)*
  - **Scaling**: WorkSpaces does NOT auto-scale �� capacity planning needed. Use CloudWatch + EventBridge + Lambda for automated provisioning/deprovisioning. *(Q#112)*
  - **Storage**: Root volume (OS, apps �� 80 GB default) and User volume (user data �� 10-100 GB). Snapshots every 12 hours, retained for 7 days.
  - **AD Integration**: Must join to a directory �� Managed AD, AD Connector (on-prem), or Simple AD. *(Q#153)*
- **?? Q Refs**: #112, #153
<!-- UPDATE_MARKER: WorkSpaces -->

### AppStream 2.0

- **Overview**: Application streaming �� stream Windows applications to any device via browser. Apps run on AWS, rendered in user's browser. Non-persistent (stateless by default). Use for SaaS delivery, training environments, secure access to internal apps.
- **?? Azure Equivalent**: Azure Virtual Desktop RemoteApp
- **Key Exam Facts** (from missed question):
  - **Migration**: Rehost legacy Windows applications without rewriting �� stream them via AppStream while gradually modernizing backend. Ideal for legacy .NET/WPF applications that cannot be easily containerized. *(Q#219)*
  - **vs WorkSpaces**: AppStream streams individual apps; WorkSpaces streams full desktops. AppStream is non-persistent by default; WorkSpaces is persistent. AppStream is charged per hour (running only); WorkSpaces is charged monthly. *(Q#219)*
  - **Fleets**: Always-On (instant connection, billed running) or On-Demand (wait for provisioning, billed per use).
  - **AD Integration**: Can join to Active Directory for user authentication and app access control.
- **?? Q Refs**: #219
<!-- UPDATE_MARKER: AppStream -->

### Outposts

- **Overview**: AWS-managed infrastructure running on-premises �� same APIs, tools, and services as AWS Regions. AWS delivers, installs, and maintains the rack in your data center. Supports EC2, EBS, ECS, EKS, RDS, S3 (Outposts bucket).
- **?? Azure Equivalent**: Azure Stack HCI / Azure Arc
- **Key Exam Facts** (from missed question):
  - **Consistent Experience**: Same AWS APIs, CLI, console �� developers don't need to learn different tools for on-prem vs cloud. Build once, deploy to Region, Outposts, or Snowball Edge. *(Q#149)*
  - **Data Residency**: Keep data on-premises for regulatory requirements while using AWS services. *(Q#149)*
  - **Low Latency**: Sub-millisecond latency for factory floor, healthcare imaging, financial trading. *(Q#149)*
  - **vs Snowball Edge**: Outposts = permanent on-prem installation (42U rack); Snowball Edge = portable, temporary, smaller capacity. Outposts supports more services (RDS, ECS). *(Q#149)*
- **?? Q Refs**: #149
<!-- UPDATE_MARKER: Outposts -->

### Snowball Edge (Compute)

- **Overview**: Portable edge compute + storage device. Runs EC2 instances and Lambda functions in disconnected/remote environments. 80 TB usable storage. Two variants: Compute Optimized (more CPU/RAM) and Storage Optimized (more storage).
- **?? Azure Equivalent**: Azure Stack Edge
- **Key Exam Facts** (from missed question):
  - **Disconnected Operation**: Runs independently without internet �� processes data locally, then ship device back to AWS for data ingestion. *(Q#123, Q#149)*
  - **vs Outposts**: Snowball Edge is portable, smaller, for temporary/remote use; Outposts is permanent rack-mounted installation for steady-state hybrid workloads. *(Q#149)*
  - **ML at Edge**: Can run SageMaker Neo-compiled models for local inference. Combined with IoT Greengrass for edge ML pipelines. *(Q#123)*
- **?? Q Refs**: #107, #123, #149, #158
<!-- UPDATE_MARKER: SnowballEdgeCompute -->

---

## 14. ?? Appendix: Complete Tag-to-Service Normalization

This table maps all tag variants found in your Wrong Answer Collection to canonical service names. Use this as a reference when adding new missed question.

<details>
<summary>Click to expand full normalization table</summary>

| Tag Variants in missed question | Canonical Service |
|---|---|
| `#EC2`, `#AWS-EC2`, `#Amazon-EC2`, `#AmazonEC2`, `#EC2_Auto_Scaling` | EC2 |
| `#Lambda`, `#AWS_Lambda`, `#AWS-Lambda`, `#AWSLambda` | Lambda |
| `#S3`, `#Amazon_S3`, `#Amazon-S3`, `#AWS_S3`, `#AWS-S3`, `#AmazonS3` | S3 |
| `#RDS`, `#AmazonRDS`, `#Amazon-RDS`, `#AWS/Database/RDS` | RDS |
| `#Aurora`, `#Amazon_Aurora`, `#Amazon-Aurora`, `#AmazonAurora`, `#Aurora_PostgreSQL`, `#Aurora-MySQL` | Aurora |
| `#DynamoDB`, `#Amazon-DynamoDB`, `#DynamoDB-Global-Tables` | DynamoDB |
| `#ECR`, `#AWS_ECR`, `#AWS-ECR`, `#Amazon-ECR` | ECR |
| `#ECS`, `#AWS-ECS`, `#Amazon-ECS`, `#AWS-ECS-Fargate` | ECS |
| `#EKS`, `#AWS-EKS`, `#Amazon-EKS` | EKS |
| `#Fargate`, `#AWS-Fargate` | Fargate |
| `#VPC`, `#Amazon_VPC`, `#VPCEndpoint`, `#VPC_Endpoint`, `#VPC-Endpoint` | VPC |
| `#Route53`, `#Route_53`, `#Amazon_Route_53`, `#AWS-Route53` | Route 53 |
| `#CloudFront`, `#CloudFront_Origin_Group` | CloudFront |
| `#ALB`, `#Application_Load_Balancer`, `#AWS-ALB`, `#ApplicationLoadBalancer` | ALB |
| `#NLB`, `#Network_Load_Balancer_NLB`, `#AWS-NLB` | NLB |
| `#API_Gateway`, `#AWS_API_Gateway`, `#AWS-API-Gateway`, `#APIGateway` | API Gateway |
| `#DirectConnect`, `#aws-direct-connect`, `#DirectConnectGateway` | Direct Connect |
| `#TransitGateway`, `#Transit_Gateway`, `#transit-gateway`, `#AWSTransitGateway` | Transit Gateway |
| `#WAF`, `#AWS_WAF`, `#AWS-WAF`, `#AWSWAF` | WAF |
| `#IAM`, `#AWS/IAM`, `#IAM-Identity-Center` | IAM |
| `#KMS`, `#AWS/KMS`, `#AWSKMS` | KMS |
| `#Organizations`, `#AWS_Organizations`, `#AWS-Organizations`, `#AWSOrganizations` | Organizations |
| `#SCP`, `#Service_Control_Policies__SCP`, `#Service_Control_Policy_SCP` | SCP |
| `#CloudFormation`, `#AWS_CloudFormation`, `#AWSCloudFormation` | CloudFormation |
| `#CodeDeploy`, `#AWS_CodeDeploy`, `#AWSCodeDeploy` | CodeDeploy |
| `#DMS`, `#AWS_DMS`, `#AWS-DMS`, `#DatabaseMigrationService` | DMS |
| `#DataSync`, `#AWS-DataSync` | DataSync |
| `#Snowball`, `#AWS-Snowball`, `#SnowballEdge`, `#Snowball-Edge` | Snow Family |
| `#EventBridge`, `#Amazon_EventBridge`, `#Amazon-EventBridge`, `#AmazonEventBridge` | EventBridge |
| `#SQS`, `#AmazonSQS`, `#Amazon-SQS` | SQS |
| `#SNS`, `#AmazonSNS`, `#Amazon-SNS`, `#AmazonSNS` | SNS |
| `#SystemsManager`, `#AWS_Systems_Manager`, `#AWSSystemsManager` | Systems Manager |
| `#FSx`, `#FSx-for-Windows`, `#FSx-for-Lustre`, `#FSxForLustre` | FSx |
| `#TransferFamily`, `#AWS_Transfer_Family`, `#AWS-Transfer-Family` | Transfer Family |
| `#StorageGateway`, `#Storage_Gateway`, `#FileGateway` | Storage Gateway |
| `#ElasticBeanstalk`, `#Elastic_Beanstalk` | Elastic Beanstalk |
| `#Backup`, `#AWSBackup`, `#AWS-Backup` | AWS Backup |
| `#Config`, `#AWS_Config`, `#AWS-Config` | AWS Config |
| `#SecretsManager`, `#Secrets-Manager`, `#AWSSecretsManager` | Secrets Manager |
| `#ACM`, `#AWS_Certificate_Manager` | Certificate Manager |
| `#GlobalAccelerator`, `#AWS-Global-Accelerator`, `#AWSGlobalAccelerator` | Global Accelerator |
| `#PrivateLink`, `#AWS_PrivateLink`, `#AWS-PrivateLink`, `#AWSPrivateLink` | PrivateLink |
| `#StepFunctions`, `#Step-Functions`, `#AWSStepFunctions` | Step Functions |
| `#Athena`, `#AmazonAthena`, `#Amazon-Athena` | Athena |
| `#EMR`, `#Amazon-EMR` | EMR |
| `#Glue`, `#AWS-Glue` | Glue |
| `#QuickSight`, `#Amazon_QuickSight`, `#AmazonQuickSight` | QuickSight |
| `#Redshift`, `#AmazonRedshift` | Redshift |
| `#SageMaker`, `#AWS-SageMaker` | SageMaker |
| `#WorkSpaces`, `#Amazon-Workspaces` | WorkSpaces |
| `#AppStream` | AppStream |
| `#Outposts`, `#AWSOutposts` | Outposts |
| `#Cognito` | Cognito |
| `#Amplify` | Amplify |
| `#AppSync` | AppSync |
| `#DocumentDB`, `#Amazon-DocumentDB` | DocumentDB |
| `#Babelfish` | Aurora Babelfish |
| `#EgressOnlyIGW`, `#IPv6` | VPC (Egress-Only Internet Gateway) |
| `#S3RTC`, `#ReplicationTimeControl` | S3 (Replication Time Control) |
| `#OriginGroup` | CloudFront (Origin Group) |
| `#WeightedTargetGroups` | ALB (Weighted Target Groups) |
| `#DRS`, `#ElasticDisasterRecovery` | Elastic Disaster Recovery |
| `#SAPC02` | Generic SAP-C02 tag variant |

</details>

---

## ?? Study Progress Tracker

| Domain | Services Covered | Q Count | Confidence (Self-Rate) |
|---|---|---|---|
| ?? Cross-Cutting | HA, DR, Cost, Security, Decoupling, Serverless, Governance, Deployments | ~44 | /10 |
| ?? Compute | EC2, Lambda, EB, Batch | ~48 | /10 |
| ?? Containers | ECS, EKS, ECR, Fargate | ~14 | /10 |
| ?? Storage | S3, EBS, EFS, FSx, Storage Gateway, Transfer Family | ~38 | /10 |
| ??? Database | RDS, Aurora, DynamoDB, ElastiCache, DocumentDB, Redshift, DMS | ~45 | /10 |
| ?? Networking | VPC, Route 53, API Gateway, CloudFront, Direct Connect, Transit Gateway, ALB/NLB, Global Accelerator | ~60 | /10 |
| ?? Security | IAM, Organizations/SCP, KMS, Secrets Manager, WAF/Shield, CloudTrail, Config | ~40 | /10 |
| ?? Integration | SQS, SNS, EventBridge, Step Functions, AppSync | ~22 | /10 |
| ?? Management | CloudFormation, Systems Manager, CloudWatch, Service Catalog, AWS Backup, Cost Management | ~32 | /10 |
| ?? Migration | DMS, DataSync, Snow Family, MGN, Migration Hub, Transfer Family | ~24 | /10 |
| ?? Analytics | Athena, EMR, Glue, QuickSight, Redshift, OpenSearch | ~12 | /10 |
| ?? ML | SageMaker, IoT Greengrass | ~3 | /10 |
| ??? Developer Tools | CodeDeploy, CodePipeline, CodeBuild, CodeCommit | ~8 | /10 |
| ??? EUC | WorkSpaces, AppStream, Outposts, Directory Service | ~7 | /10 |

> **Total missed question files**: 266 | **Canonical services covered**: ~100+ | **Last updated**: 2026-06-16

---

## ?? Next Steps

1. **Fill in Confidence scores** above (self-rate /10) �� this tells you where to focus
2. **Do more practice questions** on your weak domains
3. **Append new missed question** to the relevant service sections using the instructions at the top
4. **Revisit the Similar Service Comparison sections** before the exam �� these are the most common traps
5. **Use the AWS SAP-C02 Tutor agent** to analyze new questions following the same format
