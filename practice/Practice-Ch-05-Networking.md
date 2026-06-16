---
chapter: "5. Networking & Content Delivery"
totalQuestions: 28
tiers:
  knowledge: 10
  scenario: 13
  comparison: 5
basedOn: "AWS-SAP-C02-Learning-Material.md §5"
services:
  - VPC
  - Route 53
  - API Gateway
  - CloudFront
  - Direct Connect
  - Transit Gateway
  - ALB
  - NLB
  - GWLB
  - Global Accelerator
  - PrivateLink
  - Client VPN
  - Site-to-Site VPN
  - NAT Gateway
  - Prefix Lists
---

# Chapter 5 Practice: 🌐 Networking & Content Delivery

> **Instructions**: Complete Part A first. Do not scroll past the divider. Once finished, check Part B for answers and explanations.
> **Textbook**: `AWS-SAP-C02-Learning-Material.md` �?Section 5 (VPC, Route 53, API Gateway, CloudFront, Direct Connect, Transit Gateway, Load Balancers, Global Accelerator) + Similar Service Comparison: Networking

---

# Part A �?Questions

## 🟢 Knowledge Check (10 questions)

### Q5.1

> 🟡 L2-理解 | 🎤🎤 中频面试
A solutions architect is designing a VPC with public and private subnets. Instances in the private subnet need to download software updates from the internet but must NOT be reachable from the internet. Which component enables this?

- A. Internet Gateway attached to the private subnet
- B. NAT Gateway placed in a public subnet
- C. VPC endpoint for internet access
- D. Elastic IP assigned to each private instance

### Q5.2

> 🟡 L2-理解 | 🎤🎤 中频面试
Which statement correctly describes the difference between Security Groups and Network ACLs in a VPC?

- A. Security Groups are stateless; NACLs are stateful
- B. Security Groups apply at the subnet level; NACLs apply at the instance level
- C. Security Groups are stateful and allow rules only; NACLs are stateless and support allow and deny rules
- D. Security Groups support allow and deny rules; NACLs support allow rules only

### Q5.3

> 🟡 L2-理解 | 🎤🎤 中频面试
A company has two VPCs with overlapping CIDR ranges (both use 10.0.0.0/16). They need to enable private connectivity between a specific application in VPC A and a service in VPC B. Which solution supports this?

- A. VPC Peering with route table adjustments
- B. Transit Gateway with static routes
- C. AWS PrivateLink with a Network Load Balancer in VPC B
- D. VPC Endpoint Gateway for the target service

### Q5.4

> 🟡 L2-理解 | 🎤🎤 中频面试
A solutions architect needs to provide private connectivity from a VPC to Amazon S3 and Amazon DynamoDB without using the public internet. The solution must have no hourly charges for the endpoints themselves. Which type of VPC endpoint should be used?

- A. Interface endpoints for both S3 and DynamoDB
- B. Gateway endpoints for both S3 and DynamoDB
- C. Gateway endpoint for S3 and Interface endpoint for DynamoDB
- D. Interface endpoint for S3 and Gateway endpoint for DynamoDB

### Q5.5

> 🟡 L2-理解 | 🎤🎤 中频面试
Which Route 53 routing policy should be used to route traffic to multiple resources and return only healthy records, with up to 8 records in the response?

- A. Weighted routing policy
- B. Failover routing policy
- C. Latency routing policy
- D. Multi-Value Answer routing policy

### Q5.6

> 🟡 L2-理解 | 🎤🎤 中频面试
A company has a Direct Connect connection and wants a cost-effective failover solution if the Direct Connect link goes down. The failover path should use the public internet but maintain encrypted connectivity. Which approach should be used?

- A. A second Direct Connect connection in a different location
- B. Site-to-Site VPN as a backup to Direct Connect
- C. Client VPN for all on-premises users
- D. Transit Gateway peering to a backup Region

### Q5.7

> 🟡 L2-理解 | 🎤🎤 中频面试
Which load balancer type supports WebSocket and gRPC protocols, along with path-based and host-based routing?

- A. Network Load Balancer (NLB)
- B. Application Load Balancer (ALB)
- C. Gateway Load Balancer (GWLB)
- D. Classic Load Balancer (CLB)

### Q5.8

> 🟢 L1-知识 | 🎤🎤 中频面试
What is the purpose of an Origin Access Control (OAC) in CloudFront?

- A. To encrypt data between CloudFront and the origin using TLS
- B. To restrict S3 bucket access so that content can only be served through CloudFront
- C. To authenticate users before they can access content through CloudFront
- D. To cache content at additional edge locations for lower latency

### Q5.9

> 🟡 L2-理解 | 🎤🎤 中频面试
A solutions architect is designing a hybrid DNS solution. On-premises servers need to resolve DNS names in a Route 53 private hosted zone (cloud.example.com). Which Route 53 Resolver component should be deployed?

