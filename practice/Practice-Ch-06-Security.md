---
chapter: "6. Security, Identity & Compliance"
totalQuestions: 18
tiers:
  knowledge: 6
  scenario: 8
  comparison: 4
basedOn: "AWS-SAP-C02-Learning-Material.md §6"
services:
  - IAM
  - Organizations
  - SCP
  - KMS
  - Secrets Manager
  - WAF
  - Shield
  - CloudTrail
  - AWS Config
  - ACM
  - Directory Service
  - Cognito
---

# Chapter 6 Practice: 🔐 Security, Identity & Compliance

> **Instructions**: Complete Part A first. Do not scroll past the divider. Once finished, check Part B for answers and explanations.
> **Textbook**: `AWS-SAP-C02-Learning-Material.md` �?Section 6 (IAM, Organizations & SCP, KMS, Secrets Manager, WAF & Shield, Other Security Services) + Similar Service Comparison: Security

---

# Part A �?Questions

## 🟢 Knowledge Check (7 questions)

### Q6.1

> 🟡 L2-理解 | 🎤🎤 中频面试
What is the IAM policy evaluation logic when multiple policies apply to a single request?

- A. Explicit ALLOW overrides explicit DENY
- B. Explicit DENY overrides explicit ALLOW, and explicit ALLOW overrides implicit DENY
- C. All policies are evaluated, and the most permissive wins
- D. The first matching policy rule determines the outcome

### Q6.2

> 🟡 L2-理解 | 🎤🎤 中频面试
A solutions architect needs to rotate RDS database credentials automatically every 30 days. The application must be updated with the new credentials without code changes. Which AWS service should be used?

- A. AWS Systems Manager Parameter Store (Standard tier)
- B. AWS Secrets Manager
- C. AWS KMS with automatic key rotation
- D. IAM database authentication

### Q6.3

> 🟡 L2-理解 | 🎤🎤 中频面试
Which AWS service provides a centralized audit log of every API call made in an AWS account, including who made the call, when, and from which IP address?

- A. Amazon CloudWatch Logs
- B. AWS Config
- C. AWS CloudTrail
- D. AWS Trusted Advisor

### Q6.4

> 🟡 L2-理解 | 🎤🎤 中频面试
A company wants to apply a security guardrail that prevents any IAM user in any member account from deleting CloudTrail trails, even if an account administrator grants that permission. Which AWS Organizations feature enforces this?

- A. IAM permissions boundary on every user
- B. Service Control Policy (SCP) attached to the OU or root
- C. AWS Config rule deployed to all accounts
- D. Resource-based policy on each CloudTrail trail

### Q6.5

> 🟡 L2-理解 | 🎤🎤 中频面试
Which AWS service tracks resource configuration changes over time and can evaluate resources against compliance rules?

- A. AWS CloudTrail
- B. AWS Config
- C. Amazon CloudWatch
- D. AWS Systems Manager Inventory

### Q6.6

> 🟡 L2-理解 | 🎤🎤 中频面试
A web application is protected by an Application Load Balancer. The security team wants to block requests that contain SQL injection patterns. Which service integrates with ALB for this purpose?

- A. AWS Shield Standard
- B. AWS WAF
- C. AWS Network Firewall
- D. AWS Security Hub

### Q6.7

> 🟡 L2-理解 | 🎤🎤 中频面试
A solutions architect needs to grant an IAM entity the maximum possible permissions while preventing privilege escalation �?even if a well-meaning administrator accidentally attaches an overly permissive policy. Which IAM feature provides this safeguard?

- A. IAM Access Analyzer
- B. Service Control Policy (SCP)
- C. Permissions Boundary
- D. IAM role with a trust policy

---

## 🟡 Scenario Analysis (8 questions)

### Q6.8

> 🟡 L2-理解 | 🎤🎤 中频面试
A company has a compliance requirement to audit S3 bucket access at the object level �?every GetObject and PutObject operation must be logged. The solution must not impact S3 performance.

How should the solutions architect configure this?

- A. Enable S3 server access logs for each bucket
- B. Create a CloudTrail trail with S3 data events enabled for the buckets
- C. Use Amazon CloudWatch Logs with an S3 log ingestion agent
- D. Enable AWS Config with an S3 bucket compliance rule

### Q6.9

> 🟡 L2-理解 | 🎤🎤 中频面试
A development team accidentally made an S3 bucket publicly accessible. The security team needs to detect such configuration changes automatically and receive immediate notification. Additionally, the solution should automatically revert the bucket to private if possible.

