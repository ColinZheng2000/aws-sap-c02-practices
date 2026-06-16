---
chapter: "0. Cross-Cutting Concepts"
totalQuestions: 20
tiers:
  knowledge: 5
  scenario: 10
  comparison: 5
basedOn: "AWS-SAP-C02-Learning-Material.md â€?Cross-Cutting Concepts"
concepts:
  - High Availability
  - Disaster Recovery
  - Cost Optimization
  - Security
  - Decoupling
  - Serverless
  - Multi-Account Governance
  - Deployment Strategies
---

# Chapter 0 Practice: ğŸŒ Cross-Cutting Concepts

> **Instructions**: Complete Part A first. Do not scroll past the divider. Once finished, check Part B for answers.
> **Textbook**: `AWS-SAP-C02-Learning-Material.md` â€?Cross-Cutting Concepts (HA, DR, Cost Optimization, Security, Decoupling, Serverless, Multi-Account Governance, Deployment Strategies)

---

# Part A â€?Questions

## ğŸŸ¢ Knowledge Check (5 questions)

### Q0.1

> ğŸŸ¢ L1-çŸ¥è¯† | ğŸ¤ğŸ¤ ä¸­é¢‘é¢è¯•
What is the difference between Recovery Point Objective (RPO) and Recovery Time Objective (RTO)?

- A. RPO is the maximum acceptable data loss measured in time; RTO is the maximum acceptable time to restore service
- B. RPO is the maximum time to restore service; RTO is the maximum acceptable data loss
- C. RPO measures compute recovery; RTO measures storage recovery
- D. RPO and RTO are the same metric with different names

### Q0.2

> ğŸŸ¡ L2-ç†è§£ | ğŸ¤ğŸ¤ ä¸­é¢‘é¢è¯•
Which deployment strategy creates a completely new environment alongside the existing one and provides the fastest rollback by keeping the old environment running?

- A. Rolling deployment
- B. Canary deployment
- C. Blue/Green deployment
- D. All-at-Once deployment

### Q0.3

> ğŸŸ¡ L2-ç†è§£ | ğŸ¤ğŸ¤ ä¸­é¢‘é¢è¯•
What is the core principle of decoupling in cloud architecture?

- A. Running all components on the same server for maximum performance
- B. Reducing dependencies between components so they can operate, scale, and fail independently
- C. Using a single database for all microservices
- D. Deploying all services in a single Availability Zone

### Q0.4

> ğŸŸ¢ L1-çŸ¥è¯† | ğŸ¤ ä½é¢‘
Which of the following correctly describes the IAM policy evaluation logic when multiple policies apply to a single request?

- A. The most permissive policy wins
- B. Explicit DENY overrides explicit ALLOW, and explicit ALLOW overrides implicit DENY
- C. All policies are evaluated and the first match determines the outcome
- D. Explicit ALLOW overrides explicit DENY

### Q0.5

> ğŸŸ¢ L1-çŸ¥è¯† | ğŸ¤ğŸ¤ ä¸­é¢‘é¢è¯•
What is the primary purpose of an SCP (Service Control Policy) in AWS Organizations?

- A. To grant permissions to IAM users and roles across all accounts
- B. To set the maximum available permissions for every IAM entity in the accounts it applies to
- C. To monitor resource configuration compliance across accounts
- D. To define which services are available in a specific AWS Region

---

## ğŸŸ¡ Scenario Analysis (7 questions)

### Q0.6

> ğŸŸ¡ L2-ç†è§£ | ğŸ¤ğŸ¤ ä¸­é¢‘é¢è¯•
A company's web application runs on EC2 instances in a single AZ behind an ALB. The database is RDS Multi-AZ. During an AZ failure affecting the EC2 instances, users experienced 10 minutes of downtime while Auto Scaling launched new instances in a different AZ and the ALB shifted traffic.

What change would have minimized the downtime to near-zero?

- A. Add RDS Read Replicas in a different AZ
- B. Deploy EC2 instances across multiple AZs with the ALB distributing across them
- C. Switch from ALB to NLB for faster failover
- D. Increase EC2 instance size for faster launch times

### Q0.7