- A. Outbound Resolver Endpoint
- B. Inbound Resolver Endpoint
- C. Resolver Rule for cloud.example.com
- D. Conditional Forwarder on an EC2 instance

### Q5.10

> 🟡 L2-理解 | 🎤🎤 中频面试
Which AWS service provides two static Anycast IP addresses that serve as a fixed entry point to an application and route traffic through the AWS global network to the optimal regional endpoint?

- A. Amazon CloudFront
- B. AWS Global Accelerator
- C. Amazon Route 53 Latency Routing
- D. Elastic Load Balancing with cross-zone load balancing

---

## 🟡 Scenario Analysis (11 questions)

### Q5.11

> 🟡 L2-理解 | 🎤🎤 中频面试
A company has a VPC with private subnets across three Availability Zones. Each private subnet contains application servers that need to access the internet for software updates. The solutions architect must ensure high availability of the internet access path �?if one AZ fails, instances in the other AZs must still reach the internet.

What is the correct NAT Gateway deployment strategy?

- A. Deploy one NAT Gateway in a single public subnet and route all private subnets to it
- B. Deploy one NAT Gateway in each private subnet
- C. Deploy one NAT Gateway in a public subnet in each AZ and route each AZ's private subnets to the NAT Gateway in the same AZ
- D. Deploy one NAT Gateway in a public subnet in each AZ and route all private subnets to the nearest one using latency-based routing

### Q5.12

> 🟡 L2-理解 | 🎤🎤 中频面试
A company has three VPCs (Dev, Test, Prod) that need to communicate with each other and with an on-premises data center via Direct Connect. The solutions architect must design a scalable network architecture that allows future VPCs to be added easily. Network segmentation is required �?Dev and Test VPCs should not be able to communicate with Prod VPCs.

Which architecture meets these requirements?

- A. VPC Peering between all VPCs + separate Direct Connect connections for each VPC
- B. Transit Gateway with separate route tables for Dev/Test and Prod VPCs + one Direct Connect Gateway attachment
- C. AWS PrivateLink endpoints in each VPC + a central VPN connection
- D. Transit Gateway with a single route table for all VPCs + Network ACLs for segmentation

### Q5.13

> 🟡 L2-理解 | 🎤🎤 中频面试
A company deploys a REST API using Amazon API Gateway. The API must be accessible ONLY from within specific VPCs �?no public internet access allowed. Several trusted partner accounts in the same organization also need access to this API from their own VPCs.

Which combination of API Gateway endpoint type and access control should be used?

- A. Regional API endpoint with IAM authentication
- B. Edge-Optimized API endpoint with API keys
- C. Private API endpoint with a resource policy allowing specific VPC endpoints
- D. Regional API endpoint with a WAF Web ACL restricting IP ranges

### Q5.14

> 🟡 L2-理解 | 🎤🎤 中频面试
A global gaming company deploys a multiplayer game backend on EC2 instances in us-east-1 and eu-west-1. The game uses custom UDP protocol on port 9000. Players worldwide must connect to the Region with the lowest latency. The company needs static IP addresses that never change, so players can whitelist them in their firewall rules.

Which service should the company place in front of the game servers?

- A. Amazon CloudFront with UDP origins
- B. AWS Global Accelerator with endpoint groups in both Regions
- C. Amazon Route 53 Latency routing with health checks
- D. Network Load Balancer with cross-region peering

### Q5.15

> 🟡 L2-理解 | 🎤🎤 中频面试
A company is migrating from a legacy data center to AWS. The data center has applications that must resolve DNS names of AWS resources (e.g., db.internal.cloud.example.com), and EC2 instances must resolve DNS names of on-premises servers (e.g., erp.corp.local).

Which set of Route 53 Resolver components should be deployed?

- A. Inbound endpoint only
- B. Outbound endpoint only
- C. Both Inbound and Outbound endpoints, with appropriate forwarding rules
- D. A Route 53 public hosted zone for both domains

### Q5.16

> 🟡 L2-理解 | 🎤🎤 中频面试
A company has deployed an internal API on an Application Load Balancer in a VPC. The security team requires that all traffic to this API be inspected for SQL injection and cross-site scripting attacks. Which combination of services should be used?

- A. Network Load Balancer with AWS Shield Advanced
- B. Application Load Balancer with AWS WAF
- C. Gateway Load Balancer with AWS WAF
- D. Application Load Balancer with AWS Shield Standard

### Q5.17

> 🟡 L2-理解 | 🎤🎤 中频面试
A solutions architect needs to connect 50 VPCs across 5 AWS accounts in a hub-and-spoke topology. All VPCs should be able to communicate with each other. The solution must minimize operational overhead and cost compared to maintaining a full mesh of VPC peering connections.

