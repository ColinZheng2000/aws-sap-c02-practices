# AWS SAP-C02 面试高频考点速查表

> 📖 基于 266 个真实错题 + 211 道练习题提炼
> 🎯 用途：面试前 30 分钟快速扫描，激活记忆
> 🔄 最后更新：2026-06-16

---

## 🎤🎤🎤 极高频率（几乎必问）

### 计算 (Compute)
| 知识点 | 一句话答案 | 易混淆点 | 教材 |
|---|---|---|---|
| EC2 购买选项对比 | On-Demand(无承诺)→Spot(90%off,可中断)→Reserved(72%off,1-3yr)→Savings Plans(72%off,灵活) | Savings Plans 不覆盖 RDS/MemoryDB | §1 EC2 |
| Lambda 限制 | 15分钟超时, 10GB内存, 250MB代码包, 10GB容器镜像 | Provisioned Concurrency 消除冷启动但花钱 | §1 Lambda |
| Lambda vs EC2 vs Fargate | 事件驱动短时→Lambda; 稳态容器→ECS/Fargate; OS控制→EC2 | Fargate也是serverless但运行容器 | §1 对比 |
| Lambda Reserved vs Provisioned | Reserved=容量保证(不省钱); Provisioned=预热(花钱) | Reserved Concurrency≠billing discount | §1 Lambda |

### 存储 (Storage)
| 知识点 | 一句话答案 | 易混淆点 | 教材 |
|---|---|---|---|
| S3 存储类选择 | Standard→IA→Glacier IR→Glacier Flex→Glacier Deep Archive | IA有30天最低; Intelligent-Tiering收监控费 | §3 S3 |
| S3 CRR vs DataSync vs Storage Gateway | CRR=自动跨区复制; DataSync=迁移/同步; Storage Gateway=混合访问 | Storage Gateway是持续访问不是迁移 | §3 对比 |
| EBS vs EFS vs S3 | EBS=块存储(单AZ); EFS=NFS文件(多AZ); S3=对象(API) | EBS io2支持Multi-Attach | §3 对比 |
| S3 版本控制 + 对象锁 | 版本控制是CRR前提; 对象锁需要版本控制 | 对象锁=WORM,防删除防篡改 | §3 S3 |

### 数据库 (Database)
| 知识点 | 一句话答案 | 易混淆点 | 教材 |
|---|---|---|---|
| RDS Multi-AZ vs Read Replica | Multi-AZ=HA(同步,备用被动); RR=读扩展(异步,可读) | Multi-AZ备用不服务读流量 | §4 RDS |
| Aurora vs RDS | Aurora=5xMySQL/3xPG吞吐, 自动扩容存储, Global DB<1s延迟 | Aurora Serverless v2秒级扩缩 | §4 Aurora |
| DynamoDB vs RDS/Aurora | DynamoDB=NoSQL(键值/文档), 无限水平扩展, Global Tables多活 | 需要JOIN→RDS; 需要无限scale→DynamoDB | §4 对比 |
| DAX vs ElastiCache | DAX=仅DynamoDB(微秒); ElastiCache=任意DB(亚毫秒) | DAX是write-through; ElastiCache需应用管理 | §4 对比 |
| DynamoDB 容量模式 | Provisioned(可预测,便宜)→On-Demand(自动,约2倍贵) | Provisioned需手动Auto Scaling | §4 DynamoDB |

### 网络 (Networking)
| 知识点 | 一句话答案 | 易混淆点 | 教材 |
|---|---|---|---|
| Security Group vs NACL | SG=有状态+实例级(只allow); NACL=无状态+子网级(allow+deny) | SG自动允许回程; NACL必须显式允许回程 | §5 VPC |
| VPC Peering vs Transit Gateway vs PrivateLink | Peering=1:1(不可传递); TGW=Hub(大规模); PrivateLink=服务共享(无CIDR冲突) | PrivateLink支持重叠CIDR | §5 对比 |
| NAT Gateway vs Internet Gateway | IGW=双向公网; NAT GW=仅出站(私有子网) | NAT GW是AZ范围,需要每AZ一个 | §5 VPC |
| ALB vs NLB vs Global Accelerator | ALB=L7(HTTP,WAF); NLB=L4(静态IP,TCP); GA=全球加速(静态anycast IP) | NLB不支持WAF | §5 ALB/NLB |
| Route 53 路由策略 | Simple→Weighted→Latency→Failover→Geolocation→Geoproximity | Failover需要健康检查 | §5 Route53 |