> ğŸ”´ L3-åº”ç”¨ | ğŸ¤ğŸ¤ğŸ¤ é«˜é¢‘é¢è¯•
A company's DR plan requires that the production database be replicated to a DR Region with less than 1 second of data loss (RPO â‰?1 second) and recovery completed within 5 minutes (RTO < 5 minutes). The database must be able to serve read traffic in the DR Region during normal operations.

Which database feature meets these requirements?

- A. RDS Multi-AZ
- B. RDS Cross-Region Read Replica
- C. Aurora Global Database
- D. DynamoDB with DAX

### Q0.8

> ğŸŸ¡ L2-ç†è§£ | ğŸ¤ğŸ¤ ä¸­é¢‘é¢è¯•
A solutions architect is designing a multi-account strategy for a company with 30 AWS accounts. The security team wants to prevent any account from creating resources outside approved Regions. What is the most efficient way to enforce this across all accounts?

- A. Configure IAM policies in each account to deny resource creation in unapproved Regions
- B. Attach an SCP to the root OU denying resource creation in unapproved Regions
- C. Use AWS Config rules in each account to detect and alert on non-compliant resources
- D. Create a CloudFormation template per account with Region restrictions

### Q0.9

> ğŸŸ¡ L2-ç†è§£ | ğŸ¤ğŸ¤ ä¸­é¢‘é¢è¯•
A video processing startup has highly variable workloads â€?sometimes zero processing for hours, then thousands of 2-minute processing jobs submitted simultaneously. The startup has no dedicated operations team. Jobs can occasionally fail and be retried without business impact.

Which combination of cost optimization and compute strategies is optimal?

- A. Reserved EC2 instances provisioned for average load
- B. Spot EC2 instances with SQS for job queuing and Auto Scaling
- C. On-Demand EC2 instances with scheduled Auto Scaling
- D. Savings Plans with a mix of On-Demand and Spot

### Q0.10

> ğŸŸ¡ L2-ç†è§£ | ğŸ¤ğŸ¤ ä¸­é¢‘é¢è¯•
A company's monolithic application experiences cascading failures: a slowdown in the payment processing module causes the order placement module to also slow down, which then impacts the inventory module. The application uses synchronous HTTP calls between modules.

Which architectural pattern would prevent this cascading failure?

- A. Vertical scaling â€?increase the instance size for all modules
- B. Decoupling â€?introduce SQS between modules so each can process at its own pace
- C. Multi-AZ deployment â€?deploy each module across multiple AZs
- D. Auto Scaling â€?set aggressive scale-out policies for all modules

### Q0.11

> ğŸŸ¡ L2-ç†è§£ | ğŸ¤ğŸ¤ ä¸­é¢‘é¢è¯•
A company is deploying a new internal application. The application must run 24/7 with steady, predictable traffic. The security team requires installation of a host-level monitoring agent that accesses kernel-level metrics. The network team needs to apply custom TCP tuning parameters.

Which compute architecture should be chosen?

- A. AWS Lambda functions orchestrated by Step Functions
- B. Amazon ECS on Fargate with Service Auto Scaling
- C. Amazon EC2 instances with Auto Scaling
- D. AWS Elastic Beanstalk with immutable deployments

### Q0.12

> ğŸŸ¡ L2-ç†è§£ | ğŸ¤ğŸ¤ ä¸­é¢‘é¢è¯•
A company wants to use a canary deployment strategy for a critical production API. The canary deployment should send 10% of production traffic to the new version, automatically monitor error rates for 15 minutes, and roll back immediately if the error rate exceeds 1%.

Which AWS service provides native support for this deployment pattern?

- A. AWS Elastic Beanstalk with Rolling deployments
- B. AWS CodeDeploy with canary traffic shifting and CloudWatch alarm integration
- C. Amazon API Gateway with canary release deployments
- D. AWS CloudFormation with rolling update policies

---

## ğŸ”´ Similar Service Comparison (4 questions)

### Q0.13

> ğŸ”´ L3-åº”ç”¨ | ğŸ¤ğŸ¤ğŸ¤ é«˜é¢‘é¢è¯•
Compare Pilot Light, Warm Standby, and Multi-Site Active/Active DR strategies. A company has an RPO of < 1 second and RTO of < 1 minute. The DR Region must handle production traffic during normal operations. Which strategy must be used?

