---
chapter: "1. Compute"
totalQuestions: 25
tiers:
  knowledge: 9
  scenario: 11
  comparison: 5
basedOn: "AWS-SAP-C02-Learning-Material.md §1"
services:
  - EC2
  - EC2 Auto Scaling
  - Lambda
  - Elastic Beanstalk
  - AWS Batch
---

# Chapter 1 Practice: 💻 Compute

> **Instructions**: Complete Part A first. Do not scroll past the divider. Once finished, check Part B for answers and explanations.
> **Textbook**: `AWS-SAP-C02-Learning-Material.md` �?Section 1 (EC2, Auto Scaling, Lambda, Elastic Beanstalk, Batch) + Similar Service Comparison: Compute

---

# Part A �?Questions

## 🟢 Knowledge Check (8 questions)

### Q1.1

> 🟡 L2-理解 | 🎤🎤 中频面试
A solutions architect is designing an HPC cluster on EC2 that requires the lowest possible inter-node network latency. Which placement group type should be used?

- A. Spread placement group across multiple AZs
- B. Cluster placement group in a single AZ
- C. Partition placement group with 7 partitions
- D. Spread placement group in a single AZ

### Q1.2

> 🟢 L1-知识 | 🎤🎤 中频面试
What is the maximum execution timeout for a single AWS Lambda function invocation?

- A. 5 minutes
- B. 10 minutes
- C. 15 minutes
- D. 30 minutes

### Q1.3

> 🔴 L3-应用 | 🎤🎤🎤 高频面试
A company runs stateless, fault-tolerant batch processing jobs on EC2 nightly. The jobs can be interrupted and restarted without data loss. Which EC2 purchasing option provides the MOST cost-effective solution?

- A. On-Demand Instances
- B. Reserved Instances (3-year, All Upfront)
- C. Spot Instances
- D. Savings Plans (1-year)

### Q1.4

> 🟡 L2-理解 | 🎤🎤 中频面试
A security team requires that SSH access to EC2 instances be fully auditable, use only temporary credentials, and not depend on any long-lived SSH key pairs. Which solution meets ALL these requirements?

- A. AWS Systems Manager Session Manager
- B. EC2 Instance Connect
- C. AWS Certificate Manager with TLS client certificates
- D. Store SSH private keys in AWS Secrets Manager with automatic rotation

### Q1.5

> 🟡 L2-理解 | 🎤🎤 中频面试
A developer deploys an application using Elastic Beanstalk and needs the fastest possible rollback time if a deployment failure is detected. Which deployment policy should be used?

- A. All at Once
- B. Rolling
- C. Rolling with Additional Batch
- D. Immutable

### Q1.6

> 🟢 L1-知识 | 🎤🎤 中频面试
What is the purpose of Provisioned Concurrency in AWS Lambda?

- A. It guarantees a minimum number of concurrent executions across all functions in an account
- B. It keeps execution environments initialized and ready to respond, eliminating cold starts
- C. It limits the maximum number of concurrent executions to prevent overloading downstream resources
- D. It reserves a fixed percentage of account-level concurrency for a specific function

### Q1.7

> 🟡 L2-理解 | 🎤🎤 中频面试
A company needs to guarantee EC2 capacity in a specific Availability Zone for a critical application launch next month. They do NOT need a billing discount �?only the assurance that instances will be available. Which feature should they use?

- A. Reserved Instances (1-year)
- B. Savings Plans (Compute)
- C. On-Demand Capacity Reservations
- D. Dedicated Hosts

### Q1.8

> 🟡 L2-理解 | 🎤🎤 中频面试
A solutions architect is migrating an on-premises VMware VM to AWS. The VM contains custom software and specific OS configurations that must be preserved exactly. Which approach should be used?

- A. Install the AWS Systems Manager Agent on the VM and use AWS Backup to create an AMI
- B. Export the VM as OVF, upload to S3, and run the `aws ec2 import-image` CLI command with the `vmimport` IAM role
- C. Use AWS DataSync to replicate the VM files to an EC2 instance
- D. Create a new EC2 instance and manually reinstall all software and configurations

---

## 🟡 Scenario Analysis (10 questions)

### Q1.9

> 🟡 L2-理解 | 🎤🎤 中频面试
A company runs a message-processing application on EC2 instances in an Auto Scaling group. The ASG scales based on the SQS queue depth (`ApproximateNumberOfMessagesVisible`). During scale-in events, some instances are terminated while still processing messages, causing those messages to become visible again after the visibility timeout.