Which architecture is recommended?

- A. VPC Peering between all 50 VPCs in a full mesh
- B. Transit Gateway shared across accounts via AWS Resource Access Manager (RAM)
- C. AWS PrivateLink endpoints in each VPC connecting to a central NLB
- D. 50 Site-to-Site VPN connections between each pair of VPCs

### Q5.18

> 🟡 L2-理解 | 🎤🎤 中频面试
A company's web application is hosted on EC2 instances behind an ALB. The application needs to maintain session affinity (sticky sessions) so that a user's requests are always routed to the same backend instance. The application uses application-based cookies for session tracking.

How should the solutions architect configure this?

- A. Enable sticky sessions on the ALB target group with application-based cookie duration
- B. Deploy an NLB instead, which supports source IP affinity by default
- C. Use Route 53 weighted routing to pin users to specific instances
- D. Enable session persistence in the EC2 instance security group

### Q5.19

> 🟡 L2-理解 | 🎤🎤 中频面试
A company operates a hybrid infrastructure using a Direct Connect connection to a Transit Gateway. The company needs to isolate development workloads from production workloads at the network level. Development VPCs should never be able to communicate with production VPCs, even if routes are accidentally misconfigured.

Which Transit Gateway feature achieves this isolation?

- A. VPC route tables with blackhole routes
- B. Separate Transit Gateway route tables for Dev and Prod VPC associations, with no routes between them
- C. Network ACLs on the VPC subnets
- D. Security groups on all EC2 instances in both environments

### Q5.20

> 🟡 L2-理解 | 🎤🎤 中频面试
A company is deploying a third-party virtual firewall appliance to inspect all inbound traffic to their VPC before it reaches application servers. The firewall needs to transparently intercept traffic without requiring any changes to the application's network configuration.

Which AWS service enables this architecture?

- A. Application Load Balancer with WAF
- B. Network Load Balancer with TLS termination
- C. Gateway Load Balancer (GWLB) with the firewall appliance as a target
- D. AWS Network Firewall with VPC route table integration

### Q5.21

> 🟡 L2-理解 | 🎤🎤 中频面试
A company's security team needs to manage a list of trusted corporate IP ranges. These IP ranges must be used in security group rules across 50 VPCs in the organization. When the corporate IP ranges change, the team wants to update the list in one place rather than updating security group rules in every VPC.

Which AWS feature should be used?

- A. AWS Firewall Manager with a central security policy
- B. VPC Prefix Lists shared across accounts via Resource Access Manager (RAM)
- C. AWS WAF IP sets applied to all VPC resources
- D. Network ACLs with a central template in AWS Config

---

## 🔴 Similar Service Comparison (5 questions)

### Q5.22

> 🟡 L2-理解 | 🎤🎤 中频面试
A company needs to connect 3 VPCs. A year later, the company plans to connect 100+ VPCs. The solutions architect must choose a connectivity solution today that supports both the immediate need and the future scale. Which solution should be chosen?

- A. VPC Peering �?it supports up to 125 peers and can scale to 100
- B. Transit Gateway �?it supports hub-and-spoke topology and scales to thousands of VPCs
- C. PrivateLink �?it supports consumer-provider model with no connection limits
- D. VPC Peering now, then migrate to Transit Gateway when scaling beyond 100

### Q5.23

> 🟡 L2-理解 | 🎤🎤 中频面试
An on-premises data center needs to resolve DNS names in the cloud.example.com Route 53 private hosted zone. Which component must be deployed in AWS?

- A. Route 53 Outbound Resolver Endpoint
- B. Route 53 Inbound Resolver Endpoint
- C. An EC2 instance running BIND as a DNS forwarder
- D. A Direct Connect public virtual interface

### Q5.24

> 🟡 L2-理解 | 🎤🎤 中频面试
A company wants the fastest possible delivery of static website assets (images, CSS, JavaScript) to users worldwide. The solution should cache content close to users and serve it over HTTPS. Which service is designed specifically for this use case?

- A. AWS Global Accelerator
- B. Amazon CloudFront
- C. Amazon Route 53 Latency Routing
- D. Application Load Balancer with cross-zone load balancing

### Q5.25

> 🟡 L2-理解 | 🎤🎤 中频面试
A real-time multiplayer game uses UDP for game traffic and HTTPS for matchmaking. The game requires the lowest possible network latency from players to game servers in multiple AWS Regions. Players connect from all continents. Which service combination provides the BEST performance for BOTH traffic types?

- A. CloudFront for HTTPS + Global Accelerator for UDP
- B. Global Accelerator for both HTTPS and UDP
- C. CloudFront for both HTTPS and UDP
- D. Route 53 Latency routing for both HTTPS and UDP

### Q5.26

