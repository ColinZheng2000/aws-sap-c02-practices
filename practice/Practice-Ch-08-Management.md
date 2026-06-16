---
chapter: "8. Management & Governance"
totalQuestions: 14
tiers:
  knowledge: 5
  scenario: 6
  comparison: 3
basedOn: "AWS-SAP-C02-Learning-Material.md §8"
services:
  - CloudFormation
  - Systems Manager
  - CloudWatch
  - Service Catalog
  - AWS Backup
  - Compute Optimizer
  - Trusted Advisor
---

# Chapter 8 Practice: 📊 Management & Governance

> **Instructions**: Complete Part A first. Do not scroll past the divider. Once finished, check Part B for answers and explanations.
> **Textbook**: `AWS-SAP-C02-Learning-Material.md`  → Section 8 (CloudFormation, Systems Manager, CloudWatch, Service Catalog, AWS Backup, Other Management Services) + Similar Service Comparison: IaC & Governance

---

# Part A  → Questions

## 🟢 Knowledge Check (5 questions)

### Q8.1

> 🟡 L2-理解 | 🎤🎤 中频面试
A solutions architect needs to deploy identical infrastructure stacks to 20 AWS accounts across 3 Regions from a central management account. Which CloudFormation feature should be used?

- A. Nested Stacks
- B. CloudFormation StackSets
- C. CloudFormation Change Sets
- D. CloudFormation Drift Detection

### Q8.2

> 🟡 L2-理解 | 🎤🎤 中频面试
A security engineer needs to provide SSH access to EC2 instances without opening inbound port 22 in security groups, without a bastion host, and with full audit logging. Which Systems Manager feature provides this?

- A. Systems Manager Run Command
- B. Systems Manager Session Manager
- C. Systems Manager Fleet Manager
- D. Systems Manager Patch Manager

### Q8.3

> 🟡 L2-理解 | 🎤🎤 中频面试
Which CloudWatch feature triggers an Auto Scaling action when the average CPU utilization exceeds 80% for 5 minutes?

- A. CloudWatch Logs metric filter
- B. CloudWatch Alarm
- C. CloudWatch Dashboard
- D. CloudWatch Synthetics

### Q8.4

> 🟡 L2-理解 | 🎤🎤 中频面试
A company wants to allow development teams to deploy approved CloudFormation templates but prevent them from deploying any unapproved configurations. Which service enforces this governance model?

- A. AWS Config with compliance rules
- B. AWS Service Catalog
- C. AWS Organizations SCPs
- D. CloudFormation StackSets with service-managed permissions

### Q8.5

> 🟢 L1-知识 | 🎤🎤 中频面试
What is the default monitoring granularity for Amazon CloudWatch EC2 metrics (free tier)?

- A. 1 minute (Detailed Monitoring)
- B. 5 minutes (Basic Monitoring)
- C. 15 minutes
- D. 1 hour

---

## 🟡 Scenario Analysis (6 questions)

### Q8.6

> 🟡 L2-理解 | 🎤🎤 中频面试
A solutions architect notices that some EC2 instances were manually modified (additional security groups attached) outside of CloudFormation. The infrastructure was originally deployed via CloudFormation. The architect needs to identify all resources that differ from their original template definitions.

Which CloudFormation feature should be used?

- A. CloudFormation Change Sets
- B. CloudFormation Drift Detection
- C. CloudFormation Stack Policy
- D. CloudFormation Rollback Triggers

### Q8.7

> 🟡 L2-理解 | 🎤🎤 中频面试
A company must configure a nightly backup of all RDS databases, DynamoDB tables, and EFS file systems across 30 accounts. Backups must be retained for 35 days and copied to a DR Region.

Which service provides centralized backup management with these capabilities?

- A. RDS automated snapshots, DynamoDB on-demand backups, and EFS automated backups configured separately
- B. AWS Backup with a Backup Plan, cross-Region copy, and cross-account management via Organizations
- C. AWS Data Lifecycle Manager (DLM) with cross-Region policies
- D. Custom Lambda functions that trigger snapshots and copy them to the DR Region