Which combination of features should the solutions architect implement to prevent message loss during scale-in? (Choose two.)

- A. Enable scale-in protection for instances that are currently processing messages
- B. Switch from target tracking scaling to scheduled scaling
- C. Implement ASG lifecycle hooks to drain messages before termination
- D. Increase the SQS visibility timeout to 12 hours
- E. Use EC2 Instance Connect to gracefully shut down message processing

### Q1.10

> 🟡 L2-理解 | 🎤🎤 中频面试
A solutions architect needs to deploy a Lambda function that requires access to an RDS database in a private subnet and also needs to call an external third-party API over the internet. The function must use private IP addresses only for the database connection.

What networking configuration is required? (Choose two.)

- A. Place the Lambda function in a VPC with private subnets
- B. Attach an Internet Gateway to the VPC for the Lambda function's outbound internet access
- C. Deploy a NAT Gateway in a public subnet and route private subnet traffic to it
- D. Use a VPC endpoint for the RDS database connection
- E. Assign an Elastic IP to the Lambda function's ENI

### Q1.11

> 🟡 L2-理解 | 🎤🎤 中频面试
A company deploys a containerized application that runs 24/7 with steady traffic. The application occasionally needs OS-level kernel tuning that is not possible on Fargate. The team wants to minimize operational overhead while retaining kernel access when needed.

Which compute option best balances these requirements?

- A. AWS Lambda with container image support
- B. Amazon ECS on Fargate
- C. Amazon ECS on EC2
- D. AWS Elastic Beanstalk with Docker platform

### Q1.12

> 🟡 L2-理解 | 🎤🎤 中频面试
A solutions architect is designing a cost-optimization strategy for EC2 instances across multiple accounts in an organization. The workloads run across various instance families and include Lambda functions and Fargate tasks. The team wants maximum flexibility to change instance types and Regions without losing discount benefits.

Which purchase option should be recommended?

- A. Standard Reserved Instances (3-year, All Upfront)
- B. Convertible Reserved Instances (3-year, Partial Upfront)
- C. Compute Savings Plans (1-year)
- D. Spot Instances with Spot Fleet diversification

### Q1.13

> 🟡 L2-理解 | 🎤🎤 中频面试
An e-commerce application uses EC2 instances behind an Application Load Balancer. During flash sales, traffic increases 10x within minutes. The current Auto Scaling group uses step scaling policies but frequently over-scales and then under-scales, causing oscillation.

What should the solutions architect change to improve scaling responsiveness and stability?

- A. Replace step scaling with target tracking scaling based on CPU utilization
- B. Disable scale-in actions during flash sale periods
- C. Increase the cooldown period to 600 seconds
- D. Switch from Launch Templates to Launch Configurations

### Q1.14

> 🟡 L2-理解 | 🎤🎤 中频面试
A company runs a multi-step batch processing workflow. Step 1 is an event-driven Lambda function with a 30-second execution time. Step 2 is a 2-hour data transformation that exceeds Lambda's timeout. Step 3 is a notification step that takes 2 minutes.

Which combination of services should be used to orchestrate this workflow?

- A. Lambda for Step 1, EC2 for Step 2, Lambda for Step 3 �?orchestrated by Step Functions
- B. Lambda for all three steps �?orchestrated by Amazon EventBridge
- C. AWS Batch for all three steps �?orchestrated by CloudWatch Events
- D. Lambda for Step 1, AWS Batch for Step 2, Lambda for Step 3 �?orchestrated by Step Functions

### Q1.15

> 🟡 L2-理解 | 🎤🎤 中频面试
A company wants to deploy a .NET 6 application with minimal infrastructure management. The development team uses Azure DevOps for CI/CD but the application must run on AWS. The team wants to be able to SSH into instances for troubleshooting when needed, and the application needs to automatically scale based on request count.

Which AWS service should be used?

- A. AWS Lambda with .NET runtime
- B. Amazon ECS on Fargate
- C. AWS Elastic Beanstalk
- D. Amazon EC2 with Auto Scaling and CodeDeploy

### Q1.16

> 🟡 L2-理解 | 🎤🎤 中频面试
A solutions architect needs to launch EC2 instances with varying vCPU and memory requirements across different instance families and generations. The architect wants the Auto Scaling group to automatically pick the best available instance type that meets the defined requirements, including across newer generation types as they become available.

