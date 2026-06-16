---
chapter: "2. Containers"
totalQuestions: 10
tiers:
  knowledge: 3
  scenario: 4
  comparison: 3
basedOn: "AWS-SAP-C02-Learning-Material.md §2"
services:
  - ECS
  - EKS
  - ECR
  - Fargate
---

# Chapter 2 Practice: 📦 Containers

> **Instructions**: Complete Part A first. Do not scroll past the divider. Once finished, check Part B for answers.
> **Textbook**: `AWS-SAP-C02-Learning-Material.md`  → Section 2 (ECS, EKS, ECR, Fargate) + Similar Service Comparison: Containers

---

# Part A  → Questions

## 🟢 Knowledge Check (3 questions)

### Q2.1

> 🟡 L2-理解 | 🎤🎤 中频面试
> 🟢 L1-֪ʶ | 🎤🎤 →Ƶ→→

What is Amazon ECS on Fargate's key value proposition compared to ECS on EC2?

- A. Lower cost per task for steady-state workloads
- B. No EC2 instances to manage  → serverless container deployment
- C. Support for GPU-based container workloads
- D. Higher network throughput per task

### Q2.2

> 🟡 L2-理解 | 🎤🎤 中频面试
> 🟢 L1-֪ʶ | 🎤🎤 →Ƶ→→

A solutions architect needs to store and scan Docker images for Common Vulnerabilities and Exposures (CVEs) before deploying to ECS. Which AWS service provides this?

- A. Amazon S3 with a virus scanning Lambda
- B. Amazon ECR with Enhanced Scanning
- C. AWS Artifact
- D. AWS Security Hub

### Q2.3

> 🟡 L2-理解 | 🎤🎤 中频面试
> 🟢 L1-֪ʶ | 🎤🎤 →Ƶ→→

Which statement about EKS on Fargate is correct?

- A. EKS on Fargate requires you to manage EC2 worker nodes for the Kubernetes data plane
- B. EKS on Fargate runs Kubernetes pods on serverless compute, with no node management
- C. EKS on Fargate only supports stateless applications
- D. EKS on Fargate cannot integrate with AWS Load Balancers

---

## 🟡 Scenario Analysis (4 questions)

### Q2.4

> 🟡 L2-理解 | 🎤🎤 中频面试
> 🟡 L2-→→ | 🎤🎤 →Ƶ→→

A company runs a containerized microservice that must install a host-level security agent for compliance. The agent requires kernel module access and root privileges on the host OS. The service itself runs 24/7 with steady traffic.

Which ECS launch type should be used?

- A. ECS on Fargate
- B. ECS on EC2
- C. ECS Anywhere
- D. ECS with AWS Outposts

### Q2.5

> 🟡 L2-理解 | 🎤🎤 中频面试
> 🟡 L2-→→ | 🎤🎤 →Ƶ→→

A development team wants to deploy containerized applications without managing any servers. The workload has variable traffic patterns, with each request taking 2-10 minutes to process. The team wants the simplest possible configuration.

Which compute option should be used?

- A. ECS on EC2 with Auto Scaling
- B. ECS on Fargate with Service Auto Scaling
- C. AWS Lambda with container images
- D. Amazon EKS on Fargate

### Q2.6

> 🟡 L2-理解 | 🎤🎤 中频面试
> 🟡 L2-→→ | 🎤🎤 →Ƶ→→

A company has existing Kubernetes manifests, Helm charts, and CI/CD pipelines built around kubectl. They want to migrate to AWS but keep using their Kubernetes toolchain. Which service minimizes changes to their existing workflows?

- A. Amazon ECS
- B. Amazon EKS
- C. AWS Elastic Beanstalk (Docker platform)
- D. Amazon ECR with AWS CodeDeploy

### Q2.7

> 🟡 L2-理解 | 🎤🎤 中频面试
> 🟢 L1-֪ʶ | 🎤🎤 →Ƶ→→

A solutions architect deploys a Lambda function using a 3 GB Docker image. The image is stored in ECR. The function processes S3 upload events and each invocation runs for about 8 seconds. Which statement about this architecture is correct?

- A. This architecture is invalid  → Lambda cannot use container images
- B. This architecture is valid  → Lambda supports container images up to 10 GB from ECR
- C. This architecture is valid only if the Lambda function runs in a VPC
- D. This architecture requires ECS to orchestrate the Lambda invocations

---

## 🔴 Similar Service Comparison (3 questions)

### Q2.8

> 🟡 L2-理解 | 🎤🎤 中频面试
> 🔴 L3-Ӧ→ | 🎤🎤🎤 →Ƶ→→

A company must choose between ECS and EKS for a new microservices platform. The team has no Kubernetes experience and values operational simplicity above portability. Which should they choose?

- A. ECS  → AWS-native, lower complexity, no Kubernetes knowledge needed
- B. EKS  → more portable across clouds, standard Kubernetes API
- C. EKS on Fargate  → serverless Kubernetes, best of both worlds
- D. Self-managed Kubernetes on EC2  → maximum control

### Q2.9

