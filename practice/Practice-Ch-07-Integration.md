---
chapter: "7. Application Integration"
totalQuestions: 12
tiers:
  knowledge: 4
  scenario: 5
  comparison: 3
basedOn: "AWS-SAP-C02-Learning-Material.md §7"
services:
  - SQS
  - SNS
  - EventBridge
  - Step Functions
  - AppSync
---

# Chapter 7 Practice: 🔗 Application Integration

> **Instructions**: Complete Part A first. Do not scroll past the divider. Once finished, check Part B for answers and explanations.
> **Textbook**: `AWS-SAP-C02-Learning-Material.md` �?Section 7 (SQS, SNS, EventBridge, Step Functions, AppSync) + Similar Service Comparison: Messaging & Events

---

# Part A �?Questions

## 🟢 Knowledge Check (4 questions)

### Q7.1

> 🟡 L2-理解 | 🎤🎤 中频面试
What happens to an SQS message that is received by a consumer but not deleted before the visibility timeout expires?

- A. The message is permanently deleted from the queue
- B. The message becomes visible again and can be processed by another consumer
- C. The message is automatically sent to the Dead Letter Queue
- D. The message remains invisible indefinitely

### Q7.2

> 🟡 L2-理解 | 🎤🎤 中频面试
A solutions architect needs to send a single message to multiple SQS queues simultaneously �?each queue should receive a copy of the message. Which service enables this fan-out pattern?

- A. Amazon SQS with message duplication
- B. Amazon SNS with SQS subscriptions
- C. Amazon EventBridge with SQS targets
- D. AWS Step Functions with parallel state

### Q7.3

> 🟢 L1-知识 | 🎤🎤 中频面试
What is the purpose of a Dead Letter Queue (DLQ) in SQS?

- A. To store messages that failed processing after exceeding the maximum receive count
- B. To temporarily hold messages during high-traffic periods
- C. To duplicate messages for redundancy across multiple queues
- D. To store messages that were successfully processed for auditing

### Q7.4

> 🟡 L2-理解 | 🎤🎤 中频面试
A workflow consists of three sequential steps: (1) validate input (2 seconds), (2) process data (2 hours), (3) send notification (1 second). Each step depends on the successful completion of the previous step. If any step fails, the workflow should retry with exponential backoff.

Which service should orchestrate this workflow?

- A. Amazon SQS with a message processing chain
- B. Amazon SNS with Lambda subscriptions
- C. AWS Step Functions
- D. Amazon EventBridge with event rules

---

## 🟡 Scenario Analysis (5 questions)

### Q7.5

> 🟡 L2-理解 | 🎤🎤 中频面试
A company's order processing system uses EC2 instances in an Auto Scaling group. Orders arrive via an SQS queue. During peak hours, messages accumulate in the queue. The Auto Scaling group scales based on the `ApproximateNumberOfMessagesVisible` metric. During scale-in, some EC2 instances are terminated while still processing orders.

Which combination of features prevents this? (Choose two.)

- A. Enable scale-in protection on instances currently processing orders
- B. Increase the SQS message retention period
- C. Implement EC2 Auto Scaling lifecycle hooks to delay termination until processing completes
- D. Switch from SQS Standard to SQS FIFO
- E. Use EventBridge instead of SQS for order delivery

### Q7.6

> 🟡 L2-理解 | 🎤🎤 中频面试
A company receives events from multiple SaaS applications (Zendesk, Datadog, PagerDuty). Each event type must be routed to different Lambda functions based on event attributes (e.g., source application, event type, severity). The solution must support new SaaS integrations in the future.

Which service should be used as the event bus?

- A. Amazon SNS with message filtering
- B. Amazon EventBridge
- C. Amazon SQS with multiple queues
- D. AWS Step Functions with choice state

### Q7.7

> 🟡 L2-理解 | 🎤🎤 中频面试
A serverless application receives IoT telemetry data via API Gateway. The data must be processed by multiple downstream services: (a) real-time anomaly detection (Lambda), (b) long-term storage (S3), and (c) a third-party monitoring service (HTTP endpoint). Each downstream service should receive every message.

Which architecture minimizes coupling?

- A. Lambda writes to SQS; each downstream service polls its own queue
- B. SNS topic publishes to SQS queues for each downstream service, with Lambda, S3 event, and HTTP subscriptions
- C. Step Functions orchestrates three parallel Lambda functions
- D. API Gateway directly invokes each downstream service

### Q7.8

> 🟡 L2-理解 | 🎤🎤 中频面试
A company needs a real-time, bidirectional communication channel between a mobile app and a serverless backend. Users should subscribe to specific data channels and receive updates instantly when data changes. The backend uses DynamoDB.

