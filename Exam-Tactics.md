# AWS SAP-C02 考试兵法

> 🎯 基于 266 个真实错题和 SAP-C02 考试规律提炼
> 📖 配合教材使用，考前必读

---

## 一、题干关键词 → 服务速查

### 成本类
| 信号词 | 大概率答案方向 | 排除项 |
|---|---|---|
| "most cost-effective" + RPO小时级 | AWS Backup 跨区复制 | Aurora Global (过度) |
| "most cost-effective" + RPO秒级 | Aurora Global / DynamoDB Global Tables | AWS Backup (不够) |
| "lowest cost" + 容错批处理 | Spot Instances | Reserved (浪费) |
| "steady predictable load" | Reserved Instances / Savings Plans | Spot (不稳定) |
| "variable unpredictable load" | Compute Savings Plan | EC2 Instance SP (锁太死) |
| "Lambda cost savings" | Compute Savings Plan | Reserved Concurrency (不省钱!) |

### 运维类
| 信号词 | 大概率答案方向 | 排除项 |
|---|---|---|
| "least operational overhead" | 托管服务 (Fargate, Lambda, RDS, DynamoDB, S3) | EC2 (手动管理) |
| "no servers to manage" | Serverless (Lambda, Fargate, DynamoDB) | EC2, ECS on EC2 |
| "minimal administrative effort" | 托管 + 自动化 (AWS Backup, DLM, S3 Lifecycle) | 手动脚本, 自定义Lambda |
| "automatically mitigate failures" | Auto Scaling, Multi-AZ, Route53 Failover | 手动替换 |

### 性能类
| 信号词 | 大概率答案方向 | 排除项 |
|---|---|---|
| "single-digit millisecond latency" | DAX, ElastiCache, EBS io2, FSx Lustre | S3, EFS Standard |
| "lowest inter-node latency" | Cluster Placement Group | Spread (高可用,非低延迟) |
| "real-time" / "streaming" | Kinesis Data Streams, AppSync WebSocket | SQS, SNS (不是实时流) |
| "global users" + "low latency" | CloudFront (HTTP), Global Accelerator (TCP/UDP) | 单个Region ALB/NLB |
| "upload acceleration" | S3 Transfer Acceleration + Multipart Upload | CloudFront (用于下载,非上传) |

### 安全类
| 信号词 | 大概率答案方向 | 排除项 |
|---|---|---|
| "SQL injection attacks" | WAF SQL Database Managed Rule Group | Bot Control (不同威胁) |
| "publicly exposed S3 bucket" | IAM Access Analyzer | AWS Config (检测配置变更,非公开暴露) |
| "static IP" + "WAF" | Global Accelerator (ALB不能用EIP) | ALB+EIP (不可能), NLB (不支持WAF) |
| "temporary credentials" + "auditable" | EC2 Instance Connect / Session Manager | 手动SSH密钥 |
| "no long-lived credentials" | IAM Roles, EC2 Instance Connect | IAM Users + Access Keys |

### 架构类
| 信号词 | 大概率答案方向 | 排除项 |
|---|---|---|
| "overlapping CIDR" + "private access" | PrivateLink (VPC Endpoint) | VPC Peering (不支持重叠CIDR) |
| "decouple" / "buffer" | SQS | 直接HTTP调用 |
| "fan-out" + "one-to-many" | SNS (推) 或 EventBridge (模式匹配) | SQS (点对点) |
| "event-driven microservices" | EventBridge (模式匹配) | SNS (全部订阅者都收到) |
| "long-running task" + "orchestrate" | Step Functions | Lambda (15分钟限制) |

---

## 二、排除法速查（看到两个概念同时出现→排除）

| 组合 | 排除原因 |
|---|---|
| Reserved Instances + "flexibility across instance families" | RI是特定实例族+AZ的 |
| NAT Gateway + "IPv6 traffic" | NAT GW 仅 IPv4 → 用 Egress-Only IGW |
| ALB + "Elastic IP" | ALB只有DNS, 不能绑EIP → NLB或Global Accelerator |
| NLB + "WAF integration" | NLB是L4, WAF是L7 → 用ALB |
| DynamoDB + "Resource-based policy" | DynamoDB不支持 → 用IAM identity policy |
| SCP + "grants permissions" | SCP只限制,不授予 → IAM policy才授予 |
| Lambda Reserved Concurrency + "cost savings" | Reserved Concurrency不是billing discount |
| DataSync + "ongoing hybrid access" | DataSync是迁移/同步 → Storage Gateway才是持续访问 |
| DMS + "file migration" | DMS只迁移数据库 → DataSync迁文件 |
| Snowball Edge Storage + "run EC2 instances" | Storage Optimized缺计算能力 → 用Compute Optimized |
| Compute Savings Plan + "covers RDS/MemoryDB" | Savings Plans只覆盖EC2+Lambda+Fargate |
| Direct Connect + "encrypted by default" | DC不加密 → 需要VPN overlay |
| Fargate + "host-level monitoring agent" | Fargate无宿主机访问 → EC2 |
| S3 One Zone-IA + "production critical data" | One Zone-IA单AZ,无容灾 |