> 🟡 L2-理解 | 🎤🎤 中频面试
> 🔴 L3-Ӧ→ | 🎤🎤🎤 →Ƶ→→

A solutions architect is choosing between Lambda (with container images) and ECS on Fargate for a workload that processes video uploads. Processing takes 30 minutes per video. Which is the correct choice and why?

- A. Lambda  → serverless, no infrastructure management, handles 30-minute tasks
- B. ECS on Fargate  → Lambda has a 15-minute timeout; 30-minute tasks require ECS/Fargate
- C. Lambda with container images  → container support removes the timeout limit
- D. ECS on EC2  → Fargate also has a 15-minute timeout

### Q2.10

> 🟡 L2-理解 | 🎤🎤 中频面试
> 🔴 L3-Ӧ→ | 🎤🎤🎤 →Ƶ→→

A company deploys a critical production API on ECS behind an ALB. The API must survive an Availability Zone failure without manual intervention. The cluster runs on EC2.

Which configuration ensures high availability?

- A. Deploy the ECS service in a single AZ with an Auto Scaling group that replaces failed instances
- B. Distribute ECS tasks across multiple AZs using the `distinctInstance` task placement constraint and an ASG spanning multiple AZs
- C. Use Fargate instead of EC2 for automatic multi-AZ deployment
- D. Enable ECS Service Auto Scaling with target tracking on CPU utilization

---

# Part B  → Answers & Explanations

> ⚠️ **STOP HERE.** Complete all questions in Part A before reading below.

---

## 🟢 Knowledge Check  → Answers

### A2.1
**Correct: B**  → No EC2 instances to manage  → serverless container deployment.

**Why**: Fargate is the serverless compute engine for containers. You define the task (CPU, memory, container image) and Fargate runs it  → no EC2 instances to provision, patch, or scale. This is the core value proposition: operational simplicity. You pay per task and per vCPU/GB used.

**Why not the others**:
- **A**: Fargate is typically more expensive per task than running on well-utilized EC2 instances (you pay a premium for serverless).
- **C**: GPU support is available on EC2 launch type, not a Fargate differentiator.
- **D**: Network throughput is similar; it's not a differentiating factor.

**📖 Textbook ref**: §2  → ECS, "ECS + Fargate: No EC2 management needed"

---

### A2.2
**Correct: B**  → Amazon ECR with Enhanced Scanning.

**Why**: ECR provides two scanning options: Basic scanning (on-push, free) and Enhanced scanning (continuous, powered by Amazon Inspector). Enhanced scanning continuously monitors images for CVEs and provides detailed findings with severity ratings and remediation guidance. This is the native AWS solution for container image vulnerability scanning.

**Why not the others**:
- **A**: Custom S3 + Lambda scanning is self-managed and not integrated with ECS deployment workflows.
- **C**: AWS Artifact provides compliance reports (SOC, PCI), not container vulnerability scanning.
- **D**: Security Hub aggregates security findings from other services but doesn't scan container images itself.

**📖 Textbook ref**: §2  → ECR, "Image Scanning: Enhanced scanning with Amazon Inspector"

---

### A2.3
**Correct: B**  → EKS on Fargate runs Kubernetes pods on serverless compute, with no node management.

**Why**: When you use EKS with Fargate, each Kubernetes pod runs on its own Fargate compute  → there are no EC2 worker nodes to manage. You still use the standard EKS control plane (managed by AWS), but the data plane is fully serverless. You interact with your cluster using standard Kubernetes tools (kubectl, Helm).

**Why not the others**:
- **A**: This describes EKS on EC2, not Fargate.
- **C**: Fargate supports both stateless and stateful applications (with EFS for persistent storage).
- **D**: EKS on Fargate fully integrates with AWS Load Balancers via the AWS Load Balancer Controller.

**📖 Textbook ref**: §2  → EKS, "EKS on Fargate: Serverless pods  → no node management"

---

## 🟡 Scenario Analysis  → Answers

### A2.4
**Correct: B**  → ECS on EC2.

**Why**: The security agent requires kernel module access and root on the host OS. Fargate is serverless  → you have NO access to the underlying host. Only ECS on EC2 gives you control over the EC2 host operating system, allowing you to install kernel modules, security agents, and other host-level software while still using ECS for container orchestration.

**Why not the others**:
- **A**: Fargate provides no host access  → you cannot install kernel modules.
- **C**: ECS Anywhere extends ECS to on-prem servers but doesn't change the host access model.
- **D**: Outposts provides on-prem AWS infrastructure but still uses Fargate or EC2 launch types.

**📖 Textbook ref**: §2  → ECS + EC2, "You manage the cluster, more control"; §1  → Similar Service Comparison, "OS/kernel control" row

---

### A2.5
**Correct: B**  → ECS on Fargate with Service Auto Scaling.

**Why**: The scenarios fit Fargate: no server management, variable traffic, and task durations of 2 → 0 minutes. Fargate with Service Auto Scaling handles the scaling automatically (scale out when traffic increases, scale in when it drops). Tasks can run for any duration on Fargate (no 15-minute limit like Lambda). This is simpler than ECS on EC2 (no EC2 management) and simpler than EKS (no Kubernetes complexity).