### 安全 (Security)
| 知识点 | 一句话答案 | 易混淆点 | 教材 |
|---|---|---|---|
| IAM 评估逻辑 | Explicit DENY > Explicit ALLOW > Implicit DENY | SCP和Permissions Boundary作为过滤器 | §0 Security |
| SCP vs IAM Policy | SCP=权限上限(OU级,不可覆盖); IAM=授予权限(在上限内) | SCP不授予权限,只限制 | §6 IAM |
| KMS vs Secrets Manager | KMS=加密密钥; Secrets Manager=应用密钥(密码,API key)+自动轮换 | Secrets Manager $0.40/密钥/月 | §6 对比 |
| WAF vs Shield | WAF=L7防火墙(SQL注入,XSS); Shield=DDoS(L3/L4) | Shield Standard免费; Advanced $3K/月 | §6 WAF |
| CloudTrail vs Config vs CloudWatch | CloudTrail=API审计; Config=配置合规; CloudWatch=运维监控 | 三驾马车,功能不同 | §6 对比 |

---

## 🎤🎤 中频率（常见追问）

### 计算/容器
| 知识点 | 一句话答案 | 易混淆点 | 教材 |
|---|---|---|---|
| Placement Group 类型 | Cluster(低延迟,同AZ); Spread(分散硬件,最多7/AZ); Partition(大分布,7分区) | HPC用Cluster不是Spread | §1 EC2 |
| ECS vs EKS | ECS=AWS原生(简单); EKS=K8s标准(多云可移植) | 已有K8s技能→EKS; AWS新手→ECS | §2 对比 |
| Fargate vs EC2 启动类型 | Fargate=Serverless(无节点管理); EC2=自管理(更多控制) | Fargate不支持host-level agent | §2 对比 |
| Auto Scaling 生命周期钩子 | 启动/终止时暂停→执行脚本→继续 | 配合SQS缩容保护防止消息丢失 | §1 ASG |
| Elastic Beanstalk 部署策略 | All-at-Once→Rolling→Immutable→Blue/Green | Immutable回滚最快(旧ASG还在) | §1 EB |

### 存储
| 知识点 | 一句话答案 | 易混淆点 | 教材 |
|---|---|---|---|
| FSx for Windows vs Lustre | Windows=SMB/AD集成; Lustre=HPC高性能 | FSx存储类型创建后不可改,需Backup还原 | §3 FSx |
| Storage Gateway 三种类型 | File(NFS/SMB→S3); Volume(iSCSI→EBS); Tape(VTL→Glacier) | File Gateway配合S3 Lifecycle到Glacier Deep Archive | §3 SGW |
| S3 Transfer Acceleration | 利用边缘节点加速远距离上传,配合Multipart Upload | 适用于>100MB文件 | §3 S3 |
| EBS 加密 | 按Region启用默认加密,所有新卷自动KMS加密 | 不增加性能开销 | §3 EBS |
| S3 RTC | 99.99%对象15分钟内复制完成,可设CloudWatch告警 | 仅对关键前缀启用,不是整个桶 | §3 S3 |

### 数据库
| 知识点 | 一句话答案 | 易混淆点 | 教材 |
|---|---|---|---|
| Aurora Global Database vs DynamoDB Global Tables | Aurora GD=RPO~1s(单主); DDB GT=多活(多主,最终一致) | Aurora GD有Write Forwarding | §4 对比 |
| Babelfish for Aurora | 在Aurora PostgreSQL上运行T-SQL,最小代码改动 | SQL Server→Aurora的Replatform方案 | §4 Aurora |
| DynamoDB WCU/RCU | 1WCU=1KB写/秒; 1RCU=4KB强读/秒(或2次最终读) | 最终一致性读是强读的2倍 | §4 DynamoDB |
| DMS vs SCT | DMS=数据迁移+CDC; SCT=模式转换(Oracle→Aurora等) | 不同引擎=heterogeneous→需要SCT | §4 OtherDB |
| RDS Proxy | Lambda连接池,减少连接开销,支持IAM认证 | 解决Lambda并发连接耗尽 | §4 RDS |

### 网络
| 知识点 | 一句话答案 | 易混淆点 | 教材 |
|---|---|---|---|
| Route 53 Resolver Inbound vs Outbound | Inbound=本地→VPC DNS; Outbound=VPC→本地DNS | Inbound用你的IP; Outbound用AWS托管IP | §5 Route53 |
| CloudFront vs Global Accelerator | CF=CDN缓存(L7 HTTP); GA=网络加速(L4 TCP/UDP) | GA提供静态IP,CF不提供 | §5 对比 |
| Direct Connect vs VPN | DC=专用物理线路(不加密); VPN=IPsec隧道(加密) | DC+VPN=加密的专用连接 | §5 DC |
| API Gateway 端点类型 | Regional→Edge-Optimized(CF)→Private(PrivateLink) | Edge-Optimized是单一Region在CF后面 | §5 APIGW |
| ALB 加权目标组 | 按权重分配流量到不同目标组(如90:10金丝雀) | 配合stickiness确保会话一致性 | §5 ALB |