Which combination of services should be used? (Choose two.)

- A. AWS CloudTrail with a CloudWatch Logs metric filter
- B. AWS Config rule to detect public S3 buckets
- C. AWS CloudFormation drift detection
- D. AWS Systems Manager Automation runbook to fix the bucket policy
- E. Amazon EventBridge for notification only

### Q6.10

> 🟡 L2-理解 | 🎤🎤 中频面试
A company uses multiple AWS accounts managed through AWS Organizations. The Dev OU needs to allow all services except EC2 Spot Instances (to control costs). The Prod OU must allow all services. The root currently has the default FullAWSAccess SCP.

What is the minimal SCP configuration to implement this?

- A. Attach a deny SCP for Spot Instances to the root, and attach a separate allow SCP to Prod OU
- B. Attach a deny SCP for Spot Instances to the Dev OU only; leave root and Prod OU unchanged
- C. Remove FullAWSAccess from root; create allow SCPs for Prod and Dev separately
- D. Attach a deny SCP for Spot Instances to both Dev and Prod OUs

### Q6.11

> 🟡 L2-理解 | 🎤🎤 中频面试
An application running on EC2 needs to encrypt data before writing to S3. The encryption key must be managed by AWS but rotated annually. The application must not have access to the plaintext key material. Which key type and configuration should be used?

- A. AWS KMS symmetric key with automatic annual rotation enabled
- B. AWS KMS asymmetric key with manual rotation
- C. Server-side encryption with S3-managed keys (SSE-S3)
- D. Client-side encryption with a secret stored in Secrets Manager

### Q6.12

> 🟡 L2-理解 | 🎤🎤 中频面试
A company wants to provide Single Sign-On (SSO) to multiple AWS accounts and business applications (Salesforce, Office 365). The company has an existing on-premises Active Directory. Users should be automatically provisioned and deprovisioned in AWS when changes occur in AD.

Which solution should be implemented?

- A. IAM users with synchronized passwords from AD
- B. IAM Identity Center with AD Connector and SCIM provisioning
- C. Amazon Cognito user pool with SAML federation
- D. AWS Directory Service Simple AD with a trust to on-prem AD

### Q6.13

> 🟡 L2-理解 | 🎤🎤 中频面试
A company's security policy requires that all SSL/TLS certificates used on Application Load Balancers and CloudFront distributions be automatically renewed before expiration. The certificates must be provisioned at no additional cost beyond the load balancer and distribution charges.

Which service should be used?

- A. Purchase certificates from a third-party CA and import into IAM
- B. AWS Certificate Manager (ACM)
- C. Upload self-signed certificates and set calendar reminders for renewal
- D. AWS KMS with certificate generation capability

### Q6.14

> 🟡 L2-理解 | 🎤🎤 中频面试
A company must share an RDS database password with a Lambda function in another AWS account. The password must be automatically rotated, and the Lambda function must always retrieve the latest password without hardcoding credentials.

Which combination of services and configurations meets these requirements?

- A. Store the password in SSM Parameter Store (Standard); grant cross-account access via IAM role
- B. Store the password in Secrets Manager; configure rotation; share the secret via resource policy with the other account
- C. Encrypt the password with KMS; store the encrypted blob in S3; share S3 bucket
- D. Embed the password in the Lambda environment variable; use KMS to encrypt the variable

### Q6.15

> 🟡 L2-理解 | 🎤🎤 中频面试
A solutions architect must design a defense-in-depth security strategy for a public-facing web application. The strategy must include: (1) DDoS protection at the network edge, (2) SQL injection and XSS filtering at Layer 7, and (3) instance-level firewall rules that are stateful.

Which combination of services provides all three layers?

- A. AWS Shield Advanced + AWS WAF + Security Groups
- B. AWS Shield Standard + AWS WAF + Network ACLs
- C. AWS Shield Advanced + AWS Network Firewall + Security Groups
- D. AWS WAF + Security Groups + AWS Config rules

---

## 🔴 Similar Service Comparison (3 questions)

### Q6.16

> 🟡 L2-理解 | 🎤🎤 中频面试
A security team needs to track: (a) who terminated an EC2 instance and when, (b) what that instance's security group configuration looked like before termination, and (c) whether the termination caused the CPU utilization alarm to trigger.

Which three services are needed �?one for each requirement (a, b, c) respectively?

- A. AWS Config, CloudTrail, CloudWatch
- B. CloudTrail, AWS Config, CloudWatch
- C. CloudWatch, CloudTrail, AWS Config
- D. CloudTrail, CloudWatch, AWS Config