Which Auto Scaling feature should be used?

- A. Launch Templates with a fixed list of instance types
- B. Attribute-based instance type selection
- C. EC2 Fleet with manual instance type specification
- D. Launch Configurations with mixed instance types

### Q1.17

> 🟡 L2-理解 | 🎤🎤 中频面试
A company has an existing 3-tier application running on VMware in an on-premises data center. They want to migrate to AWS with minimal changes. The application consists of:
- Web tier: Apache on Linux (4 VMs)
- App tier: Tomcat on Linux (6 VMs)
- Database tier: Oracle on Linux (2 VMs)

The migration must preserve all software, configurations, and OS settings. Which migration strategy and tool combination should the solutions architect recommend?

- A. Replatform using AWS Elastic Beanstalk for web and app tiers; RDS for Oracle for database tier
- B. Rehost using VM Import/Export for all servers; Oracle on EC2 for database tier
- C. Refactor web and app tiers to Lambda; migrate database using DMS to Aurora
- D. Rehost using AWS Application Migration Service (MGN) for all servers

### Q1.18

> 🟡 L2-理解 | 🎤🎤 中频面试
A company's Auto Scaling group behind an ALB handles long-running HTTP requests (up to 5 minutes per request). During scale-in events, instances are terminated before completing in-flight requests, causing client errors. The team has already implemented connection draining on the ALB with a 300-second timeout.

What additional measure should the solutions architect implement?

- A. Enable ASG scale-in protection for instances with active requests
- B. Implement an ASG lifecycle hook on termination to check for active connections before allowing termination
- C. Increase the ALB deregistration delay to 600 seconds
- D. Switch to Network Load Balancer which does not terminate connections during scale-in

---

## 🔴 Similar Service Comparison (4 questions)

### Q1.19

> 🟡 L2-理解 | 🎤🎤 中频面试
A startup is deciding between compute options for a new microservice. The service receives unpredictable traffic �?sometimes zero requests for hours, then a sudden burst of thousands of requests in seconds. Each request takes 2�? seconds to process. The team has no dedicated operations staff.

Which service is the BEST fit?

- A. Amazon EC2 with Auto Scaling
- B. AWS Lambda
- C. Amazon ECS on Fargate
- D. Amazon EKS on Fargate

### Q1.20

> 🟡 L2-理解 | 🎤🎤 中频面试
A financial services company needs to run a Monte Carlo simulation workload. Individual simulation jobs run for 45 minutes each and require 16 vCPUs with high memory (256 GB). The workload runs weekly and results are needed within 4 hours of submission. Which compute option is the WORST choice?

- A. Amazon EC2 with Spot Instances
- B. AWS Lambda
- C. Amazon ECS on EC2
- D. AWS Batch on EC2

### Q1.21

> 🟡 L2-理解 | 🎤🎤 中频面试
A solutions architect evaluates two options for a steady-state production API running 24/7 with predictable traffic, containerized and requiring host-level security agent installation:
- Option 1: ECS on Fargate
- Option 2: ECS on EC2

What is the determining factor that makes Option 2 the correct choice?

- A. ECS on Fargate cannot integrate with ALB for load balancing
- B. Fargate does not allow installation of host-level agents; EC2 launch type does
- C. Fargate tasks have a maximum runtime of 15 minutes
- D. EC2 launch type has better integration with ECR for image storage

### Q1.22

> 🟡 L2-理解 | 🎤🎤 中频面试
A company's workload consists of thousands of independent, short-lived tasks (2�? seconds each) triggered by S3 object uploads. The volume of uploads varies from 10/minute overnight to 10,000/minute during peak hours. The processing logic is a simple Python script with no external dependencies.

Which compute model is the MOST cost-effective AND operationally efficient choice?

- A. EC2 Reserved Instances provisioned for peak capacity
- B. EC2 Spot Fleet with Auto Scaling based on SQS queue depth
- C. AWS Lambda with S3 event trigger
- D. ECS on Fargate with Service Auto Scaling based on SQS queue depth

### Q1.23

> 🟡 L2-理解 | 🎤🎤 中频面试
An HPC cluster runs on EC2 instances in a Cluster placement group within a single AZ. The solutions architect attempts to add more instances but receives an "insufficient capacity" error. The instances cannot be moved to a different AZ.