Which services should be used together?

- A. API Gateway REST API + SQS long polling
- B. AWS AppSync with GraphQL subscriptions + DynamoDB
- C. SNS with mobile push notifications
- D. API Gateway WebSocket API + Lambda + DynamoDB Streams

### Q7.9

> 🟡 L2-理解 | 🎤🎤 中频面试
An SQS queue receives 1,000 messages per second. A Lambda function processes each message, but occasionally a message cannot be processed due to a temporary downstream service outage. The solution should automatically retry failed messages and isolate those that repeatedly fail for manual inspection.

Which SQS features should be configured?

- A. Configure a Dead Letter Queue with `maxReceiveCount` set to an appropriate value; after messages are moved to the DLQ, analyze and redrive them to the source queue
- B. Increase the SQS visibility timeout to 12 hours
- C. Use SQS FIFO to guarantee exactly-once processing
- D. Duplicate each message to a backup queue for manual processing

---

## 🔴 Similar Service Comparison (3 questions)

### Q7.10

> 🟡 L2-理解 | 🎤🎤 中频面试
A company needs to decouple a producer from a consumer. Messages must be buffered and processed in order, and the consumer pulls messages at its own pace. The order of processing matters. Which messaging pattern and service should be used?

- A. Pub/Sub (push) �?Amazon SNS with a FIFO topic
- B. Queue (pull) �?Amazon SQS FIFO queue
- C. Event bus (push) �?Amazon EventBridge
- D. Stream (pull) �?Amazon Kinesis Data Streams

### Q7.11

> 🟡 L2-理解 | 🎤🎤 中频面试
A solution requires delivering events from AWS services to three different consumer applications. Each consumer needs only specific types of events:
- Consumer A needs only EC2 state-change events
- Consumer B needs only S3 object creation events
- Consumer C needs only events with severity "CRITICAL" from any service

The solution must be serverless and require no infrastructure management. Which service provides this granular, pattern-based event routing?

- A. Amazon SNS with subscription filter policies
- B. Amazon EventBridge
- C. Amazon SQS with three queues
- D. AWS Lambda with custom event routing logic

### Q7.12

> 🟡 L2-理解 | 🎤🎤 中频面试
A gaming company collects real-time player event data (clicks, moves, scores) at 50,000 events per second. Multiple analytics applications need to consume this stream independently, each processing events at its own pace. Some consumers need to replay events from up to 7 days ago. Which service should be used?

- A. Amazon SQS FIFO queue
- B. Amazon SNS FIFO topic
- C. Amazon Kinesis Data Streams
- D. Amazon EventBridge with archive and replay

---

# Part B �?Answers & Explanations

> ⚠️ **STOP HERE.** Complete all questions in Part A before reading below.

---

## 🟢 Knowledge Check �?Answers

### A7.1
**Correct: B** �?The message becomes visible again and can be processed by another consumer.

**Why**: The visibility timeout is the period during which SQS prevents other consumers from receiving and processing the same message. If the consumer fails to delete the message before the timeout expires (because of a crash, bug, or timeout), the message becomes visible again in the queue and another consumer can receive it. This is SQS's built-in fault tolerance mechanism.

**Why not the others**:
- **A**: Messages are only permanently deleted when the consumer explicitly calls `DeleteMessage`.
- **C**: Messages go to the DLQ only after exceeding `maxReceiveCount` �?not after a single visibility timeout expiry.
- **D**: The invisibility is temporary �?it expires after the visibility timeout period.

**📖 Textbook ref**: §7 �?SQS, "Visibility Timeout"

---

### A7.2
**Correct: B** �?Amazon SNS with SQS subscriptions.

**Why**: SNS is a pub/sub service. An SNS topic can have multiple subscriptions, including SQS queues. When a message is published to the topic, SNS delivers a copy to each subscription. This is the canonical "fan-out" pattern: one message �?multiple SQS queues, each independently processed by different consumers.

**Why not the others**:
- **A**: SQS does not duplicate messages across queues �?one message goes to one queue.
- **C**: EventBridge can route to multiple targets but is pattern-based �?it doesn't inherently fan out to multiple identical consumers.
- **D**: Step Functions orchestrates workflows, not message fan-out.

**📖 Textbook ref**: §7 �?SNS, "Fan-out Pattern: SNS �?multiple SQS queues"

---

### A7.3
**Correct: A** �?To store messages that failed processing after exceeding the maximum receive count.