- A. Pilot Light â€?core infrastructure running, minimal services
- B. Warm Standby â€?scaled-down but functional environment ready to scale up
- C. Multi-Site Active/Active â€?fully running in both Regions simultaneously
- D. Backup and Restore â€?periodic snapshots copied to DR Region

### Q0.14

> ğŸŸ¡ L2-ç†è§£ | ğŸ¤ğŸ¤ ä¸­é¢‘é¢è¯•
A solutions architect must choose between a serverless and server-based architecture. The application needs to run continuously 24/7 with steady, predictable traffic. It requires custom OS-level monitoring agents and kernel tuning. Which architecture should be chosen and why?

- A. Serverless (Lambda + API Gateway + DynamoDB) â€?lower operational overhead
- B. Server-based (EC2 + ALB + RDS) â€?serverless cannot meet kernel and OS-level requirements
- C. Hybrid â€?Lambda for compute, EC2 for monitoring agents only
- D. Serverless (Fargate + Aurora Serverless) â€?managed services meet all requirements

### Q0.15

> ğŸŸ¡ L2-ç†è§£ | ğŸ¤ğŸ¤ ä¸­é¢‘é¢è¯•
A company must choose between Active-Passive and Active-Active high availability for a critical application. The application is stateful and requires session persistence. The company needs automated failover with minimal data loss.

Which HA model and AWS service combination is appropriate?

- A. Active-Active with DynamoDB Global Tables â€?both Regions serve traffic simultaneously
- B. Active-Passive with RDS Multi-AZ â€?synchronous replication with automatic failover within a Region
- C. Active-Active with EC2 Auto Scaling across multiple AZs behind an ALB
- D. Active-Passive with Route 53 Failover routing between two Regions

### Q0.16

> ğŸŸ¡ L2-ç†è§£ | ğŸ¤ğŸ¤ ä¸­é¢‘é¢è¯•
A company needs to choose between two cost-saving strategies for EC2 workloads:
- Strategy X: Commit to a specific instance family in a specific AZ for 3 years; saves up to 72%
- Strategy Y: Commit to $/hour spend for 1 year; applies to any instance family, any Region, plus Lambda and Fargate; saves up to 66%

Which AWS purchase options do Strategy X and Strategy Y describe respectively?

- A. X=Spot Instances, Y=Compute Savings Plans
- B. X=Standard Reserved Instances, Y=Compute Savings Plans
- C. X=Convertible Reserved Instances, Y=EC2 Instance Savings Plans
- D. X=Standard Reserved Instances, Y=On-Demand Capacity Reservations

### Q0.17

> ğŸ”´ L3-åº”ç”¨ | ğŸ¤ğŸ¤ğŸ¤ é«˜é¢‘é¢è¯•
A company runs a containerized application on ECS with API Gateway, backed by Aurora and DynamoDB. The DR requirements are RPO of 2 hours and RTO of 4 hours. The solution must be the MOST cost-effective.

Which DR solution should be used?

- A. Aurora Global Database + DynamoDB Global Tables + CloudFront origin failover
- B. AWS DMS + Lambda for Aurora replication + DynamoDB Streams + Lambda for DynamoDB replication
- C. AWS Backup with cross-Region copy for both Aurora and DynamoDB + Route 53 failover
- D. Aurora Global Database + DynamoDB Global Tables + Route 53 failover

### Q0.18

> ğŸŸ¡ L2-ç†è§£ | ğŸ¤ğŸ¤ ä¸­é¢‘é¢è¯•
A company runs a web application on EC2 instances behind an ALB with AWS WAF enabled. An external customer needs static IP addresses to whitelist for accessing the application. The company must keep WAF protection and minimize operational overhead.

Which solution meets these requirements?

- A. Replace the ALB with an NLB and assign Elastic IP addresses to the NLB
- B. Assign an Elastic IP address directly to the ALB
- C. Create an AWS Global Accelerator with the ALB as endpoint and provide the accelerator's static IPs to the customer
- D. Configure CloudFront in front of the ALB and provide the distribution's IP addresses

### Q0.19

> ğŸŸ¡ L2-ç†è§£ | ğŸ¤ğŸ¤ ä¸­é¢‘é¢è¯•
A company runs EC2 instances (continuous stable load), Lambda functions (varied unpredictable load), and a MemoryDB for Redis cluster. Which combination of purchase options minimizes overall monthly costs?

