---
tags:
  - #AWS-SAP-C02
  - #Learning-Material
  - #AWS-Certification
created: 2026-06-06
updated: 2026-06-06
total_services: 100+
total_files: 187
---

# AWS SAP-C02 定制化学习材料（中文版）

> 📚 **来源**：你的 Wrong Answer Collection（187 道练习题分析）  
> 🎯 **目标**：通过 AWS Solutions Architect Professional (SAP-C02) 考试  
> 🏭 **目标行业**：医疗 / 工业  
> 👤 **你的背景**：Azure 云运维工程师（3年），熟悉 Azure DevOps Pipelines 与 Releases

---

## 📖 如何使用本材料

1. **按 AWS 服务域浏览**（Compute → Storage → Database → ...）—— 每节涵盖一项服务
2. **重点关注 "🔍 Similar Service Comparison"**—— 考试中最常见的陷阱，相似 AWS 服务作为竞争选项同时出现
3. **查看 "🔄 Azure 对照"**—— 将每个 AWS 服务映射到你已熟悉的 Azure 服务
4. **每条知识点可追溯到原题**—— 参见 `📝 Q Refs` 获取来源题号

### ➕ 追加新 missed question（未来更新）

1. 将新的 `.md` 文件加入此文件夹
2. 识别题目标签中的 AWS 服务
3. 在下方对应服务章节中找到 → 在 **"考试关键知识点"** 下追加新事实
4. 将题号追加到 `📝 Q Refs`
5. 如果某服务尚不存在，在相应服务域下新增子章节
6. 更新上方 YAML 前置元数据中的 `updated:` 日期

> **💡 提示**：当你在新 missed question 中遇到新的相似服务对比组合时，将其添加到 "🔍 Similar Service Comparison" 索引并创建 Comparison 条目。

---

## 🌐 跨领域概念 (Cross-Cutting Concepts)

这些架构模式跨越多个服务 —— 支撑着 Well-Architected Framework。

| 概念 | 关键 AWS 服务 | 常见考试角度 |
|---|---|---|
| **高可用 (HA)** | Multi-AZ, ALB, Auto Scaling, Route 53 | 主备 (active-passive) vs 双活 (active-active)，AZ 故障恢复 |
| **灾难恢复 (DR)** | RPO/RTO, Pilot Light, Warm Standby, Multi-Region | RPO/RTO 权衡，跨区域复制策略 |
| **成本优化** | Savings Plans, Spot Instances, S3 Lifecycle, Compute Optimizer | 合理配置 (rightsizing)，预留模式，存储分层 |
| **安全** | IAM, KMS, SCP, Security Groups, NACLs, WAF, Shield | 最小权限，纵深防御，静态/传输加密 |
| **解耦** | SQS, SNS, EventBridge, Step Functions | 松耦合 vs 紧耦合，异步模式 |
| **Serverless** | Lambda, API Gateway, DynamoDB, Fargate, Step Functions | 何时不应使用 Serverless，冷启动，超时限制 |
| **多账户治理** | Organizations, SCP, Control Tower, RAM, CloudFormation StackSets | OU 设计，策略继承，委托管理 |
| **部署策略** | Blue/Green, Canary, Rolling, All-at-Once | ELB 目标组权重，Route 53 加权路由 |

---

## 1. 💻 计算 (Compute)

### EC2 (Elastic Compute Cloud)