> 🟡 L2-理解 | 🎤🎤 中频面试
A solutions architect is designing connectivity between two business units. Unit A runs an application that must be accessed privately by Unit B, but the VPCs have overlapping CIDR ranges. Both units are in the same AWS Region. Which service enables this connectivity?

- A. VPC Peering
- B. Transit Gateway
- C. AWS PrivateLink
- D. Site-to-Site VPN between the VPCs

### Q5.27

> 🟡 L2-理解 | 🎤🎤 中频面试
A company has multiple VPCs with overlapping CIDR ranges across different business units. The marketing team needs to share an internal application with all other units using private IP addresses only.

Which solution meets these requirements with the LEAST operational overhead?

- A. Add unique secondary CIDR ranges and peer all VPCs with NAT
- B. Create VPN connections between each VPC pair with NAT appliances
- C. Create an AWS PrivateLink endpoint service to share the application across accounts
- D. Create an NLB and API Gateway private integration with IAM authorization

### Q5.28

> 🟡 L2-理解 | 🎤🎤 中频面试
A company is migrating its EC2 fleet to IPv6. Instances in private subnets must maintain outbound internet access but must NOT be directly reachable from the public internet.

What should the solutions architect configure?

- A. Associate IPv6 CIDR with subnets and route ::/0 to an Internet Gateway
- B. Associate IPv6 CIDR with subnets, create an Egress-Only Internet Gateway, and route ::/0 from private subnets to it
- C. Associate IPv6 CIDR with subnets and route ::/0 to a NAT Gateway
- D. Deploy Dual-stack NAT Gateways and route ::/0 to them

---

# Part B �?Answers & Explanations

> ⚠️ **STOP HERE.** Complete all questions in Part A before reading below.
>
> Scoring guideline: 🟢 Knowledge (easy), 🟡 Scenario (medium), 🔴 Comparison (hardest)

---

## 🟢 Knowledge Check �?Answers

### A5.1
**Correct: B** �?NAT Gateway placed in a public subnet.

**Why**: A NAT Gateway enables instances in private subnets to initiate outbound connections to the internet (e.g., download updates) while preventing inbound connections from the internet. The NAT Gateway itself is placed in a public subnet (because it needs internet access), and private subnet route tables direct 0.0.0.0/0 traffic to it.

**Why not the others**:
- **A**: An Internet Gateway attached to private subnets would make them public �?contradicting the "must NOT be reachable" requirement.
- **C**: VPC endpoints provide private access to AWS services, not general internet access.
- **D**: Elastic IPs make instances directly reachable from the internet, violating the requirement.

**📖 Textbook ref**: §5 �?VPC, "Azure Bridge"; §5 �?Other Networking Services, "NAT Gateway"

---

### A5.2
**Correct: C** �?Security Groups are stateful and allow rules only; NACLs are stateless and support allow and deny rules.

**Why**: Security Groups are stateful �?if you allow outbound traffic, the return traffic is automatically allowed regardless of inbound rules. They support allow rules only (implicit deny). NACLs are stateless �?you must explicitly allow both inbound and outbound (return) traffic in separate rules. NACLs support both allow and deny rules.

**Why not the others**:
- **A**: Reversed �?Security Groups are stateful, NACLs are stateless.
- **B**: Reversed �?Security Groups apply at the instance level (ENI), NACLs apply at the subnet level.
- **D**: Reversed �?Security Groups allow only; NACLs support both allow and deny.

**📖 Textbook ref**: §5 �?VPC, "Security Groups vs NACLs"

---

### A5.3
**Correct: C** �?AWS PrivateLink with a Network Load Balancer in VPC B.

**Why**: PrivateLink enables private connectivity even between VPCs with overlapping CIDRs. VPC B exposes its service via an NLB, and VPC A creates a VPC Endpoint (Interface type) to access it. The connection uses AWS's private network and the overlapping CIDRs are not an issue because PrivateLink uses NAT at the endpoint.

**Why not the others**:
- **A**: VPC Peering explicitly does not support overlapping CIDRs.
- **B**: Transit Gateway also does not support routing between VPCs with overlapping CIDRs.
- **D**: Gateway endpoints are only for S3 and DynamoDB �?not for arbitrary application services.

**📖 Textbook ref**: §5 �?VPC, "Overlapping CIDRs"; §5 �?Similar Service Comparison, "Overlapping CIDRs" row

---

### A5.4
**Correct: B** �?Gateway endpoints for both S3 and DynamoDB.

**Why**: Gateway endpoints are the only type that is free (no hourly charge) and both S3 and DynamoDB are the only two AWS services that support Gateway endpoints. They work by adding routes in the VPC route table.

**Why not the others**:
- **A**: Interface endpoints (powered by PrivateLink) have an hourly charge + data processing fees.
- **C & D**: There is no combination needed �?both S3 and DynamoDB support Gateway endpoints.