What should the solutions architect do to resolve this issue?

- A. Create a new placement group and merge it with the original group
- B. Stop and start all existing instances in the placement group, then retry the launch
- C. Convert the Cluster placement group to a Spread placement group
- D. Launch the additional instances as Dedicated Hosts in the same placement group

### Q1.24

> 🟡 L2-理解 | 🎤🎤 中频面试
A company wants to migrate from hardcoded EC2 instance types to a flexible Auto Scaling configuration that can automatically choose the best available instance types across multiple generations and architectures (x86 and ARM). The ASG should prioritize cost efficiency while meeting minimum vCPU and memory requirements.

Which feature should the solutions architect use?

- A. EC2 Fleet with manual instance type overrides
- B. Multiple ASGs each with a different instance type and target tracking policies
- C. Attribute-Based Instance Type Selection in the ASG Launch Template
- D. AWS Compute Optimizer recommendations applied to the launch template

### Q1.25

> 🟡 L2-理解 | 🎤🎤 中频面试
A company deploys applications using Elastic Beanstalk. When deploying a major update, the company wants zero downtime, the ability to test the new version before cutover, and the fastest possible rollback if issues are detected.

Which deployment strategy within Elastic Beanstalk best meets these requirements?

- A. Rolling deployment �?updates instances in batches
- B. All at Once �?deploys to all instances simultaneously
- C. Blue/Green via CNAME swap �?deploy to new environment, validate, then swap DNS
- D. Rolling with Additional Batch �?adds new instances before updating originals

---

# Part B �?Answers & Explanations

> ⚠️ **STOP HERE.** Complete all questions in Part A before reading below.
>
> Scoring guideline: 🟢 Knowledge (easy), 🟡 Scenario (medium), 🔴 Comparison (hardest)

---

## 🟢 Knowledge Check �?Answers

### A1.1
**Correct: B** �?Cluster placement group in a single Availability Zone.

**Why**: Cluster placement groups place instances in close physical proximity within a single AZ, providing the lowest possible inter-node network latency (up to 10 Gbps for single-flow, or 100 Gbps with ENA). This is ideal for HPC workloads.

**Why not the others**:
- **A & D**: Spread placement groups distribute instances across hardware; they maximize fault tolerance, not low latency.
- **C**: Partition placement groups are for large distributed workloads (e.g., HDFS, Cassandra), not for minimizing inter-node latency.

**📖 Textbook ref**: §1 �?EC2, "Placement Groups"

---

### A1.2
**Correct: C** �?15 minutes.

**Why**: AWS Lambda has a maximum execution timeout of 900 seconds (15 minutes). This is a hard limit �?any execution exceeding this will be forcibly terminated.

**Why not the others**: 5 and 10 minutes were earlier limits (Lambda originally launched with 5 minutes, later extended to 15). 30 minutes is not supported.

**📖 Textbook ref**: §1 �?Lambda, "Overview"

---

### A1.3
**Correct: C** �?Spot Instances.

**Why**: Spot Instances offer up to 90% discount compared to On-Demand. Since the workload is stateless, fault-tolerant, and can be interrupted without data loss, Spot is the ideal use case. The 2-minute termination warning allows graceful shutdown.

**Why not the others**:
- **A**: On-Demand has no discount �?most expensive option for steady work.
- **B**: Reserved Instances require a 1�? year commitment; unsuitable if the workload pattern could change.
- **D**: Savings Plans also require a $/hour commitment; excessive for fault-tolerant batch jobs.

**📖 Textbook ref**: §1 �?EC2, "Spot Instances"

---

### A1.4
**Correct: B** �?EC2 Instance Connect.

**Why**: EC2 Instance Connect pushes a temporary SSH public key to the instance metadata via the AWS API. The key is valid for 60 seconds �?enough to establish one SSH connection. All API calls are logged in CloudTrail for auditability. No long-lived key pairs are stored anywhere.

**Why not the others**:
- **A**: Session Manager also provides auditable access but via browser-based SSH/RDP, not standard SSH. The question specifically mentions "SSH access."
- **C**: Certificate Manager provides SSL/TLS certificates, not SSH authentication.
- **D**: Secrets Manager with rotation still requires managing long-lived key material �?the private key exists somewhere.

**📖 Textbook ref**: §1 �?EC2, "EC2 Instance Connect"

---