### Q6.17

> 🟡 L2-理解 | 🎤🎤 中频面试
An application needs to store two types of data: (1) database credentials that must be automatically rotated, and (2) application configuration values (feature flags, endpoint URLs) that rarely change and have no rotation requirement. The solution should minimize cost.

Which services should be used for each data type respectively?

- A. Secrets Manager for both
- B. Secrets Manager for credentials; SSM Parameter Store (Standard) for configuration
- C. SSM Parameter Store (Advanced) for both
- D. KMS for credentials; SSM Parameter Store for configuration

### Q6.18

> 🟡 L2-理解 | 🎤🎤 中频面试
A solutions architect is designing access controls for an organization with 50 accounts. The architect wants to understand the maximum possible permissions in an account by examining the least number of policies.

Which access control layer limits the maximum permissions for EVERY principal in an account, regardless of what IAM policies allow?

- A. IAM permissions boundary on each IAM entity
- B. Resource-based policies on each resource
- C. Service Control Policy (SCP) on the account's OU
- D. Session policy applied during role assumption

---

# Part B �?Answers & Explanations

> ⚠️ **STOP HERE.** Complete all questions in Part A before reading below.

---

## 🟢 Knowledge Check �?Answers

### A6.1
**Correct: B** �?Explicit DENY overrides explicit ALLOW, and explicit ALLOW overrides implicit DENY.

**Why**: IAM evaluates all applicable policies together. The evaluation logic: (1) Start with an implicit DENY (default �?no access). (2) If any policy contains an explicit ALLOW, that overrides the implicit deny. (3) If ANY policy (including SCP, permissions boundary, or session policy) contains an explicit DENY, the request is denied �?DENY always wins, even over explicit ALLOWs. This is the "deny-by-default, allow-explicitly, deny-always-wins" principle.

**Why not the others**:
- **A**: Reversed �?DENY overrides ALLOW, not the other way around.
- **C**: Not true �?explicit DENY always wins, not "most permissive."
- **D**: All policies are evaluated; there's no "first match."

**📖 Textbook ref**: §6 �?IAM, "Policy evaluation: explicit DENY > explicit ALLOW > implicit DENY"

---

### A6.2
**Correct: B** �?AWS Secrets Manager.

**Why**: Secrets Manager is purpose-built for secret rotation. For RDS, it can automatically rotate credentials using a Lambda function that generates a new password, updates both the RDS database and the Secrets Manager secret, and manages versioning. The application retrieves the latest secret via a simple API call �?no code changes needed when the password rotates.

**Why not the others**:
- **A**: Parameter Store (Standard) does not support automatic rotation �?you must rotate manually.
- **C**: KMS key rotation rotates the encryption key material, not database passwords.
- **D**: IAM DB Authentication provides password-less access (token-based) the avoids password management entirely �?a valid alternative but not "credential rotation" as asked.

**📖 Textbook ref**: §6 �?Secrets Manager, "Rotation: Built-in for RDS"

---

### A6.3
**Correct: C** �?AWS CloudTrail.

**Why**: CloudTrail records every API call (management events) in an AWS account �?including console sign-ins, CLI commands, SDK calls, and service-to-service calls. Each event includes who (IAM identity), what (API action), when (timestamp), source IP, and request parameters. Trails deliver logs to S3 and optionally CloudWatch Logs.

**Why not the others**:
- **A**: CloudWatch Logs stores application logs �?it doesn't automatically record API calls.
- **B**: AWS Config tracks resource configurations and compliance, not "who called which API."
- **D**: Trusted Advisor provides best practice recommendations, not API audit logs.

**📖 Textbook ref**: §6 �?Other Security Services, "CloudTrail: API audit log"; Similar Service Comparison, "AWS Config vs CloudTrail vs CloudWatch"

---

### A6.4
**Correct: B** �?Service Control Policy (SCP) attached to the OU or root.

**Why**: SCPs are guardrails at the organization level that limit the maximum permissions available to every IAM entity in an account. Even if an account administrator attaches an AdministratorAccess policy to a user, an SCP that denies `cloudtrail:DeleteTrail` will block that action. SCPs work as permission filters �?they don't grant permissions; they only limit what IAM policies can grant.

**Why not the others**:
- **A**: Permissions boundaries apply per IAM entity (user/role) �?you'd need to configure each one.
- **C**: AWS Config detects non-compliance but doesn't block actions �?it's detective, not preventive.
- **D**: Resource policies control access to individual resources �?you'd need to configure each trail.