### Q8.8

> 🟡 L2-理解 | 🎤🎤 中频面试
A solutions architect needs to run a patching operation on 500 EC2 instances across multiple AWS accounts. The patches must be applied during a specific maintenance window, and the architect needs a detailed compliance report showing which instances were patched and which failed.

Which Systems Manager feature combination should be used?

- A. Run Command with a custom patching script
- B. Patch Manager with Patch Baselines + Maintenance Windows
- C. Session Manager to log into each instance and run yum/apt
- D. Fleet Manager to manually select instances and apply updates

### Q8.9

> 🟡 L2-理解 | 🎤🎤 中频面试
An organization needs to visualize its AWS spending across 50 accounts, identify cost trends, and receive Savings Plans recommendations. The finance team needs interactive dashboards.

Which combination of services should be used?

- A. Cost Explorer + AWS Budgets
- B. Cost and Usage Reports (CUR) + Amazon Athena + Amazon QuickSight
- C. AWS Trusted Advisor + CloudWatch Dashboards
- D. AWS Compute Optimizer + CloudWatch Metrics

### Q8.10

> 🟡 L2-理解 | 🎤🎤 中频面试
A company receives EC2 rightsizing recommendations but finds them difficult to action. The recommendations suggest different instance types for different workloads, but the team doesn't know which instances can be safely changed. Which service provides ML-based rightsizing recommendations with clear guidance on which changes are low-risk?

- A. AWS Trusted Advisor
- B. AWS Compute Optimizer
- C. Amazon CloudWatch Anomaly Detection
- D. AWS Cost Explorer Rightsizing Recommendations

### Q8.11

> 🟡 L2-理解 | 🎤🎤 中频面试
A company needs to create short-lived test environments for every pull request. Each environment consists of a VPC, EC2 instance, and security group. The environments must be created automatically when a PR is opened and deleted when the PR is merged. The solution must minimize operational overhead.

Which combination of services should be used?

- A. CloudFormation triggered by CodePipeline on PR events
- B. CloudFormation StackSets with manual stack creation for each PR
- C. AWS Service Catalog with self-service product provisioning
- D. Manual EC2 launch via AWS CLI for each PR

---

## 🔴 Similar Service Comparison (3 questions)

### Q8.12

> 🟡 L2-理解 | 🎤🎤 中频面试
A solutions architect needs to deploy infrastructure to a single AWS account in a single Region. The deployment must be repeatable and version-controlled. Which IaC tool should be used?

- A. CloudFormation StackSets
- B. CloudFormation Stack
- C. AWS Service Catalog
- D. AWS Config

### Q8.13

> 🟡 L2-理解 | 🎤🎤 中频面试
A company needs to back up only EBS volumes and create AMIs of EC2 instances on a daily schedule. The backups must be retained for 7 days. The solution should be simple and focus exclusively on EBS and EC2  → no other services need backup.

Which service provides the simplest, most targeted solution?

- A. AWS Backup
- B. Amazon Data Lifecycle Manager (DLM)
- C. Manual snapshots via a scheduled Lambda function
- D. CloudFormation with snapshot resources

### Q8.14

> 🟡 L2-理解 | 🎤🎤 中频面试
A governance team wants to detect when a resource's configuration has been modified outside of an approved process. Specifically, they want to know: "Was this S3 bucket made public by someone manually (not through the approved CloudFormation pipeline)?"

Which service combination answers this question?

- A. CloudTrail to see who made the API call + AWS Config to see the current compliance state
- B. CloudFormation Drift Detection to detect changes outside CloudFormation
- C. CloudWatch Logs with a metric filter on S3 API calls
- D. Systems Manager Inventory to track resource changes

---

# Part B  → Answers & Explanations

> ⚠️ **STOP HERE.** Complete all questions in Part A before reading below.

---

## 🟢 Knowledge Check  → Answers