- **概述**：云中的虚拟机 —— 核心计算原语。实例族按计算、内存、存储、GPU 优化。
- **🔄 Azure 对应**：Azure Virtual Machines
- **🔄 Azure 对照**：类似 Azure VM，但：(1) EBS 卷独立挂载 vs Managed Disks，(2) 实例类型命名不同（`m7i.large` vs `Standard_D2s_v5`），(3) security groups = NSGs，(4) key pairs = SSH keys。EC2 有更细粒度的购买选项（On-Demand, Reserved, Savings Plans, Spot, Dedicated Hosts）。
- **考试关键知识点**（源自 missed question）：
  - **Placement Groups（置放群组）**：Cluster（低延迟，同 AZ），Spread（关键实例分散到不同硬件，每 AZ 最多 7 个），Partition（大规模分布式负载，每 AZ 最多 7 个分区）。Cluster 置放群组为 HPC 负载提供最高吞吐量。*(Q#195)*
  - **增强网络 (Enhanced Networking)**：ENA（最高 100 Gbps）和 EFA（用于 HPC/ML，OS-bypass）。配合置放群组发挥完整性能。*(Q#195)*
  - **Capacity Reservations（容量预留）**：On-Demand Capacity Reservations 保证特定 AZ 的容量；不同于 Reserved Instances（后者是计费折扣）。*(Q#20)*
  - **Spot Instances（竞价实例）**：最高节省 90%，可能被 2 分钟警告终止。使用 Spot Fleet 搭配多种实例类型 + 购买选项实现多样化。*(Q#129, Q#205, Q#247)*
  - **VM Import/Export**：将本地 VM 迁移到 EC2，导出 OVF → 上传 S3 → 运行 `ec2 import-image` CLI 命令。保留软件和配置。*(Q#50)*
  - **EC2 Instance Connect**：通过 AWS API 推送临时 SSH 密钥 —— CloudTrail 可审计，无需长期 SSH 密钥。*(Q#254)*
- **常见误区**：
  - ❌ 混淆 Capacity Reservations（保证容量）与 Reserved Instances（计费折扣）
  - ❌ 认为 Spot 可靠 —— 始终要为中断做设计
  - ❌ 在 HPC 场景使用 Spread 置放群组（应使用 Cluster，而非 Spread）
- **📝 Q Refs**：#20, #35, #39, #49, #50, #90, #96, #108, #109, #110, #129, #152, #161, #164, #195, #205, #206, #208, #209, #233, #250, #252, #254

### EC2 Auto Scaling

- **概述**：根据需求自动调整 EC2 容量。使用 Launch Templates（或旧版 Launch Configurations）定义实例规格。
- **🔄 Azure 对应**：Azure Virtual Machine Scale Sets (VMSS)
- **🔄 Azure 对照**：类似 VMSS 但：(1) Launch Templates 定义启动内容，(2) ASG lifecycle hooks 允许在启动/终止时执行自定义操作，(3) 扩缩容策略更细粒度（target tracking, step, simple, scheduled）。在 Azure DevOps 中，用 pipeline tasks 更新 VMSS 镜像 —— 类似于更新 Launch Templates。
- **考试关键知识点**（源自 missed question）：
  - **基于属性的实例选择 (Attribute-Based Instance Selection)**：定义实例需求（vCPU、内存）而非硬编码实例类型。ASG 自动从跨代匹配类型中择优选择。*(Q#129, Q#233)*
  - **Scale-In Protection（缩容保护）**：防止特定实例在缩容时被终止 —— 对有状态负载或正处理消息的实例至关重要。*(Q#110)*
  - **Lifecycle Hooks（生命周期钩子）**：在实例启动/终止时暂停，执行自定义脚本（如安装软件、排空连接）。*(Q#10)*
  - **与 SQS 集成**：基于队列深度（`ApproximateNumberOfMessagesVisible`）扩缩容。*(Q#110)*
- **常见误区**：
  - ❌ Spot Fleets 中只使用单一实例类型 —— 应多样化以保证可用性
  - ❌ 忘记将 Launch Templates 附加到 ASG（新功能必须使用）
- **📝 Q Refs**：#4, #10, #25, #29, #32, #33, #90, #108, #110, #129, #152, #204, #208, #209, #222, #233, #251

### Lambda

- **概述**：Serverless 计算 —— 无需预置服务器即可运行代码。按请求 + 时长付费。最长超时 15 分钟，最大内存 10 GB。
- **🔄 Azure 对应**：Azure Functions
- **🔄 Azure 对照**：与 Azure Functions 非常相似。关键区别：(1) Lambda 有 200+ AWS 服务集成作为触发器 vs Azure Functions bindings，(2) Lambda 使用 IAM execution role 管理权限 vs Azure Managed Identity，(3) Lambda Layers = 共享代码依赖，(4) 原生没有 Durable Functions 等价物 —— 使用 Step Functions。
- **考试关键知识点**（源自 missed question）：
  - **Versions & Aliases（版本与别名）**：`$LATEST` 可变；编号版本是不可变快照。别名（如 `prod`, `staging`）指向特定版本，支持加权流量切换实现部署。*(Q#120)*
  - **Lambda@Edge**：在 CloudFront 边缘节点运行 Lambda —— 用于请求/响应操纵（如 URL 重写、请求头注入、A/B 测试）。不适合重计算。*(Q#5, Q#235)*
  - **Lambda in VPC**：VPC 内的 Lambda 会在你的子网中创建 ENI —— 可访问 VPC 资源（RDS, ElastiCache）。注意：这会增加冷启动延迟，且需要 NAT Gateway 才能访问互联网。
  - **Docker/Lambda**：最大 10 GB 的容器镜像可部署到 Lambda（存储在 ECR）。如果负载是事件驱动且短时执行，首选 Lambda 而非 ECS/Fargate。*(Q#122)*
  - **Concurrency（并发）**：Reserved concurrency = 保证容量；Provisioned concurrency = 无冷启动。每个账户每个区域有突发限制。*(Q#17)*
  - **集成**：与 API Gateway, S3 事件, DynamoDB Streams, SQS, SNS, EventBridge, Kinesis 紧密集成。*(Q#131, Q#142, Q#143)*
- **常见误区**：
  - ❌ 用 Lambda 处理长时间运行任务（> 15 分钟）—— 应使用 Step Functions 或 EC2
  - ❌ Lambda@Edge 有不同限制（viewer 事件：5 秒超时，128 MB 内存上限）
  - ❌ 忘记 VPC 内 Lambda 需要 NAT Gateway 访问互联网 → 成本影响
- **📝 Q Refs**：#5, #10, #14, #17, #33, #35, #36, #40, #48, #82, #88, #92, #96, #98, #109, #111, #112, #113, #115, #120, #122, #131, #142, #143, #160, #164, #204, #206, #212, #223, #247

### Elastic Beanstalk

- **概述**：PaaS —— 无需管理底层基础设施即可部署应用程序（Java, .NET, Node, Python, Docker, Go, PHP）。自动预置 EC2, ASG, ELB, RDS。
- **🔄 Azure 对应**：Azure App Service
- **🔄 Azure 对照**：与 Azure App Service 非常相似。区别：Elastic Beanstalk 让你完全访问底层资源（可以 SSH 进入 EC2），而 App Service 更抽象。基于你的 Azure DevOps 背景：部署到 Elastic Beanstalk 可以使用 `aws elasticbeanstalk create-application-version` —— 类似 `az webapp deploy`。
- **考试关键知识点**（源自 missed question）：
  - **Blue/Green 部署**：通过 CNAME 交换环境 URL —— 新环境（green）验证通过后，Route 53 CNAME 指向 green。零停机。*(Q#225)*
  - **部署策略**：All at Once（最快，有停机），Rolling（逐批更新），Rolling with Additional Batch（无容量损失，成本更高），Immutable（新 ASG，最安全），Traffic Splitting（canary 测试）。*(Q#69)*
  - **快速回滚**：Immutable 部署支持最快回滚 —— 旧 ASG 仍在运行。*(Q#69)*
- **常见误区**：
  - ❌ Beanstalk 环境内创建的 RDS 与环境绑定 —— 生产环境应单独创建 RDS
  - ❌ .NET on Linux 自 2021 年起已支持 —— 不要假设 .NET 仅限 Windows
- **📝 Q Refs**：#29, #69, #85, #225

### AWS Batch

- **概述**：全托管批处理 —— 动态预置 EC2 或 Fargate 资源。针对大规模批处理作业优化（基因组学、金融建模、ETL）。
- **🔄 Azure 对应**：Azure Batch
- **🔄 Azure 对照**：与 Azure Batch 几乎相同。两者都管理作业队列、计算环境和自动扩缩容。AWS Batch 与 Step Functions 集成以编排工作流。*(Q#104, Q#107)*
- **考试关键知识点**（源自 missed question）：
  - **Managed vs Unmanaged Compute**：Managed = AWS 预置和扩缩容 EC2/Fargate；Unmanaged = 自行管理。
  - **与 Step Functions 集成**：复杂多步骤批处理工作流由 Step Functions 编排 AWS Batch 作业。*(Q#104)*
- **📝 Q Refs**：#104, #107, #204

---

## 🔍 Similar Service Comparison — Compute

### Lambda 🆚 ECS 🆚 Fargate 🆚 EC2 — 何时选择哪个？

| 标准 | Lambda | ECS on Fargate | ECS on EC2 | EC2（裸机） |
|---|---|---|---|---|
| **最大运行时间** | 15 分钟 | 无限制 | 无限制 | 无限制 |
| **冷启动** | 有（通过 Provisioned Concurrency 缓解） | 无（热容器） | 无 | 无（始终热） |
| **OS/内核控制** | 无 | 无（Fargate） | 有（EC2 宿主机） | 完全控制 |
| **扩缩容速度** | 即时（按请求） | 快速（Service Auto Scaling） | 中等 | 中等 + 冷却期 |
| **最适合** | 事件驱动、短时、波动 | 稳态微服务、API | 需要宿主机调优的容器化应用 | 遗留系统直接迁移（lift-and-shift），完全控制 |
| **Azure 对应** | Azure Functions | Azure Container Apps | 带 VM 节点池的 AKS | Azure VMs |

**考试信号**：题目说 "event-driven"、"no servers to manage"、"short execution" → Lambda。说 "containerized"、"Docker"、"long-running service" → ECS/EKS。说 "control over OS"、"kernel modules"、"legacy app" → EC2。

> 📝 **Related Qs**：#100, #104, #122, #204

### Spot Instances 🆚 Reserved Instances 🆚 Savings Plans 🆚 On-Demand

| 购买选项 | 折扣 | 承诺期 | 灵活性 | 最适合 |
|---|---|---|---|---|
| **On-Demand** | 无 | 无 | 最大 | 不可预测、短期 |
| **Spot** | 最高 90% | 无 | 可被中断 | 无状态、容错、批处理 |
| **Reserved Instances** | 最高 72% | 1 或 3 年，AZ 特定 | 有限（可修改） | 稳态、可预测 |
| **Savings Plans** | 最高 72% | 1 或 3 年，$/小时承诺 | 高（任意实例族、区域） | 现代、灵活的承诺 |
| **Compute Savings Plans** | 最高 66% | 1 或 3 年 | 任意实例族 + Lambda + Fargate | 最灵活 |

**考试信号**："Most cost-effective for steady workload" → Reserved/Savings Plans。"Fault-tolerant, stateless" → Spot。"Need flexibility across services" → Compute Savings Plans。

> 📝 **Related Qs**：#20, #119, #129, #205, #247

---

## 2. 📦 容器 (Containers)

### ECS (Elastic Container Service)

- **概述**：AWS 原生容器编排。两种启动类型：EC2（自行管理节点）和 Fargate（Serverless）。
- **🔄 Azure 对应**：Azure Container Apps / Azure Container Instances
- **考试关键知识点**（源自 missed question）：
  - **ECS + Fargate**：无需管理 EC2 —— 每个 task 获得隔离 ENI。运维最简。*(Q#100, Q#122)*
  - **ECS + EC2**：自行管理集群，更多控制。使用 placement constraints/strategies 控制 task 放置。*(Q#100)*
  - **ECR 集成**：容器镜像存储在 ECR。通过 ECR Scan（Basic 或 Enhanced）进行 CVE 镜像扫描。*(Q#175)*
  - **ECS Exec**：类 SSH 方式进入运行中的容器进行调试。*(Q#175)*
- **📝 Q Refs**：#100, #122, #146, #175, #204, #234

### EKS (Elastic Kubernetes Service)

- **概述**：托管 Kubernetes 控制平面。可在 EC2 或 Fargate 上运行。适用于已有 Kubernetes 工作流的组织。
- **🔄 Azure 对应**：Azure Kubernetes Service (AKS)
- **🔄 Azure 对照**：你提到不熟悉 Kubernetes —— EKS 是 AWS 的托管 K8s。基于你的背景，ECS（AWS 原生）或 Fargate 可能比 EKS 更相关。考试考查何时选择 EKS（已有 K8s 投入、多云可移植性）vs ECS（AWS 原生、更简单）。
- **考试关键知识点**（源自 missed question）：
  - **EKS on Fargate**：Serverless Pod —— 无需节点管理。*(Q#179)*
  - **Global Accelerator + EKS**：为多区域 EKS 集群使用 Global Accelerator —— 提供静态 anycast IP 和改善的延迟。*(Q#162)*
- **📝 Q Refs**：#100, #119, #162, #179

### ECR (Elastic Container Registry)

- **概述**：托管 Docker/OCI 容器注册表。与 ECS, EKS, Lambda（容器镜像）集成。漏洞扫描。
- **🔄 Azure 对应**：Azure Container Registry (ACR)
- **考试关键知识点**（源自 missed question）：
  - **Image Scanning（镜像扫描）**：Enhanced scanning 与 Amazon Inspector 集成，实现持续 CVE 检测。*(Q#175)*
  - **跨账户访问**：使用 repository policies 或 IAM roles。*(Q#107)*
- **📝 Q Refs**：#107, #122, #175

### Fargate

- **概述**：Serverless 容器计算引擎 —— 同时支持 ECS 和 EKS。无需管理 EC2。
- **🔄 Azure 对应**：Azure Container Instances (ACI) 或 Azure Container Apps
- **📝 Q Refs**：#100, #115, #122, #146, #204

---

## 🔍 Similar Service Comparison — Containers

### ECS 🆚 EKS — 何时选择哪个？

| 因素 | ECS | EKS |
|---|---|---|
| **生态** | AWS 原生 | Kubernetes (CNCF) |
| **复杂度** | 较低 | 较高 |
| **多云可移植性** | 否（仅 AWS） | 是（标准 K8s manifests） |
| **已有投入** | 最小学习曲线 | 利用已有 K8s 投入 |
| **考试触发词** | "Minimizing operational overhead"、"AWS-native" | "Existing Kubernetes tools"、"multi-cloud"、"Helm charts" |

> 📝 **Related Qs**：#100, #162, #179

---

## 3. 💾 存储 (Storage)

### S3 (Simple Storage Service)

- **概述**：对象存储 —— 无限规模，99.999999999%（11 个 9）持久性。对象最大 5 TB。支持存储类以实现成本优化。
- **🔄 Azure 对应**：Azure Blob Storage
- **🔄 Azure 对照**：类似 Azure Blob 但：(1) S3 存储类更多（8 vs 4），(2) bucket policies = SAS tokens + access policies 的组合，(3) S3 Object Lock = immutable blob storage，(4) S3 Event Notifications = Azure Event Grid blob triggers。在你的 DevOps pipeline 中，`aws s3 sync` = `az storage blob upload-batch`。
- **考试关键知识点**（源自 missed question）：
  - **存储类 (Storage Classes)**：Standard（频繁访问）→ Intelligent-Tiering（自动迁移）→ Standard-IA（不频繁，最少 30 天）→ One Zone-IA → Glacier Instant Retrieval（毫秒级检索）→ Glacier Flexible Retrieval（分钟到小时级）→ Glacier Deep Archive（12 小时，最便宜）。*(Q#65, Q#246)*
  - **S3 Intelligent-Tiering**：基于访问模式自动在 Frequent 和 Infrequent 层之间移动对象。无检索费，无运维开销。成本：每个对象的监控费。*(Q#65)*
  - **S3 Storage Lens**：组织级存储使用情况、活动趋势和成本优化建议的可见性。默认 14 天指标；高级指标（15 个月）需额外成本。*(Q#66)*
  - **S3 Replication（复制）**：CRR（Cross-Region Replication）用于 DR/合规，SRR（Same-Region）用于日志聚合。复制要求源和目标均启用 versioning。*(Q#28, Q#105)*
  - **S3 Access Points（访问点）**：命名的网络端点，带专用权限 —— 简化跨账户共享数据集的访问管理。可限制到 VPC。*(Q#224)*
  - **S3 Event Notifications（事件通知）**：在对象 create/delete/restore 事件上触发 Lambda, SQS 或 SNS。*(Q#113)*
  - **S3 + CloudFront**：Origin Access Control (OAC) 替代 Origin Access Identity (OAI)。将 S3 存储桶访问限制为仅 CloudFront。*(Q#5, Q#28, Q#235)*
  - **S3 + Transfer Family**：托管 SFTP/FTPS/FTP 接口到 S3。*(Q#49, Q#113, Q#230)*
- **常见误区**：
  - ❌ CRR vs S3 Sync：CRR 是自动且持续的；S3 sync 是一次性批量操作
  - ❌ S3 Object Lock 需要 versioning —— 没有它无法启用
  - ❌ Intelligent-Tiering 有按对象监控费（约 $0.0025/1000 对象）—— 不适合极小对象
- **📝 Q Refs**：#10, #15, #18, #28, #31, #34, #49, #60, #65, #66, #78, #83, #92, #105, #107, #109, #113, #115, #120, #122, #130, #134, #136, #158, #224, #236, #246

### EBS (Elastic Block Store)

- **概述**：EC2 的块级存储卷。类型：gp3/gp2 (SSD), io2/io1 (Provisioned IOPS), st1/sc1 (HDD)。快照存储在 S3 中。
- **🔄 Azure 对应**：Azure Managed Disks
- **🔄 Azure 对照**：类似 Managed Disks 但：(1) EBS 是 AZ 范围的（不能跨 AZ 挂载），(2) 快照是增量式的并存储在 S3 中，(3) EBS Multi-Attach（仅 io2）= shared disks。gp3 = Premium SSD，io2 = Ultra Disk。
- **考试关键知识点**（源自 missed question）：
  - **Encryption by Default（默认加密）**：可按区域启用 —— 所有新 EBS 卷均使用 KMS 静态加密。*(Q#253)*
  - **EBS vs Instance Store**：EBS 持久化；Instance Store（临时）物理挂载，停止/终止后丢失。
  - **DLM (Data Lifecycle Manager)**：自动化快照创建、保留和跨账户复制。*(Q#114, Q#245)*
- **📝 Q Refs**：#86, #102, #195, #253

### EFS (Elastic File System)

- **概述**：托管 NFS 文件系统 —— 可扩展、弹性、多 AZ。仅限 Linux。三种存储类：Standard, Infrequent Access, Archive。
- **🔄 Azure 对应**：Azure Files (SMB/NFS) 或 Azure NetApp Files
- **考试关键知识点**（源自 missed question）：
  - **Multi-AZ**：EFS 是区域级的 —— 可从区域内任意 AZ 访问。
  - **EFS + Transfer Family**：EFS 可作为 Transfer Family SFTP 端点的后端。*(Q#230)*
- **📝 Q Refs**：#11, #179, #230

### FSx

- **概述**：托管 Windows (SMB) 或 Lustre (HPC) 文件系统。FSx for Windows = 托管 Windows File Server；FSx for Lustre = 高性能计算负载。
- **🔄 Azure 对应**：Azure NetApp Files / Azure Files
- **考试关键知识点**（源自 missed question）：
  - **FSx for Windows**：支持 SMB, DFS, Active Directory 集成。与 WorkSpaces 配合存储用户配置文件。*(Q#108, Q#112, Q#153)*
  - **FSx for Lustre**：亚毫秒延迟，与 S3 集成（懒加载数据）。用于 HPC, ML, 媒体处理。*(Q#18, Q#130)*
  - **FSx + DataSync**：DataSync 可将本地文件数据迁移到 FSx for Windows。*(Q#27)*
- **📝 Q Refs**：#18, #27, #108, #112, #130, #153

### Storage Gateway

- **概述**：混合云存储 —— 本地设备（VM）连接到 S3。三种类型：File Gateway (NFS/SMB → S3), Volume Gateway (iSCSI → EBS snapshots), Tape Gateway（虚拟磁带库 → S3 Glacier）。
- **🔄 Azure 对应**：Azure File Sync / Azure Stack Edge
- **考试关键知识点**（源自 missed question）：
  - **File Gateway**：提供以 S3 为后端的 NFS/SMB 共享。支持 S3 Lifecycle 策略 —— 热数据本地缓存，冷数据存入 S3 Glacier。*(Q#230, Q#246)*
  - **与 DataSync 不同**：Storage Gateway 提供持续访问；DataSync 用于迁移/同步。*(Q#107)*
- **📝 Q Refs**：#49, #107, #116, #246

### AWS Transfer Family

- **概述**：托管 SFTP, FTPS, FTP 服务，以 S3 或 EFS 为后端。支持通过 Service Managed, AD 或自定义 IdP 进行身份认证。
- **🔄 Azure 对应**：Azure SFTP（预览版，基于 Blob Storage）
- **考试关键知识点**（源自 missed question）：
  - **高可用 (HA)**：多 AZ 部署 —— Elastic IPs 支持故障转移。*(Q#49, Q#230)*
  - **后端选择**：S3 或 EFS —— S3 适合简单对象访问，EFS 适合 POSIX 兼容文件操作。*(Q#230)*
- **📝 Q Refs**：#49, #113, #230

---

## 🔍 Similar Service Comparison — Storage & Data Transfer

### S3 Replication (CRR/SRR) 🆚 DataSync 🆚 Storage Gateway 🆚 Snow Family

| 服务 | 方向 | 使用场景 | 延迟 | 带宽 |
|---|---|---|---|---|
| **S3 CRR** | S3 → S3（跨区域） | DR 合规，减少延迟 | 近实时 | S3 吞吐量 |
| **DataSync** | 本地 ↔ AWS | 迁移、定期数据传送 | 按计划 | 每 agent 最高 10 Gbps |
| **Storage Gateway** | 本地 → AWS（缓存） | 混合访问，分层到云 | 持续（缓存） | 本地网络速度 |
| **Snow Family** | 物理设备 | 大规模离线传送（>10 TB） | 数天-数周（物理） | 设备容量 |

**考试信号**："Migrate petabytes" → Snowball。"Ongoing hybrid access" → Storage Gateway。"Fast online migration" → DataSync。"Automatic cross-region DR" → S3 CRR。

> 📝 **Related Qs**：#27, #28, #105, #107, #116, #130, #158, #246

### S3 🆚 EBS 🆚 EFS 🆚 FSx — 不同负载的存储选择

| 存储 | 类型 | 访问方式 | 多 AZ | EC2 共享 | 最适合 |
|---|---|---|---|---|---|
| **S3** | Object | HTTP/API | 区域级（始终） | 任意实例通过 API | 静态资源、数据湖、备份 |
| **EBS** | Block | 操作系统级（挂载） | AZ 范围 | 单个实例（除 io2 Multi-Attach） | 启动卷、数据库、低延迟应用 |
| **EFS** | File (NFS) | 挂载 (NFSv4) | 区域级 | 多实例同时 | 共享代码仓库、CMS、Web 服务 |
| **FSx** | File (SMB/Lustre) | 挂载 | 多 AZ (Windows) | 多实例 | Windows 负载、HPC |

**考试信号**："Shared across many EC2 instances" + "Linux" → EFS。"Windows, AD integration" → FSx for Windows。"High throughput for HPC" → FSx for Lustre。"Boot volume" → EBS。

> 📝 **Related Qs**：#11, #15, #18, #130, #179, #230

---

## 4. 🗄️ 数据库 (Database)

### RDS (Relational Database Service)

- **概述**：托管关系型数据库 —— MySQL, PostgreSQL, MariaDB, Oracle, SQL Server。Multi-AZ 实现 HA，Read Replicas 实现读扩展。
- **🔄 Azure 对应**：Azure SQL Database / Azure Database for MySQL/PostgreSQL
- **🔄 Azure 对照**：类似 Azure SQL DB 但：(1) RDS 给你更多控制（选择实例类型、存储、维护窗口），(2) Multi-AZ 使用同步复制 vs Azure 的自动故障转移组，(3) Read Replicas 使用异步复制。
- **考试关键知识点**（源自 missed question）：
  - **加密**：静态通过 KMS；传输中通过 SSL/TLS。IAM DB Authentication 实现无密码访问（仅 MySQL/PostgreSQL）。*(Q#160, Q#253)*
  - **Multi-AZ**：在不同 AZ 部署同步备用副本 —— 自动故障转移。不用于扩展（备用副本是被动的）。*(Q#29, Q#61)*
  - **Cross-Region Read Replica**：异步复制到另一区域实现 DR。可提升为主实例。*(Q#61, Q#213)*
  - **RDS Proxy**：为 Lambda/Serverless 提供连接池 —— 减少连接开销。跨 Lambda 调用共享连接。*(Q#40)*
  - **备份**：自动备份（时间点恢复，最多保留 35 天）+ 手动快照。支持跨账户快照共享。*(Q#245)*
  - **RDS 上的 SQL Server**：Babelfish for Aurora 在 PostgreSQL 上实现 SQL Server 应用兼容性。*(Q#161)*
- **📝 Q Refs**：#21, #40, #60, #61, #84, #86, #96, #119, #160, #161, #180, #245, #247, #251

### Aurora

- **概述**：MySQL/PostgreSQL 兼容，标准 MySQL 的 5 倍吞吐量，PostgreSQL 的 3 倍。自动扩缩容存储（10 GB → 128 TB）。计算和存储层分离。
- **🔄 Azure 对应**：Azure Cosmos DB（for PostgreSQL）或 Azure Database for PostgreSQL Hyperscale (Citus)
- **考试关键知识点**（源自 missed question）：
  - **Aurora Global Database**：跨区域复制，典型延迟 < 1 秒。1 个主区域 + 最多 5 个辅助区域。辅助区域可提升用于 DR。RPO 约 1 秒，RTO < 1 分钟。*(Q#213, Q#227)*
  - **Aurora Auto Scaling**：Read replicas 基于负载自动扩缩容。最多 15 个副本。*(Q#4)*
  - **Aurora Serverless v2**：在几分之一秒内自动扩缩容量。用于波动/不可预测负载。*(Q#4)*
  - **Backtrack**：将数据库回退到某个时间点，无需恢复。仅限 Aurora MySQL。*(Q#213, Q#227)*
  - **Babelfish**：在 Aurora PostgreSQL 上运行 SQL Server 应用，代码改动极小。T-SQL 兼容。*(Q#161)*
- **📝 Q Refs**：#4, #29, #40, #92, #114, #161, #213, #227, #234, #236, #251

### DynamoDB

- **概述**：全托管 NoSQL 键值和文档数据库。任意规模下单毫秒级性能。Serverless。
- **🔄 Azure 对应**：Azure Cosmos DB
- **🔄 Azure 对照**：与 Cosmos DB 非常相似。两者都是 Serverless NoSQL，支持全球分布。区别：(1) DynamoDB 使用 provisioned capacity 或 on-demand，Cosmos DB 使用 Request Units，(2) DynamoDB Global Tables = Cosmos DB multi-region writes，(3) DynamoDB Streams = Cosmos DB change feed。
- **考试关键知识点**（源自 missed question）：
  - **Global Tables**：多活（任意区域读写），最终一致性。基于 DynamoDB Streams 构建。冲突解决：last-writer-wins。*(Q#2, Q#105, Q#121)*
  - **DynamoDB Streams**：有序的条目级变更序列。24 小时保留。触发 Lambda。是 Global Tables 的基础。*(Q#105)*
  - **DAX (DynamoDB Accelerator)**：DynamoDB 的内存缓存 —— 读密集型负载微秒级延迟。直写缓存 (write-through)。不是 ElastiCache 的替代品（后者适用于任何数据库）。*(Q#199)*
  - **容量模式**：Provisioned（可预测、更便宜）vs On-Demand（自动扩缩容、按请求付费、约 2 倍成本）。Provisioned 模式配合 Application Auto Scaling 使用。*(Q#32, Q#222)*
  - **WCU/RCU**：Write Capacity Units（1 WCU = 1 KB 条目 1 次写入/秒），Read Capacity Units（1 RCU = 4 KB 条目 1 次强一致性读取/秒，或 2 次最终一致性读取）。*(Q#222)*
  - **属性级访问控制 (Attribute-Level Access Control)**：IAM 策略可限制对 DynamoDB 条目中特定属性（列）的访问。*(Q#148)*
- **📝 Q Refs**：#32, #60, #101, #105, #120, #121, #131, #148, #179, #199, #222, #223, #234

### ElastiCache

- **概述**：托管 Redis 或 Memcached 内存缓存。Redis：多 AZ、持久化、pub/sub、地理空间；Memcached：简单、多线程。
- **🔄 Azure 对应**：Azure Cache for Redis
- **考试关键知识点**（源自 missed question）：
  - **Redis**：会话存储、排行榜、实时分析、地理空间。Multi-AZ 自动故障转移。*(Q#251)*
  - **Reserved Nodes**：类似 Reserved Instances 但用于 ElastiCache。1-3 年承诺可获显著折扣（最高约 60%）。*(Q#247)*
- **📝 Q Refs**：#247, #251

### 其他数据库

- **DocumentDB**：MongoDB 兼容（3.6/4.0/5.0 API），托管。用于现有 MongoDB 负载迁移到 AWS。*(Q#106)*
- **Redshift**：PB 级数据仓库，列式存储。Concurrency Scaling 用于突发查询负载。Elastic Resize 用于快速调整集群大小。*(Q#243)*
- **OpenSearch Service**：托管 Elasticsearch/Kibana 继任者。UltraWarm 用于不频繁访问数据，Cold Storage 用于很少访问的数据。*(Q#34)*
- **DMS (Database Migration Service)**：以最小停机时间将数据库迁移到 AWS。支持 homogeneous（相同引擎）和 heterogeneous（不同引擎）。SCT (Schema Conversion Tool) 用于 heterogeneous 模式转换。*(Q#84, Q#114, Q#158, Q#180, Q#236)*
- **📝 Q Refs**：#34, #84, #106, #114, #158, #180, #236, #243

---

## 🔍 Similar Service Comparison — Database

### RDS 🆚 Aurora 🆚 DynamoDB — 选择你的数据库

| 标准 | RDS | Aurora | DynamoDB |
|---|---|---|---|
| **数据模型** | 关系型 (SQL) | 关系型 (MySQL/PG 兼容) | 键值 / 文档 (NoSQL) |
| **可扩展性** | 垂直 + Read Replicas（最多 5 个） | 自动扩缩容存储 + 最多 15 个副本 | 水平扩展，无上限 |
| **全球** | Cross-Region Read Replica | Aurora Global Database（< 1 秒延迟） | Global Tables（多活） |
| **性能** | 标准 | 5 倍 MySQL / 3 倍 PG 吞吐 | 任意规模单毫秒级 |
| **Serverless** | 否 | Aurora Serverless v2 | On-Demand 模式 |
| **最适合** | 传统应用、连接、事务 | 高吞吐 OLTP、SaaS | Web/移动/游戏、IoT、会话存储 |
| **Azure 对应** | Azure SQL DB | Cosmos DB / Hyperscale | Cosmos DB |

**考试信号**："Relational, complex joins" → RDS 或 Aurora。"Need 5x MySQL performance" → Aurora。"Unpredictable scale, key-value, serverless" → DynamoDB。

> 📝 **Related Qs**：#40, #60, #92, #106, #179

### DMS 🆚 DataSync 🆚 SCT — 迁移工具

| 工具 | 迁移什么 | 方向 | 备注 |
|---|---|---|---|
| **DMS** | 数据库（持续复制） | 本地 → AWS, AWS ↔ AWS | CDC 实现最小停机 |
| **SCT** | 数据库模式（转换引擎） | N/A（模式转换） | 与 DMS 配合用于 heterogeneous |
| **DataSync** | 文件/对象 | 本地 ↔ AWS | 不用于数据库 |

> 📝 **Related Qs**：#84, #114, #158, #236

### ElastiCache 🆚 DAX 🆚 CloudFront 缓存

| 缓存层 | 范围 | 延迟 | 最适合 |
|---|---|---|---|
| **CloudFront** | Edge（全球） | ~毫秒（缓存命中） | 静态/动态内容、API 响应 |
| **DAX** | 仅 DynamoDB | 微秒级 | 读密集型 DynamoDB 负载 |
| **ElastiCache** | 任何数据库/应用 | 亚毫秒 | 会话存储、排行榜、查询缓存 |

> 📝 **Related Qs**：#199, #235, #247, #251

---

## 5. 🌐 网络与内容分发 (Networking & Content Delivery)

### VPC (Virtual Private Cloud)

- **概述**：AWS 中的隔离虚拟网络。基于 CIDR。子网（公有/私有）、路由表、Internet Gateway、NAT Gateway、Network ACLs、Security Groups。
- **🔄 Azure 对应**：Azure Virtual Network (VNet)
- **🔄 Azure 对照**：与 VNet 非常相似。区别：(1) VPC 子网是 AZ 范围的（一个子网 = 一个 AZ），Azure 子网跨 AZ，(2) security groups 是有状态的、实例级应用（类似 NSG 但有状态），NACLs 是无状态的、子网级（类似 Azure NSG 但无状态），(3) VPC 有 IGW 用于互联网、NAT Gateway 用于仅出站、VPC Endpoints 用于私有访问 AWS 服务。在 Azure DevOps pipeline 中，`aws ec2 create-vpc` = `az network vnet create`。
- **考试关键知识点**（源自 missed question）：
  - **重叠 CIDR**：不能 Peering 重叠 CIDR 的 VPC。使用 PrivateLink 或带 NAT 的 Transit Gateway。*(Q#135)*
  - **Security Groups vs NACLs**：SG = 有状态（回程流量自动允许），实例级。NACL = 无状态（必须显式允许回程），子网级。*(Q#108)*
  - **Transit Gateway**：Hub-and-spoke 网络架构 —— 连接数千 VPC 和本地网络。路由表控制流量流向。大规模场景优于 VPC peering（网状）。*(Q#1, Q#62, Q#81, Q#95, Q#218)*
  - **VPC Endpoints**：无需互联网即可私有连接 AWS 服务。Gateway endpoints（S3, DynamoDB —— 免费）。Interface endpoints（大多数其他服务 —— 由 PrivateLink 提供，$ 每小时）。*(Q#8, Q#92, Q#111)*
  - **VPC Peering**：两个 VPC 之间的 1:1 连接。不可传递（A→B 且 B→C 不意味着 A→C）。不能有重叠 CIDR。*(Q#62, Q#81)*
- **📝 Q Refs**：#1, #8, #15, #31, #62, #81, #92, #108, #111, #135, #206, #210, #217, #218, #224, #250

### Route 53

- **概述**：高可用 DNS 服务。支持 Public Hosted Zones, Private Hosted Zones（用于 VPC），以及 Resolver 用于混合 DNS。
- **🔄 Azure 对应**：Azure DNS + Azure Private DNS
- **🔄 Azure 对照**：类似 Azure DNS。关键映射：Route 53 Private Hosted Zone = Azure Private DNS Zone；Route 53 Resolver = Azure DNS Private Resolver。Route 53 的路由策略（weighted, latency, geolocation, failover）比 Azure DNS 更高级。
- **考试关键知识点**（源自 missed question）：
  - **路由策略 (Routing Policies)**：Simple（无健康检查），Weighted（流量分割），Latency（最低延迟），Failover（主备），Geolocation（用户位置），Geoproximity（偏向流量），Multi-Value Answer（最多 8 个健康记录）。*(Q#2, Q#25, Q#88, Q#121)*
  - **Private Hosted Zone**：DNS 记录仅在关联的 VPC 内可解析。可关联多个 VPC（跨账户通过 CLI/SDK）。*(Q#1, Q#255)*
  - **Route 53 Resolver**：混合 DNS 解析。
    - **Inbound Endpoint**：本地 → VPC DNS 查询（在 VPC 中放置 ENI，本地转发到这些 IP）。*(Q#1, Q#217)*
    - **Outbound Endpoint**：VPC → 本地 DNS 查询（本地域名的转发规则）。*(Q#217)*
  - **Resolver Rules**：将特定域名的 DNS 查询转发到特定 IP。可通过 RAM 跨账户共享。*(Q#255)*
  - **Health Checks**：通过 HTTP/HTTPS/TCP 监控端点。可绑定 Route 53 路由策略实现自动故障转移。
- **📝 Q Refs**：#1, #2, #19, #25, #28, #29, #49, #88, #121, #152, #217, #225, #234, #255

### API Gateway

- **概述**：全托管 REST, HTTP 和 WebSocket API 服务。与 Lambda, EC2 及任意 HTTP 端点集成。支持请求/响应转换、限流、缓存和 API 密钥。
- **🔄 Azure 对应**：Azure API Management
- **🔄 Azure 对照**：类似 Azure APIM。你用 Azure DevOps pipeline 部署 API —— 类似模式：`aws apigateway create-deployment` 对应 Azure DevOps release pipeline 部署到 APIM。API Gateway 的 Lambda 集成比 APIM 的 Azure Functions 集成更紧密。
- **考试关键知识点**（源自 missed question）：
  - **端点类型 (Endpoint Types)**：Regional（同区域），Edge-Optimized（通过 CloudFront），Private（仅 VPC，通过 PrivateLink）。*(Q#111)*
  - **Private API**：仅可通过 VPC Endpoint (PrivateLink) 在 VPC 内访问。Resource policy 控制哪些 VPC endpoints 可以访问。*(Q#111)*
  - **Throttling & Usage Plans**：API 密钥 + usage plans 控制每客户端速率限制。保护后端免于过载。*(Q#17)*
  - **故障转移 (Failover)**：使用 Regional 端点 + Route 53 failover（不要使用多区域 edge-optimized —— edge-optimized 是单个区域在 CloudFront 后面）。*(Q#2)*
  - **WebSocket**：API Gateway 支持 WebSocket 实现实时双向通信。*(Q#223)*
- **📝 Q Refs**：#2, #5, #14, #17, #36, #88, #111, #121, #122, #143, #162, #196, #234

### CloudFront

- **概述**：CDN —— 在全球 450+ 边缘节点缓存内容。支持静态（S3）和动态（ALB, EC2, API Gateway）源站。与 WAF, Shield, Lambda@Edge 集成。
- **🔄 Azure 对应**：Azure CDN / Azure Front Door
- **🔄 Azure 对照**：类似 Azure Front Door（全球负载均衡器 + CDN）。CloudFront 有更多边缘节点（450+ vs 190+）。关键区别：CloudFront 使用 "distributions"，Front Door 使用 "endpoints"。Lambda@Edge = Azure Front Door Rules Engine。
- **考试关键知识点**（源自 missed question）：
  - **Origin Groups**：主 + 辅助源站实现故障转移。*(Q#28)*
  - **缓存优化**：查询字符串标准化、缓存策略、源站请求策略。*(Q#235)*
  - **Lambda@Edge**：在边缘运行代码 —— 请求/响应操纵、A/B 测试、安全请求头注入。Viewer 事件（5 秒超时）vs Origin 事件（30 秒超时）。*(Q#5, Q#235)*
  - **OAC (Origin Access Control)**：限制 S3 访问仅允许 CloudFront —— 替代 OAI。*(Q#28)*
- **📝 Q Refs**：#5, #11, #14, #28, #105, #127, #162, #201, #235

### Direct Connect

- **概述**：本地与 AWS 之间的专用物理连接（通过 Direct Connect 合作伙伴或直接到 AWS）。1 Gbps, 10 Gbps, 100 Gbps。默认不加密（使用 VPN 覆盖）。
- **🔄 Azure 对应**：Azure ExpressRoute
- **🔄 Azure 对照**：与 ExpressRoute 非常相似。两者都提供专用私有连接。DC + VPN = ExpressRoute + VPN 故障转移。Direct Connect Gateway = ExpressRoute Gateway（多区域）。
- **考试关键知识点**（源自 missed question）：
  - **Direct Connect Gateway**：通过 Transit Gateway 关联将 Direct Connect 连接到跨多个区域的 VPC。*(Q#12, Q#95)*
  - **DC + VPN**：使用 Site-to-Site VPN 作为 Direct Connect 的故障转移 —— 常见企业模式。*(Q#95)*
  - **LAG (Link Aggregation Group)**：组合多个 Direct Connect 连接以获得更高带宽。
- **📝 Q Refs**：#12, #27, #95, #107, #158, #230, #255

### Transit Gateway (TGW)

- **概述**：区域网络中转枢纽 —— 连接 VPCs, VPN, Direct Connect。Hub-and-spoke 模型。路由表控制哪些附件之间可以通信。
- **🔄 Azure 对应**：Azure Virtual WAN Hub
- **🔄 Azure 对照**：类似 Virtual WAN Hub。TGW Route Tables = Virtual WAN Route Tables。TGW 是大规模 AWS 网络的中心连接构造。
- **考试关键知识点**（源自 missed question）：
  - **TGW Route Tables**：分段隔离 —— 通过将开发/生产 VPC 关联到不同路由表实现隔离。*(Q#218)*
  - **TGW + VPN**：将 Site-to-Site VPN 挂接到 TGW —— 所有连接的 VPC 都能访问本地。*(Q#62, Q#250)*
  - **TGW + DX**：将 Direct Connect Gateway 挂接到 TGW。*(Q#95)*
  - **TGW Peering**：跨区域连接 TGW 实现全球网络。*(Q#81)*
- **📝 Q Refs**：#1, #62, #81, #95, #218, #250

### 负载均衡器 (Load Balancers) — ALB, NLB, GWLB

| 负载均衡器 | OSI 层 | 协议 | 关键特性 | 使用场景 |
|---|---|---|---|---|
| **ALB** | Layer 7 | HTTP/HTTPS, gRPC | 路径/主机/请求头路由，WAF 集成 | 微服务、Web 应用 |
| **NLB** | Layer 4 | TCP/UDP/TLS | 静态 IP，超低延迟，保留客户端 IP | 游戏、IoT、金融 |
| **GWLB** | Layer 3 | All IP | 透明内联设备插入 | 防火墙、IDS/IPS、深度包检测 |

- **🔄 Azure 对应**：ALB = Azure Application Gateway；NLB = Azure Load Balancer；GWLB = Azure Firewall（大致 —— GWLB 更多关于路由到第三方设备）
- **考试关键知识点**（源自 missed question）：
  - **ALB**：支持加权目标组实现 blue/green 部署。通过基于应用的 cookie 实现 sticky sessions。*(Q#4, Q#152)*
  - **NLB**：保留源 IP；每 AZ 一个静态 IP；每 AZ 可拥有 Elastic IP。支持 TLS 终结。*(Q#19, Q#121)*
  - **ALB + WAF**：ALB 与 WAF 集成实现 Layer 7 保护。NLB 不能与 WAF 集成（仅 L4）。*(Q#146)*
  - **ALB Target Groups**：可指向 EC2, ECS, Lambda, IP 地址。健康检查确定目标健康状态。*(Q#152)*
- **📝 Q Refs**：#4, #19, #25, #29, #121, #126, #127, #146, #152, #162, #209, #251

### Global Accelerator

- **概述**：通过 AWS 全球网络路由流量，改善全球应用的可用性和性能。提供 2 个静态 Anycast IP。路由到最优区域端点。
- **🔄 Azure 对应**：Azure Front Door (Global) / Azure Traffic Manager
- **考试关键知识点**（源自 missed question）：
  - **vs CloudFront**：Global Accelerator 通过 AWS 骨干网路由（不是边缘缓存）—— 用于 TCP/UDP、游戏、VoIP、IoT。CloudFront 用于 HTTP/S 内容缓存。*(Q#121, Q#162)*
  - **静态 IP**：两个不变的 anycast IP —— 将 DNS 指向这两个 IP。*(Q#162)*
- **📝 Q Refs**：#121, #162

### 其他网络服务

- **PrivateLink (VPC Endpoint)**：通过 NLB 将你的服务私有地暴露给其他 VPC/账户。消费者通过 VPC Endpoint 访问。无重叠 CIDR 问题。*(Q#8, Q#111, Q#135)*
- **Client VPN**：基于 OpenVPN 的托管 VPN，供远程员工访问 VPC。自动扩展。*(Q#81)*
- **Site-to-Site VPN**：本地与 VPC 之间的 IPsec VPN。每个连接两个隧道实现 HA。*(Q#62, Q#217, Q#250)*
- **NAT Gateway**：托管 NAT，供私有子网仅出站访问互联网。AZ 范围（每个 AZ 需要一个以实现 HA）。挂载 Elastic IP。*(Q#206)*
- **Prefix Lists**：托管 CIDR 块集合。简化 security group 规则 —— 更新一个 prefix list 而不是多个规则。*(Q#127)*
- **📝 Q Refs**：#8, #62, #81, #111, #127, #135, #206, #217, #250

---

## 🔍 Similar Service Comparison — Networking

### VPC Peering 🆚 Transit Gateway 🆚 PrivateLink

| 特性 | VPC Peering | Transit Gateway | PrivateLink |
|---|---|---|---|
| **拓扑** | 网状（每条连接 1:1） | Hub-and-spoke | 消费者-提供者 |
| **规模** | 每 VPC 最多 125 个 peers | 数千 VPC | 一个服务 → 多个消费者 |
| **传递路由** | ❌ 否 | ✅ 是（通过路由表） | N/A（仅消费者→提供者） |
| **重叠 CIDR** | ❌ 不支持 | ❌ 不支持 | ✅ 支持（端点处 NAT） |
| **跨区域** | ✅ 是 | ✅ 是（TGW Peering） | ❌ 否（仅区域级） |
| **带宽** | 无聚合限制（每流） | 每 VPC 挂接最高 50 Gbps | 每端点最高 10 Gbps |
| **成本** | 数据传输（每 GB） | 数据传输 + 每挂接每小时 | 每端点每小时 + 数据 |

**考试信号**："Connect 3 VPCs" → 两者均可（但 TGW 更可扩展）。"Connect 100 VPCs" → TGW。"Share a service privately to many accounts" → PrivateLink。"Overlapping CIDRs" → PrivateLink。

> 📝 **Related Qs**：#8, #62, #81, #111, #135, #218

### Route 53 Resolver Inbound 🆚 Outbound Endpoints

| 端点 | 方向 | 目的 | IP |
|---|---|---|---|
| **Inbound** | 本地 → AWS | 本地解析 AWS private hosted zone 名称 | VPC 中的 ENI（你的 IP） |
| **Outbound** | AWS → 本地 | AWS 资源解析本地 DNS 名称 | VPC 中的 ENI（AWS 托管） |

**考试信号**："On-prem needs to resolve cloud.example.com" → Inbound resolver。"EC2 needs to resolve server.corp.local" → Outbound resolver。"Both ways" → 两个端点。

> 📝 **Related Qs**：#1, #217, #255

### CloudFront 🆚 Global Accelerator 🆚 Route 53 Latency Routing

| 服务 | 层 | 优化 | 静态 IP | 缓存 |
|---|---|---|---|---|
| **CloudFront** | L7 (HTTP/S) | 内容分发（缓存） | ❌（使用域名） | ✅ 是 |
| **Global Accelerator** | L4 (TCP/UDP) | 网络路径（AWS 骨干网） | ✅（2 个 anycast IP） | ❌ 否 |
| **Route 53 Latency** | DNS | DNS 解析到最低延迟端点 | N/A | ❌ 否 |

**考试信号**："Cache content globally" → CloudFront。"Gaming/VoIP/IoT, low-latency TCP/UDP" → Global Accelerator。"DNS-level latency-based routing" → Route 53 Latency。

> 📝 **Related Qs**：#11, #121, #162, #235

---

## 6. 🔐 安全、身份与合规 (Security, Identity & Compliance)

### IAM (Identity and Access Management)

- **概述**：控制谁可以对 AWS 做什么。Users, Groups, Roles, Policies。支持联合身份（SAML 2.0, OIDC）。策略评估：显式 DENY > 显式 ALLOW > 隐式 DENY。
- **🔄 Azure 对应**：Microsoft Entra ID (Azure AD) + Azure RBAC
- **🔄 Azure 对照**：你在 Azure DevOps 中使用 Azure AD 管理身份。AWS IAM roles 就像 Azure Managed Identities —— 分配权限给资源而无需凭证。IAM policies = Azure RBAC role definitions。IAM 的显式 deny > allow > 隐式 deny 与 Azure 的 denyAssignments 模式不同。
- **考试关键知识点**（源自 missed question）：
  - **IAM Roles vs Resource-Based Policies**：Role = "此主体可以做什么"；Resource policy = "谁可以访问此资源"（如 S3 bucket policy, KMS key policy）。跨账户访问：role（主体承担角色）或 resource policy（授予访问权限）。*(Q#16, Q#103, Q#117, Q#118)*
  - **IAM DB Authentication**：RDS/Aurora MySQL 和 PostgreSQL 可使用 IAM 令牌认证 —— 应用中无密码。令牌有效期 15 分钟。*(Q#92)*
  - **Permissions Boundary（权限边界）**：IAM 实体可拥有的最大权限 —— 即使附加了更宽泛的策略。防止权限提升。*(Q#148)*
  - **Access Analyzer**：分析资源策略中意外的公开/跨账户访问。生成发现结果。可在部署前验证策略。*(Q#101, Q#136)*
  - **IAM Identity Center (SSO)**：AWS 账户 + 业务应用的单点登录。与 AD 集成（通过 AD Connector 或 Managed AD）。SCIM 用于自动预置。*(Q#16, Q#56, Q#252)*
- **📝 Q Refs**：#16, #23, #24, #56, #59, #78, #92, #101, #103, #117, #118, #148, #254

### AWS Organizations & SCP

- **概述**：集中管理多个 AWS 账户。将账户组织到 OU 中。应用 SCP (Service Control Policies) —— 限制账户可使用哪些服务/操作的防护栏。
- **🔄 Azure 对应**：Azure Management Groups + Azure Policy
- **🔄 Azure 对照**：Organizations = Management Groups 层级结构；SCPs = Azure Policies（在 management group 级别）。关键区别：AWS 中的 SCP 是"权限边界"（本身不授予权限，只限制 IAM 可授予的权限），Azure Policies 评估资源合规性。
- **考试关键知识点**（源自 missed question）：
  - **SCP 评估**：SCP 限制最大权限。即使 IAM 允许，SCP 也可拒绝。Root SCP 适用于所有 OU —— 要豁免某个账户，将它移到没有该 SCP 的 OU。*(Q#3, Q#24)*
  - **Deny List vs Allow List**：Deny list（默认 FullAWSAccess，添加 deny SCPs）—— 更易管理。Allow list（移除 FullAWSAccess，添加 allow SCPs）—— 更严格，维护工作更多。*(Q#3)*
  - **SCP 继承**：父 OU 的 SCP 适用于子 OU。账户级 SCP 可更严格但不能更宽松。*(Q#24)*
  - **Tag Policies**：标准化组织内的标签。强制执行标签键、值和格式。与 Cost Explorer 配合用于成本分摊。*(Q#232)*
- **📝 Q Refs**：#3, #23, #24, #30, #35, #56, #67, #210, #224, #232, #245

### KMS (Key Management Service)

- **概述**：托管加密密钥服务。对称密钥、非对称密钥和自定义密钥存储（CloudHSM, External）。与大多数 AWS 服务集成。
- **🔄 Azure 对应**：Azure Key Vault (keys)
- **🔄 Azure 对照**：KMS 创建和管理加密密钥 —— 类似 Azure Key Vault 的密钥功能。Key policies = Key Vault access policies。KMS 主要用于加密密钥；Secrets Manager（见下文）用于应用密钥。
- **考试关键知识点**（源自 missed question）：
  - **Key Policies**：基于资源的策略，控制谁可以使用/管理密钥。默认：密钥创建者拥有完全访问权限。*(Q#78, Q#103)*
  - **自动密钥轮换 (Automatic Key Rotation)**：对称 KMS 密钥可每年自动轮换。客户托管密钥：可选，按密钥启用。*(Q#160)*
  - **跨账户访问**：通过 key policy（首选）或 IAM role 授予密钥使用权限。*(Q#103)*
- **📝 Q Refs**：#78, #83, #103, #160, #253

### Secrets Manager

- **概述**：存储和轮换密钥（数据库凭证、API 密钥、OAuth 令牌）。通过 Lambda 自动轮换。与 RDS, Redshift, DocumentDB 集成。
- **🔄 Azure 对应**：Azure Key Vault (secrets)
- **🔄 Azure 对照**：在 Azure DevOps 中，你在 pipeline 中使用 Key Vault 注入密钥 —— `AzureKeyVault@2` task。AWS 等价：CodeBuild/CodePipeline 中的 `aws secretsmanager get-secret-value`。Secrets Manager 可通过 Lambda 自动轮换 RDS 密码 —— 类似 Azure Key Vault 自动轮换。
- **考试关键知识点**（源自 missed question）：
  - **轮换 (Rotation)**：内置 RDS, Redshift, DocumentDB 的轮换。使用 Lambda 生成新密码，同时更新 Secrets Manager 和数据库。*(Q#160, Q#164)*
  - **跨账户**：通过 resource policies 共享密钥。*(Q#103)*
  - **vs Parameter Store**：Secrets Manager = 轮换、跨账户、$0.40/密钥/月；Parameter Store = 免费、无轮换、10K 参数限制。*(Q#21, Q#164)*
- **📝 Q Refs**：#21, #103, #160, #164

### WAF & Shield

- **概述**：WAF = Layer 7 Web 应用防火墙（SQL 注入, XSS, 速率限制）。Shield = DDoS 保护（Standard = 免费, Advanced = $3K/月 + 1 年承诺）。
- **🔄 Azure 对应**：Azure WAF（on Application Gateway / Front Door）+ Azure DDoS Protection
- **考试关键知识点**（源自 missed question）：
  - **WAF**：与 CloudFront, ALB, API Gateway, AppSync 关联。托管规则（AWS Managed, Marketplace）。基于 IP、国家、请求头、请求体、速率的自定义规则。*(Q#125, Q#127, Q#146, Q#196)*
  - **WAF + ALB**：仅 Layer 7 —— ALB 转发到 WAF 进行检测。NLB 不能使用 WAF（L4）。*(Q#146)*
  - **Shield Advanced**：24/7 DDoS 响应团队支持，攻击期间扩展成本保护，实时可见性。*(Q#125)*
- **📝 Q Refs**：#79, #125, #127, #146, #196

### 其他安全服务

- **CloudTrail**：API 审计日志 —— 记录每个 API 调用。Management events（控制平面）+ Data events（S3 对象级、Lambda 调用）。CloudTrail Lake 用于基于 SQL 的分析。*(Q#101, Q#254)*
- **AWS Config**：资源清单 + 合规评估。跟踪资源配置变更，按规则评估。Config rules 可通过 SSM Automation 自动修复。*(Q#3, Q#35, Q#172)*
- **Security Groups**：有状态、实例级防火墙。仅允许规则（隐式拒绝）。*(Q#35, Q#127)*
- **Certificate Manager (ACM)**：为 ALB, CloudFront, API Gateway 预置 SSL/TLS 证书。免费。自动续期。*(Q#39)*
- **Directory Service**：Managed Microsoft AD（AWS 中的完整 AD），AD Connector（代理到本地 AD），Simple AD（基于 Samba）。*(Q#16, Q#56, Q#108, Q#112, Q#153, Q#219, Q#252, Q#255)*
- **Cognito**：Web/移动应用的用户身份。User pools（认证）+ Identity pools（授权访问 AWS 服务）。*(Q#201)*
- **📝 Q Refs**：#16, #39, #56, #59, #101, #172, #201, #252, #254

---

## 🔍 Similar Service Comparison — Security

### IAM Role 🆚 SCP 🆚 Permissions Boundary — 访问控制层级

| 层级 | 范围 | 功能 | 谁设置 |
|---|---|---|---|
| **IAM Policy** | 主体 (User/Role) | 授予权限 (ALLOW) | 账户管理员 |
| **Resource Policy** | 资源 (S3, KMS 等) | 谁可以访问此资源 | 资源所有者 |
| **SCP** | OU / 账户 | 限制最大权限（防护栏） | 组织管理员 |
| **Permissions Boundary** | IAM 实体 | 限制最大权限（按实体） | 账户管理员 |
| **Session Policy** | 临时会话 | 进一步限制会话权限 | 调用者 |

**评估顺序**：全部必须 ALLOW。SCP 和 Permissions Boundary 作为过滤器 —— 即使 IAM policy 允许，SCP 仍可拒绝。

> 📝 **Related Qs**：#3, #24, #148

### Secrets Manager 🆚 Parameter Store (SSM)

| 特性 | Secrets Manager | SSM Parameter Store |
|---|---|---|
| **用途** | 应用密钥 | 配置数据 + 密钥 |
| **轮换** | ✅ 自动（Lambda） | ❌ 手动 |
| **跨账户** | ✅ 通过 resource policy | ❌ 原生不支持 |
| **成本** | $0.40/密钥/月 + API 调用 | 免费（Standard），$0.05/advanced |
| **RDS 集成** | ✅ 内置 | ❌ 手动 |
| **考试触发词** | "Automatic rotation of RDS credentials" | "Hierarchical configuration storage" |

> 📝 **Related Qs**：#21, #160, #164

### AWS Config 🆚 CloudTrail 🆚 CloudWatch

| 服务 | 用途 | 数据 | 保留 |
|---|---|---|---|
| **CloudTrail** | "谁在什么时候做了什么？" | API 调用 | 90 天（Event History），无限（Trail → S3） |
| **AWS Config** | "我的资源长什么样？" + "它合规吗？" | 资源配置 | 无限 |
| **CloudWatch** | "我的系统性能如何？" | 指标、日志、告警 | 基于日志组保留设置 |

**考试信号**："Security audit of API activity" → CloudTrail。"Track resource configuration drift" → AWS Config。"Performance monitoring and alerting" → CloudWatch。

> 📝 **Related Qs**：#3, #35, #101, #102, #172, #254

---

## 7. 🔗 应用集成 (Application Integration)

### SQS (Simple Queue Service)

- **概述**：全托管消息队列。Standard（至少一次，高吞吐）和 FIFO（精确一次，300 msg/s）。消息最多保留 14 天。
- **🔄 Azure 对应**：Azure Queue Storage / Azure Service Bus
- **🔄 Azure 对照**：你日常使用 Azure DevOps pipelines —— SQS 类似 Service Bus Queues。在 pipeline 中，你可能轮询 SQS 等待消息再继续 —— 类似检查 Service Bus 队列深度。
- **考试关键知识点**（源自 missed question）：
  - **Visibility Timeout（可见性超时）**：消息被接收后不可见的时间 —— 防止其他消费者处理。如果在超时前未删除，消息重新出现。*(Q#110)*
  - **Dead Letter Queue / DLQ（死信队列）**：超过 `maxReceiveCount` 的消息进入 DLQ。分析后可重新驱动到源队列。*(Q#110, Q#142, Q#212)*
  - **解耦模式 (Decoupling Pattern)**：生产者和消费者之间的 SQS 平滑流量高峰。生产者发送到队列；消费者按自身节奏处理。*(Q#33)*
  - **SQS + Auto Scaling**：基于队列深度（ApproximateNumberOfMessagesVisible）扩缩容 EC2。为仍在处理的实例启用缩容保护。*(Q#110)*
- **📝 Q Refs**：#33, #82, #110, #115, #131, #142, #143, #212

### SNS (Simple Notification Service)

- **概述**：Pub/sub 消息。Topics → Subscriptions（SQS, Lambda, HTTP/S, email, SMS, 移动推送）。Fan-out：一条消息 → 多个订阅者。
- **🔄 Azure 对应**：Azure Event Grid / Azure Notification Hubs
- **考试关键知识点**（源自 missed question）：
  - **Fan-out 模式**：SNS → 多个 SQS 队列（每个消费者一个）。每个队列独立处理消息。*(Q#131)*
  - **SNS + SQS**：SNS 投递到 SQS 实现持久化处理。如果订阅者（Lambda）失败，消息必须持久化 → SQS。*(Q#142)*
  - **SNS + Lambda**：直接触发 —— Lambda 即时处理。无持久化顾虑。*(Q#113, Q#142)*
- **📝 Q Refs**：#35, #109, #113, #131, #136, #142, #172, #175

### EventBridge

- **概述**：Serverless 事件总线。SaaS 集成（Zendesk, Datadog, PagerDuty）。模式匹配规则将事件路由到目标。Schema registry 用于事件发现。
- **🔄 Azure 对应**：Azure Event Grid
- **考试关键知识点**（源自 missed question）：
  - **vs SNS**：EventBridge = 基于模式的路由（规则匹配事件属性）；SNS = 基于主题（订阅者接收所有消息）。EventBridge 有第三方 SaaS 集成。*(Q#131)*
  - **EventBridge + Step Functions**：编排由事件触发的复杂工作流。*(Q#104)*
  - **自动化**：EventBridge + Lambda + SSM 实现自动修复（如 S3 公开访问 → EventBridge → Lambda → 修复）。*(Q#35, Q#136)*
- **📝 Q Refs**：#10, #35, #96, #104, #112, #131, #134, #136, #175

### Step Functions

- **概述**：分布式应用的可视化工作流编排。Standard（精确一次，最长 1 年）和 Express（高容量，最长 5 分钟）。内置重试、错误处理、并行执行。
- **🔄 Azure 对应**：Azure Logic Apps + Durable Functions
- **考试关键知识点**（源自 missed question）：
  - **编排 (Orchestration)**：协调 Lambda, ECS, Batch, SNS, SQS —— 处理重试、超时、条件分支。*(Q#104)*
  - **错误处理**：内置指数退避重试、catch 块、回退状态。无需自定义错误处理代码。*(Q#104)*
- **📝 Q Refs**：#104, #107, #134, #175

### AppSync

- **概述**：托管 GraphQL 服务。通过 WebSocket 实现实时订阅。与 DynamoDB, Lambda, HTTP, RDS 集成。配合 Amplify DataStore 实现离线数据。
- **🔄 Azure 对应**：Azure API Management (GraphQL) / Hot Chocolate on .NET
- **📝 Q Refs**：#212, #223

---

## 🔍 Similar Service Comparison — Messaging & Events

### SQS 🆚 SNS 🆚 EventBridge 🆚 Kinesis

| 服务 | 模式 | 保留 | 排序 | 最适合 |
|---|---|---|---|---|
| **SQS** | Queue (pull) | 最多 14 天 | FIFO 队列支持 | 解耦生产者/消费者、缓冲 |
| **SNS** | Pub/Sub (push) | 无持久化（发后即忘） | FIFO topic 支持 | Fan-out、推送通知 |
| **EventBridge** | Event bus (push) | 存档（可选重放） | 不保证 | 跨账户、SaaS 集成、模式匹配 |
| **Kinesis Data Streams** | Stream (pull) | 最多 365 天（默认 24 小时） | 按分片排序 | 实时流处理、重放、多消费者 |

**考试信号**："Decouple, buffer messages" → SQS。"One message → many subscribers" → SNS。"Pattern matching + SaaS events" → EventBridge。"Real-time stream, replay from any point" → Kinesis。

> 📝 **Related Qs**：#33, #82, #110, #131, #142, #143, #212

---

## 8. 📊 管理与治理 (Management & Governance)

### CloudFormation

- **概述**：基础设施即代码 (IaC) —— 在 YAML/JSON 模板中定义 AWS 资源。声明式。堆栈管理（创建、更新、删除、漂移检测）。
- **🔄 Azure 对应**：Azure Resource Manager (ARM) / Bicep
- **🔄 Azure 对照**：**这是你的强项！** 你使用 Azure DevOps pipelines + ARM/Bicep 部署基础设施。CloudFormation 在概念上几乎相同。关键映射：CloudFormation template = ARM template；CloudFormation Stack = Resource Group deployment；CloudFormation StackSets = Deployment Stacks (Azure)。在你的 pipeline 中，`aws cloudformation deploy` 替代 `az deployment group create`。
- **考试关键知识点**（源自 missed question）：
  - **StackSets**：从中央管理账户将同一模板部署到多个账户/区域。Self-managed 或 service-managed 权限。*(Q#30, Q#67, Q#210)*
  - **Nested Stacks**：将大型模板分解为更小的可重用部分。与 StackSets 不同（后者将同一堆栈部署到多个位置）。*(Q#67)*
  - **Drift Detection（漂移检测）**：检测资源是否在 CloudFormation 之外被更改。*(Q#232)*
  - **Change Sets（变更集）**：在应用更改前预览 —— 理解部署的影响。*(Q#59)*
- **📝 Q Refs**：#14, #21, #30, #48, #59, #67, #134, #232, #245, #250

### Systems Manager (SSM)

- **概述**：运维管理套件。Parameter Store, Session Manager, Automation, Patch Manager, Run Command, Fleet Manager, Inventory。
- **🔄 Azure 对应**：Azure Automation / Azure Update Manager / Azure Arc
- **考试关键知识点**（源自 missed question）：
  - **Session Manager**：基于浏览器的 SSH/RDP 访问 EC2 —— 无需堡垒主机，无需开放入站端口。通过 CloudTrail + S3 日志可审计。*(Q#252, Q#254)*
  - **Fleet Manager**：管理 EC2 实例机群 —— 查看性能、排障、运行命令。*(Q#252)*
  - **Automation**：常见维护任务的 Runbook（AMI 创建、实例停止/启动、补丁）。*(Q#125)*
  - **Run Command**：远程在托管实例上执行脚本 —— 无需 SSH。*(Q#90)*
- **📝 Q Refs**：#9, #10, #90, #125, #164, #252, #254

### CloudWatch

- **概述**：Metrics（EC2, RDS, Lambda, 自定义）, Logs（应用日志）, Alarms（基于阈值的操作）, Dashboards, Synthetics (canaries), ServiceLens (traces)。
- **🔄 Azure 对应**：Azure Monitor
- **考试关键知识点**（源自 missed question）：
  - **Alarms**：基于指标阈值触发 Auto Scaling、SNS 通知或 EC2 操作。*(Q#14, Q#204, Q#206)*
  - **Logs**：统一日志存储 —— 保留期可配置。Log Insights 用于查询。*(Q#172)*
  - **Metrics**：默认指标（免费）vs 详细监控（1 分钟粒度，收费）。可通过 API 发布自定义指标。*(Q#222)*
- **📝 Q Refs**：#14, #102, #112, #204, #206, #209, #222, #243

### 其他管理服务

- **Service Catalog**：发布已批准产品（CloudFormation 模板）供自助使用。执行治理 —— 用户只能部署已批准的配置。*(Q#210)*
- **AWS Backup**：跨服务集中备份管理（EC2, EBS, RDS, DynamoDB, EFS, FSx 等）。Backup Plans, Vaults, 跨账户复制。*(Q#134, Q#153, Q#234, Q#245)*
- **Cost Explorer**：可视化分析 AWS 支出。Savings Plans 和 Reserved Instance 推荐。*(Q#232)*
- **Compute Optimizer**：基于 ML 的 EC2, EBS, Lambda, ECS 合理配置建议。*(Q#102, Q#233)*
- **Trusted Advisor**：跨成本、性能、安全、容错、服务限制的最佳实践检查。*(Q#102)*
- **Migration Evaluator**：估算迁移到 AWS 的 TCO —— 生成商业案例。*(Q#124, Q#137)*
- **Application Discovery Service**：发现本地服务器，映射依赖关系，估算迁移成本。*(Q#124, Q#137)*
- **📝 Q Refs**：#26, #64, #102, #124, #134, #137, #153, #210, #232, #233, #234, #245

---

## 🔍 Similar Service Comparison — IaC & Governance

### CloudFormation 🆚 CloudFormation StackSets 🆚 Service Catalog

| 工具 | 范围 | 使用场景 |
|---|---|---|
| **CloudFormation** | 单账户、单区域 | 部署资源堆栈 |
| **StackSets** | 多账户、多区域 | 跨组织部署同一堆栈 |
| **Service Catalog** | 受控自助服务 | 允许团队部署已批准的产品 |

**考试信号**："Deploy to one account" → CloudFormation。"Deploy to all accounts" → StackSets。"Self-service with governance" → Service Catalog。

> 📝 **Related Qs**：#30, #67, #210, #232

### AWS Backup 🆚 DLM 🆚 手动快照

| 方法 | 范围 | 自动化 | 跨区域 | 跨账户 |
|---|---|---|---|---|
| **AWS Backup** | 多服务 | ✅ 计划 + 保留规则 | ✅ 内置 | ✅ 内置 |
| **DLM** | EBS snapshots, AMIs | ✅ 计划策略 | ❌ | ✅（自 2023 年起） |
| **手动快照** | 按资源 | ❌ | ❌ 手动 | ❌ 手动 |

> 📝 **Related Qs**：#114, #134, #153, #234, #245

---

## 9. 🚚 迁移与传输 (Migration & Transfer)

> **注意**：DMS 详见 [第 4 节 —— 数据库](#4-%EF%B8%8F-数据库-database)。Storage Gateway 和 Transfer Family 详见 [第 3 节 —— 存储](#3--存储-storage)。请交叉引用这些章节获取完整详情。

### DataSync

- **概述**：在线数据传送服务 —— 在本地和 AWS（S3, EFS, FSx）之间移动文件/对象。自动计划、带宽限制、增量传送。每个 agent 最高 10 Gbps。
- **🔄 Azure 对应**：Azure File Sync / AzCopy
- **🔄 Azure 对照**：类似 AzCopy 但是托管服务 —— 计划执行、增量传送、带宽控制。在你的 DevOps 世界中，DataSync 就像托管的 `robocopy` 或 `rsync` 到 AWS。
- **考试关键知识点**（源自 missed question）：
  - **不是 Storage Gateway**：DataSync 用于迁移/同步（一次性或计划）；Storage Gateway 用于持续混合访问。*(Q#107)*
  - **支持的目标**：S3, EFS, FSx for Windows, FSx for Lustre。*(Q#27, Q#130)*
  - **增量传送**：初次完整同步后仅传送变更文件 —— 节省带宽。*(Q#27)*
  - **DataSync + Direct Connect**：使用 Direct Connect 在大数据传送期间获得稳定带宽。*(Q#27)*
- **📝 Q Refs**：#27, #107, #114, #130, #158

### Snow Family (Snowball Edge / Snowmobile)

- **概述**：用于离线数据传送的物理设备。Snowball Edge（80 TB 存储 + 计算），Snowmobile（100 PB，字面意思的集装箱卡车）。当网络传送耗时过长或成本过高时使用。
- **🔄 Azure 对应**：Azure Data Box / Data Box Heavy
- **考试关键知识点**（源自 missed question）：
  - **何时使用**：>10 TB 且网络慢/成本高。Snowball Edge 还提供边缘计算（EC2, Lambda）—— 适用于断开连接/远程环境。*(Q#107, Q#123, Q#149, Q#158)*
  - **Snowball Edge Compute**：在设备上运行 Lambda 函数 + EC2 实例。用于工业 IoT、工厂车间、远程采矿。*(Q#123, Q#149)*
  - **不用于数据库**：Snowball 将数据传送到 S3；数据库迁移使用 DMS。*(Q#158)*
  - **加密**：数据静态加密（256 位）和传输中加密（TLS）。设备防篡改。
- **📝 Q Refs**：#107, #123, #149, #158

### Application Migration Service (MGN)

- **概述**：服务器级直接迁移 (lift-and-shift / rehost) —— 将整台服务器（物理、VMware、Hyper-V）复制到 AWS 作为 EC2 实例。块级持续复制，RPO 接近零。前身为 CloudEndure。
- **🔄 Azure 对应**：Azure Migrate: Server Migration
- **考试关键知识点**（源自 missed question）：
  - **持续复制 (Continuous Replication)**：块级复制保持源和目标同步直到切换。最小停机时间。
  - **vs DMS**：MGN 迁移整台服务器（OS + 应用 + 数据）；DMS 仅迁移数据库。Lift-and-shift 用 MGN，仅数据库迁移（含模式转换）用 DMS。*(Q#116)*
- **📝 Q Refs**：#116

### Application Discovery Service

- **概述**：发现本地服务器，映射依赖关系，收集性能数据。两种模式：Agentless（通过 vCenter，仅 VMware）和 Agent-based（任意 OS，更深洞察）。数据汇入 Migration Hub。
- **🔄 Azure 对应**：Azure Migrate: Discovery and Assessment
- **考试关键知识点**（源自 missed question）：
  - **依赖映射 (Dependency Mapping)**：可视化哪些服务器之间通信 —— 为迁移批次识别应用组。*(Q#124, Q#137)*
  - **TCO 估算**：与 Migration Evaluator 配合生成商业案例。*(Q#124, Q#137)*
  - **Agent-based vs Agentless**：Agent-based 收集更多数据（运行进程、网络连接）；Agentless 更轻量但仅限 VMware。*(Q#124)*
- **📝 Q Refs**：#124, #137

### Migration Hub

- **概述**：中央仪表板，跟踪跨多个工具（MGN, DMS, DataSync 等）的迁移进度。整个资产组合迁移状态的单一视图。
- **🔄 Azure 对应**：Azure Migrate (hub)
- **📝 Q Refs**：#137

### SCT (Schema Conversion Tool)

- **概述**：将数据库模式从一种引擎转换为另一种（如 Oracle → Aurora, SQL Server → MySQL）。处理存储过程、视图、函数。与 DMS 配合用于 heterogeneous 迁移。
- **🔄 Azure 对应**：Azure Database Migration Service（模式转换）/ SSMA
- **考试关键知识点**（源自 missed question）：
  - **仅限 Heterogeneous**：SCT 仅在源和目标数据库引擎不同时需要。Homogeneous 迁移（MySQL → RDS MySQL）仅使用 DMS。*(Q#84)*
  - **评估报告 (Assessment Report)**：SCT 生成报告，展示可自动转换的模式比例 vs 需手动干预的比例。*(Q#84)*
- **📝 Q Refs**：#84, #161

### Migration Evaluator

- **概述**：免费工具，分析本地资产清单并提供迁移到 AWS 的商业案例 —— 包括 TCO 对比、预计节省和资源映射。
- **🔄 Azure 对应**：Azure TCO Calculator / Azure Migrate Business Case
- **📝 Q Refs**：#124, #137

### VM Import/Export

- **概述**：将 VM 镜像（OVA, VMDK, VHD, RAW）从本地导入 AWS 为 AMI。将 AMI 导出回本地格式。保留软件、配置和数据。
- **🔄 Azure 对应**：Azure Migrate（VM 导入）/ Azure VM Image Builder
- **考试关键知识点**（源自 missed question）：
  - **CLI 驱动**：使用 `aws ec2 import-image` CLI 命令 —— 需要 IAM role `vmimport`。镜像先存储在 S3 中，再转换为 AMI。*(Q#50)*
  - **支持的格式**：OVA, VMDK, VHD, RAW。可直接导入 VMware VM。*(Q#50)*
- **📝 Q Refs**：#50

---

## 🔍 Similar Service Comparison — Migration

### DataSync 🆚 Storage Gateway 🆚 Snow Family 🆚 DMS

| 服务 | 类型 | 何时使用 | 速度 |
|---|---|---|---|
| **DataSync** | 在线文件传送 | < 10 TB，持续同步 | 最高 10 Gbps |
| **Storage Gateway** | 混合访问（非迁移） | 持续本地访问云存储 | 本地网络速度 |
| **Snowball Edge** | 离线设备 | > 10 TB，网络慢/成本高 | 数天（物理） |
| **Snowmobile** | 离线卡车 | > 10 PB | 数周（物理） |
| **DMS** | 数据库（非文件） | 带 CDC 的数据库迁移 | 持续复制 |
| **MGN** | 服务器级 | 整机 Lift-and-shift | 块级复制 |

> 📝 **Related Qs**：#27, #40, #50, #84, #107, #130, #158, #236

---

## 10. 📈 分析 (Analytics)

> **注意**：Redshift 详见 [第 4 节 —— 数据库](#4-%EF%B8%8F-数据库-database) 中"其他数据库"。OpenSearch 也在那里。请交叉引用获取完整详情。

### Athena

- **概述**：Serverless 交互式查询服务 —— 直接在 S3 数据上运行标准 SQL。无需管理基础设施。仅按扫描数据量付费（$5/TB）。基于 Presto。
- **🔄 Azure 对应**：Azure Synapse Serverless SQL Pool
- **🔄 Azure 对照**：类似 Synapse Serverless SQL —— 在数据所在位置（S3/Data Lake）查询，无需加载到数据库。使用 `CREATE EXTERNAL TABLE` 在读时定义模式。
- **考试关键知识点**（源自 missed question）：
  - **S3 作为数据源**：直接查询 S3 中的 CSV, JSON, Parquet, ORC, Avro。无需 ETL 即可进行即席查询。*(Q#64, Q#115)*
  - **成本优化**：使用列式格式（Parquet/ORC）+ 分区 + 压缩以减少扫描数据量。*(Q#64)*
  - **Athena + QuickSight**：Athena 作为 QuickSight 仪表板的数据源。Cost and Usage Reports (CUR) → Athena → QuickSight 实现成本可视化。*(Q#64)*
  - **vs Glue**：Athena = 查询（即席、交互式）；Glue = ETL（计划、转换）。可配合使用：Glue 转换数据 → Athena 查询数据。*(Q#115)*
- **📝 Q Refs**：#64, #98, #115

### EMR (Elastic MapReduce)

- **概述**：托管 Hadoop/Spark 集群。跨动态可扩展 EC2 实例处理海量数据。支持 Hive, Pig, HBase, Presto, Flink。
- **🔄 Azure 对应**：Azure HDInsight / Azure Databricks
- **考试关键知识点**（源自 missed question）：
  - **EMRFS**：EMR File System —— 直接从 S3 读取而非 HDFS。允许集群短暂存在（数据在集群终止后保留在 S3）。*(Q#205)*
  - **Spot Instances**：Task 节点使用 Spot 降低成本。Core 节点应为 On-Demand/Reserved。*(Q#205)*
  - **临时集群 (Transient Clusters)**：启动集群 → 处理数据 → 终止 —— 数据通过 EMRFS 保留在 S3。巨大成本节省。*(Q#205)*
- **📝 Q Refs**：#115, #205

### Glue

- **概述**：Serverless ETL 服务 —— 自动发现、编目和转换数据。Crawlers 扫描 S3 并填充 Glue Data Catalog（元数据仓库）。作业在 Apache Spark 上运行。
- **🔄 Azure 对应**：Azure Data Factory
- **🔄 Azure 对照**：Glue = Azure Data Factory（ETL 编排）+ Azure Purview（数据目录）。Glue Crawlers = ADF 模式推断。Glue Data Catalog = Purview 数据地图。作业可使用 Python 或 Spark。
- **考试关键知识点**（源自 missed question）：
  - **Data Catalog**：中央元数据仓库 —— 表、模式、分区。被 Athena, EMR, Redshift Spectrum 使用。*(Q#115)*
  - **转换 (Transformations)**：常见 ETL 任务的内置转换（drop fields, filter, join, map, resolve choice）。自定义转换为 Python/Spark。*(Q#115)*
  - **敏感数据**：Glue 可使用内置 ML 转换（`FindMatches`, `DetectPII`）检测和掩盖 PII/PHI。*(Q#115)*
  - **Serverless**：无需基础设施 —— 按 DPU-小时 (Data Processing Unit) 付费。自动扩缩容。
- **📝 Q Refs**：#115

### QuickSight

- **概述**：Serverless BI 仪表板和可视化。ML 驱动的洞察（自动叙述、异常检测）。SPICE 引擎实现快速内存查询。按会话付费定价。
- **🔄 Azure 对应**：Power BI
- **🔄 Azure 对照**：类似 Power BI 但是 AWS 原生。SPICE (Super-fast, Parallel, In-memory Calculation Engine) = Power BI 的 VertiPaq。QuickSight Q (NLQ) = Power BI Q&A。
- **考试关键知识点**（源自 missed question）：
  - **SPICE**：加速查询的内存引擎 —— 将数据导入 SPICE 进行分析（vs. 直接查询）更快。*(Q#26, Q#64)*
  - **CUR + QuickSight**：连接 Cost and Usage Reports → Athena → QuickSight 制作成本仪表板。*(Q#26, Q#64)*
  - **行级安全 (Row-Level Security)**：在同一仪表板中按用户/组限制数据访问。
- **📝 Q Refs**：#26, #64, #83

### Kinesis

- **概述**：实时流数据平台。四个服务：**Data Streams**（摄取和处理流数据），**Data Firehose**（将流传送到 S3/Redshift/OpenSearch/Splunk），**Data Analytics**（流上的 SQL/Flink），**Video Streams**（安全流式传输视频）。
- **🔄 Azure 对应**：Azure Event Hubs (Data Streams) + Stream Analytics (Data Analytics)
- **考试关键知识点**（源自 missed question）：
  - **Data Streams vs SQS**：Kinesis = 带重放的实时流（最多 365 天保留，基于分片排序）；SQS = 消息队列（最多 14 天，默认无重放）。实时分析用 Kinesis，解耦用 SQS。*(Q#123)*
  - **Shards（分片）**：吞吐量 = 分片数 × 1 MB/秒输入，2 MB/秒输出每分片。Reshard（split/merge）进行扩缩容。
  - **Kinesis Video Streams**：用于 IoT 设备、摄像头的视频。与 SageMaker 集成实现视频帧上的 ML。*(Q#123)*
- **📝 Q Refs**：#123

---

## 11. 🤖 机器学习 (Machine Learning)

### SageMaker

- **概述**：全托管 ML 平台 —— 大规模构建、训练和部署模型。包括 SageMaker Studio (IDE), Ground Truth（数据标注）, training jobs（托管基础设施）, hosting（实时端点）, SageMaker Neo（边缘优化）。
- **🔄 Azure 对应**：Azure Machine Learning
- **🔄 Azure 对照**：与 Azure ML 几乎相同。两者都提供托管 notebook、自动 ML、训练 pipeline、模型注册表和托管端点。SageMaker Studio = Azure ML Studio。
- **考试关键知识点**（源自 missed question）：
  - **SageMaker + IoT**：可将训练好的模型部署到 IoT Greengrass 设备进行边缘推理。*(Q#123)*
  - **SageMaker + Kinesis Video Streams**：处理视频流进行 ML 推理 —— 对象检测、活动识别。*(Q#123)*
  - **离线推理**：在断开连接的环境（工厂车间、船舶、矿山）中使用 Snowball Edge 进行 ML 推理。*(Q#123)*
  - **训练**：托管训练作业 —— 选择实例类型（GPU/CPU）、分布式训练、Spot instances 节省成本。自动模型调优进行超参数调整。
- **📝 Q Refs**：#123

### IoT Greengrass

- **概述**：IoT 设备的边缘运行时 —— 在设备上本地运行 Lambda 函数、Docker 容器和 ML 模型。即使没有云连接也能进行本地处理、消息传递和操作。
- **🔄 Azure 对应**：Azure IoT Edge
- **考试关键知识点**（源自 missed question）：
  - **离线运行**：与云端断开连接时设备继续运行 —— 本地操作、本地 ML 推理。重新连接时同步。*(Q#123)*
  - **边缘 ML**：将 SageMaker 训练的模型部署到 Greengrass 设备。无需云端往返即可运行推理。*(Q#123)*
  - **Connectors**：常见 IoT 模式的预构建模块（如 Kinesis Firehose, Twilio, ServiceNow）。
- **📝 Q Refs**：#123

### Monitron

- **概述**：端到端 ML 驱动的预测性维护系统。包括传感器（振动 + 温度）、网关和云服务。无需构建自定义 ML 模型即可检测异常设备模式。
- **🔄 Azure 对应**：Azure IoT + Azure ML 自定义（无精确等价物）
- **考试关键知识点**（源自 missed question）：
  - **专用构建**：Monitron 专门用于预测性维护 —— 非通用 ML。附带旋转设备（电机、泵、风扇）的预训练模型。*(Q#123)*
  - **无需 ML 专业知识**：Monitron 是交钥匙解决方案 —— 安装传感器、连接网关、接收告警。对比 SageMaker 需要 ML 知识。
- **📝 Q Refs**：#123

---

## 12. 🛠️ 开发者工具 — 你的专长领域！

### CodeDeploy

- **概述**：自动化代码部署到 EC2, Lambda, ECS。Blue/green, rolling, canary 策略。验证测试的钩子。
- **🔄 Azure 对应**：Azure DevOps Release Pipelines → "Deploy to App Service/VM" 任务
- **🔄 Azure 对照**：**这直接映射到你的 Azure DevOps release pipelines！** CodeDeploy 的 deployment groups = 你的 Azure release stages/environments。CodeDeploy 中的 blue/green 部署 = 交换 Azure App Service 的 deployment slots。`appspec.yml` 文件定义生命周期钩子 —— 类似你的 pipeline YAML 步骤。
- **考试关键知识点**（源自 missed question）：
  - **Canary 部署**：CodeDeploy 可增量切换流量（如 10% → 100%），告警时自动回滚。*(Q#48)*
  - **Blue/Green**：一次替换整个机群 —— 通过 ELB 目标组交换切换流量。最快回滚。*(Q#69)*
  - **部署钩子 (Deployment Hooks)**：appspec.yml 中的钩子在生命周期事件（BeforeInstall, AfterInstall, ApplicationStart, ValidateService）运行。*(Q#48, Q#208)*
- **📝 Q Refs**：#14, #48, #69, #104, #208

### CodePipeline

- **概述**：CI/CD 编排 —— source → build → test → deploy。与 CodeCommit, GitHub, S3, CodeBuild, CodeDeploy, CloudFormation 和第三方工具集成。
- **🔄 Azure 对应**：Azure Pipelines (YAML)
- **🔄 Azure 对照**：**你的核心专长！** CodePipeline = Azure DevOps Pipelines。CodePipeline 的 stages/actions = 你的 pipeline stages/jobs/tasks。关键区别：CodePipeline 使用 JSON/YAML 定义 pipeline（不如 Azure Pipelines YAML 成熟）。CodePipeline 没有 Azure DevOps 那样丰富的可视化设计器。大多数企业使用 CodePipeline + GitHub Actions 或 Jenkins。
- **📝 Q Refs**：#134, #208

### CodeBuild

- **概述**：托管构建服务 —— 编译代码、运行测试、产出制品。按分钟付费。
- **🔄 Azure 对应**：Azure DevOps Build Pipelines / Azure Pipelines 构建任务
- **考试关键知识点**（源自 missed question）：
  - **buildspec.yml**：定义构建命令、制品、缓存设置。*(Q#134)*
- **📝 Q Refs**：#134, #208

### CodeCommit

- **概述**：托管 Git 仓库（类似 GitHub 但是 AWS 原生）。
- **🔄 Azure 对应**：Azure Repos
- **📝 Q Refs**：#134

---

## 🔍 Similar Service Comparison — CI/CD（你的专长！）

### CodeDeploy 🆚 CodePipeline 🆚 CodeBuild 🆚 CodeCommit

| 服务 | 用途 | Azure 对应 |
|---|---|---|
| **CodeCommit** | Git 仓库托管 | Azure Repos |
| **CodeBuild** | 编译、测试、打包 | Azure Pipelines 构建任务 |
| **CodeDeploy** | 部署到计算 | Azure Pipelines 发布任务 |
| **CodePipeline** | 编排整个 CI/CD 流程 | Azure Pipelines（端到端） |

**考试信号**："Orchestrate source→build→deploy" → CodePipeline。"Deploy to EC2 with canary" → CodeDeploy。"Compile and package" → CodeBuild。"Store code" → CodeCommit。

> 💡 **基于你的 Azure DevOps 背景**：CodePipeline + CodeBuild + CodeDeploy 一起 = 一个 Azure DevOps Pipeline (YAML)。实际上许多 AWS 商店也使用 GitHub Actions 或 Jenkins —— 考试专门考查 Code* 系列服务。

> 📝 **Related Qs**：#14, #48, #69, #134, #208

---

## 13. 🖥️ 终端用户计算与混合 (End User Computing & Hybrid)

### WorkSpaces

- **概述**：托管虚拟桌面基础设施 (VDI) —— 云中的 Windows 或 Linux 桌面。持久化（root + user 卷）。与 AD, FSx 和多因素认证集成。
- **🔄 Azure 对应**：Azure Virtual Desktop (AVD)
- **🔄 Azure 对照**：WorkSpaces = AVD。两者都是云托管 VDI。关键区别：WorkSpaces 为每个用户使用专用 EBS 卷（持久化）；AVD 可在 Azure Files 上使用 FSLogix profile containers。WorkSpaces 原生集成 FSx for Windows 用于共享用户配置文件。
- **考试关键知识点**（源自 missed question）：
  - **FSx for User Profiles**：将 FSLogix profile containers 存储在 FSx for Windows 上 —— 实现快速登录和配置文件漫游。*(Q#112, Q#153)*
  - **扩缩容**：WorkSpaces 不自动扩缩容 —— 需要容量规划。使用 CloudWatch + EventBridge + Lambda 实现自动预置/取消预置。*(Q#112)*
  - **存储**：Root 卷（OS, 应用 —— 默认 80 GB）和 User 卷（用户数据 —— 10-100 GB）。每 12 小时快照一次，保留 7 天。
  - **AD 集成**：必须加入目录 —— Managed AD, AD Connector（本地）或 Simple AD。*(Q#153)*
- **📝 Q Refs**：#112, #153

### AppStream 2.0

- **概述**：应用流式传输 —— 通过浏览器将 Windows 应用流式传输到任何设备。应用在 AWS 上运行，在用户浏览器中渲染。默认无状态（非持久化）。用于 SaaS 交付、培训环境、安全访问内部应用。
- **🔄 Azure 对应**：Azure Virtual Desktop RemoteApp
- **考试关键知识点**（源自 missed question）：
  - **迁移**：无需重写即可重新托管遗留 Windows 应用 —— 通过 AppStream 流式传输同时逐步现代化后端。*(Q#219)*
  - **vs WorkSpaces**：AppStream 流式传输单个应用；WorkSpaces 流式传输完整桌面。AppStream 默认非持久化；WorkSpaces 持久化。AppStream 按运行小时计费；WorkSpaces 按月计费。*(Q#219)*
  - **Fleets**：Always-On（即时连接，运行中计费）或 On-Demand（等待预置，按使用计费）。
  - **AD 集成**：可加入 Active Directory 进行用户认证和应用访问控制。
- **📝 Q Refs**：#219

### Outposts

- **概述**：在本地运行的 AWS 托管基础设施 —— 与 AWS 区域相同的 API、工具和服务。AWS 在你的数据中心交付、安装和维护机架。支持 EC2, EBS, ECS, EKS, RDS, S3 (Outposts bucket)。
- **🔄 Azure 对应**：Azure Stack HCI / Azure Arc
- **考试关键知识点**（源自 missed question）：
  - **一致体验**：相同的 AWS API、CLI、控制台 —— 开发者在本地和云端无需学习不同工具。*(Q#149)*
  - **数据驻留**：满足监管要求的同时将数据保留在本地并使用 AWS 服务。*(Q#149)*
  - **低延迟**：工厂车间、医疗影像、金融交易的亚毫秒级延迟。*(Q#149)*
  - **vs Snowball Edge**：Outposts = 永久本地安装（42U 机架）；Snowball Edge = 便携、临时、容量较小。Outposts 支持更多服务（RDS, ECS）。*(Q#149)*
- **📝 Q Refs**：#149

### Snowball Edge (Compute)

- **概述**：便携式边缘计算 + 存储设备。在断开连接/远程环境中运行 EC2 实例和 Lambda 函数。80 TB 可用存储。两种型号：Compute Optimized（更多 CPU/RAM）和 Storage Optimized（更多存储）。
- **🔄 Azure 对应**：Azure Stack Edge
- **考试关键知识点**（源自 missed question）：
  - **断网运行**：无互联网独立运行 —— 本地处理数据，然后将设备送回 AWS 进行数据导入。*(Q#123, Q#149)*
  - **vs Outposts**：Snowball Edge 便携、较小、用于临时/远程使用；Outposts 是永久机架安装，用于稳态混合负载。*(Q#149)*
  - **边缘 ML**：可运行 SageMaker Neo 编译的模型进行本地推理。与 IoT Greengrass 结合实现边缘 ML 管道。*(Q#123)*
- **📝 Q Refs**：#107, #123, #149, #158

---

## 14. 📋 附录：完整的标签到服务标准化映射

此表将你的 Wrong Answer Collection 中所有标签变体映射到规范服务名称。添加新 missed question 时作为参考。

<details>
<summary>点击展开完整标准化映射表</summary>

| 错题中的标签变体 | 规范服务名称 |
|---|---|
| `#EC2`, `#AWS-EC2`, `#Amazon-EC2`, `#AmazonEC2`, `#EC2_Auto_Scaling` | EC2 |
| `#Lambda`, `#AWS_Lambda`, `#AWS-Lambda`, `#AWSLambda` | Lambda |
| `#S3`, `#Amazon_S3`, `#Amazon-S3`, `#AWS_S3`, `#AWS-S3`, `#AmazonS3` | S3 |
| `#RDS`, `#AmazonRDS`, `#Amazon-RDS`, `#AWS/Database/RDS` | RDS |
| `#Aurora`, `#Amazon_Aurora`, `#Amazon-Aurora`, `#AmazonAurora`, `#Aurora_PostgreSQL`, `#Aurora-MySQL` | Aurora |
| `#DynamoDB`, `#Amazon-DynamoDB`, `#DynamoDB-Global-Tables` | DynamoDB |
| `#ECR`, `#AWS_ECR`, `#AWS-ECR`, `#Amazon-ECR` | ECR |
| `#ECS`, `#AWS-ECS`, `#Amazon-ECS`, `#AWS-ECS-Fargate` | ECS |
| `#EKS`, `#AWS-EKS`, `#Amazon-EKS` | EKS |
| `#Fargate`, `#AWS-Fargate` | Fargate |
| `#VPC`, `#Amazon_VPC`, `#VPCEndpoint`, `#VPC_Endpoint`, `#VPC-Endpoint` | VPC |
| `#Route53`, `#Route_53`, `#Amazon_Route_53`, `#AWS-Route53` | Route 53 |
| `#CloudFront`, `#CloudFront_Origin_Group` | CloudFront |
| `#ALB`, `#Application_Load_Balancer`, `#AWS-ALB`, `#ApplicationLoadBalancer` | ALB |
| `#NLB`, `#Network_Load_Balancer_NLB`, `#AWS-NLB` | NLB |
| `#API_Gateway`, `#AWS_API_Gateway`, `#AWS-API-Gateway`, `#APIGateway` | API Gateway |
| `#DirectConnect`, `#aws-direct-connect`, `#DirectConnectGateway` | Direct Connect |
| `#TransitGateway`, `#Transit_Gateway`, `#transit-gateway`, `#AWSTransitGateway` | Transit Gateway |
| `#WAF`, `#AWS_WAF`, `#AWS-WAF`, `#AWSWAF` | WAF |
| `#IAM`, `#AWS/IAM`, `#IAM-Identity-Center` | IAM |
| `#KMS`, `#AWS/KMS`, `#AWSKMS` | KMS |
| `#Organizations`, `#AWS_Organizations`, `#AWS-Organizations`, `#AWSOrganizations` | Organizations |
| `#SCP`, `#Service_Control_Policies__SCP`, `#Service_Control_Policy_SCP` | SCP |
| `#CloudFormation`, `#AWS_CloudFormation`, `#AWSCloudFormation` | CloudFormation |
| `#CodeDeploy`, `#AWS_CodeDeploy`, `#AWSCodeDeploy` | CodeDeploy |
| `#DMS`, `#AWS_DMS`, `#AWS-DMS`, `#DatabaseMigrationService` | DMS |
| `#DataSync`, `#AWS-DataSync` | DataSync |
| `#Snowball`, `#AWS-Snowball`, `#SnowballEdge`, `#Snowball-Edge` | Snow Family |
| `#EventBridge`, `#Amazon_EventBridge`, `#Amazon-EventBridge`, `#AmazonEventBridge` | EventBridge |
| `#SQS`, `#AmazonSQS`, `#Amazon-SQS` | SQS |
| `#SNS`, `#AmazonSNS`, `#Amazon-SNS`, `#AmazonSNS` | SNS |
| `#SystemsManager`, `#AWS_Systems_Manager`, `#AWSSystemsManager` | Systems Manager |
| `#FSx`, `#FSx-for-Windows`, `#FSx-for-Lustre`, `#FSxForLustre` | FSx |
| `#TransferFamily`, `#AWS_Transfer_Family`, `#AWS-Transfer-Family` | Transfer Family |
| `#StorageGateway`, `#Storage_Gateway`, `#FileGateway` | Storage Gateway |
| `#ElasticBeanstalk`, `#Elastic_Beanstalk` | Elastic Beanstalk |
| `#Backup`, `#AWSBackup`, `#AWS-Backup` | AWS Backup |
| `#Config`, `#AWS_Config`, `#AWS-Config` | AWS Config |
| `#SecretsManager`, `#Secrets-Manager`, `#AWSSecretsManager` | Secrets Manager |
| `#ACM`, `#AWS_Certificate_Manager` | Certificate Manager |
| `#GlobalAccelerator`, `#AWS-Global-Accelerator`, `#AWSGlobalAccelerator` | Global Accelerator |
| `#PrivateLink`, `#AWS_PrivateLink`, `#AWS-PrivateLink`, `#AWSPrivateLink` | PrivateLink |
| `#StepFunctions`, `#Step-Functions`, `#AWSStepFunctions` | Step Functions |
| `#Athena`, `#AmazonAthena`, `#Amazon-Athena` | Athena |
| `#EMR`, `#Amazon-EMR` | EMR |
| `#Glue`, `#AWS-Glue` | Glue |
| `#QuickSight`, `#Amazon_QuickSight`, `#AmazonQuickSight` | QuickSight |
| `#Redshift`, `#AmazonRedshift` | Redshift |
| `#SageMaker`, `#AWS-SageMaker` | SageMaker |
| `#WorkSpaces`, `#Amazon-Workspaces` | WorkSpaces |
| `#AppStream` | AppStream |
| `#Outposts`, `#AWSOutposts` | Outposts |
| `#Cognito` | Cognito |
| `#Amplify` | Amplify |
| `#AppSync` | AppSync |
| `#DocumentDB`, `#Amazon-DocumentDB` | DocumentDB |
| `#ElastiCache`, `#ElastiCacheRedis` | ElastiCache |
| `#DirectoryService`, `#ActiveDirectory`, `#Active-Directory` | Directory Service |

</details>

---

## 📊 学习进度跟踪 (Study Progress Tracker)

| 领域 | 涵盖服务 | 题目数 | 自信度（自评） |
|---|---|---|---|
| 💻 Compute | EC2, Lambda, EB, Batch | ~45 | /10 |
| 📦 Containers | ECS, EKS, ECR, Fargate | ~12 | /10 |
| 💾 Storage | S3, EBS, EFS, FSx, Storage Gateway, Transfer Family | ~35 | /10 |
| 🗄️ Database | RDS, Aurora, DynamoDB, ElastiCache, DocumentDB, Redshift, DMS | ~40 | /10 |
| 🌐 Networking | VPC, Route 53, API Gateway, CloudFront, Direct Connect, Transit Gateway, ALB/NLB, Global Accelerator | ~55 | /10 |
| 🔐 Security | IAM, Organizations/SCP, KMS, Secrets Manager, WAF/Shield, CloudTrail, Config | ~35 | /10 |
| 🔗 Integration | SQS, SNS, EventBridge, Step Functions, AppSync | ~20 | /10 |
| 📊 Management | CloudFormation, Systems Manager, CloudWatch, Service Catalog, AWS Backup, Cost Management | ~30 | /10 |
| 🚚 Migration | DMS, DataSync, Snow Family, MGN, Migration Hub | ~20 | /10 |
| 📈 Analytics | Athena, EMR, Glue, QuickSight, Redshift, OpenSearch | ~10 | /10 |
| 🤖 ML | SageMaker, IoT Greengrass | ~3 | /10 |
| 🛠️ Developer Tools | CodeDeploy, CodePipeline, CodeBuild, CodeCommit | ~8 | /10 |
| 🖥️ EUC | WorkSpaces, AppStream, Outposts | ~5 | /10 |

> **missed question 文件总数**：187 | **涵盖规范服务**：~80+ | **最后更新**：2026-06-06

---

## 🔄 下一步 (Next Steps)

1. **填写上方自信度分数**（自评 /10）—— 这告诉你应聚焦哪个领域
2. **在薄弱领域多做练习题**
3. **将新的 missed question 追加**到相关服务章节，按照顶部说明操作
4. **考前重温 Similar Service Comparison 章节**—— 这些是最常见的陷阱
5. **使用 AWS SAP-C02 Tutor 智能体**以相同格式分析新题目