**📖 Textbook ref**: §5 �?VPC, "VPC Endpoints"

---

### A5.5
**Correct: D** �?Multi-Value Answer routing policy.

**Why**: Multi-Value Answer routing returns up to 8 healthy records selected at random. It can be combined with health checks so only healthy resources are returned. This is distinct from Simple routing (no health check), Weighted (traffic split percentage), and Failover (one primary, one secondary).

**Why not the others**:
- **A**: Weighted routing splits traffic by percentage but doesn't specifically return up to 8 records.
- **B**: Failover returns only the primary or secondary, not multiple records.
- **C**: Latency routing returns the lowest-latency record, not up to 8.

**📖 Textbook ref**: §5 �?Route 53, "Routing Policies"

---

### A5.6
**Correct: B** �?Site-to-Site VPN as a backup to Direct Connect.

**Why**: This is a classic enterprise pattern �?use Direct Connect as the primary (private, dedicated, consistent performance) connection and a Site-to-Site VPN over the public internet as a backup. Both connect to the same VPC/VGW or TGW. If DX fails, traffic fails over to the VPN. The VPN is encrypted (IPsec), satisfying the encryption requirement.

**Why not the others**:
- **A**: A second DX provides higher availability but is not cost-effective �?a VPN is significantly cheaper.
- **C**: Client VPN is for individual remote users, not site-to-site connectivity.
- **D**: TGW peering connects Regions, not on-prem to AWS.

**📖 Textbook ref**: §5 �?Direct Connect, "DC + VPN"

---

### A5.7
**Correct: B** �?Application Load Balancer (ALB).