### A8.1
**Correct: B**  → CloudFormation StackSets.

**Why**: StackSets is designed for multi-account, multi-Region deployments. A StackSet created in a central administrator account can deploy stacks to target accounts (within the same Organization) across multiple Regions. You can use service-managed permissions (automatic) or self-managed permissions (manual role creation in each account). One operation deploys to all 20 accounts × 3 Regions = 60 stacks.

**Why not the others**:
- **A**: Nested Stacks are for breaking a large single-account/single-Region stack into reusable components  → not multi-account.
- **C**: Change Sets preview the impact of changes to a single stack.
- **D**: Drift Detection identifies resources changed outside CloudFormation.

**📖 Textbook ref**: §8  → CloudFormation, "StackSets: Multi-account, multi-Region"

---

### A8.2
**Correct: B**  → Systems Manager Session Manager.

**Why**: Session Manager provides browser-based (or CLI-based) shell access to EC2 instances via the SSM Agent. It requires no inbound security group rules, no bastion host, and no SSH keys. All session activity is logged to CloudTrail and optionally to S3/CloudWatch Logs for full auditability. It uses IAM policies to control who can start sessions on which instances.

**Why not the others**:
- **A**: Run Command executes scripts remotely but doesn't provide interactive shell access.
- **C**: Fleet Manager is a UI for managing fleets  → it uses Session Manager for shell access.
- **D**: Patch Manager applies OS patches; it doesn't provide interactive access.

**📖 Textbook ref**: §8  → Systems Manager, "Session Manager: No bastion host, no open inbound ports"

---

### A8.3
**Correct: B**  → CloudWatch Alarm.

**Why**: A CloudWatch Alarm watches a single metric over a specified time period and performs one or more actions when the metric crosses a defined threshold. In this case: metric = CPUUtilization, statistic = Average, period = 5 minutes, threshold = 80%, action = Auto Scaling policy. This is the standard CloudWatch  → Auto Scaling integration.

**Why not the others**:
- **A**: Metric filters extract metric data from logs but don't trigger alarms directly.
- **C**: Dashboards display metrics visually but don't trigger actions.
- **D**: Synthetics monitors application endpoints via canaries, not EC2 CPU metrics.

**📖 Textbook ref**: §8  → CloudWatch, "Alarms: Trigger Auto Scaling based on metric thresholds"

---

### A8.4
**Correct: B**  → AWS Service Catalog.

**Why**: Service Catalog allows administrators to create "products" from approved CloudFormation templates. Users can browse and launch only approved products. This enforces governance  → teams cannot deploy arbitrary configurations. Administrators can update the underlying templates and version the products. This is the self-service with guardrails model.

**Why not the others**:
- **A**: Config detects non-compliance after deployment; it doesn't prevent deployment of unapproved configurations.
- **C**: SCPs limit which services/actions can be used but don't control the specific resource configurations.
- **D**: StackSets deploy the same stack across accounts but don't prevent users from deploying other stacks.

**📖 Textbook ref**: §8  → Service Catalog, "Users deploy only approved configurations"

---

### A8.5
**Correct: B**  → 5 minutes (Basic Monitoring).

**Why**: EC2 Basic Monitoring (free) sends metric data to CloudWatch at 5-minute intervals. This includes metrics like CPUUtilization, NetworkIn, NetworkOut, StatusCheckFailed. Detailed Monitoring (paid) sends data at 1-minute intervals and must be explicitly enabled per instance.

**Why not the others**: 1 minute is Detailed Monitoring (paid); 15 minutes and 1 hour are not EC2 CloudWatch metric intervals.

**📖 Textbook ref**: §8  → CloudWatch, "Metrics: Default (free) vs Detailed Monitoring (1-min, $)"

---

## 🟡 Scenario Analysis  → Answers

### A8.6
**Correct: B**  → CloudFormation Drift Detection.