**Why**: A Dead Letter Queue (DLQ) is a separate SQS queue that receives messages that have been received and not deleted `maxReceiveCount` times. Instead of the message cycling endlessly in the source queue (consuming resources and potentially blocking other messages), it's moved to the DLQ for analysis. You can then diagnose why processing failed, fix the issue, and redrive the messages back to the source queue.

**Why not the others**:
- **B**: DLQ is for failed messages, not temporary traffic buffering.
- **C**: DLQ doesn't duplicate �?it moves messages from the source queue.
- **D**: DLQ stores failed messages, not successfully processed ones.

**📖 Textbook ref**: §7 �?SQS, "Dead Letter Queue (DLQ)"

---

### A7.4
**Correct: C** �?AWS Step Functions.

**Why**: Step Functions is purpose-built for multi-step workflow orchestration. It coordinates sequential steps, handles errors with built-in exponential backoff retry (configurable), manages state between steps, and can integrate with Lambda (for short steps 1 and 3) and AWS Batch or ECS (for the 2-hour step 2 that exceeds Lambda's 15-minute timeout). The declarative state machine definition handles all the coordination logic.

**Why not the others**:
- **A**: SQS chains require custom code to coordinate stages, manage retries, and track state.
- **B**: SNS is fire-and-forget �?it doesn't coordinate sequential steps or manage state.
- **D**: EventBridge routes events based on patterns �?it doesn't orchestrate sequential workflows.

**📖 Textbook ref**: §7 �?Step Functions, "Orchestration" and "Error Handling"

---

## 🟡 Scenario Analysis �?Answers

### A7.5
**Correct: A and C** �?Scale-in protection + lifecycle hooks.

**Why**:
- **A (Scale-in protection)**: When an instance picks up an order from SQS, it can enable scale-in protection on itself. While processing, it's protected from termination. When it finishes the batch and is ready to be terminated, it removes the protection.
- **C (Lifecycle hooks)**: A termination lifecycle hook pauses the instance just before termination, allowing a script to complete in-flight processing and drain the local queue. After the hook completes, the instance is terminated.

**Why not the others**:
- **B**: Retention period affects how long messages stay in the queue before being deleted, not how instances process them.
- **D**: FIFO guarantees ordering but doesn't solve the termination-during-processing problem.
- **E**: EventBridge doesn't buffer messages for EC2 processing �?it's for event routing.

**📖 Textbook ref**: §1 �?EC2 Auto Scaling, "Scale-In Protection" and "Lifecycle Hooks"; §7 �?SQS, "SQS + Auto Scaling"

---

### A7.6
**Correct: B** �?Amazon EventBridge.

**Why**: EventBridge has native integrations with SaaS applications (Zendesk, Datadog, PagerDuty) �?events from these partners flow directly into the event bus. EventBridge uses pattern-based routing: you define rules that match specific event attributes (source, event type, severity), and each rule routes matching events to specific targets (Lambda functions). New integrations simply need new rules �?no architectural changes.

**Why not the others**:
- **A**: SNS filtering works but SNS doesn't have native SaaS integrations.
- **C**: SQS with multiple queues requires the SaaS applications to push to different queues �?not a unified event bus.
- **D**: Step Functions orchestrates workflows, not event routing.

**📖 Textbook ref**: §7 �?EventBridge, "SaaS integration" and "Pattern-based routing"

---

### A7.7
**Correct: B** �?SNS topic publishes to SQS queues for each downstream service, with Lambda, S3 event, and HTTP subscriptions.

**Why**: This is the decoupled fan-out architecture. The API Gateway publishes to an SNS topic. SNS delivers to: (a) Lambda for anomaly detection (direct Lambda subscription), (b) SQS �?Lambda �?S3 for long-term storage (durable), (c) HTTP endpoint for third-party monitoring. Each downstream service operates independently �?if one fails, others are unaffected. Adding a new consumer just means adding a new subscription.

**Why not the others**:
- **A**: A Lambda writing to SQS is a custom fan-out with more custom code to maintain.
- **C**: Step Functions is for sequential/parallel orchestration of a single workflow, not independent fan-out.
- **D**: API Gateway directly invoking each service creates tight coupling �?if one service is slow, the entire API call is slow.

**📖 Textbook ref**: §7 �?SNS, "Fan-out Pattern" and "SNS + SQS"

---

### A7.8
**Correct: B** �?AWS AppSync with GraphQL subscriptions + DynamoDB.

**Why**: AppSync provides managed GraphQL with real-time subscriptions via WebSocket. Clients subscribe to specific data channels (e.g., `onUpdateOrder`), and when data changes in DynamoDB, AppSync pushes updates to all subscribed clients in real time. This is the native, serverless solution for real-time bidirectional communication with a DynamoDB backend.

**Why not the others**:
- **A**: REST API with SQS long polling is pull-based �?clients poll for updates, not receive them instantly.
- **C**: SNS push notifications are for mobile notifications (APNs, FCM), not real-time data subscription channels.
- **D**: WebSocket API with DynamoDB Streams also works but requires more custom code for subscription management �?AppSync handles this natively.

**📖 Textbook ref**: §7 �?AppSync, "Real-time subscriptions via WebSocket"

---

### A7.9
**Correct: A** �?Configure DLQ with `maxReceiveCount`; after messages move to DLQ, analyze and redrive.

**Why**: This is the standard SQS error handling pattern. Set `maxReceiveCount` to a value like 3�?. If a Lambda invocation fails (throws an error), SQS receives the message again until the receive count exceeds the threshold, at which point the message is moved to the DLQ. From the DLQ, you can inspect failed messages, fix the root cause (e.g., downstream service is back up), and redrive them to the source queue for reprocessing.

**Why not the others**:
- **B**: A 12-hour visibility timeout means failed messages are invisible for 12 hours each time �?too long for a temporary outage.
- **C**: FIFO addresses ordering, not failure handling.
- **D**: Duplicating messages adds unnecessary complexity �?SQS DLQ is the native solution.

**📖 Textbook ref**: §7 �?SQS, "DLQ: Analyze, then redrive to source queue"

---

## 🔴 Similar Service Comparison �?Answers

### A7.10
**Correct: B** �?Queue (pull) �?Amazon SQS FIFO queue.

**Why**: Three requirements drive this choice: (1) Decouple producer from consumer �?both queue and pub/sub achieve this. (2) Messages must be processed in order �?SQS FIFO guarantees first-in-first-out ordering within a message group. (3) Consumer pulls at its own pace �?SQS is a pull-based model where the consumer controls the consumption rate. The "pull" model is SQS's defining characteristic.

**Why not the others**:
- **A**: SNS is push-based �?the consumer must be available when SNS delivers; it doesn't buffer messages for the consumer's pace.
- **C**: EventBridge is push-based and doesn't guarantee ordering.
- **D**: Kinesis is pull-based and ordered, but "message" semantics (vs. stream) and the specific need for independent message processing point to SQS.

**📖 Textbook ref**: §7 �?Similar Service Comparison, "SQS vs SNS vs EventBridge vs Kinesis"

---

### A7.11
**Correct: B** �?Amazon EventBridge.

**Why**: EventBridge's core value proposition is pattern-based event routing. You define rules with event patterns (matching `source`, `detail-type`, or specific JSON fields like `detail.severity`). Consumer C's rule matches any event where `$.detail.severity == "CRITICAL"` �?this level of content-based routing is exactly what EventBridge is designed for. SNS can filter on message attributes (metadata) but can't filter on the actual event body/JSON structure.

**Why not the others**:
- **A**: SNS subscription filter policies can filter on message attributes, not on the event body/JSON content like "severity within the event payload."
- **C**: SQS would require all messages to go to one queue and consumers to filter themselves �?wasteful.
- **D**: A custom Lambda router adds management overhead (not truly serverless in the managed sense).

**📖 Textbook ref**: §7 �?EventBridge, "Pattern-based routing (rules match event attributes)"; Similar Service Comparison

---

### A7.12
**Correct: C** �?Amazon Kinesis Data Streams.

**Why**: Three requirements point to Kinesis: (1) High throughput �?50,000 events/sec is well within Kinesis capacity (each shard = 1,000 records/sec writes; 50 shards handle this). (2) Multiple independent consumers �?Kinesis supports multiple consumer applications reading from the same stream, each at its own pace, without affecting others. (3) Replay capability �?Kinesis retains data for up to 365 days (configurable); consumers can replay events from any point within the retention window.

**Why not the others**:
- **A**: SQS messages max at 14 days retention; once consumed and deleted, they cannot be replayed.
- **B**: SNS is fire-and-forget �?no replay capability.
- **D**: EventBridge archive supports replay but is not designed for 50K events/sec sustained throughput and per-consumer pacing.

**📖 Textbook ref**: §7 �?Similar Service Comparison, "Kinesis: Real-time streaming, replay, multi-consumer"

---

> **📊 Chapter 7 Summary**: 4 Knowledge + 5 Scenario + 3 Comparison = 12 questions
> 
> **Next**: If you missed any questions, review the corresponding section in `AWS-SAP-C02-Learning-Material.md` and add the Q number to your missed question tracker.