- A. EC2 Instance Savings Plan for EC2 + Compute Savings Plan for Lambda + Reserved Nodes for MemoryDB
- B. Single Compute Savings Plan to cover all three (EC2, Lambda, MemoryDB)
- C. Compute Savings Plan for EC2 + Lambda Reserved Concurrency + Reserved Nodes for MemoryDB
- D. EC2 Instance Savings Plan for EC2 and MemoryDB + Lambda Reserved Concurrency

### Q0.20

> ğŸŸ¡ L2-ç†è§£ | ğŸ¤ğŸ¤ ä¸­é¢‘é¢è¯•
A company migrated a legacy application to AWS running on EC2 instances in private subnets across 3 AZs behind an ALB. The application needs outbound access to on-premises systems, but the on-premises firewall only allows a single IP address. The solution must automatically mitigate NAT Gateway failures.

Which architecture meets these requirements?

- A. Deploy three NAT Gateways (one per AZ) sharing a single Elastic IP
- B. Replace the ALB with an NLB and assign the Elastic IP to the NLB for outbound traffic
- C. Deploy a single NAT Gateway with Elastic IP + CloudWatch alarm + Lambda to recreate NAT GW in another AZ and reassign the EIP on failure
- D. Assign the Elastic IP to the ALB and use Route 53 to manage failover

---

# Part B â€?Answers & Explanations

> âš ï¸ **STOP HERE.** Complete all questions in Part A before reading below.

---

## ğŸŸ¢ Knowledge Check â€?Answers

### A0.1
**Correct: A** â€?RPO = maximum acceptable data loss (time); RTO = maximum acceptable time to restore service.

**Why**: RPO answers "how much data can we afford to lose?" measured in time (e.g., 1 hour of data loss = RPO of 1 hour). RTO answers "how fast must we recover?" measured in time (e.g., recover within 4 hours = RTO of 4 hours). Lower RPO/RTO = more expensive DR solution.

**Why not the others**:
- **B**: Reversed â€?RPO is data loss, RTO is downtime.
- **C**: Both measure time, not compute vs storage.
- **D**: They are distinct metrics measuring different aspects of recovery.

**ğŸ“– Textbook ref**: Cross-Cutting Concepts â€?Disaster Recovery, "RPO: max acceptable data loss; RTO: max acceptable time"

---

### A0.2
**Correct: C** â€?Blue/Green deployment.

**Why**: Blue/Green creates a completely new (green) environment alongside the existing (blue) one. After validation, traffic is switched via DNS or load balancer. If any issue occurs, switch traffic back to blue â€?instant rollback. Trade-off: requires double capacity during deployment.

**Why not the others**:
- **A**: Rolling updates batches progressively â€?rollback requires re-deploying the old version to each instance.
- **B**: Canary shifts a small % first, then ramps up â€?good for testing but not fastest rollback for the entire fleet.
- **D**: All-at-Once updates all instances simultaneously â€?fastest deployment but slowest rollback (all instances already updated).

**ğŸ“– Textbook ref**: Cross-Cutting Concepts â€?Deployment Strategies, "Blue/Green: Fastest rollback"; Â§1 â€?Elastic Beanstalk

---

### A0.3
**Correct: B** â€?Reducing dependencies between components so they can operate, scale, and fail independently.

**Why**: Decoupling means components interact through asynchronous, buffered channels (queues, events) rather than direct synchronous calls. This prevents cascading failures and allows each component to scale independently based on its own load and failure characteristics.

**Why not the others**:
- **A**: The opposite â€?co-location creates tight coupling.
- **C**: Shared database creates tight coupling at the data layer â€?anti-pattern for microservices.
- **D**: Single AZ is about availability, not coupling.

**ğŸ“– Textbook ref**: Cross-Cutting Concepts â€?Decoupling, "Reducing dependencies so components can operate, scale, and fail independently"

---

### A0.4
**Correct: B** â€?Explicit DENY overrides explicit ALLOW, and explicit ALLOW overrides implicit DENY.