### A1.5
**Correct: D** �?Immutable.

**Why**: Immutable deployments create a completely new Auto Scaling group for the new version. If deployment fails, the old ASG is still running and healthy �?rollback is instantaneous (just point traffic back to the old ASG). This provides the fastest rollback of all deployment policies.

**Why not the others**:
- **A**: All at Once is fastest to deploy but slowest to roll back �?all instances were already updated.
- **B & C**: Rolling and Rolling with Additional Batch update instances progressively; rollback requires re-deploying the old version to each instance.

**📖 Textbook ref**: §1 �?Elastic Beanstalk, "Fast Rollback"

---

### A1.6
**Correct: B** �?It keeps execution environments initialized and ready to respond, eliminating cold starts.

**Why**: Provisioned Concurrency pre-warms a specified number of execution environments so they are ready to immediately serve requests. This eliminates the initialization latency ("cold start") that occurs when Lambda creates a new execution environment.

**Why not the others**:
- **A**: This describes Reserved Concurrency, which guarantees capacity but does NOT eliminate cold starts.
- **C**: This also describes Reserved Concurrency used as a throttle.
- **D**: Reserved Concurrency reserves a portion of the account-level limit, not a "percentage" per se.

**📖 Textbook ref**: §1 �?Lambda, "Concurrency"

---

### A1.7
**Correct: C** �?On-Demand Capacity Reservations.

**Why**: On-Demand Capacity Reservations guarantee that capacity will be available in a specific AZ when you need it. They provide no billing discount �?you pay On-Demand rates regardless of whether you use the capacity. This is the exact use case described.

**Why not the others**:
- **A & B**: Reserved Instances and Savings Plans are billing discounts, not capacity guarantees.
- **D**: Dedicated Hosts give you a physical server but are about compliance/licensing, not capacity assurance.

**📖 Textbook ref**: §1 �?EC2, "Capacity Reservations" and Common Pitfall #1

---

### A1.8
**Correct: B** �?Export as OVF, upload to S3, run `ec2 import-image` with the `vmimport` IAM role.

**Why**: VM Import/Export is the native AWS service for importing VM images. The process is: (1) export the VM as OVF (or VMDK, VHD, RAW), (2) upload the image to S3, (3) run `aws ec2 import-image` with the `vmimport` service role. This preserves all software, OS settings, and configurations exactly.

**Why not the others**:
- **A**: SSM Agent + AWS Backup does not create AMIs from on-prem VMs.
- **C**: DataSync moves files, not whole VM images �?it cannot preserve OS-level configurations.
- **D**: Manual reinstallation violates the "must preserve exactly" requirement.

**📖 Textbook ref**: §1 �?EC2, "VM Import/Export"; §9 �?Migration, "VM Import/Export"

---

## 🟡 Scenario Analysis �?Answers

### A1.9
**Correct: A and C** �?Scale-in protection + lifecycle hooks.

**Why**:
- **A (Scale-in protection)**: Prevents specific instances from being terminated during scale-in. An instance processing messages can set scale-in protection on itself, process its messages, then remove the protection �?allowing it to be terminated later.
- **C (Lifecycle hooks)**: The `Terminating` lifecycle hook pauses termination and allows a script to run (e.g., drain the in-memory message queue, finish processing, signal completion). Once the hook completes, the instance is terminated.

**Why not the others**:
- **B**: Scheduled scaling doesn't solve the message-loss problem �?messages still arrive unpredictably.
- **D**: Increasing visibility timeout to 12 hours delays message re-delivery but doesn't prevent the processing from being interrupted; messages still reappear after the (very long) timeout.
- **E**: EC2 Instance Connect is for SSH access, not for coordinating graceful shutdown.

**📖 Textbook ref**: §1 �?EC2 Auto Scaling, "Scale-In Protection" and "Lifecycle Hooks"

---

### A1.10
**Correct: A and C** �?VPC with private subnets + NAT Gateway.

**Why**:
- **A (VPC with private subnets)**: Lambda in VPC creates ENIs in the specified subnets. Using private subnets means the Lambda function has private IP addresses for RDS access.
- **C (NAT Gateway)**: Lambda in a private subnet cannot reach the internet directly. A NAT Gateway in a public subnet routes outbound traffic from the private subnet to the internet, enabling the third-party API call.