---

## 三、常见"选两个" (Choose Two) 组合

| 场景 | 正确组合 |
|---|---|
| S3 跨区复制 + 权限 | CRR/SRR + 版本控制(必须) |
| Lambda 访问VPC内RDS + 公网API | Lambda in VPC(private subnet) + NAT Gateway |
| ASG 缩容时不丢消息 | Scale-in Protection + Lifecycle Hook |
| DynamoDB 读性能优化 + 成本可控 | DAX(微秒缓存) + Provisioned模式+Auto Scaling |
| S3 公开访问检测 + 告警 | IAM Access Analyzer + EventBridge → SNS |
| 跨账户DynamoDB 属性级访问 | IAM Role(信任+Assume) + dynamodb:Attributes条件 |
| EC2 SSH审计 + 无长期密钥 | EC2 Instance Connect + CloudTrail |
| 大文件上传加速 + 安全 | S3 Transfer Acceleration + Presigned URL + Multipart |
| 私有子网IPv6出站 + 不可入站 | Egress-Only IGW + ::/0路由 |
| CloudFront 故障转移 | Origin Group(主+备) + Failover cache behavior |

---

## 四、架构决策树速记

### 数据库选择
```
需要SQL?
├─ 是 → 需要MySQL/PG兼容?
│   ├─ 是 → 需要5x性能? → Aurora
│   └─ 否 → RDS (Multi-AZ HA)
└─ 否 → NoSQL → 需要全球多活?
    ├─ 是 → DynamoDB Global Tables
    └─ 否 → DynamoDB (Provisioned模式+Auto Scaling)
```

### 消息/事件选择
```
需要什么模式?
├─ 点对点,解耦缓冲 → SQS
├─ 一对多,推送 → 需要模式匹配?
│   ├─ 是 → EventBridge
│   └─ 否 → SNS
└─ 实时流,多消费者重放 → Kinesis Data Streams
```

### 网络连接选择
```
需要什么规模?
├─ 2-3个VPC → VPC Peering (无重叠CIDR)
├─ 100+个VPC → Transit Gateway
├─ 跨账户共享服务 → 有重叠CIDR?
│   ├─ 是 → PrivateLink
│   └─ 否 → RAM共享 或 PrivateLink
└─ 本地到AWS → <10TB在线?
    ├─ 是 → DataSync 或 Direct Connect+VPN
    └─ 否 → Snowball Edge
```

### DR策略选择
```
RPO要求?
├─ < 1秒 → Aurora Global Database / DynamoDB Global Tables
├─ 秒-分钟级 → DRS (EC2块级) / DMS CDC (数据库)
├─ 小时级 → AWS Backup跨区复制 (最省钱!)
└─ 天级 → 手动快照 + 恢复
```

---

## 五、常见陷阱速记

| 陷阱 | 正确认知 |
|---|---|
| Multi-AZ RDS备用可读 | ❌ 备用是被动的,不可读 |
| S3 CRR自动启用 | ❌ 需要先开通版本控制 |
| SCP授予权限 | ❌ SCP只限制权限,需IAM授予 |
| NAT GW跨AZ高可用 | ❌ NAT GW是AZ范围的,需要每AZ一个 |
| S3 对象锁独立使用 | ❌ 必须先开版本控制 |
| DAX替代ElastiCache | ❌ DAX仅DynamoDB,ElastiCache是通用缓存 |
| CloudFront静态IP | ❌ CF IP动态变化,用Global Accelerator |
| Lambda在VPC内自动访问公网 | ❌ 需要NAT Gateway |
| DMS迁移文件 | ❌ DMS仅数据库,用DataSync |
| Aurora Global Database省钱 | ❌ 全球库按复制写I/O计费,成本高 |