**Why**: IAM evaluation starts with implicit DENY (no access by default). An explicit ALLOW in any policy overrides this. However, if ANY policy (IAM, SCP, permissions boundary, session policy) contains an explicit DENY, the request is denied â€?DENY always wins. This is the foundation of least-privilege security in AWS.

**Why not the others**:
- **A**: Explicit DENY always wins, not "most permissive."
- **C**: All policies are evaluated together; there is no "first match" logic.
- **D**: Reversed â€?DENY overrides ALLOW.

**ğŸ“– Textbook ref**: Cross-Cutting Concepts â€?Security, "IAM Evaluation Logic: Explicit DENY > Explicit ALLOW > Implicit DENY"

---

### A0.5
**Correct: B** â€?To set the maximum available permissions for every IAM entity in the accounts it applies to.

**Why**: SCPs are guardrails that define the maximum permissions ceiling. They don't grant permissions themselves â€?they only limit what can be granted through IAM policies. Even if an account administrator attaches AdministratorAccess to a user, an SCP can block specific actions. This is the preventive governance mechanism for multi-account organizations.

**Why not the others**:
- **A**: SCPs don't grant permissions â€?they only limit. IAM policies are needed to grant.
- **C**: AWS Config monitors compliance â€?SCPs enforce it preventively.
- **D**: SCPs can restrict services/Regions but their purpose is broader â€?maximum permission boundaries.

**ğŸ“– Textbook ref**: Cross-Cutting Concepts â€?Multi-Account Governance, "SCP: Maximum permission ceiling at OU/account level"

---

## ğŸŸ¡ Scenario Analysis â€?Answers

### A0.6
**Correct: B** â€?Deploy EC2 instances across multiple AZs with the ALB distributing across them.

**Why**: Single-AZ deployment is the root cause. When the single AZ fails, all instances are unavailable. ALB health checks detect failures in seconds and route traffic to healthy instances â€?but there are none. Auto Scaling then launches new instances in another AZ (minutes). With instances already running in multiple AZs, ALB immediately stops routing to the failed AZ â€?downtime â‰?health check detection time (seconds), not launch time (minutes).

**Why not the others**:
- **A**: Read Replicas help with read scaling, not instance-level HA.
- **C**: NLB also requires multi-AZ targets for HA â€?the issue is single-AZ, not the LB type.
- **D**: Larger instances launch the same speed â€?the problem is there are no running instances in other AZs during failure.

**ğŸ“– Textbook ref**: Cross-Cutting Concepts â€?High Availability, "Multi-AZ EC2 + ALB cross-zone balancing"

---

### A0.7
**Correct: C** â€?Aurora Global Database.

**Why**: Aurora Global Database provides cross-Region physical replication with < 1 second typical lag (RPO â‰?1 sec). Secondary Region can be promoted to primary in < 1 minute (RTO < 1 min). Secondary Regions are readable during normal operations â€?satisfying all three requirements simultaneously.

**Why not the others**:
- **A**: RDS Multi-AZ is within a single Region â€?no cross-Region DR.
- **B**: Cross-Region Read Replica is asynchronous with much higher lag (minutes); manual promotion takes longer.
- **D**: DAX is an in-Region cache, not a cross-Region DR solution.

**ğŸ“– Textbook ref**: Cross-Cutting Concepts â€?Disaster Recovery, "Aurora Global Database: < 1 sec lag, RTO < 1 min"

---

### A0.8
**Correct: B** â€?Attach an SCP to the root OU denying resource creation in unapproved Regions.

**Why**: A single SCP at the root OU cascades to all accounts via OU inheritance. The SCP denies all actions (`*`) with a condition on `aws:RequestedRegion` not being in the approved list. This is centrally managed, cannot be overridden by account administrators (SCP > IAM), and requires zero per-account configuration. The most scalable governance pattern.

**Why not the others**:
- **A**: IAM policies in 30 accounts require ongoing per-account management â€?not scalable.
- **C**: AWS Config detects non-compliance reactively â€?it doesn't prevent resource creation.
- **D**: CloudFormation per account has similar scaling issues to IAM policies.

**ğŸ“– Textbook ref**: Cross-Cutting Concepts â€?Multi-Account Governance, "SCP Inheritance: Parent OU SCPs apply to child OUs"

---

### A0.9
**Correct: B** â€?Spot EC2 instances with SQS for job queuing and Auto Scaling.