**Why not the others**:
- **B**: Internet Gateway enables inbound/outbound internet for public subnets, but Lambda would need a public IP �?contradicting the "private IPs only for DB" requirement.
- **D**: VPC endpoints provide private connectivity to AWS services �?but an RDS instance in the same VPC is already reachable via private IP without an endpoint. An endpoint doesn't help here.
- **E**: Lambda ENIs cannot have Elastic IPs assigned directly.

**📖 Textbook ref**: §1 �?Lambda, "Lambda in VPC"; §5 �?VPC, "NAT Gateway"

---

### A1.11
**Correct: C** �?Amazon ECS on EC2.

**Why**: ECS on EC2 gives the team full control over the EC2 host OS, enabling kernel tuning when needed. ECS manages container orchestration (reducing operational overhead vs. raw EC2), but the underlying EC2 instances are accessible for kernel-level changes.

**Why not the others**:
- **A**: Lambda container support is for event-driven, short-lived workloads �?not 24/7 steady traffic, and it has no kernel access.
- **B**: Fargate is serverless �?no host OS access at all.
- **D**: Elastic Beanstalk with Docker abstracts away the host �?kernel access is limited.

**📖 Textbook ref**: §2 �?Containers, "ECS + EC2: you manage the cluster, more control"; §1 �?Similar Service Comparison table

---

### A1.12
**Correct: C** �?Compute Savings Plans (1-year).

**Why**: Compute Savings Plans provide the maximum flexibility: they apply to any instance family, any Region, and also cover Lambda and Fargate usage �?all mentioned in the scenario. A 1-year term balances commitment with flexibility. They automatically apply to new instance generations as they become available.

**Why not the others**:
- **A**: Standard RIs are locked to a specific instance family in a specific AZ/Region �?no flexibility to change families or Regions.
- **B**: Convertible RIs allow changing instance families but are still Region-specific and don't cover Lambda/Fargate.
- **D**: Spot Instances offer no discount guarantee (prices fluctuate) and can be terminated �?unsuitable as the primary cost strategy for steady workloads.

**📖 Textbook ref**: §1 �?Similar Service Comparison, "Spot vs Reserved vs Savings Plans vs On-Demand"

---

### A1.13
**Correct: A** �?Replace step scaling with target tracking scaling based on CPU utilization.

**Why**: Target tracking scaling maintains a specified metric at a target value (e.g., CPU at 60%). It automatically adjusts the desired capacity proportionally �?scaling out more aggressively when the metric is far from target, and scaling in gradually. This eliminates the oscillation (over-scale/under-scale cycle) common with step scaling policies during rapid traffic changes.

**Why not the others**:
- **B**: Disabling scale-in wastes money and doesn't fix oscillation during scale-out.
- **C**: A longer cooldown makes scaling slower, worsening the responsiveness problem.
- **D**: Launch Configurations are legacy; Launch Templates are the modern, recommended approach.

**📖 Textbook ref**: §1 �?EC2 Auto Scaling, "Azure Bridge" (scaling policy types)

---

### A1.14
**Correct: D** �?Lambda for Step 1, AWS Batch for Step 2, Lambda for Step 3 �?orchestrated by Step Functions.

**Why**: Step Functions orchestrates multi-step workflows with built-in error handling, retry, and state management. The 2-hour Step 2 exceeds Lambda's 15-minute timeout, so AWS Batch (which handles long-running jobs) is the right choice. Lambda handles Steps 1 and 3 efficiently.

**Why not the others**:
- **A**: EC2 for Step 2 would work but requires manually managing the instance lifecycle; Batch is fully managed for this use case.
- **B**: Lambda cannot run for 2 hours �?exceeds the 15-minute max.
- **C**: AWS Batch is not suitable for 30-second or 2-minute event-driven tasks; Lambda is better for those.

**📖 Textbook ref**: §1 �?AWS Batch, "Integration with Step Functions"; §7 �?Step Functions

---

### A1.15
**Correct: C** �?AWS Elastic Beanstalk.

**Why**: Elastic Beanstalk is a PaaS that automatically manages the underlying infrastructure (EC2, ASG, ELB) while still allowing SSH access to the EC2 instances for troubleshooting. It supports .NET 6 on Linux, auto-scaling based on request count, and integrates with Azure DevOps pipelines for deployment �?matching the team's existing CI/CD setup.