**📖 Textbook ref**: §6 �?Organizations & SCP, "SCP Evaluation: restricts maximum permissions"

---

### A6.5
**Correct: B** �?AWS Config.

**Why**: AWS Config continuously monitors and records resource configurations. It tracks changes over time (configuration history) and evaluates resources against Config rules (e.g., "is this S3 bucket public?" "is this EBS volume encrypted?"). It can trigger notifications or auto-remediation when a resource becomes non-compliant.

**Why not the others**:
- **A**: CloudTrail records API activity (who did what), not resource configuration state.
- **C**: CloudWatch monitors performance metrics and logs, not configuration compliance.
- **D**: Systems Manager Inventory collects software inventory on EC2 instances, not resource configuration tracking.

**📖 Textbook ref**: §6 �?AWS Config; Similar Service Comparison, "AWS Config vs CloudTrail vs CloudWatch"

---

### A6.6
**Correct: B** �?AWS WAF.

**Why**: AWS WAF is a Layer 7 web application firewall that integrates with ALB, CloudFront, API Gateway, and AppSync. It includes AWS Managed Rules (e.g., SQL injection, cross-site scripting) and allows custom rules based on IP addresses, HTTP headers, body content, and rate limits. WAF Web ACLs are associated directly with the ALB.

**Why not the others**:
- **A**: Shield provides DDoS protection, not SQL injection filtering.
- **C**: Network Firewall operates at the VPC subnet level (Layer 3/4), not Layer 7 application inspection.
- **D**: Security Hub aggregates findings from other services but doesn't filter traffic itself.

**📖 Textbook ref**: §6 �?WAF, "WAF + ALB: Layer 7 only"

---

### A6.7
**Correct: C** �?Permissions Boundary.

**Why**: A permissions boundary defines the maximum permissions an IAM entity (user or role) can ever have �?regardless of what policies are attached. Even if someone attaches the AdministratorAccess policy, the entity's effective permissions are still limited by the boundary. This is the primary use case: prevent privilege escalation by setting a hard ceiling on permissions.

**Why not the others**:
- **A**: Access Analyzer identifies unintended external access but doesn't limit permissions.
- **B**: SCP limits permissions at the account/OU level �?broader than a per-entity boundary. Both are valid, but Permissions Boundary is the per-entity mechanism described.
- **D**: A trust policy controls who can assume the role, not what the role can do.

**📖 Textbook ref**: §6 �?IAM, "Permissions Boundary: Prevents privilege escalation"

---

## 🟡 Scenario Analysis �?Answers

### A6.8
**Correct: B** �?Create a CloudTrail trail with S3 data events enabled for the buckets.

**Why**: CloudTrail supports two types of events: Management events (control plane �?create/delete/modify resources) and Data events (data plane �?object-level operations like GetObject, PutObject). S3 data events are NOT logged by default �?you must explicitly enable them on a trail. Once enabled, every S3 object-level API call is logged to S3 (or CloudWatch Logs) with no impact on S3 performance.

**Why not the others**:
- **A**: S3 server access logs provide similar information but are delivered on a best-effort basis (not guaranteed) and have delivery delays.
- **C**: CloudWatch Logs requires an agent on each resource �?S3 doesn't support agents for object-level logging.
- **D**: AWS Config tracks bucket configuration (public/private, versioning, encryption), not object-level access.

**📖 Textbook ref**: §6 �?CloudTrail, "Management events + Data events (S3 object-level)"

---

### A6.9
**Correct: B and D** �?AWS Config rule + SSM Automation runbook.

**Why**:
- **B (Config rule)**: AWS Config has a managed rule (`s3-bucket-public-read-prohibited` or `s3-bucket-public-write-prohibited`) that detects public S3 buckets. Config continuously evaluates resources and marks non-compliant resources. Config integrates with EventBridge for notifications.
- **D (SSM Automation)**: Systems Manager Automation can run a runbook that modifies the S3 bucket policy to remove public access. When combined with Config rule auto-remediation, the workflow is: Config detects non-compliance �?triggers SSM Automation �?runbook fixes the bucket policy.

**Why not the others**:
- **A**: CloudTrail logs the API call that made the bucket public, but doesn't detect the current configuration state or auto-remediate.
- **C**: CloudFormation drift detection identifies resources changed outside CloudFormation �?not useful if the bucket wasn't created with CloudFormation.
- **E**: EventBridge alone provides notification but not automatic remediation.

