---
chapter: "13. End User Computing & Hybrid"
totalQuestions: 7
tiers:
  knowledge: 2
  scenario: 3
  comparison: 2
basedOn: "AWS-SAP-C02-Learning-Material.md §13"
services:
  - WorkSpaces
  - AppStream 2.0
  - Outposts
  - Snowball Edge
---

# Chapter 13 Practice: 🖥 → End User Computing & Hybrid

> **Instructions**: Complete Part A first. Do not scroll past the divider. Once finished, check Part B for answers.
> **Textbook**: `AWS-SAP-C02-Learning-Material.md`  → Section 13 (WorkSpaces, AppStream 2.0, Outposts, Snowball Edge Compute)

---

# Part A  → Questions

## 🟢 Knowledge Check (2 questions)

### Q13.1

> 🟡 L2-理解 | 🎤🎤 中频面试
A company wants to stream individual Windows applications (not full desktops) to contractors via a web browser. The contractors should not have access to a full desktop  → only specific apps. Which service should be used?

- A. Amazon WorkSpaces
- B. Amazon AppStream 2.0
- C. AWS Client VPN
- D. Amazon WorkSpaces Web

### Q13.2

> 🟡 L2-理解 | 🎤🎤 中频面试
What is AWS Outposts?

- A. A portable edge device for temporary remote computing
- B. A fully managed AWS infrastructure rack installed in your on-premises data center
- C. A virtual desktop service for remote workers
- D. A content delivery network for cached content

---

## 🟡 Scenario Analysis (3 questions)

### Q13.3

> 🟡 L2-理解 | 🎤🎤 中频面试
A hospital needs to run a low-latency medical imaging application on-premises due to data residency regulations. The application is already running on AWS in the cloud and uses EC2, EBS, and RDS. The hospital wants the same API and management experience as the cloud but with data staying on-premises.

Which service should be used?

- A. AWS Snowball Edge
- B. AWS Outposts
- C. AWS Storage Gateway
- D. AWS Local Zones

### Q13.4

> 🟡 L2-理解 | 🎤🎤 中频面试
A company provides virtual Windows desktops to 500 employees via WorkSpaces. Employees need to log in to any WorkSpace and access their full profile (documents, application settings). The profile data must be stored on a shared, high-performance Windows file system.

Which storage solution should be used for the user profiles?

- A. Amazon S3 with S3 Sync on each WorkSpace
- B. Amazon EBS volumes attached to each WorkSpace
- C. Amazon FSx for Windows File Server with FSLogix profile containers
- D. Amazon EFS mounted on each WorkSpace

### Q13.5

> 🟡 L2-理解 | 🎤🎤 中频面试
A mining company operates in a remote location with no internet connectivity. They need to run EC2 instances and Lambda functions locally to process geological survey data. The results must be transferred to AWS S3 periodically when the device is returned to a connected location.

Which device should be used?

- A. AWS Outposts
- B. AWS Snowball Edge (Compute Optimized)
- C. AWS Storage Gateway
- D. AWS Direct Connect

---

## 🔴 Similar Service Comparison (2 questions)

### Q13.6

> 🔴 L3-应用 | 🎤🎤🎤 高频面试
Compare AppStream 2.0 and WorkSpaces: An organization needs to provide temporary training lab access  → each user needs a full Windows desktop for 3 hours, and the desktops should be clean (no persistent data) between sessions. Which service is the better fit?

- A. WorkSpaces  → it provides persistent desktops
- B. AppStream 2.0  → it streams individual apps, not full desktops
- C. WorkSpaces  → it can be configured as non-persistent
- D. AppStream 2.0  → it is designed for streaming individual applications

### Q13.7

> 🔴 L3-应用 | 🎤🎤🎤 高频面试
Compare Outposts and Snowball Edge: A manufacturing company needs a permanent on-premises infrastructure solution that supports the same AWS services (EC2, EBS, RDS, ECS) as their cloud environment. They have a standard data center with power and cooling. Which should they choose and why?

- A. Snowball Edge  → it's portable and supports EC2 and Lambda
- B. Outposts  → it provides a permanent 42U rack with a broad set of AWS services identical to the cloud
- C. Snowball Edge  → it's more cost-effective for permanent installations
- D. Outposts  → it's portable and can be moved between locations

---

# Part B  → Answers & Explanations

> ⚠️ **STOP HERE.** Complete all questions in Part A before reading below.

---

## 🟢 Knowledge Check  → Answers