**Why not the others**:
- **A**: Lambda has no SSH access to the execution environment.
- **B**: Fargate has no SSH access to the underlying host.
- **D**: Raw EC2 requires significantly more infrastructure management than Elastic Beanstalk.

**📖 Textbook ref**: §1 �?Elastic Beanstalk, "Azure Bridge" and "Overview"

---

### A1.16
**Correct: B** �?Attribute-based instance type selection.

**Why**: Attribute-based instance type selection lets you define requirements (e.g., "4�? vCPUs, 16�?2 GB memory") instead of specifying exact instance types. The ASG automatically selects the best matching type from all available families and generations, including newer instances as AWS releases them �?no template updates needed.

**Why not the others**:
- **A**: A fixed list requires manual updates when new generations are released.
- **C**: EC2 Fleet with manual specification has the same limitation as A.
- **D**: Launch Configurations are deprecated and don't support attribute-based selection.

**📖 Textbook ref**: §1 �?EC2 Auto Scaling, "Attribute-Based Instance Selection"

---

### A1.17
**Correct: D** �?Rehost using AWS Application Migration Service (MGN) for all servers.

**Why**: MGN (formerly CloudEndure) performs block-level continuous replication of entire servers (OS + apps + data) to AWS. This is a pure lift-and-shift (rehost) migration that preserves all software, configurations, and OS settings. For the Oracle database, running on EC2 avoids the complexity of schema conversion to RDS/Aurora.

**Why not the others**:
- **A**: Replatforming to Beanstalk and RDS changes the architecture �?this is not "minimal changes."
- **B**: VM Import/Export handles individual VMs but requires manual coordination across 12 VMs; MGN provides continuous replication with cutover orchestration.
- **C**: Refactoring to Lambda is a complete rewrite �?far from "minimal changes."

**📖 Textbook ref**: §9 �?Migration, "MGN"; §1 �?EC2, "VM Import/Export"

---

### A1.18
**Correct: B** �?Implement an ASG lifecycle hook on termination to check for active connections before allowing termination.

**Why**: A termination lifecycle hook pauses the instance termination and allows a script to run. The script can check whether the instance has active connections or in-flight requests. If it does, the hook can extend the wait (up to 2 hours) or even abort the termination. This provides active coordination between the application and the ASG �?far more reliable than ALB connection draining alone.

**Why not the others**:
- **A**: Scale-in protection is a static flag �?it doesn't dynamically check for active requests. Setting and unsetting it per request adds complexity.
- **C**: Increasing deregistration delay to 600 seconds (10 minutes) doesn't help because the question already has 300 seconds. The problem may be that requests last longer than expected or that scale-in decisions are made regardless.
- **D**: NLB also terminates connections during scale-in; it doesn't solve the problem.

**📖 Textbook ref**: §1 �?EC2 Auto Scaling, "Lifecycle Hooks"

---

## 🔴 Similar Service Comparison �?Answers

### A1.19
**Correct: B** �?AWS Lambda.

**Why**: Lambda is ideal for variable, bursty traffic with zero-to-thousands swings. It scales instantly per-request, costs nothing when idle (no requests = $0), and requires no operations staff to manage. Each request takes 2�? seconds �?well within Lambda's capabilities.

**Why not the others**:
- **A**: EC2 Auto Scaling has a warm-up delay; it cannot scale from zero to thousands in seconds.
- **C & D**: ECS/EKS on Fargate requires at least one running task (costs money even when idle) and scales more slowly than Lambda for rapid bursts.

**📖 Textbook ref**: §1 �?Similar Service Comparison, "Lambda vs ECS vs Fargate vs EC2"

---

### A1.20
**Correct: B** �?AWS Lambda.

**Why**: Lambda has a 15-minute maximum timeout �?each simulation job runs for 45 minutes, making Lambda categorically impossible for this workload. The question asks for the WORST choice; Lambda cannot run the workload at all.

**Why the others**:
- **A**: Spot EC2 can run 45-minute jobs; the weekly cadence and 4-hour deadline mean Spot interruptions are manageable with retries.
- **C**: ECS on EC2 can run long-duration containerized jobs.
- **D**: AWS Batch on EC2 is purpose-built for this exact use case �?managed batch with long-running jobs.

**📖 Textbook ref**: §1 �?Similar Service Comparison, "Max runtime" row; §1 �?Lambda, "Common Pitfalls"

---

### A1.21
**Correct: B** �?Fargate does not allow installation of host-level agents; EC2 launch type does.