**Why not the others**:
- **A**: ECS on EC2 requires managing EC2 instances  → "simplest possible configuration" points to Fargate.
- **C**: Lambda has a 15-minute max timeout  → 10-minute tasks are within limit, but Fargate is better for consistently long-running services (2-10 min each).
- **D**: EKS on Fargate introduces Kubernetes complexity that's unnecessary.

**📖 Textbook ref**: §1  → Similar Service Comparison, "Lambda vs ECS vs Fargate vs EC2"

---

### A2.6
**Correct: B**  → Amazon EKS.

**Why**: EKS is a managed Kubernetes control plane that is compatible with standard Kubernetes tooling  → kubectl, Helm, existing manifests, and CI/CD pipelines that use kubectl commands work with EKS with minimal changes (primarily updating the kubeconfig to point to the EKS cluster endpoint). This is the primary reason organizations choose EKS over ECS: they already have Kubernetes investments.

**Why not the others**:
- **A**: ECS uses its own API and orchestration model  → manifests and kubectl workflows don't transfer.
- **C**: Elastic Beanstalk doesn't use standard Kubernetes tooling.
- **D**: ECR is just the registry; CodeDeploy for ECS doesn't use kubectl.

**📖 Textbook ref**: §2  → EKS, "Azure Bridge: existing K8s investment"; Similar Service Comparison, "Existing investment" row

---

### A2.7
**Correct: B**  → This architecture is valid  → Lambda supports container images up to 10 GB from ECR.

**Why**: AWS Lambda supports container images up to 10 GB stored in ECR. The function processes S3 events (trigger valid), runs for 8 seconds (within 15-min timeout), and uses a 3 GB image (under 10 GB limit). This is a fully valid, supported architecture. Container image support in Lambda is specifically designed for this use case.

**Why not the others**:
- **A**: Lambda has supported container images since December 2020.
- **C**: Lambda can use container images with or without VPC  → VPC is not required.
- **D**: Lambda invocations are managed by Lambda, not ECS.

**📖 Textbook ref**: §1  → Lambda, "Docker/Lambda: Container images up to 10 GB in ECR"

---

## 🔴 Similar Service Comparison  → Answers

### A2.8
**Correct: A**  → ECS  → AWS-native, lower complexity, no Kubernetes knowledge needed.

**Why**: ECS is simpler: no Kubernetes concepts to learn (pods, deployments, services, ingress controllers), no cluster API to manage (just task definitions and services), and deep AWS integration. For a team with no Kubernetes experience who doesn't need multi-cloud portability, ECS provides the fastest time-to-value with the lowest operational burden.

**Why not the others**:
- **B**: EKS adds Kubernetes complexity that this team doesn't need and hasn't asked for.
- **C**: EKS on Fargate doesn't eliminate Kubernetes complexity  → you still need to understand and manage Kubernetes constructs.
- **D**: Self-managed Kubernetes maximizes complexity  → opposite of the team's goals.

**📖 Textbook ref**: §2  → Similar Service Comparison, "ECS vs EKS"

---

### A2.9
**Correct: B**  → ECS on Fargate  → Lambda has a 15-minute timeout; 30-minute tasks require ECS/Fargate.

**Why**: This is a straightforward timeout comparison. Lambda max timeout = 15 minutes. Video processing = 30 minutes per task. Lambda is categorically not an option. ECS on Fargate has no task duration limit  → tasks can run indefinitely. This is the correct choice for long-running workloads.

**Why not the others**:
- **A**: Lambda cannot run 30 minutes  → this is factually wrong.
- **C**: Container image support does not change the 15-minute timeout limit.
- **D**: Fargate has no timeout limit for tasks  → this statement is false.

**📖 Textbook ref**: §1  → Similar Service Comparison, "Max runtime" row

---

### A2.10
**Correct: B**  → Distribute ECS tasks across multiple AZs with distinctInstance placement and a multi-AZ ASG.

**Why**: For ECS on EC2 with multi-AZ HA: (1) the ASG must span multiple AZs to provide EC2 capacity in each AZ. (2) The ECS service should use a task placement strategy like `distinctInstance` or spread across AZs to ensure tasks are distributed. (3) The ALB distributes traffic across tasks in all AZs automatically.

**Why not the others**:
- **A**: Single AZ = no AZ failure resilience.
- **C**: Fargate also requires configuring multi-AZ (subnets in multiple AZs)  → it's not automatically multi-AZ.
- **D**: Service Auto Scaling handles load-based scaling, not AZ failure resilience.

**📖 Textbook ref**: §2  → ECS, "ECS + EC2: placement constraints/strategies"; §5  → ALB

---

> **📊 Chapter 2 Summary**: 3 Knowledge + 4 Scenario + 3 Comparison = 10 questions
> 
> **Next**: If you missed any questions, review the corresponding section in `AWS-SAP-C02-Learning-Material.md` and add the Q number to your missed question tracker.