### A13.1
**Correct: B**  → Amazon AppStream 2.0.

**Why**: AppStream 2.0 is designed for streaming individual Windows applications to users via a web browser. Apps run on AWS but appear as if they're running locally in the user's browser. Unlike WorkSpaces (which provides full desktops), AppStream streams only the specified applications.

**📖 Textbook ref**: §13  → AppStream 2.0, "Application streaming  → stream Windows applications to any device via browser"

---

### A13.2
**Correct: B**  → A fully managed AWS infrastructure rack installed in your on-premises data center.

**Why**: Outposts is a 42U rack of AWS-managed hardware delivered and installed in your data center. It runs the same AWS services (EC2, EBS, ECS, EKS, RDS, S3) with the same APIs and management tools. AWS maintains the hardware, and you get consistent cloud-to-on-premises experience.

**📖 Textbook ref**: §13  → Outposts, "AWS-managed infrastructure running on-premises"

---

## 🟡 Scenario Analysis  → Answers

### A13.3
**Correct: B**  → AWS Outposts.

**Why**: Outposts meets all requirements: (1) on-premises data residency (data stays in the hospital's data center), (2) low latency (local compute), (3) same AWS services (EC2, EBS, RDS) with identical APIs and console experience. The hospital can run the same medical imaging application with no architecture changes.

**📖 Textbook ref**: §13  → Outposts, "Data Residency" and "Consistent Experience"

---

### A13.4
**Correct: C**  → Amazon FSx for Windows File Server with FSLogix profile containers.

**Why**: FSx for Windows is a managed Windows file server (SMB protocol) that integrates with Active Directory. FSLogix profile containers store user profiles (documents, settings, app data) as VHD/VHDX files on the file share. When a user logs into any WorkSpace, their profile is mounted from FSx  → enabling profile roaming. This is the native, recommended AWS architecture for WorkSpaces profile management.

**📖 Textbook ref**: §13  → WorkSpaces, "FSx for User Profiles"; §3  → FSx for Windows

---

### A13.5
**Correct: B**  → AWS Snowball Edge (Compute Optimized).

**Why**: Snowball Edge provides portable local compute (EC2 instances + Lambda functions) with 80 TB storage, and operates fully disconnected from the internet. The mining company processes data locally, and when the device is shipped back to AWS, data is ingested into S3. This is the disconnected-edge pattern that Snowball Edge is designed for.

**📖 Textbook ref**: §13  → Snowball Edge, "Disconnected Operation"

---

## 🔴 Similar Service Comparison  → Answers

### A13.6
**Correct: WorkSpaces is the better fit**  → but the reasoning requires nuance.

Both AppStream 2.0 and WorkSpaces can serve training labs. However: WorkSpaces is designed for full desktop experiences and is the standard choice when users need a complete Windows desktop. While WorkSpaces is persistent by default, you can configure it for training lab scenarios by using AutoStop mode (stops after idle timeout) and rebuilding/reprovisioning workspaces between training sessions. WorkSpaces supports both persistent and non-persistent configurations.

AppStream 2.0 can also stream full desktops, but its primary use case is individual application streaming. For a clear "full Windows desktop for 3 hours" requirement, WorkSpaces aligns more naturally. However, a strong argument can be made for AppStream 2.0 On-Demand fleets which are non-persistent by default, bill per hour, and support both app and desktop streaming modes.

**Key distinction for the exam**: WorkSpaces = full persistent VDI (monthly billing). AppStream 2.0 = app streaming or desktop streaming (hourly billing, non-persistent by default). For temporary, non-persistent desktop sessions billed per hour  → AppStream 2.0 On-Demand fleets are technically more cost-effective.

**📖 Textbook ref**: §13  → WorkSpaces vs AppStream comparison

---

### A13.7
**Correct: B**  → Outposts provides a permanent 42U rack with a broad set of AWS services identical to the cloud.

**Why**: Outposts is a permanent installation  → AWS delivers, installs, and maintains a 42U rack in your data center. It supports the broadest set of AWS services (EC2, EBS, ECS, EKS, RDS, S3). Snowball Edge is portable, smaller (80 TB), and has limited compute  → it's designed for portable/remote/temporary use, not permanent data center installation.

**📖 Textbook ref**: §13  → Outposts vs Snowball Edge: "Outposts = permanent, Snowball Edge = portable"

---

> **📊 Chapter 13 Summary**: 2 Knowledge + 3 Scenario + 2 Comparison = 7 questions