**Why**: Fargate is serverless �?you have no access to the underlying host OS. Security agents that require kernel-level or host-level installation cannot be deployed on Fargate. With ECS on EC2, you control the EC2 host and can install any agent software you need.

**Why not the others**:
- **A**: Fargate fully supports ALB integration via service discovery and target groups. This statement is false.
- **C**: Fargate tasks have no runtime limit. This statement confuses Fargate with Lambda.
- **D**: Both Fargate and EC2 launch types integrate with ECR identically. This statement is false.

**📖 Textbook ref**: §1 �?Similar Service Comparison, "OS/kernel control" row; §2 �?Fargate

---

### A1.22
**Correct: C** �?AWS Lambda with S3 event trigger.

**Why**: S3 event notifications can directly trigger Lambda on each object upload �?no queue, no polling, no infrastructure. Lambda scales automatically per request, handles 2�? second tasks perfectly, and costs nothing when uploads are at 10/minute overnight. This is the canonical "S3 �?Lambda" event-driven pattern. Python support is native.

**Why not the others**:
- **A**: Provisioning for peak (10,000/min) wastes enormous capacity overnight.
- **B**: Spot Fleet adds complexity (interruption handling, queue management) with no benefit for such short tasks.
- **D**: Fargate always has a running cost baseline and requires an SQS queue between S3 and the service �?unnecessary complexity.

**📖 Textbook ref**: §1 �?Similar Service Comparison, "Scaling speed" and "Best for" rows; §3 �?S3, "Event Notifications"

---

### A1.23
**Correct: B** �?Stop and start all existing instances in the placement group, then retry the launch.

**Why**: Stop/Start causes EC2 to re-place instances on different host hardware, which can free up contiguous capacity that matches the placement group's constraints. This is the documented troubleshooting step when hitting "insufficient capacity" within a Cluster placement group. Placement groups cannot be merged, converted, or combined.

**Why not the others**:
- **A**: Placement groups cannot be merged �?this operation doesn't exist in AWS.
- **C**: You cannot convert a Cluster placement group to Spread after creation.
- **D**: Dedicated Hosts don't resolve placement group capacity constraints �?the issue is hardware placement, not tenancy.

**📖 Textbook ref**: §1 �?EC2, "Placement Group Capacity Issue"

---

### A1.24
**Correct: C** �?Attribute-Based Instance Type Selection in the ASG Launch Template.

**Why**: Attribute-Based Instance Selection lets you define requirements like `vcpu >= 4`, `memory >= 16 GiB`, and `architecture = x86_64, arm64`. The ASG automatically selects matching instance types across generations �?and as AWS releases new types meeting the criteria, they're automatically included. No manual updates needed. Works with both On-Demand and Spot.

**Why not the others**:
- **A**: Manual overrides defeat the purpose of "automatic selection."
- **B**: Multiple ASGs add management complexity and don't auto-discover new instance types.
- **D**: Compute Optimizer identifies recommendations but doesn't automatically apply them to ASG configurations.

**📖 Textbook ref**: §1 �?EC2 Auto Scaling, "Attribute-Based Instance Selection"

---

### A1.25
**Correct: C** �?Blue/Green via CNAME swap �?deploy to new environment, validate, then swap DNS.

**Why**: Elastic Beanstalk Blue/Green deployment creates a separate "green" environment with the new version. After validation (testing before cutover), you swap the CNAME (DNS alias) from the old blue environment to the new green one. If issues are detected, swap back to the original CNAME �?instant rollback. Zero downtime because both environments run independently during the swap. You can also use Route 53 weighted routing for gradual traffic shifting between environments.

**Why not the others**:
- **A**: Rolling updates instances in batches �?no separate test environment, and rollback requires re-deploying old version to each instance.
- **B**: All at Once has downtime during deployment and slowest rollback.
- **D**: Rolling with Additional Batch avoids capacity loss but still updates in place �?no pre-cutover validation environment.

**📖 Textbook ref**: §1 �?Elastic Beanstalk, "Blue/Green Deployment via CNAME swap"

---

> **📊 Chapter 1 Summary**: 9 Knowledge + 11 Scenario + 5 Comparison = 25 questions
> 
> **Next**: If you missed any questions, review the corresponding section in `AWS-SAP-C02-Learning-Material.md` and add the Q number to your missed question tracker.