**Why**: Drift Detection compares the current state of resources in a CloudFormation stack with the original template definitions. It identifies resources that have been changed outside CloudFormation (e.g., manually via console or CLI). The result shows which resources have drifted and what properties changed. This is exactly the tool for finding manually modified resources in a CloudFormation-managed infrastructure.

**Why not the others**:
- **A**: Change Sets preview planned changes before applying them  → they don't detect historical unauthorized changes.
- **C**: Stack Policies protect resources from unintended updates during CloudFormation stack updates, not from out-of-band changes.
- **D**: Rollback Triggers monitor CloudWatch alarms during stack creation/update  → not for drift detection.

**📖 Textbook ref**: §8  → CloudFormation, "Drift Detection"

---

### A8.7
**Correct: B**  → AWS Backup with a Backup Plan, cross-Region copy, and cross-account management via Organizations.

**Why**: AWS Backup is the centralized backup service that supports multiple services (RDS, DynamoDB, EFS, EBS, EC2, FSx, and more). A Backup Plan defines the schedule (nightly), retention (35 days), and cross-Region copy rules. With AWS Organizations integration, you can manage backup policies centrally across all accounts.

**Why not the others**:
- **A**: Configuring each service's native backup separately in 30 accounts is an operational nightmare  → no centralized management.
- **C**: DLM only handles EBS snapshots and AMIs  → not RDS, DynamoDB, or EFS.
- **D**: Custom Lambda adds operational overhead  → AWS Backup is the managed solution.

**📖 Textbook ref**: §8  → AWS Backup, "Centralized backup management across services"

---

### A8.8
**Correct: B**  → Patch Manager with Patch Baselines + Maintenance Windows.

**Why**: Systems Manager Patch Manager uses patch baselines to define which patches to apply (by severity, classification, or explicit lists). Maintenance Windows define when patches can be applied. Patch Manager can run across accounts (using Systems Manager in each account), and it generates compliance reports showing patched vs. non-compliant instances. This is the managed, scalable approach to fleet-wide patching.

**Why not the others**:
- **A**: Run Command + custom script works but lacks built-in compliance reporting  → you'd need to build that.
- **C**: Manually logging into 500 instances is impractical.
- **D**: Fleet Manager provides visibility but is not a patching automation tool.

**📖 Textbook ref**: §8  → Systems Manager, "Patch Manager" and "Automation"

---

### A8.9
**Correct: B**  → Cost and Usage Reports (CUR) + Amazon Athena + Amazon QuickSight.

**Why**: CUR provides the most detailed cost data (hourly granularity, per-resource, per-tag). CUR data is delivered to S3. Athena can query CUR data directly in S3 using standard SQL. QuickSight connects to Athena as a data source to create interactive, shareable dashboards with visualizations, trends, and drill-downs. This is the enterprise cost visualization pattern.

**Why not the others**:
- **A**: Cost Explorer is a simpler UI for basic analysis; it doesn't provide the raw data detail or interactive dashboards for 50 accounts at enterprise scale.
- **C**: Trusted Advisor checks best practices; CloudWatch dashboards are for operational metrics, not cost.
- **D**: Compute Optimizer focuses on resource sizing, not overall cost visualization.

**📖 Textbook ref**: §8  → Cost Explorer; §10  → Athena + QuickSight

---

### A8.10
**Correct: B**  → AWS Compute Optimizer.

**Why**: Compute Optimizer uses ML to analyze historical utilization metrics (CPU, memory, network, disk) and provides rightsizing recommendations with confidence scores. It classifies recommendations as low, medium, or high risk, helping teams prioritize safe changes. It covers EC2 instances, Auto Scaling groups, EBS volumes, Lambda functions, and ECS services on Fargate.

**Why not the others**:
- **A**: Trusted Advisor provides basic recommendations (e.g., "instance is idle") but not ML-based, confidence-scored guidance.
- **C**: CloudWatch Anomaly Detection identifies metric anomalies, not rightsizing recommendations.
- **D**: Cost Explorer Rightsizing Recommendations is a simpler feature based on basic utilization thresholds, not ML.

