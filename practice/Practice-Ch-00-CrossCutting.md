---
chapter: "0. Cross-Cutting Concepts"
totalQuestions: 10
tiers:
  knowledge: 3
  scenario: 5
  comparison: 2
basedOn: "AWS-SAP-C02-Learning-Material.md — Cross-Cutting Concepts"
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

# Chapter 0 Practice: 🌐 Cross-Cutting Concepts

> **Instructions**: Complete Part A first. Do not scroll past the divider. Once finished, check Part B for answers.
> **Textbook**: `AWS-SAP-C02-Learning-Material.md` — Cross-Cutting Concepts (HA, DR, Cost Optimization, Security, Decoupling, Serverless, Multi-Account Governance, Deployment Strategies)

---

# Part A — Questions

## 🟢 Knowledge Check (3 questions)

### Q0.1
What is the difference between Recovery Point Objective (RPO) and Recovery Time Objective (RTO)?

- A. RPO is the maximum acceptable data loss measured in time; RTO is the maximum acceptable time to restore service
- B. RPO is the maximum time to restore service; RTO is the maximum acceptable data loss
- C. RPO measures compute recovery; RTO measures storage recovery
- D. RPO and RTO are the same metric with different names

### Q0.2
Which deployment strategy replaces the entire fleet at once and provides the fastest rollback by keeping the old environment running?

- A. Rolling deployment
- B. Canary deployment
- C. Blue/Green deployment
- D. All-at-Once deployment

### Q0.3
What is the core principle of decoupling in cloud architecture?

- A. Running all components on the same server for maximum performance
- B. Reducing dependencies between components so they can operate and scale independently
- C. Using a single database for all microservices
- D. Deploying all services in a single Availability Zone

---

## 🟡 Scenario Analysis (5 questions)

### Q0.4
A company's web application runs on EC2 instances in a single AZ behind an ALB. The database is RDS Multi-AZ. During an AZ failure affecting the EC2 instances, users experienced 10 minutes of downtime while Auto Scaling launched new instances in a different AZ and the ALB shifted traffic.

What change would have minimized the downtime to near-zero?

- A. Add RDS Read Replicas in a different AZ
- B. Deploy EC2 instances across multiple AZs with the ALB distributing across them
- C. Switch from ALB to NLB for faster failover
- D. Increase EC2 instance size for faster launch times

### Q0.5
A company's DR plan requires that the production database be replicated to a DR Region with less than 1 second of data loss (RPO ≈ 1 second) and recovery completed within 5 minutes (RTO < 5 minutes). The database must be able to serve read traffic in the DR Region during normal operations.

Which database feature meets these requirements?

- A. RDS Multi-AZ
- B. RDS Cross-Region Read Replica
- C. Aurora Global Database
- D. DynamoDB with DAX

### Q0.6
A solutions architect is designing a multi-account strategy for a company with 30 AWS accounts across development, testing, and production environments. The security team wants to prevent any account from creating resources outside approved Regions. What is the most efficient way to enforce this across all accounts?

- A. Configure IAM policies in each account to deny resource creation in unapproved Regions
- B. Attach an SCP to the root OU denying resource creation in unapproved Regions
- C. Use AWS Config rules in each account to detect and alert on non-compliant resources
- D. Create a CloudFormation template per account with Region restrictions

### Q0.7
A video processing startup has highly variable workloads — sometimes zero processing for hours, then thousands of 2-minute processing jobs submitted simultaneously. The startup has no dedicated operations team. Jobs can occasionally fail and be retried without business impact.

Which combination of cost optimization and compute strategies is optimal?

- A. Reserved EC2 instances provisioned for average load
- B. Spot EC2 instances with SQS for job queuing and Auto Scaling
- C. On-Demand EC2 instances with scheduled Auto Scaling
- D. Savings Plans with a mix of On-Demand and Spot

### Q0.8
A company's application consists of tightly coupled monolithic services. During peak traffic, a slowdown in the payment processing module causes the order placement module to also slow down, creating cascading failures across the entire application.

Which architectural pattern would prevent this cascading failure?

- A. Vertical scaling — increase the instance size for all modules
- B. Decoupling — introduce SQS between modules so each can process at its own pace
- C. Multi-AZ deployment — deploy each module across multiple AZs
- D. Auto Scaling — set aggressive scale-out policies for all modules

---

## 🔴 Similar Service Comparison (2 questions)

### Q0.9
Compare Pilot Light, Warm Standby, and Multi-Site Active/Active DR strategies. A company has an RPO of < 1 second and RTO of < 1 minute. The DR Region must handle production traffic during normal operations. Which strategy must be used?

- A. Pilot Light — core infrastructure running, minimal services
- B. Warm Standby — scaled-down but functional environment ready to scale up
- C. Multi-Site Active/Active — fully running in both Regions simultaneously
- D. Backup and Restore — periodic snapshots copied to DR Region

### Q0.10
A solutions architect must choose between a serverless and server-based architecture for a new application. The application needs to run continuously 24/7 with steady, predictable traffic. It requires custom OS-level monitoring agents and kernel tuning for network performance.

Which architecture should be chosen?

- A. Serverless (Lambda + API Gateway + DynamoDB) — lower operational overhead
- B. Server-based (EC2 + ALB + RDS) — serverless cannot meet kernel and OS-level requirements
- C. Hybrid — Lambda for compute, EC2 for monitoring agents only
- D. Serverless (Fargate + Aurora Serverless) — managed services meet all requirements

---

# Part B — Answers & Explanations