**📖 Textbook ref**: §6 �?AWS Config, "Config rules can auto-remediate via SSM Automation"

---

### A6.10
**Correct: B** �?Attach a deny SCP for Spot Instances to the Dev OU only; leave root and Prod OU unchanged.

**Why**: This uses the deny list SCP strategy �?the default FullAWSAccess SCP at the root allows everything. You add a targeted deny SCP to the Dev OU that denies `ec2:RunInstances` with a condition for Spot instances. The Prod OU and root are not affected. This is minimal configuration �?one SCP, one attachment, and the existing FullAWSAccess handles the rest.

**Why not the others**:
- **A**: Attaching the deny to the root would also affect Prod �?wrong scope.
- **C**: Converting to an allow list (removing FullAWSAccess) requires defining explicit allows for every service in both OUs �?far more maintenance.
- **D**: Attaching the deny to Prod unnecessarily restricts it �?Prod should have all services.

**📖 Textbook ref**: §6 �?Organizations & SCP, "Deny List vs Allow List" and "SCP Inheritance"

---

### A6.11
**Correct: A** �?AWS KMS symmetric key with automatic annual rotation enabled.

**Why**: AWS KMS symmetric keys support automatic annual key rotation. When rotation is enabled, KMS generates new backing key material annually while keeping the same key ID and ARN �?the application doesn't need to change its configuration. The key material never leaves KMS (it's managed by AWS), and the application calls the KMS API to encrypt/decrypt �?it never sees the plaintext key.

**Why not the others**:
- **B**: Asymmetric keys do not support automatic rotation �?you must rotate manually.
- **C**: SSE-S3 uses S3-managed keys with no visibility into rotation schedule �?but the application doesn't control encryption (S3 encrypts on its behalf).
- **D**: Client-side encryption with a secret in Secrets Manager means the application handles the plaintext key �?violates "must not have access to plaintext key material."

**📖 Textbook ref**: §6 �?KMS, "Automatic Key Rotation: Symmetric KMS keys can auto-rotate yearly"

---

### A6.12
**Correct: B** �?IAM Identity Center with AD Connector and SCIM provisioning.

**Why**: IAM Identity Center (formerly AWS SSO) provides SSO to AWS accounts and business applications (via SAML 2.0). AD Connector is a proxy that connects IAM Identity Center to the on-prem AD �?users authenticate against on-prem AD. SCIM (System for Cross-domain Identity Management) enables automatic provisioning: when users are added/removed in AD, the changes automatically sync to IAM Identity Center.

**Why not the others**:
- **A**: IAM users are not SSO and don't support automatic provisioning.
- **C**: Cognito is for customer-facing identity (web/mobile apps), not workforce SSO.
- **D**: Simple AD is a Samba-based directory �?it cannot establish a trust with on-prem AD.

**📖 Textbook ref**: §6 �?IAM, "IAM Identity Center (SSO): Integrates with AD via AD Connector. SCIM for automated provisioning"

---

### A6.13
**Correct: B** �?AWS Certificate Manager (ACM).

**Why**: ACM provisions, manages, and automatically renews SSL/TLS certificates for use with AWS services (ALB, CloudFront, API Gateway, etc.). Certificates are free �?you pay only for the AWS resources they're attached to. ACM automatically renews certificates before they expire (typically 60 days before) as long as the certificate is in use and the domain validation remains valid (DNS validation is recommended for automatic renewal).

**Why not the others**:
- **A**: Third-party certificates incur purchase + renewal costs and require manual import into ACM/IAM.
- **C**: Self-signed certificates are not trusted by browsers and require manual renewal.
- **D**: KMS manages encryption keys, not SSL/TLS certificates.

**📖 Textbook ref**: §6 �?Certificate Manager, "Free. Auto-renewal"

---

### A6.14
**Correct: B** �?Store the password in Secrets Manager; configure rotation; share via resource policy.

**Why**: Secrets Manager supports cross-account access via resource-based policies. You can grant a specific IAM role in another account access to a secret. The password rotation is configured in the secret's owning account. The Lambda function in the other account retrieves the latest password via the Secrets Manager API using its IAM role �?no hardcoded credentials. This is the correct pattern for cross-account secret sharing.

**Why not the others**:
- **A**: SSM Parameter Store does not natively support cross-account access.
- **C**: Storing encrypted blobs in S3 adds complexity (decryption logic in Lambda) and doesn't support automatic rotation.
- **D**: Embedding passwords in environment variables is an anti-pattern �?even with KMS encryption, the environment variable is decrypted at function initialization and visible in the console.

