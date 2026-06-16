---
chapter: "12. Developer Tools"
totalQuestions: 7
tiers:
  knowledge: 2
  scenario: 3
  comparison: 2
basedOn: "AWS-SAP-C02-Learning-Material.md §12"
services:
  - CodeDeploy
  - CodePipeline
  - CodeBuild
  - CodeCommit
---

# Chapter 12 Practice: 🛠 → Developer Tools  → Your Expertise Zone!

> **Instructions**: Complete Part A first. Do not scroll past the divider. Once finished, check Part B for answers.
> **Textbook**: `AWS-SAP-C02-Learning-Material.md`  → Section 12 (CodeDeploy, CodePipeline, CodeBuild, CodeCommit) + Similar Service Comparison: CI/CD

---

# Part A  → Questions

## 🟢 Knowledge Check (2 questions)

### Q12.1

> 🟡 L2-理解 | 🎤🎤 中频面试
A deployment to EC2 must shift traffic incrementally  → 10% of traffic first, then monitor for 10 minutes, then 100%. If CloudWatch alarms trigger during the test, the deployment must automatically roll back. Which CodeDeploy deployment type should be used?

- A. Blue/Green deployment
- B. Canary deployment (linear traffic shifting)
- C. In-place (rolling) deployment
- D. All-at-once deployment

### Q12.2

> 🟡 L2-理解 | 🎤🎤 中频面试
What file defines the build commands, artifact outputs, and cache settings for AWS CodeBuild?

- A. appspec.yml
- B. buildspec.yml
- C. codepipeline.yml
- D. Dockerfile

---

## 🟡 Scenario Analysis (3 questions)

### Q12.3

> 🟡 L2-理解 | 🎤🎤 中频面试
A company wants a fully automated CI/CD pipeline: when code is pushed to CodeCommit, CodeBuild should run tests and build a Docker image, push it to ECR, then CodeDeploy should deploy the new image to ECS on Fargate using a blue/green deployment strategy.

Which service orchestrates this entire workflow?

- A. AWS CodeBuild with multiple build phases
- B. AWS CodeDeploy with deployment hooks
- C. AWS CodePipeline
- D. Amazon EventBridge with multiple targets

### Q12.4

> 🟡 L2-理解 | 🎤🎤 中频面试
A deployment validation test takes 5 minutes and must run AFTER the new application version is installed but BEFORE traffic is shifted to the new instances. In CodeDeploy's appspec.yml, which lifecycle hook should run this test?

- A. BeforeInstall
- B. AfterInstall
- C. ApplicationStart
- D. ValidateService

### Q12.5

> 🟡 L2-理解 | 🎤🎤 中频面试
A company's application is deployed via CodeDeploy using an in-place deployment strategy to an Auto Scaling group. During deployment, if any instance fails to deploy the new version, the entire deployment must be stopped and rolled back. The deployment should also stop if CloudWatch alarms are triggered.

Which CodeDeploy configuration provides this? (Choose two.)

- A. Set the deployment rollback configuration to roll back on deployment failure
- B. Add CloudWatch alarm monitoring to the deployment group and configure rollback on alarm
- C. Use CodePipeline to wrap the CodeDeploy action with a manual approval step
- D. Enable automatic rollback in the Auto Scaling group launch template

---

## 🔴 Similar Service Comparison (2 questions)

### Q12.6

> 🟡 L2-理解 | 🎤🎤 中频面试
A company uses three distinct AWS developer tools. Match each tool to its purpose:
- Tool X: Compiles code, runs unit tests, produces a deployable artifact
- Tool Y: Orchestrates the flow from source  → build  → staging  → production
- Tool Z: Manages the deployment strategy (blue/green, canary) to compute resources

Which mapping is correct?

- A. X=CodePipeline, Y=CodeBuild, Z=CodeDeploy
- B. X=CodeBuild, Y=CodePipeline, Z=CodeDeploy
- C. X=CodeDeploy, Y=CodePipeline, Z=CodeBuild
- D. X=CodeBuild, Y=CodeDeploy, Z=CodePipeline

### Q12.7

> 🟡 L2-理解 | 🎤🎤 中频面试
An Azure DevOps engineer (you!) is learning AWS CI/CD. You use Azure Pipelines for end-to-end CI/CD  → source control, build, and release management in one YAML pipeline. In AWS, which single service is the closest equivalent to the entire Azure Pipelines workflow?