**Why**: Multiple factors align: (1) variable workload â†?don't provision for peak. (2) Fault-tolerant (can retry) â†?Spot's interruption risk is acceptable. (3) No ops team â†?full automation needed. SQS decouples job submission from processing and buffers during spikes. ASG scales Spot instances based on queue depth. Spot saves up to 90% vs On-Demand.

**Why not the others**:
- **A**: Reserved for average load means paying for idle capacity during quiet periods and being under-provisioned during spikes.
- **C**: Scheduled scaling requires predictable patterns â€?this workload is "sometimes zero for hours, then thousands simultaneously" (unpredictable timing).
- **D**: Savings Plans still commit spend â€?Spot with SQS maximizes flexibility.

**ğŸ“– Textbook ref**: Cross-Cutting Concepts â€?Cost Optimization + Decoupling; Â§1 â€?Spot Instances; Â§7 â€?SQS + Auto Scaling

---

### A0.10
**Correct: B** â€?Decoupling â€?introduce SQS between modules.

**Why**: Synchronous HTTP calls create tight coupling â€?one slow module blocks all callers upstream. Introducing SQS between modules converts synchronous calls to asynchronous: payment processing reads from its queue at its own pace. If it slows, the queue grows but order placement keeps accepting orders. This is the textbook cascading failure prevention pattern.

**Why not the others**:
- **A**: Vertical scaling makes individual modules faster but doesn't remove the synchronous dependency â€?a slow module still blocks callers.
- **C**: Multi-AZ improves availability of individual modules but doesn't decouple them.
- **D**: Auto Scaling helps individual modules scale but doesn't break the synchronous dependency chain.

**ğŸ“– Textbook ref**: Cross-Cutting Concepts â€?Decoupling, "Cascading Failure Prevention: SQS between tiers"

---

### A0.11
**Correct: C** â€?Amazon EC2 instances with Auto Scaling.

**Why**: Three requirements eliminate serverless options: (1) host-level monitoring agent with kernel access â€?Fargate and Lambda provide no host OS access. (2) Custom TCP tuning â€?requires OS-level network stack configuration. (3) 24/7 steady traffic â€?EC2 Reserved/Savings Plans are cost-effective for continuous workloads. EC2 provides full OS/kernel control.

**Why not the others**:
- **A**: Lambda provides no OS access â€?cannot install kernel agents or tune TCP.
- **B**: Fargate is serverless â€?no host OS access for kernel-level monitoring or TCP tuning.
- **D**: Elastic Beanstalk can use EC2 but abstracts OS configuration â€?kernel tuning is limited.

**ğŸ“– Textbook ref**: Cross-Cutting Concepts â€?Serverless, "When NOT to use serverless: OS/kernel control needed"

---

### A0.12
**Correct: B** â€?AWS CodeDeploy with canary traffic shifting and CloudWatch alarm integration.

**Why**: CodeDeploy's canary deployment supports: (1) linear traffic shifting in increments (e.g., 10% â†?100%), (2) configurable bake time between increments (15 minutes), (3) automatic rollback triggered by CloudWatch alarms (error rate > 1%). This matches all three requirements exactly â€?percentage-based, time-based monitoring, alarm-based rollback.

**Why not the others**:
- **A**: Elastic Beanstalk Rolling is all-or-nothing per batch â€?not percentage-based canary.
- **C**: API Gateway canary deployments shift traffic but are tied to a single API stage â€?CodeDeploy works across EC2, Lambda, and ECS.
- **D**: CloudFormation rolling updates don't support fine-grained traffic shifting with alarm-based rollback.

**ğŸ“– Textbook ref**: Cross-Cutting Concepts â€?Deployment Strategies, "Canary: CodeDeploy linear traffic shifting with auto rollback"

---

## ğŸ”´ Similar Service Comparison â€?Answers

### A0.13
**Correct: C** â€?Multi-Site Active/Active.

**Why**: RPO < 1 second requires near-synchronous replication (Aurora Global Database or DynamoDB Global Tables). RTO < 1 minute requires the DR Region to already be running (no "spin-up" time). "Handle production traffic during normal operations" = both Regions are live. Only Active/Active meets all three. Pilot Light (must launch instances) and Warm Standby (must scale up) have RTOs measured in minutes to hours, not < 1 minute.

