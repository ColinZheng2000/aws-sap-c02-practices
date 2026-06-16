---
chapter: "11. Machine Learning"
totalQuestions: 5
tiers:
  knowledge: 2
  scenario: 2
  comparison: 1
basedOn: "AWS-SAP-C02-Learning-Material.md §11"
services:
  - SageMaker
  - IoT Greengrass
  - Monitron
---

# Chapter 11 Practice: 🤖 Machine Learning

> **Instructions**: Complete Part A first. Do not scroll past the divider. Once finished, check Part B for answers.
> **Textbook**: `AWS-SAP-C02-Learning-Material.md`  → Section 11 (SageMaker, IoT Greengrass, Monitron)

---

# Part A  → Questions

## 🟢 Knowledge Check (2 questions)

### Q11.1

> 🟡 L2-理解 | 🎤🎤 中频面试
A company wants to deploy ML models trained in the cloud to IoT devices for local inference at the edge, even when internet connectivity is unavailable. Which services should be used together?

- A. SageMaker + IoT Greengrass
- B. SageMaker + Lambda@Edge
- C. Monitron + CloudFront
- D. SageMaker + Kinesis Video Streams

### Q11.2

> 🟡 L2-理解 | 🎤🎤 中频面试
A manufacturing plant needs to monitor rotating equipment (motors, pumps, fans) for abnormal vibration and temperature patterns to predict failures before they occur. The plant has no ML expertise. Which AWS service is purpose-built for this?

- A. Amazon SageMaker with custom anomaly detection models
- B. Amazon Monitron
- C. Amazon Kinesis Data Analytics with ML algorithms
- D. AWS IoT Core with custom Lambda analytics

---

## 🟡 Scenario Analysis (2 questions)

### Q11.3

> 🟡 L2-理解 | 🎤🎤 中频面试
An oil drilling platform operates in a remote location with satellite internet that is slow and frequently disconnected. The platform generates video feeds that need ML-based object detection for safety monitoring. The ML model must run locally and only send alerts (not full video) when connectivity is available.

Which combination of services should be used?

- A. SageMaker to train the model + IoT Greengrass to run inference locally on a Snowball Edge device
- B. SageMaker + Lambda@Edge at the nearest CloudFront edge location
- C. SageMaker real-time endpoint accessed over the satellite connection
- D. Monitron sensors placed on cameras for vibration-based detection

### Q11.4

> 🟡 L2-理解 | 🎤🎤 中频面试
A research team wants to train a custom computer vision model using 100,000 labeled images stored in S3. The team needs managed infrastructure for distributed training with GPU instances. After training, the model must be deployed as a real-time API endpoint with auto-scaling.

Which service provides the complete ML platform for this workflow?

- A. Amazon EC2 GPU instances + custom training scripts + Elastic Load Balancing
- B. Amazon SageMaker (Training Jobs + Model Hosting with auto-scaling)
- C. AWS Lambda with container images for both training and inference
- D. Amazon EMR with Spark MLlib for training + API Gateway for inference

---

## 🔴 Similar Service Comparison (1 question)

### Q11.5

> 🟡 L2-理解 | 🎤🎤 中频面试
A factory has two different use cases:
- Use Case A: Generic predictive maintenance for standard rotating equipment (pumps, motors) with no ML team available
- Use Case B: Custom quality inspection model using computer vision, with a data science team building custom models

Which AWS services should be used for each use case respectively?

- A. Monitron for A; SageMaker for B
- B. SageMaker for both
- C. IoT Greengrass for A; SageMaker for B
- D. Monitron for A; IoT Greengrass for B

---

# Part B  → Answers & Explanations

> ⚠️ **STOP HERE.** Complete all questions in Part A before reading below.

---

## 🟢 Knowledge Check  → Answers

### A11.1
**Correct: A**  → SageMaker + IoT Greengrass.

**Why**: SageMaker trains the model in the cloud. SageMaker Neo can optimize the model for edge hardware. IoT Greengrass deploys the model to edge devices and runs inference locally  → no cloud round-trip needed. Greengrass devices continue operating even when offline, syncing results when connectivity returns.

**📖 Textbook ref**: §11  → SageMaker, "Deploy trained models to IoT Greengrass devices for edge inference"

---

### A11.2
**Correct: B**  → Amazon Monitron.

**Why**: Monitron is a purpose-built, end-to-end predictive maintenance system. It includes pre-calibrated sensors (vibration + temperature), a gateway device, and cloud service with pre-trained ML models for rotating equipment. No ML expertise required  → install sensors, connect gateway, receive alerts. It ships with models specifically trained for motors, pumps, and fans.

**📖 Textbook ref**: §11  → Monitron, "Purpose-Built: Ships with pre-trained models for rotating equipment"

---

## 🟡 Scenario Analysis  → Answers

### A11.3
**Correct: A**  → SageMaker training + IoT Greengrass local inference on Snowball Edge.

**Why**: SageMaker trains the object detection model. Snowball Edge provides local compute (EC2 + Lambda) in the disconnected remote environment. IoT Greengrass runs on Snowball Edge and manages the ML model deployment and inference. Video is processed locally  → only alert metadata is transmitted when satellite is available. This is the edge ML pattern for disconnected environments.

**📖 Textbook ref**: §11  → SageMaker, "Offline Inference: Snowball Edge for ML"; §13  → Snowball Edge, "Disconnected Operation"

---

### A11.4
**Correct: B**  → Amazon SageMaker (Training Jobs + Model Hosting).

**Why**: SageMaker provides the complete ML platform: (1) Training Jobs with managed GPU instances (choose instance type, distributed training across multiple instances), (2) automatic hyperparameter tuning, (3) Model Registry for versioning, (4) Real-time endpoints with auto-scaling for inference. Everything is managed  → no infrastructure to set up beyond choosing instance types.

**📖 Textbook ref**: §11  → SageMaker, "Fully managed ML platform"

---

## 🔴 Similar Service Comparison  → Answers

### A11.5
**Correct: A**  → Monitron for A; SageMaker for B.

**Why**: Monitron is turnkey  → pre-trained models, purpose-built sensors, no ML team needed. Perfect for generic rotating equipment monitoring. SageMaker is a flexible ML platform for custom models  → the data science team can build, train, and deploy their custom computer vision model. The key distinction: turnkey (Monitron) vs. custom (SageMaker).

**📖 Textbook ref**: §11  → Monitron vs SageMaker: "No ML Expertise Required" vs "ML knowledge needed"

---

> **📊 Chapter 11 Summary**: 2 Knowledge + 2 Scenario + 1 Comparison = 5 questions