**📖 Textbook ref**: §6 �?Secrets Manager, "Cross-Account: Share secrets via resource policies"

---

### A6.15
**Correct: A** �?AWS Shield Advanced + AWS WAF + Security Groups.

**Why**: This provides all three layers:
- **DDoS protection at network edge**: Shield Advanced provides enhanced DDoS protection with 24/7 response team and cost protection against scaling during attacks.
- **SQL injection/XSS filtering at Layer 7**: WAF integrates with ALB/CloudFront and provides managed rules for SQL injection and XSS.
- **Instance-level stateful firewall**: Security Groups are stateful �?if you allow inbound traffic, return traffic is automatically allowed. They apply at the ENI/instance level.

**Why not the others**:
- **B**: Shield Standard provides basic DDoS protection but not the enhanced features. NACLs are stateless �?not stateful as required.
- **C**: AWS Network Firewall provides Layer 3/4 filtering, not Layer 7 SQLi/XSS detection.
- **D**: Missing Shield for DDoS protection at the network edge.

**📖 Textbook ref**: §6 �?WAF & Shield overview; §5 �?Security Groups

---

## 🔴 Similar Service Comparison �?Answers

### A6.16
**Correct: B** �?CloudTrail, AWS Config, CloudWatch �?for requirements (a), (b), (c) respectively.

**Why**:
- **(a) Who terminated the instance and when**: CloudTrail records the `TerminateInstances` API call with the caller identity, timestamp, and source IP. This answers the "who, what, when" question.
- **(b) Security group configuration before termination**: AWS Config records a configuration history timeline �?you can look up the instance's configuration (including security groups) at any point in time, even after termination.
- **(c) CPU utilization alarm**: CloudWatch monitors CPU utilization metrics and triggers alarms based on thresholds. You can check whether the alarm state changed during the termination.

**Why not the others**: Each other option mixes up the service-to-requirement mapping. The key distinction: CloudTrail = "who did what" (API audit), Config = "what did it look like" (configuration history), CloudWatch = "how is it performing" (metrics/alarms).

**📖 Textbook ref**: §6 �?Similar Service Comparison, "AWS Config vs CloudTrail vs CloudWatch"

---

### A6.17
**Correct: B** �?Secrets Manager for credentials; SSM Parameter Store (Standard) for configuration.

**Why**: Secrets Manager is designed for secrets that need rotation (RDS credentials) and costs $0.40/secret/month. Parameter Store Standard is free and designed for configuration data (feature flags, URLs) that doesn't need rotation. Using the right tool for each data type minimizes cost �?don't pay Secrets Manager pricing ($0.40/month) for simple config values. Standard tier Parameter Store is sufficient since no advanced features (rotation, longer parameter values) are needed.

**Why not the others**:
- **A**: Secrets Manager for both wastes money on config values that don't need rotation.
- **C**: Advanced tier costs $0.05/parameter/month �?more expensive than Standard (free) for simple config.
- **D**: KMS is for encryption keys, not arbitrary configuration values.

**📖 Textbook ref**: §6 �?Similar Service Comparison, "Secrets Manager vs Parameter Store"

---

### A6.18
**Correct: C** �?Service Control Policy (SCP) on the account's OU.

**Why**: An SCP applies to every IAM entity (users, roles, root user) in every account under the OU. It limits the MAXIMUM permissions �?regardless of what IAM policies say. If an SCP denies `s3:DeleteBucket`, even the AdministratorAccess policy cannot grant that permission to any principal in that account. To understand the maximum possible permissions in an account, you only need to check the SCPs on its OU path (root �?parent OU �?account). You don't need to examine individual IAM policies.

**Why not the others**:
- **A**: Permissions boundaries are per-entity �?you'd need to examine every user and role.
- **B**: Resource policies are per-resource �?you'd need to check every resource.
- **D**: Session policies are per-session (temporary) �?not account-wide maximum permissions.

**📖 Textbook ref**: §6 �?Similar Service Comparison, "IAM Role vs SCP vs Permissions Boundary �?Access Control Layers"; §6 �?SCP, "Limits MAX permissions (guardrail)"

---

> **📊 Chapter 6 Summary**: 7 Knowledge + 8 Scenario + 3 Comparison = 18 questions
> 
> **Next**: If you missed any questions, review the corresponding section in `AWS-SAP-C02-Learning-Material.md` and add the Q number to your missed question tracker.