**Why not the others**:
- **A**: Pilot Light â€?core services running but application servers must be launched during DR (RTO > 1 min).
- **B**: Warm Standby â€?scaled-down but requires scaling up (RTO could be 5-10 minutes).
- **D**: Backup & Restore â€?highest RPO (hours of data loss) and RTO (hours to restore).

**ğŸ“– Textbook ref**: Cross-Cutting Concepts â€?Disaster Recovery, "DR Strategies (cold â†?hot)"

---

### A0.14
**Correct: B** â€?Server-based (EC2 + ALB + RDS).

**Why**: Two hard requirements eliminate serverless: (1) Custom OS-level monitoring agents require host access â€?Lambda and Fargate abstract the OS completely. (2) Kernel tuning requires root access to the host kernel. Additionally, steady 24/7 traffic favors reserved pricing over serverless per-request pricing â€?EC2 with Savings Plans is significantly cheaper for continuous workloads.

**Why not the others**:
- **A**: Serverless cannot meet the kernel/OS requirements â€?this is a hard blocker, not a preference.
- **C**: A hybrid adds complexity without benefit â€?if you need EC2 for agents anyway, run the full workload there.
- **D**: Fargate and Aurora Serverless have no host OS access for monitoring agents or kernel tuning.

**ğŸ“– Textbook ref**: Cross-Cutting Concepts â€?Serverless, "When NOT to use serverless"; Â§1 â€?Comparison table, "OS/kernel control" row

---

### A0.15
**Correct: B** â€?Active-Passive with RDS Multi-AZ.

**Why**: The application is stateful (session persistence needed) and runs within a single Region. RDS Multi-AZ provides synchronous replication to a standby in a different AZ â€?automatic failover with zero data loss (the standby is an exact synchronous copy). The application connects via the RDS endpoint which automatically resolves to the active instance. This is the within-Region, stateful HA pattern.

**Why not the others**:
- **A**: Active-Active with DynamoDB Global Tables is multi-Region and DynamoDB â€?may not fit a stateful relational workload.
- **C**: Active-Active EC2 behind ALB works for stateless web/app tiers but the question focuses on the stateful database component.
- **D**: Route 53 Failover is multi-Region â€?the question is about within-Region HA with the lowest data loss risk.

**ğŸ“– Textbook ref**: Cross-Cutting Concepts â€?High Availability, "Active-Passive: RDS Multi-AZ synchronous standby"

---

### A0.16
**Correct: B** â€?X=Standard Reserved Instances, Y=Compute Savings Plans.