**Why**: ALB operates at Layer 7 and supports advanced request routing: path-based (e.g., /api/* �?target group A; /images/* �?target group B), host-based (e.g., api.example.com �?target group C), header-based, and method-based routing. ALB natively supports HTTP/2, WebSocket, and gRPC protocols.

**Why not the others**:
- **A**: NLB operates at Layer 4 and does not inspect HTTP headers �?no path or host routing.
- **C**: GWLB does not terminate connections; it routes to appliances transparently.
- **D**: CLB is the legacy predecessor and does not support path/host routing or WebSocket.

**📖 Textbook ref**: §5 �?Load Balancers, ALB row

---

### A5.8
**Correct: B** �?To restrict S3 bucket access so that content can only be served through CloudFront.

**Why**: OAC (Origin Access Control) replaces the older OAI (Origin Access Identity). It uses a CloudFront-specific principal to authenticate requests to S3, ensuring that the S3 bucket cannot be accessed directly via its S3 URL �?all access must go through the CloudFront distribution URL. This prevents bypassing CloudFront caching, WAF, and other edge features.

**Why not the others**:
- **A**: TLS between CloudFront and origin is configured separately (origin protocol policy).
- **C**: User authentication is handled by signed URLs/cookies or Cognito, not by OAC.
- **D**: Cache behavior is configured on the distribution's cache policy, not OAC.

**📖 Textbook ref**: §5 �?CloudFront, "OAC (Origin Access Control)"

---

### A5.9
**Correct: B** �?Inbound Resolver Endpoint.

**Why**: Route 53 Resolver Inbound Endpoint enables DNS queries from outside AWS (on-premises) to resolve DNS names in Route 53 private hosted zones. You place ENIs in your VPC, and on-prem DNS servers forward queries for `cloud.example.com` to these ENI IP addresses.

**Why not the others**:
- **A**: Outbound endpoint is for AWS resources to resolve on-prem DNS names �?the opposite direction.
- **C**: Resolver Rules are used with Outbound endpoints to forward specific domains.
- **D**: Running your own DNS forwarder on EC2 adds operational overhead; Resolver is the managed alternative.

**📖 Textbook ref**: §5 �?Route 53 Resolver, "Inbound Endpoint"; Similar Service Comparison �?Resolver Inbound vs Outbound

---

### A5.10
**Correct: B** �?AWS Global Accelerator.

**Why**: Global Accelerator provides 2 static Anycast IP addresses. Incoming traffic enters the AWS global network at the nearest edge location and is routed through AWS's backbone (not the public internet) to the optimal regional endpoint. The IPs never change �?ideal for whitelisting.

**Why not the others**:
- **A**: CloudFront uses a domain name, not a pair of static IPs. It caches content at the edge.
- **C**: Route 53 Latency routing returns the DNS record with the lowest latency, but doesn't provide static IPs or AWS backbone routing.
- **D**: ELB IPs can change; cross-zone LB distributes within a Region, not globally.

**📖 Textbook ref**: §5 �?Global Accelerator, "Static IPs" and "vs CloudFront"

---

## 🟡 Scenario Analysis �?Answers

### A5.11
**Correct: C** �?Deploy one NAT Gateway in a public subnet in each AZ and route each AZ's private subnets to the NAT Gateway in the same AZ.

**Why**: NAT Gateways are AZ-scoped �?a NAT Gateway in AZ-a only provides outbound connectivity for resources in AZ-a. If you have a single NAT Gateway in AZ-a and AZ-a fails, instances in AZ-b and AZ-c lose internet access. Deploying one per AZ with AZ-local routing ensures each AZ has an independent internet path �?full HA.

**Why not the others**:
- **A**: A single NAT Gateway is a single point of failure for cross-AZ traffic.
- **B**: NAT Gateways must be in public subnets, not private ones.
- **D**: Route 53 latency routing is for DNS, not VPC routing. There is no "nearest NAT Gateway" routing mechanism within a VPC.

**📖 Textbook ref**: §5 �?NAT Gateway, "AZ-scoped (need one per AZ for HA)"

---

### A5.12
**Correct: B** �?Transit Gateway with separate route tables for Dev/Test and Prod VPCs + one Direct Connect Gateway attachment.

**Why**: TGW supports multiple route tables. By associating Dev and Test VPCs with one route table and Prod VPCs with another, and not propagating routes between them, the network segmentation is enforced at the TGW level. A single Direct Connect Gateway attachment connects the TGW to on-prem. Adding new VPCs is a matter of creating a new VPC attachment to the TGW �?no mesh growth.

**Why not the others**:
- **A**: Full mesh of VPC Peering does not scale and separate DX connections are expensive.
- **C**: PrivateLink is for consumer-provider access, not general inter-VPC routing.
- **D**: A single route table would allow all VPCs to communicate �?violating the segmentation requirement. Network ACLs add complexity vs. architectural segmentation via route tables.

**📖 Textbook ref**: §5 �?Transit Gateway, "TGW Route Tables"; §5 �?Direct Connect Gateway

---

### A5.13
**Correct: C** �?Private API endpoint with a resource policy allowing specific VPC endpoints.

**Why**: A Private API Gateway endpoint is only accessible from within a VPC via a VPC Endpoint (powered by PrivateLink). The API's resource policy can specify which VPC Endpoints (by their IDs) or which AWS accounts are allowed to invoke it. This enables controlled cross-account access without any public internet exposure.

**Why not the others**:
- **A**: A Regional endpoint is still public (accessible over the internet); IAM auth controls who can call it but doesn't restrict network access.
- **B**: Edge-Optimized is public via CloudFront.
- **D**: WAF IP restrictions on a Regional endpoint still expose the endpoint to the internet.

**📖 Textbook ref**: §5 �?API Gateway, "Private API" and "Endpoint Types"

---

### A5.14
**Correct: B** �?AWS Global Accelerator with endpoint groups in both Regions.

**Why**: Global Accelerator is designed for non-HTTP protocols (TCP/UDP), provides 2 static Anycast IPs that never change, and routes traffic through the AWS backbone for the lowest possible latency. Endpoint groups in each Region let GA route to the closest healthy endpoint. This is the ideal solution for real-time gaming (UDP + latency-sensitive).

**Why not the others**:
- **A**: CloudFront is HTTP/HTTPS only �?it does not support UDP.
- **C**: Route 53 Latency routing resolves DNS but does not provide static IPs or backbone routing. DNS caching by clients can also delay failover.
- **D**: NLB is Regional; cross-region peering is not a native NLB feature.

**📖 Textbook ref**: §5 �?Global Accelerator, "vs CloudFront" and "Static IPs"

---

### A5.15
**Correct: C** �?Both Inbound and Outbound endpoints, with appropriate forwarding rules.

**Why**: The requirements are bidirectional: on-premises �?AWS (resolve `cloud.example.com`) requires an **Inbound** endpoint with on-prem DNS servers forwarding to it. AWS �?on-premises (resolve `corp.local`) requires an **Outbound** endpoint with forwarding rules to on-prem DNS servers. Both are independent and can coexist in the same VPC.

**Why not the others**:
- **A**: Inbound only handles on-prem �?AWS, not the reverse.
- **B**: Outbound only handles AWS �?on-prem, not the reverse.
- **D**: Public hosted zones are for internet-routable domains, not internal corporate domains.

**📖 Textbook ref**: §5 �?Route 53 Resolver, "Inbound Endpoint" and "Outbound Endpoint"; Similar Service Comparison �?Resolver Inbound vs Outbound

---

### A5.16
**Correct: B** �?Application Load Balancer with AWS WAF.

**Why**: ALB operates at Layer 7, making it compatible with AWS WAF (also Layer 7). WAF provides managed rules for SQL injection and cross-site scripting (XSS), as well as custom rules. The WAF Web ACL is associated directly with the ALB, and traffic is inspected before reaching the backend.

**Why not the others**:
- **A**: NLB operates at Layer 4 �?WAF cannot be associated with it.
- **C**: GWLB routes traffic to third-party appliances for inspection; it does not natively integrate with AWS WAF's managed rule groups for SQLi/XSS.
- **D**: Shield Standard provides basic DDoS protection, not SQL injection or XSS inspection.

**📖 Textbook ref**: §5 �?Load Balancers, "ALB + WAF"; §6 �?WAF, "WAF + ALB: Layer 7 only"

---

### A5.17
**Correct: B** �?Transit Gateway shared across accounts via AWS Resource Access Manager (RAM).

**Why**: TGW supports hub-and-spoke topology and scales to thousands of VPC attachments. Through RAM, a TGW in one account can be shared with other accounts in the same organization. Each account creates VPC attachments to the shared TGW. All VPCs can communicate (with appropriate route tables), and cost is far lower than 1,225 VPC peering connections (50 × 49 / 2 for a full mesh).

**Why not the others**:
- **A**: A full mesh of 50 VPCs requires 1,225 peering connections �?massive operational overhead and cost.
- **C**: PrivateLink doesn't support full-mesh communication; it's consumer-to-provider, one service at a time.
- **D**: 50 × 49 Site-to-Site VPNs is not a viable architecture.

**📖 Textbook ref**: §5 �?Transit Gateway, "Hub-and-spoke" and scale; §5 �?Similar Service Comparison, "VPC Peering vs TGW vs PrivateLink"

---

### A5.18
**Correct: A** �?Enable sticky sessions on the ALB target group with application-based cookie duration.

**Why**: ALB supports sticky sessions (session affinity) using application-based cookies. The ALB generates a cookie (`AWSALBAPP`) that maps the user to a specific target. The duration is configurable. Since the application already uses application-based cookies, ALB's application-based stickiness is the right fit.

**Why not the others**:
- **B**: NLB does support source IP affinity but the application uses application-based cookies �?the affinity method must match the application's session tracking mechanism. Also, the scenario says they use an ALB.
- **C**: Route 53 weighted routing does not provide session-level affinity.
- **D**: Security groups are firewalls; they have no session persistence capability.

**📖 Textbook ref**: §5 �?Load Balancers, "Sticky sessions via application-based cookies"

---

### A5.19
**Correct: B** �?Separate Transit Gateway route tables for Dev and Prod VPC associations, with no routes between them.

**Why**: TGW route tables provide network segmentation. By associating Dev VPCs with one route table and Prod VPCs with another, and NOT propagating routes between the two tables, traffic cannot flow between Dev and Prod �?even if an administrator accidentally adds a route in a VPC's route table, the TGW itself blocks the traffic. This is architectural isolation at the TGW level.

**Why not the others**:
- **A**: Blackhole routes in individual VPCs don't enforce isolation across all VPCs �?they must be configured per VPC.
- **C**: NACLs provide a second layer of defense but can be misconfigured; TGW route table isolation is stronger as the only connectivity path.
- **D**: Security groups are per-instance; there is no way to guarantee all instances are correctly configured.

**📖 Textbook ref**: §5 �?Transit Gateway, "TGW Route Tables: Segmentation"

---

### A5.20
**Correct: C** �?Gateway Load Balancer (GWLB) with the firewall appliance as a target.

**Why**: GWLB is specifically designed for transparent inline appliance insertion. Traffic is routed to the GWLB endpoint, which sends it to the third-party firewall appliance via GENEVE encapsulation. The original packet (source/destination IP and port) is preserved �?the firewall inspects it transparently, and the application servers see the original client IP. No changes needed to the application.

**Why not the others**:
- **A**: ALB + WAF only provides Layer 7 inspection based on HTTP �?not transparent full-packet inspection.
- **B**: NLB with TLS termination doesn't provide firewall inspection.
- **D**: AWS Network Firewall is a managed service (different from GWLB), but it doesn't route to third-party appliances.

**📖 Textbook ref**: §5 �?Load Balancers, GWLB row; "Transparent inline appliance insertion"

---

### A5.21
**Correct: B** �?VPC Prefix Lists shared across accounts via Resource Access Manager (RAM).

**Why**: Prefix Lists are managed collections of CIDR blocks. You create a customer-managed prefix list with your corporate IP ranges, reference it in security group rules across all VPCs, and share it via RAM to other accounts. When the IP ranges change, you update the prefix list once, and all security group rules referencing it automatically apply the new ranges.

**Why not the others**:
- **A**: Firewall Manager manages WAF rules and Shield protections, not security group CIDR lists.
- **C**: WAF IP sets apply to WAF Web ACLs (Layer 7), not security group rules (which operate at the instance level).
- **D**: AWS Config evaluates compliance but does not manage security group rules.

**📖 Textbook ref**: §5 �?Other Networking Services, "Prefix Lists"

---

## 🔴 Similar Service Comparison �?Answers

### A5.22
**Correct: B** �?Transit Gateway �?it supports hub-and-spoke topology and scales to thousands of VPCs.

**Why**: TGW is designed for this exact evolution �?3 VPCs today, thousands tomorrow. A hub-and-spoke model means adding a new VPC requires only one new attachment to the TGW (linear growth), vs VPC Peering which requires N×(N�?)/2 connections (quadratic growth). Choosing TGW from the start avoids a painful migration later.

**Why not the others**:
- **A**: VPC Peering supports 125 but the mesh complexity (1,225 connections for 50 VPCs) makes it operationally impractical well before that limit.
- **C**: PrivateLink is not designed for general inter-VPC routing; it's for sharing specific services.
- **D**: Migrating from peering to TGW is disruptive; building on TGW from the start is the better strategy.

**📖 Textbook ref**: §5 �?Similar Service Comparison, "VPC Peering vs TGW vs PrivateLink" �?Scale row

---

### A5.23
**Correct: B** �?Route 53 Inbound Resolver Endpoint.

**Why**: Inbound = outside �?into AWS. The on-prem DNS servers forward queries for `cloud.example.com` to the IP addresses of the Inbound Resolver Endpoint's ENIs in the VPC. The Resolver then queries the private hosted zone and returns the result.

**Why not the others**:
- **A**: Outbound is the opposite direction �?AWS �?on-prem.
- **C**: Running BIND on EC2 is a self-managed alternative (a correct but high-operational-overhead answer in some contexts), but the question asks specifically about the Route 53 Resolver component.
- **D**: A public VIF is for accessing AWS public services, not private hosted zones.

**📖 Textbook ref**: §5 �?Similar Service Comparison, "Route 53 Resolver Inbound vs Outbound"

---

### A5.24
**Correct: B** �?Amazon CloudFront.

**Why**: CloudFront is a Content Delivery Network (CDN) built for caching static content at 450+ edge locations globally. Users download assets from the nearest edge location �?dramatically reducing latency. CloudFront natively supports HTTPS, integrates with AWS Certificate Manager for free SSL certificates, and is the go-to service for static asset delivery.

**Why not the others**:
- **A**: Global Accelerator optimizes network path (TCP/UDP) but does NOT cache content. Every request still reaches the origin.
- **C**: Route 53 Latency routes DNS to the lowest-latency origin but does not cache content.
- **D**: ALB distributes traffic within a Region; it provides no global caching.

**📖 Textbook ref**: §5 �?Similar Service Comparison, "CloudFront vs Global Accelerator vs Route 53 Latency"

---

### A5.25
**Correct: A** �?CloudFront for HTTPS + Global Accelerator for UDP.

**Why**: CloudFront is optimized for HTTPS content delivery (caching, edge locations, WAF integration). Global Accelerator is optimized for non-HTTP protocols (UDP) �?it routes through the AWS backbone for the lowest possible network latency. Most importantly, CloudFront does NOT support UDP at all. So the HTTPS traffic goes through CloudFront (matchmaking, leaderboards, static assets) and the UDP game traffic goes through Global Accelerator (real-time gameplay).

**Why not the others**:
- **B**: Global Accelerator can carry HTTPS but doesn't cache content �?CloudFront is better for HTTPS delivery with caching.
- **C**: CloudFront does not support UDP.
- **D**: Route 53 Latency does not provide the backbone routing or static IPs needed for real-time gaming.

**📖 Textbook ref**: §5 �?Similar Service Comparison, "CloudFront vs Global Accelerator vs Route 53 Latency"; §5 �?Global Accelerator, "vs CloudFront"

---

### A5.26
**Correct: C** �?AWS PrivateLink.

**Why**: PrivateLink is the only service among the options that supports connectivity between VPCs with overlapping CIDRs. It achieves this by using NAT at the VPC Endpoint �?the consumer side sees a local IP in the endpoint's subnet, not the provider's actual IP. The service provider exposes their application via an NLB, and the consumer creates an Interface VPC Endpoint.

**Why not the others**:
- **A**: VPC Peering explicitly does not support overlapping CIDRs.
- **B**: Transit Gateway does not support overlapping CIDRs between attached VPCs.
- **D**: Site-to-Site VPN does not solve overlapping CIDRs natively �?NAT must be configured on one side, adding complexity.

**📖 Textbook ref**: §5 �?Similar Service Comparison, "Overlapping CIDRs" row; §5 �?PrivateLink

---

> **📊 Chapter 5 Summary**: 10 Knowledge + 14 Scenario + 6 Comparison = 30 questions
> 
> **Next**: If you missed any questions, review the corresponding section in `AWS-SAP-C02-Learning-Material.md` and add the Q number to your missed question tracker.