**📖 Textbook ref**: §8  → Compute Optimizer, "ML-based rightsizing"

---

### A8.11
**Correct: A**  → CloudFormation triggered by CodePipeline on PR events.

**Why**: This is the CI/CD pattern for infrastructure. A CodePipeline pipeline is triggered by a PR event (via EventBridge or CodeCommit/GitHub integration). The pipeline runs CloudFormation to create the test environment stack (VPC, EC2, SG). When the PR is merged, a cleanup action in the pipeline deletes the CloudFormation stack, removing all resources. This is fully automated  → zero manual intervention.

**Why not the others**:
- **B**: StackSets is for multi-account deployment, not for automating individual PR environments.
- **C**: Service Catalog provides self-service but still requires manual launch  → not automated on PR events.
- **D**: Manual CLI is the opposite of minimal operational overhead.

**📖 Textbook ref**: §8  → CloudFormation, "Infrastructure as Code declarative"; §12  → CodePipeline, "Source  → Build  → Deploy"

---

## 🔴 Similar Service Comparison  → Answers

### A8.12
**Correct: B**  → CloudFormation Stack.

**Why**: A CloudFormation Stack deploys resources to a single account in a single Region. It's version-controlled (template in source control), repeatable (same template creates identical environments), and is the fundamental IaC primitive. StackSets, Service Catalog, and Config all build on top of this basic unit.

**Why not the others**:
- **A**: StackSets is for multi-account, multi-Region  → overkill for a single account/Region.
- **C**: Service Catalog is for governed self-service across an organization  → overkill for one deployment.
- **D**: Config tracks compliance but doesn't deploy resources.

**📖 Textbook ref**: §8  → Similar Service Comparison, "CloudFormation vs StackSets vs Service Catalog"

---

### A8.13
**Correct: B**  → Amazon Data Lifecycle Manager (DLM).

**Why**: DLM is purpose-built for automating EBS snapshots and AMI creation. It uses lifecycle policies to define schedules, retention rules, and optional cross-account sharing. For EBS + EC2 only, DLM is simpler than AWS Backup (which is a multi-service platform) and more reliable than custom Lambda. If the company later expands to other services, they can migrate to AWS Backup.

**Why not the others**:
- **A**: AWS Backup works but is a broader platform  → simpler to use DLM when scope is limited to EBS/EC2.
- **C**: Custom Lambda requires development and maintenance  → not the simplest solution.
- **D**: CloudFormation doesn't schedule recurring operations; it deploys resources once.

**📖 Textbook ref**: §8  → Similar Service Comparison, "AWS Backup vs DLM vs Manual Snapshots"; §3  → EBS, "DLM"

---

### A8.14
**Correct: B**  → CloudFormation Drift Detection to detect changes outside CloudFormation.

**Why**: Drift Detection is specifically designed to answer this question: "Has this resource been changed outside of the CloudFormation stack that manages it?" If the S3 bucket was created via CloudFormation, drift detection will show that its `PublicAccessBlockConfiguration` no longer matches the template definition  → indicating someone changed it outside the approved process. This is more direct than combining CloudTrail + Config.

**Why not the others**:
- **A**: CloudTrail + Config works but requires correlation: CloudTrail shows who made the `PutBucketPublicAccessBlock` call, Config shows the current state. Drift Detection directly answers "was this changed outside CloudFormation."
- **C**: CloudWatch logs don't track resource configuration states.
- **D**: Systems Manager Inventory tracks software inventory on instances, not S3 bucket configurations.

**📖 Textbook ref**: §8  → CloudFormation, "Drift Detection: Detect when resources changed outside CloudFormation"

---

> **📊 Chapter 8 Summary**: 5 Knowledge + 6 Scenario + 3 Comparison = 14 questions
> 
> **Next**: If you missed any questions, review the corresponding section in `AWS-SAP-C02-Learning-Material.md` and add the Q number to your missed question tracker.