- A. AWS CodeBuild
- B. AWS CodeDeploy
- C. AWS CodePipeline
- D. AWS CodeCommit + CodeBuild + CodeDeploy combined

---

# Part B  → Answers & Explanations

> ⚠️ **STOP HERE.** Complete all questions in Part A before reading below.

---

## 🟢 Knowledge Check  → Answers

### A12.1
**Correct: B**  → Canary deployment (linear traffic shifting).

**Why**: CodeDeploy canary deployments shift traffic incrementally in defined percentages (e.g., 10%, then 100%) with a bake time between each increment. If CloudWatch alarms trigger at any point, CodeDeploy automatically rolls back the deployment. This is the exact pattern described in the scenario.

**Why not the others**: Blue/Green replaces the entire fleet at once. In-place updates instances progressively but doesn't do incremental traffic shifting with bake times.

**📖 Textbook ref**: §12  → CodeDeploy, "Canary Deployments: Shift traffic incrementally with auto rollback"

---

### A12.2
**Correct: B**  → buildspec.yml.

**Why**: buildspec.yml is the CodeBuild configuration file. It defines the build phases (install, pre_build, build, post_build), artifacts to output, and cache settings for speeding up subsequent builds. appspec.yml is for CodeDeploy, not CodeBuild.

**📖 Textbook ref**: §12  → CodeBuild, "buildspec.yml"

---

## 🟡 Scenario Analysis  → Answers

### A12.3
**Correct: C**  → AWS CodePipeline.

**Why**: CodePipeline is the CI/CD orchestrator  → it coordinates the entire flow: source stage (CodeCommit)  → build stage (CodeBuild, including Docker build + ECR push)  → deploy stage (CodeDeploy, blue/green to ECS). CodePipeline manages the transitions, passes artifacts between stages, and handles pipeline-level triggers.

**📖 Textbook ref**: §12  → CodePipeline, "CI/CD orchestration"; §12  → Similar Service Comparison table

---

### A12.4
**Correct: D**  → ValidateService.

**Why**: The ValidateService hook runs AFTER the application has started successfully but BEFORE traffic is routed to the new instances. It's designed specifically for running validation tests before declaring the deployment successful. If the validation fails, the deployment is marked as failed and can be configured to roll back.

**Why not the others**: BeforeInstall runs before the old app is stopped. AfterInstall runs after the new app is installed but before it starts. ApplicationStart runs when the app starts.

**📖 Textbook ref**: §12  → CodeDeploy, "Deployment Hooks"

---

### A12.5
**Correct: A and B**  → Rollback on deployment failure + CloudWatch alarm monitoring.

**Why**: CodeDeploy supports two rollback triggers: (A) If any instance fails deployment, CodeDeploy can automatically stop and roll back. (B) You can associate CloudWatch alarms with the deployment group  → if an alarm triggers (e.g., high error rate), CodeDeploy rolls back. Both are configured in the deployment group settings.

**📖 Textbook ref**: §12  → CodeDeploy, "Canary Deployments: automatic rollback on alarm"

---

## 🔴 Similar Service Comparison  → Answers

### A12.6
**Correct: B**  → X=CodeBuild, Y=CodePipeline, Z=CodeDeploy.

**Why**: CodeBuild = build/test/package (compile + artifact). CodePipeline = orchestration (source  → build  → test  → deploy flow). CodeDeploy = deployment strategy (blue/green, canary, rolling to EC2/Lambda/ECS).

**📖 Textbook ref**: §12  → Similar Service Comparison table

---

### A12.7
**Correct: C**  → AWS CodePipeline.

**Why**: CodePipeline is conceptually the closest single service to the entire Azure Pipelines workflow  → it orchestrates source, build, and deploy stages. However, the more precise answer is that CodePipeline + CodeBuild + CodeDeploy together = one Azure Pipeline. But given the choice of a "single service," CodePipeline is the orchestrator, analogous to how Azure Pipelines orchestrates the entire CI/CD flow.

**📖 Textbook ref**: §12  → CodePipeline, "Your core expertise!"

---

> **📊 Chapter 12 Summary**: 2 Knowledge + 3 Scenario + 2 Comparison = 7 questions