> ⚠️ **STOP HERE.** Complete all questions in Part A before reading below.

---

## 🟢 Knowledge Check — Answers

### A0.1
**Correct: A** — RPO = maximum acceptable data loss (time); RTO = maximum acceptable time to restore service.

**Why**: RPO answers "how much data can we afford to lose?" measured in time (e.g., 1 hour of data loss = RPO of 1 hour). RTO answers "how fast must we recover?" measured in time (e.g., recover within 4 hours = RTO of 4 hours). Lower RPO/RTO = more expensive DR solution.

**📖 Textbook ref**: Cross-Cutting Concepts — Disaster Recovery

---

### A0.2
**Correct: C** — Blue/Green deployment.

**Why**: Blue/Green creates a completely new (green) environment alongside the existing (blue) one. After validation, traffic is switched. If any issue occurs, switch traffic back to blue — instant rollback. This is the trade-off: fastest rollback, but requires double the capacity during deployment.

**📖 Textbook ref**: Cross-Cutting Concepts — Deployment Strategies; §1 — Elastic Beanstalk, "Blue/Green: Fastest rollback"

---

### A0.3
**Correct: B** — Reducing dependencies between components so they can operate and scale independently.

**Why**: Decoupling means components interact through asynchronous, buffered channels (queues, events) rather than direct synchronous calls. This prevents cascading failures and allows each component to scale independently based on its own load. SQS, SNS, and EventBridge are the primary decoupling services.

**📖 Textbook ref**: Cross-Cutting Concepts — Decoupling

---

## 🟡 Scenario Analysis — Answers

### A0.4
**Correct: B** — Deploy EC2 instances across multiple AZs.

**Why**: The root cause is single-AZ deployment of EC2 instances. When that AZ fails, all instances become unavailable, and the ALB has no healthy targets until new instances launch in another AZ. With instances in multiple AZs, the ALB automatically routes traffic away from the failed AZ to healthy instances in other AZs — downtime is the time to detect health check failure (seconds), not to launch new instances (minutes).

**📖 Textbook ref**: Cross-Cutting Concepts — High Availability; §5 — ALB

---

### A0.5
**Correct: C** — Aurora Global Database.

**Why**: Aurora Global Database provides cross-Region replication with < 1 second typical lag (RPO ≈ 1 sec). The secondary Region can be promoted to primary in < 1 minute (RTO < 1 min). Secondary Regions support read traffic during normal operations. This directly matches all three requirements: ~1s RPO, < 5 min RTO, read traffic in DR Region.

**📖 Textbook ref**: §4 — Aurora Global Database; Cross-Cutting Concepts — DR

---

### A0.6
**Correct: B** — Attach an SCP to the root OU denying resource creation in unapproved Regions.

**Why**: An SCP attached to the root OU applies to ALL accounts in the organization (via OU inheritance). One SCP can deny all actions in unapproved Regions for all services across all accounts. This is centrally managed, cannot be overridden by account administrators, and requires no per-account configuration.

**📖 Textbook ref**: §6 — SCP; Cross-Cutting Concepts — Multi-Account Governance

---

### A0.7
**Correct: B** — Spot EC2 instances with SQS for job queuing and Auto Scaling.

**Why**: The workload characteristics are ideal for Spot: variable, fault-tolerant, batch nature (video processing), no dedicated ops team (need automation). SQS queues decouple submission from processing, buffering thousands of jobs. Auto Scaling based on queue depth automatically scales EC2 Spot instances up and down. Cost is minimal since Spot is up to 90% cheaper than On-Demand.

**📖 Textbook ref**: §1 — Spot Instances; §7 — SQS + Auto Scaling; Cross-Cutting Concepts — Cost Optimization + Decoupling

---

### A0.8
**Correct: B** — Decoupling — introduce SQS between modules.

**Why**: The cascading failure is caused by tight coupling — synchronous dependencies mean one slow module blocks all others. Decoupling with SQS breaks the synchronous chain: each module reads from its input queue and writes to the next module's output queue. If payment processing slows down, its queue grows but order placement continues independently. This is the fundamental value of decoupling — independent failure domains.

**📖 Textbook ref**: Cross-Cutting Concepts — Decoupling; §7 — SQS

---

## 🔴 Similar Service Comparison — Answers

### A0.9
**Correct: C** — Multi-Site Active/Active.

**Why**: Only Active/Active meets RPO < 1 second (continuous synchronous or near-synchronous replication) and RTO < 1 minute (traffic already routed to DR Region). Pilot Light and Warm Standby involve "spinning up" resources — inherently slower. Active/Active also satisfies "handle production traffic during normal operations" — both Regions are live. This is the most expensive but most resilient strategy.

**📖 Textbook ref**: Cross-Cutting Concepts — DR strategies

---

### A0.10
**Correct: B** — Server-based (EC2 + ALB + RDS).

**Why**: Two requirements make serverless impossible: (1) custom OS-level monitoring agents — Lambda and Fargate provide no host OS access. (2) kernel tuning for network performance — requires EC2 host control. Serverless abstracts away the OS. Additionally, the 24/7 steady workload favors reserved/server-based pricing over per-request serverless pricing. EC2 provides full OS control and is cost-effective for steady-state workloads.

**📖 Textbook ref**: Cross-Cutting Concepts — Serverless "When NOT to use serverless"; §1 — Similar Service Comparison "OS/kernel control" row

---

> **📊 Chapter 0 Summary**: 3 Knowledge + 5 Scenario + 2 Comparison = 10 questions