### 安全/管理/集成
| 知识点 | 一句话答案 | 易混淆点 | 教材 |
|---|---|---|---|
| IAM Roles vs Resource-Based Policies | Role=资源能做什么; Resource Policy=谁能访问资源 | 跨账户: Role+信任 或 Resource Policy | §6 IAM |
| Secrets Manager vs Parameter Store | SM=轮换+跨账户+$0.40/月; PS=免费+无轮换 | 自动轮换RDS密码→Secrets Manager | §6 对比 |
| SQS vs SNS vs EventBridge | SQS=队列(pull); SNS=发布订阅(push); EB=事件总线(模式匹配) | EventBridge有SaaS集成 | §7 对比 |
| Step Functions | 工作流编排,内置重试+错误处理+并行 | Standard=精确1次(1年); Express=高容量(5分钟) | §7 SF |
| CloudFormation StackSets | 跨账户/区域部署同一模板 | vs嵌套Stack(同一账户内拆分) | §8 CF |

### 迁移/混合
| 知识点 | 一句话答案 | 易混淆点 | 教材 |
|---|---|---|---|
| Snowball vs DataSync vs DMS | Snowball=离线设备(>10TB); DataSync=在线文件; DMS=数据库 | 60TB用Snowball,不是Direct Connect | §9 对比 |
| MGN vs DMS | MGN=整服务器(OS+应用+数据); DMS=仅数据库 | MGN=lift-and-shift; DMS=DB迁移 | §9 MGN |
| Outposts vs Snowball Edge | Outposts=永久机架(42U,RDS); Snowball Edge=便携(80TB) | Outposts用于数据驻留+低延迟 | §13 对比 |
| AppStream vs WorkSpaces | AppStream=应用流; WorkSpaces=完整桌面 | AppStream非持久化; WorkSpaces持久化 | §13 对比 |

---

## 🎤 低频率（深度问题）

| 知识点 | 一句话答案 | 教材 |
|---|---|---|
| EC2 Instance Connect vs Session Manager | Instance Connect=临时SSH密钥(60秒); Session Manager=浏览器SSH/RDP | §1 EC2 |
| Lambda@Edge 限制 | 5秒超时(viewer), 128MB内存, 仅Node/Python | §1 Lambda |
| EKS + EFS | EFS作为K8s PVC实现有状态Pod | §2 EKS |
| ECR Enhanced Scanning | 与Inspector集成,持续CVE检测,EventBridge+Step Functions自动化 | §2 ECR |
| Redshift Concurrency Scaling vs Elastic Resize | CS=瞬态额外容量(突发查询); ER=快速调整节点数(同类型) | §4 OtherDB |
| IPv6 + Egress-Only IGW | 私有子网IPv6出站不用NAT GW(NAT GW仅IPv4) | §5 VPC |
| Cross-Region PrivateLink | 原生不支持,变通:NLB IP targets+跨区VPC Peering | §5 OtherNet |
| IAM Access Analyzer | 持续监控资源策略的公开/跨账户访问,EventBridge→SNS告警 | §6 IAM |
| SCP + Tag Policy + Cost Explorer | 标签策略→强制执行→Cost Explorer按标签分摊成本 | §8 Org |
| AWS Backup 跨账户 | Organizations内跨账户+跨区域备份复制 | §8 OtherMgmt |
| DLM vs AWS Backup | DLM=EBS快照(小时RPO); Backup=多服务集中(小时RPO) | §8 对比 |
| CloudFormation Custom Resources | Lambda支持的操作CF不支持时使用,响应发到预签名S3 URL | §8 CF |
| AppSync WebSocket | GraphQL实时订阅,Serverless后端 | §7 AppSync |
| Migration Evaluator + ADS | Evaluator=商业案例; ADS=技术发现+依赖映射 | §9 Migration |

---

## 🔢 关键数字速记

| 数值 | 含义 |
|---|---|
| 15 分钟 | Lambda 最大超时 |
| 14 天 | SQS 消息最长保留 |
| < 1 秒 | Aurora Global Database 典型复制延迟 |
| < 1 分钟 | Aurora Global Database 故障转移 RTO |
| < 15 分钟 | S3 RTC 99.99% 对象复制完成 |
| 5 TB | S3 单对象最大大小 |
| 128 TB | Aurora 存储自动扩容最大值 |
| 450+ | CloudFront 边缘节点数 |
| 10 Gbps | DataSync 每 agent 最大带宽 |
| 80 TB | Snowball Edge 可用存储 |
| 100 PB | Snowmobile 容量 |
| 72% | EC2 Savings Plan 最大折扣 |
| 90% | Spot Instance 最大折扣 |
| 24 小时 | DynamoDB Streams 记录保留 |
| 365 天 | Kinesis Data Streams 最长保留 |