**Why**: Strategy X describes Standard RIs: specific instance family, specific AZ, 1-3 year commitment, up to 72% discount. Strategy Y describes Compute Savings Plans: $/hour commitment (not instance-specific), applies to any instance family in any Region, also covers Lambda and Fargate, up to 66% discount (slightly less than RIs since it's more flexible). The key trade-off: RIs = higher discount but locked in; Compute Savings Plans = slightly lower discount but maximum flexibility.

**Why not the others**:
- **A**: Spot Instances are not a commitment â€?they can be terminated at any time.
- **C**: Convertible RIs allow instance family changes but are still Region-specific and don't cover Lambda/Fargate.
- **D**: On-Demand Capacity Reservations guarantee capacity with no discount â€?not a savings strategy.

**ğŸ“– Textbook ref**: Cross-Cutting Concepts â€?Cost Optimization, "Purchase Options ranked"; Â§1 â€?Comparison, "Spot vs Reserved vs Savings Plans"

---

### A0.17
**Correct: C** â€?AWS Backup with cross-Region copy for both Aurora and DynamoDB + Route 53 failover.

**Why**: RPO of 2 hours and RTO of 4 hours are moderate values measured in hours, not seconds. AWS Backup with cross-Region copy satisfies both objectives at the lowest cost: pay only for backup storage and periodic data transfer. Aurora Global Database + DynamoDB Global Tables (Options A, D) provide sub-second RPO â€?massive overkill and overpriced for 2-hour RPO. A custom DMS+Lambda pipeline (B) requires a 24Ã—7 DMS replication instance (significant fixed cost). The exam consistently pairs moderate RPO/RTO with backup-based solutions and tight RPO/RTO with continuous replication.

**Why not the others**:
- **A/D**: Aurora Global Database + DynamoDB Global Tables are designed for RPO < 1 second â€?disproportionately expensive for 2-hour RPO. You pay for a full secondary Aurora cluster and every replicated DynamoDB write.
- **B**: DMS replication instance runs 24Ã—7 ($0.30â€?2.00+/hour) + Lambda orchestration complexity â€?higher cost and more failure modes than managed AWS Backup.

**ğŸ“– Textbook ref**: Cross-Cutting Concepts â€?Disaster Recovery, "RPO/RTO â†?Solution Mapping"

---

### A0.18
**Correct: C** â€?Create an AWS Global Accelerator with the ALB as endpoint and provide the accelerator's static IPs.

**Why**: ALB does NOT support Elastic IP addresses (DNS name only, IPs change over time). NLB supports EIPs but does NOT integrate with WAF (Layer 4 only). Global Accelerator provides 2 static anycast IPs that don't change, routes traffic through AWS global backbone to the ALB, and preserves the ALB's WAF integration. This is the purpose-built solution for providing static IPs while retaining Layer 7 protections.

**Why not the others**:
- **A**: NLB does not integrate with AWS WAF â€?you lose WAF protection for the application. Also adds architectural complexity layering NLBâ†’ALB.
- **B**: ALB does not support Elastic IP addresses â€?this is technically impossible.
- **D**: CloudFront IPs are dynamic and change over time; AWS explicitly states you must not rely on static CloudFront IPs.

**ğŸ“– Textbook ref**: Cross-Cutting Concepts â€?Security, "Global Accelerator for Static IP + WAF"; Â§5 â€?Global Accelerator

---

### A0.19
**Correct: A** â€?EC2 Instance Savings Plan for EC2 + Compute Savings Plan for Lambda + Reserved Nodes for MemoryDB.

**Why**: Each discount instrument is matched to the workload pattern: (1) EC2 Instance Savings Plan gives the deepest discount (up to 72%) for stable, predictable EC2 loads â€?ideal since EC2 is "continuous and stable." (2) Compute Savings Plan provides maximum flexibility (any family, any Region, + Lambda) for variable/unpredictable Lambda usage â€?prevents over-commitment waste. (3) Reserved Nodes are the correct mechanism for MemoryDB â€?neither Savings Plan type covers database/caching services.

**Why not the others**:
- **B**: Compute Savings Plan does NOT cover MemoryDB (database service) â€?only EC2, Lambda, Fargate.
- **C**: Lambda Reserved Concurrency is a capacity reservation/throttling mechanism, NOT a cost-saving discount.
- **D**: Compute Savings Plan doesn't cover MemoryDB + Lambda Reserved Concurrency doesn't save money.

**ğŸ“– Textbook ref**: Cross-Cutting Concepts â€?Cost Optimization, "Savings Plans Decision Matrix"; "Reserved Concurrency â‰?cost savings"

---

### A0.20
**Correct: C** â€?Deploy a single NAT Gateway with Elastic IP + CloudWatch alarm + Lambda to recreate NAT GW in another AZ and reassign the EIP on failure.

**Why**: A single Elastic IP can only be assigned to one NAT Gateway at a time â€?three NAT Gateways sharing one EIP (Option A) is impossible. When the on-prem firewall restricts to a single source IP, the standard multi-AZ NAT GW pattern (one per AZ, each with own EIP) won't work. Solution: one NAT GW in one AZ â†?CloudWatch monitors â†?Lambda recreates NAT GW in a different AZ and reassigns the EIP on failure. This preserves the single whitelisted IP while achieving cross-AZ failover.

**Why not the others**:
- **A**: An EIP can only associate with one resource at a time â€?cannot assign the same EIP to three NAT Gateways.
- **B**: NLB handles inbound traffic â€?not outbound NAT for private instances reaching on-premises.
- **D**: ALB does not support EIPs + ALB handles inbound (clientâ†’app), not outbound (appâ†’on-prem).

**ğŸ“– Textbook ref**: Cross-Cutting Concepts â€?High Availability, "NAT Gateway HA with Single EIP"; Â§5 â€?NAT Gateway, VPC
