# SysDesign Flash — Complete App Plan

> A visual, swipeable system design flashcard app for backend engineers preparing for
> interviews or building intuition for large-scale systems.
> Built with Flutter · Material 3 · Riverpod · Hive · Supabase

---

## Table of Contents

1. [Vision & Goals](#1-vision--goals)
2. [Full System Design Knowledge Bank](#2-full-system-design-knowledge-bank)
3. [Monetisation — Free & Pro](#3-monetisation--free--pro)
4. [App Architecture](#4-app-architecture)
5. [Phase 1 — Foundation](#5-phase-1--foundation-weeks-12)
6. [Phase 2 — Core Features](#6-phase-2--core-features-weeks-34)
7. [Phase 3 — Learning Engine](#7-phase-3--learning-engine-weeks-56)
8. [Phase 4 — Polish & UX](#8-phase-4--polish--ux-weeks-78)
9. [Phase 5 — Backend & Auth](#9-phase-5--backend--auth-weeks-910)
10. [Phase 6 — Launch & GTM](#10-phase-6--launch--gtm-weeks-1112)
11. [Phase 7 — Growth](#11-phase-7--growth-post-launch)
12. [Tech Stack Reference](#12-tech-stack-reference)
13. [File & Folder Structure](#13-file--folder-structure)
14. [Summary Timeline](#14-summary-timeline)

---

## 1. Vision & Goals

### What it is
A mobile-first flashcard app that teaches system design through **visual ASCII diagrams**,
**mnemonics**, **key bullet points**, and **real interview questions** — all in a swipeable
card format optimised for quick revision sessions of 5–15 minutes.

### Target users
- Backend engineers preparing for FAANG / senior-level interviews
- Mid-level engineers building system design intuition
- Computer science students learning distributed systems
- Engineering managers brushing up on architectural patterns

### Core learning principles
- **Spaced repetition** — surface weak concepts more often, not randomly
- **Visual memory** — ASCII diagrams + icons for right-brain retention
- **Active recall** — interview Q&A reveal mechanic forces retrieval, not re-reading
- **Micro-sessions** — each card takes 60–90 seconds; usable on a commute
- **No barriers to learning** — all content is free; Pro makes you learn faster, not differently

---

## 2. Full System Design Knowledge Bank

This is the complete curriculum. Every category maps to a deck of flashcards.
Total: **120+ cards** across 13 categories. All cards are free.

---

### 2.1 Scalability & Performance

| Concept | Key Trade-off | Interview Hook |
|---|---|---|
| Horizontal vs Vertical Scaling | Cost vs hardware ceiling | Design Twitter feed for 500M users |
| Load Balancing (L4 vs L7) | Simplicity vs intelligence | Design a global CDN |
| Auto-scaling (HPA, ASG) | Responsiveness vs cost | Design a viral video platform |
| Caching Strategies (Cache-aside, Write-through, Write-behind) | Freshness vs speed | Design a URL shortener |
| Cache Eviction (LRU, LFU, FIFO) | Hit rate vs memory | Design a browser cache |
| CDN & Edge Computing | Latency vs staleness | Design YouTube video delivery |
| Read Replicas | Consistency vs read throughput | Design an e-commerce product page |
| Database Sharding | Complexity vs horizontal scale | Design Instagram's data layer |
| Denormalisation | Query speed vs write overhead | Design a leaderboard |
| Connection Pooling | Latency vs resource use | Debug slow DB queries under load |

---

### 2.2 Distributed Systems Fundamentals

| Concept | Key Trade-off | Interview Hook |
|---|---|---|
| CAP Theorem | Consistency vs Availability | Design a distributed bank |
| PACELC Theorem | Extends CAP with latency | Design DynamoDB's behaviour |
| Eventual Consistency | Availability vs correctness | Design a shopping cart |
| Strong vs Weak Consistency | Latency vs accuracy | Design a real-time chat read receipt |
| Consensus Algorithms (Raft, Paxos) | Safety vs liveness | Design a distributed config store |
| Leader Election | Availability vs split-brain risk | Design a distributed lock |
| Vector Clocks | Causality tracking overhead | Design conflict resolution in Dynamo |
| Distributed Transactions (2PC, Saga) | Atomicity vs availability | Design a payment flow |
| Idempotency | Safety vs complexity | Design a retry-safe payments API |
| Exactly-Once Delivery | Throughput vs correctness | Design a billing event pipeline |

---

### 2.3 Data Storage & Databases

| Concept | Key Trade-off | Interview Hook |
|---|---|---|
| SQL vs NoSQL | Structure vs flexibility | Design Instagram storage |
| Relational DB (PostgreSQL) | ACID vs scalability | Design a user-relationship graph |
| Wide-Column (Cassandra, HBase) | Write throughput vs query flexibility | Design a time-series metrics store |
| Document DB (MongoDB) | Schema flexibility vs joins | Design a CMS |
| Key-Value Store (Redis, DynamoDB) | Speed vs query richness | Design a session store |
| Graph DB (Neo4j) | Relationship traversal vs scalability | Design LinkedIn's people-you-may-know |
| Time-Series DB (InfluxDB, Prometheus) | Compression vs query complexity | Design an IoT sensor platform |
| Search DB (Elasticsearch) | Full-text search vs consistency | Design autocomplete / search |
| Object Storage (S3, GCS) | Cost vs latency | Design Google Photos |
| Block vs File vs Object Storage | I/O performance vs cost | Design a cloud file system |
| Database Indexing (B-Tree, LSM, Hash) | Read speed vs write amplification | Debug slow query on 100M-row table |
| ACID Properties | Safety vs performance | Design a double-entry ledger |
| BASE Properties | Availability vs exactness | Design a social media like counter |
| Database Replication (sync vs async) | Durability vs latency | Design a multi-region DB |
| Write-Ahead Log (WAL) | Durability vs write amplification | How does PostgreSQL crash-recover? |

---

### 2.4 Messaging & Event-Driven Systems

| Concept | Key Trade-off | Interview Hook |
|---|---|---|
| Message Queues (SQS, RabbitMQ) | Decoupling vs operational cost | Design an email delivery system |
| Pub/Sub (Kafka, Google Pub/Sub) | Fan-out scale vs ordering | Design a notification system |
| Kafka Architecture (topics, partitions, offsets) | Throughput vs ordering guarantee | Design a real-time analytics pipeline |
| Event Sourcing | Auditability vs storage growth | Design an audit log |
| CQRS | Read/write optimisation vs complexity | Design a bank account view |
| Dead Letter Queues | Resilience vs debugging overhead | Design a payment retry system |
| Message Ordering | Correctness vs throughput | Design a chat message delivery system |
| Backpressure | System protection vs latency | Design a log ingestion pipeline |
| Stream Processing (Flink, Spark Streaming) | Latency vs throughput | Design a fraud detection system |
| Change Data Capture (CDC, Debezium) | Sync accuracy vs coupling | Design a search index updater |

---

### 2.5 API Design & Communication

| Concept | Key Trade-off | Interview Hook |
|---|---|---|
| REST API Design | Simplicity vs expressiveness | Design the Uber Eats API |
| GraphQL | Flexibility vs complexity | Design a mobile-optimised API |
| gRPC & Protocol Buffers | Performance vs tooling maturity | Design internal microservice comms |
| WebSockets | Real-time vs state management | Design a live auction platform |
| Server-Sent Events (SSE) | Simplicity vs bidirectionality | Design a live dashboard |
| Long Polling | Compatibility vs efficiency | Design legacy-compatible notifications |
| API Gateway | Centralised control vs bottleneck | Design a multi-service mobile backend |
| API Versioning | Stability vs evolution | Deprecate a heavily-used endpoint |
| Pagination (cursor vs offset) | Performance vs simplicity | Design infinite scroll for Twitter |
| Idempotency Keys | Safety vs complexity | Design a safe payments POST |

---

### 2.6 Reliability & Fault Tolerance

| Concept | Key Trade-off | Interview Hook |
|---|---|---|
| Circuit Breaker | Fail-fast vs availability | Design resilient payment service calls |
| Retry with Exponential Backoff & Jitter | Resilience vs thundering herd | Design a retry-safe notification sender |
| Bulkhead Pattern | Isolation vs resource efficiency | Design a multi-tenant SaaS |
| Timeout Strategy | Responsiveness vs false failures | Set DB timeouts for a high-traffic API |
| Health Checks (liveness vs readiness) | Safety vs false negatives | Design Kubernetes pod readiness |
| Graceful Degradation | UX vs engineering cost | Design Netflix during a partial outage |
| Chaos Engineering | Confidence vs risk | Design a fault injection test plan |
| SLA / SLO / SLI | Accountability vs over-engineering | Define reliability targets for a payment API |
| Error Budgets | Velocity vs reliability | Balance feature shipping with uptime |
| Multi-region Failover | Resilience vs cost | Design a globally available service |

---

### 2.7 Rate Limiting & Traffic Management

| Concept | Key Trade-off | Interview Hook |
|---|---|---|
| Token Bucket | Burst tolerance vs complexity | Design Twitter API rate limiter |
| Leaky Bucket | Smooth output vs burst rejection | Design downstream traffic smoother |
| Fixed Window Counter | Simplicity vs boundary spikes | Design a basic request quota |
| Sliding Window Log | Accuracy vs memory use | Design a precise API quota tracker |
| Sliding Window Counter | Balance of accuracy + memory | Design a production rate limiter |
| Distributed Rate Limiting (Redis) | Accuracy vs network overhead | Rate limit across 50 API servers |
| Throttling vs Rate Limiting | User experience vs protection | Design fair-use quotas per user tier |
| DDoS Mitigation | Security vs false positives | Design Cloudflare-style traffic scrubbing |
| Request Queuing (priority queues) | Fairness vs latency | Design a job scheduling system |

---

### 2.8 Microservices & System Architecture

| Concept | Key Trade-off | Interview Hook |
|---|---|---|
| Monolith vs Microservices | Simplicity vs scalability | When should Uber split a monolith? |
| Service Discovery (Consul, Eureka) | Dynamic routing vs overhead | Design microservice mesh with auto-discovery |
| API Gateway Pattern | Centralisation vs bottleneck | Design Netflix's edge layer |
| Sidecar Pattern | Separation of concerns vs resource use | Design service mesh observability |
| Strangler Fig Migration | Safe migration vs long transition | Migrate a legacy monolith to services |
| Saga Pattern | Distributed consistency vs complexity | Design a multi-service order flow |
| BFF (Backend for Frontend) | Client-specific optimisation vs duplication | Design separate mobile/web APIs |
| Domain-Driven Design (DDD) | Bounded contexts vs upfront cost | Define service boundaries for e-commerce |
| Event-Driven Architecture | Decoupling vs debugging difficulty | Design a real-time order tracking system |
| Service Mesh (Istio, Linkerd) | Observability vs operational overhead | Design mutual TLS across 200 services |

---

### 2.9 Security & Authentication

| Concept | Key Trade-off | Interview Hook |
|---|---|---|
| OAuth 2.0 / OpenID Connect | Delegation vs complexity | Design Google Sign-In for your app |
| JWT vs Session Tokens | Statelessness vs revocability | Design auth for a microservices system |
| API Key Management | Simplicity vs security | Design API keys for a developer platform |
| Encryption at Rest vs in Transit | Security vs performance | Design encrypted user data storage |
| Secret Management (Vault, AWS Secrets Manager) | Security vs developer friction | Rotate DB credentials without downtime |
| Zero Trust Architecture | Security vs usability | Design auth for an internal tools platform |
| CSRF / XSS / SQL Injection Prevention | Security vs developer speed | Audit a web app for OWASP Top 10 |
| Data Masking & PII Handling | Privacy vs analytics utility | Design GDPR-compliant user data pipeline |
| mTLS (Mutual TLS) | Trust vs operational complexity | Secure service-to-service comms |
| Role-Based Access Control (RBAC) | Flexibility vs management overhead | Design permissions for a SaaS platform |

---

### 2.10 Observability & Operations

| Concept | Key Trade-off | Interview Hook |
|---|---|---|
| Logging (structured logs, log levels) | Insight vs storage cost | Debug a production incident with logs |
| Distributed Tracing (Jaeger, Zipkin, OTEL) | Root cause visibility vs overhead | Trace a slow request across 8 services |
| Metrics & Alerting (Prometheus, Grafana) | Proactive detection vs alert fatigue | Design SLO-based alerting for a payment API |
| The Four Golden Signals | Simplicity vs completeness | Define monitoring strategy for a new service |
| Centralized Log Aggregation (ELK, Loki) | Searchability vs cost | Design log pipeline for 10k req/sec |
| On-Call & Incident Management | Response speed vs engineer burnout | Design an escalation policy |
| Runbooks & Playbooks | Consistency vs maintenance overhead | Write a runbook for DB failover |
| Canary Deployments | Safety vs release speed | Roll out a risky DB migration safely |
| Feature Flags | Decoupled releases vs complexity | Design gradual feature rollout |
| Capacity Planning | Cost vs over-provisioning | Plan infrastructure for 10x growth |

---

### 2.11 Networking & Infrastructure

| Concept | Key Trade-off | Interview Hook |
|---|---|---|
| DNS & Anycast | Lookup latency vs propagation delay | How does Cloudflare route global traffic? |
| TCP vs UDP | Reliability vs speed | When would you choose UDP? |
| HTTP/1.1 vs HTTP/2 vs HTTP/3 | Feature richness vs complexity | Why upgrade to HTTP/2 for an API? |
| TLS Handshake & Certificates | Security vs connection latency | Debug slow HTTPS connection setup |
| Reverse Proxy vs Forward Proxy | Traffic control vs privacy | Design Nginx as an API gateway |
| VPC, Subnets, Security Groups | Isolation vs flexibility | Design network isolation for PCI-DSS |
| Service Mesh (network layer) | Observability vs resource overhead | Why use Istio over direct gRPC? |
| NAT & Private Networks | Security vs routing complexity | Design a private internal service network |
| Bandwidth vs Latency vs Throughput | Common confusion to clarify | Optimise file upload for mobile users |

---

### 2.12 Data Engineering & Processing

| Concept | Key Trade-off | Interview Hook |
|---|---|---|
| Batch vs Stream Processing | Latency vs simplicity | Design an analytics dashboard |
| MapReduce | Scale vs operational complexity | Design a word count across 1PB of logs |
| Lambda Architecture | Speed vs operational burden | Design a real-time + historical dashboard |
| Kappa Architecture | Simplicity vs historical reprocessing | Replace Lambda with a simpler pipeline |
| ETL vs ELT | Control vs cloud warehouse power | Design a data warehouse pipeline |
| Data Partitioning Strategies | Query performance vs balance | Design a Hive table for time-series logs |
| Data Lake vs Data Warehouse | Flexibility vs query speed | Design Airbnb's analytics infrastructure |
| Bloom Filters | Space efficiency vs false positives | Avoid DB lookups for non-existent URLs |
| Consistent Hashing | Even distribution vs complexity | Design a distributed cache ring |
| Merkle Trees | Efficient comparison vs build cost | How does Dynamo detect data inconsistency? |

---

### 2.13 Classic Interview System Designs

These are the canonical questions every backend engineer must be ready for.
Each maps to a focused card series in the app.

| System | Core Challenges | Key Components |
|---|---|---|
| URL Shortener (bit.ly) | High read, redirect speed, analytics | Hashing, Redis cache, Cassandra |
| Pastebin | Storage, expiry, abuse prevention | Object storage, TTL, rate limiting |
| Twitter Feed | Fan-out at scale, timeline assembly | Kafka, Redis sorted sets, sharding |
| Instagram | Media upload, CDN, feed generation | S3, CDN, PostgreSQL + Cassandra |
| WhatsApp / Chat | Real-time delivery, offline support | WebSocket, Kafka, message store |
| Uber / Ride Sharing | Geo-matching, surge pricing, maps | Geohash, Redis, WebSocket, Kafka |
| Netflix | Video encoding, adaptive streaming | CDN, Spark, Cassandra, Kafka |
| Google Search | Crawling, indexing, ranking, serving | Distributed crawler, inverted index, MapReduce |
| Google Drive / Dropbox | File sync, versioning, conflict resolution | Block storage, CDC, diff-sync protocol |
| Notification System | Scale, multi-channel, rate limiting | Kafka, FCM/APNs, SendGrid, Redis |
| Rate Limiter | Distributed counters, accuracy | Token bucket, Redis INCR+TTL |
| Web Crawler | Distributed crawling, politeness, dedup | BFS/DFS, bloom filter, queue |
| Search Autocomplete | Latency, ranking, prefix matching | Trie, Redis, Elasticsearch |
| Design YouTube | Upload, transcode, stream, recommendations | S3, FFmpeg, CDN, Kafka, Cassandra |
| Design a Payment System | Idempotency, ACID, fraud, reconciliation | PostgreSQL, Kafka, Saga, Vault |
| Distributed Cache | Eviction, consistency, partitioning | Consistent hashing, Redis Cluster |
| Key-Value Store | Durability, partitioning, replication | LSM tree, consistent hashing, Raft |
| Distributed Message Queue | Ordering, durability, at-least-once | Kafka internals, ISR, consumer groups |
| Typeahead / Search | Latency < 100ms, ranking, update lag | Trie, Elasticsearch, Redis |
| News Feed | Fan-out on read vs write, ranking | Redis, Kafka, ML ranking model |
| Hotel Booking System | Inventory, double-booking prevention | Optimistic locking, distributed lock |
| Stock Exchange | Order matching, latency, fairness | In-memory order book, Kafka, CQRS |
| Task Scheduler | Distributed scheduling, exactly-once | Zookeeper, Kafka, partition assignment |
| Proximity Service / Yelp | Geo-search, radius query efficiency | Geohash, Quadtree, PostGIS |

---

## 3. Monetisation — Free & Pro

### Design philosophy

The guiding principle for this app is: **pricing must never be a barrier to learning**.
All 120+ cards, every category, every tab — free. Pro makes you learn faster by adding
intelligence on top of the same content. The upgrade pitch is always "work smarter",
never "get access".

---

### Tier overview

```
┌──────────────────────────────────────────────────────────┐
│                   SYSDESIGN FLASH                        │
├──────────────────────────┬───────────────────────────────┤
│   FREE                   │   PRO                         │
│   Forever · No account   │   $5.99/month                 │
│                          │   $35.99/year  (save 50%)     │
│                          │   $79.99 lifetime             │
│                          │   7-day free trial            │
├──────────────────────────┼───────────────────────────────┤
│  All 120+ cards          │  Everything in Free, plus:    │
│  All 13 categories       │                               │
│  All 3 tabs per card     │  SM-2 spaced repetition       │
│  Unlimited sessions      │  Interview simulation mode    │
│  Streak counter          │  Readiness score + analytics  │
│  Category filters        │  Heatmap activity calendar    │
│  Unlimited bookmarks     │  Cloud sync (multi-device)    │
│  Basic progress bars     │  Custom daily reminders       │
│  Local data only         │                               │
└──────────────────────────┴───────────────────────────────┘
```

---

### Feature gate matrix

| Feature | Free | Pro |
|---|:---:|:---:|
| **Content** | | |
| All 120+ concept cards | ✅ | ✅ |
| All 3 tabs (Diagram / Key Points / Interview Q&A) | ✅ | ✅ |
| All 13 categories | ✅ | ✅ |
| **Study Modes** | | |
| Swipe study — unlimited sessions | ✅ | ✅ |
| Category filter study | ✅ | ✅ |
| Unlimited bookmarks | ✅ | ✅ |
| Card difficulty filter | ✅ | ✅ |
| Interview simulation mode (timed, scenario-based) | ❌ | ✅ |
| Answer quality rating (0–5) | ❌ | ✅ |
| Session summary with score | ❌ | ✅ |
| **Smart Learning Engine** | | |
| Manual "Got it / Review Again" | ✅ | ✅ |
| Simple mastered tracking | ✅ | ✅ |
| SM-2 spaced repetition scheduling | ❌ | ✅ |
| "Due today" smart queue | ❌ | ✅ |
| Weak area detection | ❌ | ✅ |
| Interview readiness score (predicted %) | ❌ | ✅ |
| Custom daily study goal | ❌ | ✅ |
| **Analytics & Progress** | | |
| Basic mastered count per category | ✅ | ✅ |
| Per-category progress bar | ✅ | ✅ |
| Streak counter 🔥 | ✅ | ✅ |
| Heatmap activity calendar | ❌ | ✅ |
| Mastery confidence chart | ❌ | ✅ |
| Review history per concept | ❌ | ✅ |
| **Platform** | | |
| Offline mode | ✅ | ✅ |
| Local data persistence | ✅ | ✅ |
| No account required | ✅ | — |
| Cloud sync across devices | ❌ | ✅ |
| Progress backup | ❌ | ✅ |
| Custom daily reminder (time + days) | ❌ | ✅ |
| 7-day free trial | — | ✅ |
| Lifetime purchase option ($79.99) | — | ✅ |

---

### What is never gated

These will never be locked behind Pro, regardless of future pressure to monetise more aggressively:

- Any card content, diagram, or interview question
- The swipe study loop
- Streak tracking (taking it away is cruel)
- Category filters and bookmarks
- Offline access to all studied content

---

### Pricing psychology

**$5.99/month** sits below the "reflexive pause" threshold for engineers earning $50–200/hr.
The mental maths is "that's basically free" — it removes the last friction point for someone
already convinced.

**$35.99/year** is anchored as "only $3/month" and shown with the saving in dollars ("save
$35.89"), because dollar amounts feel more real than percentages.

**$79.99 lifetime** serves as an anchor that makes the annual plan look cheap. It also rewards
power users and creates a one-time revenue spike at launch.

**7-day free trial** removes all purchase risk. Users experience Pro's SM-2 scheduling and
interview simulation before paying a cent. This is the primary conversion lever.

---

### Free tier UX — screen by screen

The free experience is deliberately uncluttered. No interstitials, no mid-session popups,
no aggressive upsell banners. Trust is built by respecting the user's time.

#### Home Screen (Free)
```
┌─────────────────────────────────┐
│ 🏗️ SysDesign Flash    [👤 Ana]  │
├─────────────────────────────────┤
│ Hey, Ana 👋                     │
│ Keep going — you're doing great!│
│ ████████░░░░  52 / 120 mastered │
├─────────────────────────────────┤
│ 🔥 5-day streak  📚 52 mastered │
├─────────────────────────────────┤
│ [All] [Scalability] [Databases] │
│ [Caching] [Messaging] ...       │
├─────────────────────────────────┤
│ ┌──────────┐ ┌──────────┐      │
│ │ ⚡ Horiz. │ │ 💾 Cache │ ✅   │
│ │ Scaling  │ │ Strategy │      │
│ └──────────┘ └──────────┘      │
│ ┌──────────┐ ┌──────────┐      │
│ │ 🔄 CAP   │ │ 📨 Kafka │      │
│ │ Theorem  │ │ Internals│      │
│ └──────────┘ └──────────┘      │
├─────────────────────────────────┤
│ ✨ Study smarter with Pro       │  ← soft banner, dismissible, once/day
│    Smart scheduling + interview │
│    simulation  [Try free 7 days]│
└─────────────────────────────────┘
```

Key design decisions:
- All cards visible and tappable. Nothing locked or blurred in the grid.
- The upsell banner is one line, dismissible, appears at most once per day, never mid-session.
- No interstitial ads. Free users study in complete peace.

#### Card Screen (Free)
```
┌─────────────────────────────────┐
│ ← Back          3 / 120   🔖   │
│ ████████████░░░░░░░░░░░░░ 3/120│
├─────────────────────────────────┤
│ ⚡  SCALABILITY                 │
│ Horizontal vs Vertical Scaling  │
│ "Scale out, not just up"        │
│                                 │
│  VERTICAL (Scale Up)            │
│  ┌───────────┐                  │
│  │  Server   │ ← bigger CPU     │
│  └───────────┘                  │
│                                 │
│  HORIZONTAL (Scale Out)         │
│  ┌────┐ ┌────┐ ┌────┐          │
│  │ S1 │ │ S2 │ │ S3 │          │
│  └────┘ └────┘ └────┘          │
│       Load Balancer             │
├─────────────────────────────────┤
│ [Diagram] [Key Points] [🎤 Q&A] │  ← all three tabs free, always
├─────────────────────────────────┤
│ [✗ Review Again]  [✓ Got It!]   │
└─────────────────────────────────┘
```

#### Progress Screen (Free)
```
┌─────────────────────────────────┐
│ Progress                        │
├─────────────────────────────────┤
│ Overall: 52 / 120  ████░░░  43% │
│                                 │
│ 📚 120  ✅ 52  ⏳ 68            │
├─────────────────────────────────┤
│ Scalability       8/10  ████░   │
│ Databases         5/10  ███░░   │
│ Caching           4/8   ███░░   │
│ Messaging         3/10  ██░░░   │
│ ...                             │
├─────────────────────────────────┤
│ ┌─────────────────────────────┐ │
│ │ Study smarter with Pro      │ │  ← one non-intrusive nudge at bottom
│ │ SM-2 scheduling · analytics │ │
│ │ Interview simulation mode   │ │
│ │ [Start 7-day free trial →]  │ │
│ └─────────────────────────────┘ │
└─────────────────────────────────┘
```

---

### Pro tier — feature designs

#### SM-2 Spaced Repetition Engine

Every card reviewed by a Pro user gets a `ReviewSchedule` entry that auto-calculates
the next optimal review date:

```
Got it easily      → show again in 6 days
Got it with effort → show again in 3 days
Struggled          → show again tomorrow
Failed             → show again in this session
```

The Home Screen transforms for Pro users to show a personalised daily queue:

```
┌─────────────────────────────────┐
│ Today's Queue                   │
│ ┌─────────────────────────────┐ │
│ │ 📅 Due today        8 cards │ │
│ │ 🆕 New this session 3 cards │ │
│ │ 💪 Weak cards       4 cards │ │
│ │                             │ │
│ │ [Start Smart Session →]     │ │
│ └─────────────────────────────┘ │
│ 🔮 Interview Readiness: 67%     │
│ Keep going — 3 more sessions    │
│ to reach 80% readiness          │
└─────────────────────────────────┘
```

#### Interview Simulation Mode

A timed, pressure-simulated session mirroring a real FAANG system design interview.

Setup screen:
```
┌─────────────────────────────────┐
│ ← Interview Simulation          │
├─────────────────────────────────┤
│ Pick your scenario              │
│ [Design Twitter Feed]           │
│ [Design a URL Shortener]        │
│ [Design a Notification System]  │
│ [Design Uber]  [Random]         │
├─────────────────────────────────┤
│ Duration  [30 min][45 min][60 min]│
│ Level     [Mid]  [Senior][Staff] │
├─────────────────────────────────┤
│ [Start Interview →]             │
└─────────────────────────────────┘
```

Post-session review:
```
┌─────────────────────────────────┐
│ Session Complete ✓              │
│ Design Twitter Feed — 45 min    │
├─────────────────────────────────┤
│ Key concepts for this problem:  │
│ ✅ Fan-out on write             │
│ ✅ Redis sorted sets            │
│ ✅ Kafka for event streaming    │
│ ⚠️  Consistent hashing          │  ← you should have mentioned this
│ ❌ Read replicas                │
├─────────────────────────────────┤
│ [Review missed concepts →]      │
│ [Share result]                  │
└─────────────────────────────────┘
```

#### Advanced Analytics (Pro)

```
┌─────────────────────────────────┐
│ Analytics                    Pro│
├─────────────────────────────────┤
│ 🔮 Interview Readiness: 67%     │
│ Estimated: 2–3 weeks to 80%     │
├─────────────────────────────────┤
│ Activity — Last 30 days         │
│  M  T  W  T  F  S  S           │
│  ▓  ▓  ░  ▓  ▓  ▓  ░           │
│  ▓  ░  ▓  ▓  ░  ▓  ░           │
│  ▓  ▓  ▓  ▓  ▓  ░  ░           │
├─────────────────────────────────┤
│ Mastery confidence              │
│ Scalability    ████████░░  80%  │
│ Databases      ██████░░░░  62%  │
│ Consistency    ███░░░░░░░  34% ⚠│
│ Messaging      █████████░  90%  │
├─────────────────────────────────┤
│ ⚠️  Focus areas                 │
│ CAP Theorem — reviewed 4×,      │
│ still marking "review again"    │
│ [Study CAP Theorem now →]       │
└─────────────────────────────────┘
```

---

### Paywall screen designs

#### Contextual paywall — triggered by tapping a Pro feature

```
┌─────────────────────────────────┐
│ ×                               │
│                                 │
│ 🚀 Interview Simulation         │
│                                 │
│ Practice under real pressure.   │
│ Timed sessions, scenario-based  │
│ questions, concept gap analysis.│
│                                 │
│ [Start 7-day Free Trial →]      │
│                                 │
│ $5.99/month after trial         │
│ Cancel anytime · No commitment  │
│                                 │
│ [See all Pro features]          │
│ [Not now]                       │
└─────────────────────────────────┘
```

#### Full upgrade screen

```
┌─────────────────────────────────┐
│ ← SysDesign Flash Pro           │
├─────────────────────────────────┤
│ Study smarter, not just more.   │
│                                 │
│ ✦ SM-2 spaced repetition        │
│   Right card, right time        │
│                                 │
│ ✦ Interview simulation          │
│   Timed, scenario-based Q&A     │
│                                 │
│ ✦ Readiness score & analytics   │
│   Know when you're truly ready  │
│                                 │
│ ✦ Cloud sync                    │
│   Never lose your progress      │
├─────────────────────────────────┤
│ ● Annual    $35.99/yr   ← BEST  │  ← pre-selected
│             only $3/month       │
│ ○ Monthly   $5.99/month         │
│ ○ Lifetime  $79.99 one-time     │
├─────────────────────────────────┤
│ [Start 7-day Free Trial →]      │
│                                 │
│ ⭐⭐⭐⭐⭐ "Best system design    │
│ prep resource I've found"       │
│ — Senior Engineer, Google       │
│                                 │
│ Cancel anytime · Restore · Privacy│
└─────────────────────────────────┘
```

#### Session-end nudge (after 5 sessions, as BottomSheet)
```
┌─────────────────────────────────┐
│ ▬                               │
│ 🎉 Great session! 12 reviewed   │
│                                 │
│ You've studied 5 times —        │
│ you're building a real habit.   │
│                                 │
│ Pro users master concepts 3×    │
│ faster with smart scheduling.   │
│                                 │
│ [Try Pro free for 7 days]       │
│ [Continue without Pro]          │
└─────────────────────────────────┘
```

---

### Upgrade flow — end to end

```
User taps Pro feature or upgrade banner
            │
            ▼
  Contextual or full paywall shown
            │
            ▼
  User selects plan (annual pre-selected)
            │
            ▼
  7-day free trial begins
  → Google Play Billing confirmation
  → No charge for 7 days
            │
            ▼
  Pro features instantly unlocked
  → "Welcome to Pro" BottomSheet
  → Confetti animation
  → Prompt to sign in for cloud sync
            │
            ▼
  Day 6: push notification
  "Your trial ends tomorrow —
   don't lose your 6-day streak
   or smart schedule."
            │
            ▼
  Day 7: auto-renews or cancels
            │
  On downgrade:
  → All content still accessible (free)
  → SM-2 schedules preserved (resume on re-subscribe)
  → Cloud data kept 30 days
  → "Your data is safe. Come back anytime."
```

---

### Revenue model

#### Assumptions (conservative)

| Metric | Value |
|---|---|
| Monthly app installs | 2,000 (organic, post-launch) |
| Free → Pro conversion | 4% (B2C edtech avg: 3–6%) |
| Annual / Monthly split | 65% annual, 35% monthly |
| Monthly churn (Pro) | 5% |

#### Month 6 estimate

```
Cumulative installs:     12,000
Pro users (4%):             480

Monthly Pro (35%):   168 × $5.99  =  $1,006/month
Annual Pro (65%):    312 × $35.99 / 12 =  $936/month
Lifetime (launch):     ~20 × $79.99  =  $1,600 (one-time)

Total MRR (Month 6):             ≈  $1,942/month
```

#### Month 12 estimate

```
Cumulative installs:     40,000
Pro users:                1,600

Monthly Pro (35%):   560 × $5.99  =  $3,354/month
Annual Pro (65%):  1,040 × $2.99  =  $3,110/month (monthly equiv.)
Lifetime ongoing:    ~10/mo × $79.99 = $800/month

Total MRR (Month 12):            ≈  $7,264/month
Annual Revenue Run Rate:         ≈  $87,168/year
```

#### A/B tests to run (once ≥500 MAU)

| Test | Variant A | Variant B | Metric |
|---|---|---|---|
| Paywall default | Monthly pre-selected | Annual pre-selected | Revenue per paywall view |
| Trial length | 7-day | 14-day | Trial-to-paid conversion |
| Paywall CTA | "Start Free Trial" | "Try Pro Free" | Click-through rate |
| Streak nudge trigger | 3-day streak | 7-day streak | Conversion rate |
| Session-end nudge timing | After 3 sessions | After 5 sessions | Conversion rate |
| Annual price point | $35.99/yr | $39.99/yr | Revenue per convert |

---

## 4. App Architecture

### State management — Riverpod (code-gen)

```
Providers:
  conceptsProvider          → List<Concept>  (static data)
  masteredProvider          → Set<int>  (persisted in Hive)
  deckFilterProvider        → String  (selected category)
  studySessionProvider      → StudySession  (current session state)
  spacedRepetitionProvider  → Map<int, ReviewSchedule>  (Pro only)
  userProfileProvider       → UserProfile  (name, streak, joined date)
  settingsProvider          → AppSettings  (theme, daily goal)
  subscriptionProvider      → SubscriptionTier  (free | pro)
```

### Navigation — go_router

```
/                    → SplashScreen
/onboarding          → OnboardingScreen (3 pages)
/auth                → AuthScreen (Google Sign-In · Email/Password)
/home                → HomeScreen (concept grid)
/home/progress       → ProgressScreen
/home/settings       → SettingsScreen
/study/:deckId       → CardScreen (swipeable session)
/paywall             → PaywallScreen
/paywall/success     → UpgradeSuccessScreen
```

### Subscription state

```dart
enum SubscriptionTier { free, pro }

@riverpod
class SubscriptionState extends _$SubscriptionState {
  @override
  SubscriptionTier build() => SubscriptionTier.free;

  bool get isPro => state == SubscriptionTier.pro;

  Future<void> refresh() async {
    final tier = await SubscriptionRepository.getCurrentTier();
    state = tier;
  }
}
```

### Data layer

```
local/
  hive_store.dart           → Hive boxes: mastered, schedules, profile, settings
  concepts_repository.dart  → loads static data

domain/
  concept.dart              → id, category, color, icon, title, tagline,
                              diagram, bullets, mnemonic, interviewQ, interviewA,
                              difficulty, tags
  review_schedule.dart      → SM-2 fields: easiness, interval, repetitions,
                              nextReview, lastQuality
  study_session.dart        → cardOrder, currentIndex, gotItCount, startedAt
  user_profile.dart         → name, photoUrl, phone, locale, streak, joinDate, dailyGoal
```

---

## 5. Phase 1 — Foundation (Weeks 1–2)

**Goal:** Working skeleton on device. Navigation works. First 25 cards load.

### Tasks

#### 1.1 Project setup
```bash
flutter create sysdesign_flash --org com.yourname
cd sysdesign_flash
flutter pub add flutter_riverpod riverpod_annotation
flutter pub add go_router
flutter pub add animations
flutter pub add hive hive_flutter
flutter pub add shared_preferences
flutter pub add in_app_purchase
flutter pub add google_sign_in          # Google OAuth + contact details
flutter pub add supabase_flutter        # Supabase Auth + DB client
flutter pub add http                    # Google People API call
flutter pub add dev:build_runner dev:riverpod_generator dev:hive_generator
```

#### 1.2 Folder structure
Create the full structure (see Section 13) before writing any feature code.
Naming conventions established upfront avoids painful refactors later.

#### 1.3 App theme — Material 3
Implement `AppTheme` with `useMaterial3: true` and `ColorScheme.fromSeed()`.
Dark and light variants. All colour constants in `app_colors.dart` so the
entire UI can be reskinned from one file.

Key M3 components to configure upfront:
- `NavigationBarTheme` — bottom nav indicator colour
- `CardTheme` — `surfaceContainerHigh`, no elevation
- `FilledButtonTheme` — radius, padding, text style
- `SegmentedButtonTheme` — for tab switcher on card screen
- `SnackBarTheme` — floating, rounded

#### 1.4 Data models
Define `Concept`, `ReviewSchedule`, `StudySession`, `UserProfile` as
immutable classes with `copyWith`. No mutable state in models.

#### 1.5 Knowledge bank — Phase 1 (25 cards)
Encode Sections 2.1 (Scalability) and 2.2 (Distributed Systems) into
`lib/data/concepts/`. Each concept needs all fields:

```dart
Concept(
  id: 1,
  category: 'Scalability',
  color: Color(0xFFFF6B35),
  icon: '⚡',
  title: 'Horizontal vs Vertical Scaling',
  tagline: 'Scale out, not just up',
  diagram: '...',      // ASCII art
  bullets: [...],      // 3–5 key points
  mnemonic: '...',
  interviewQ: '...',
  interviewA: '...',
  difficulty: Difficulty.beginner,
  tags: ['scaling', 'infrastructure'],
)
```

#### 1.6 Navigation shell
Wire up go_router with all routes. Implement the `NavigationBar` shell with
Concepts and Progress tabs. Settings accessible via AppBar action.

#### 1.7 Splash + onboarding
- Name entry with `shared_preferences` persistence
- Auto-skip splash if name already stored
- Hero animation: logo and title fly from splash into home AppBar

**Deliverable:** App launches, shows concept grid, tapping a card opens
CardScreen, back returns to home. No state persistence yet.

---

## 6. Phase 2 — Core Features (Weeks 3–4)

**Goal:** Full swipe study loop. All 120+ cards encoded. Progress saved locally.

### Tasks

#### 2.1 Complete knowledge bank — all 120+ cards
Encode all concepts from Section 2 across 13 category files.

Difficulty distribution:
- 🟢 Beginner (30 cards) — scaling, caching, SQL vs NoSQL, basic patterns
- 🟡 Intermediate (55 cards) — CAP, messaging, API design, reliability
- 🔴 Advanced (35 cards) — consensus, distributed transactions, stream processing

#### 2.2 CardScreen — full swipe UX
- Drag gesture with card rotation (`Matrix4.rotateZ`)
- GOT IT / REVIEW stamp overlays (opacity driven by drag fraction)
- Card stack effect (2 ghost cards behind, slightly offset + rotated)
- Haptic feedback (`HapticFeedback.mediumImpact` on swipe commit,
  `selectionClick` on tab switch)
- Card enter animation (scale + fade, `easeOutBack` spring curve)
- SegmentedButton tab switcher: Diagram / Key Points / Interview
- AnimatedSwitcher for smooth tab content transitions
- Interview answer reveal with `SizeTransition`
- Swipe velocity detection for fling gesture
- Long press → `ModalBottomSheet` with full concept detail

#### 2.3 Local persistence — Hive boxes
```dart
// Open at app start in main()
await Hive.openBox<bool>('mastered');         // conceptId → bool
await Hive.openBox<int>('review_counts');      // conceptId → n
await Hive.openBox<String>('profile');         // name, joinDate, streak
await Hive.openBox<String>('settings');        // theme, dailyGoal
```

Mastered set persists across restarts. Mastered badge appears on grid cards.

#### 2.4 HomeScreen
- Horizontal `FilterChip` row for category selection
- `SliverAppBar` collapses on scroll, search `IconButton` in actions
- `AnimatedSwitcher` when filter changes (grid rebuilds smoothly)
- Welcome banner with animated progress (`TweenAnimationBuilder`)
- Mastered count badge overlaid on category chips

#### 2.5 Progress tab — baseline (free)
- Animated `LinearProgressIndicator` per category
- Overall mastery count and percentage
- Simple stats: total, mastered, remaining
- Pro analytics teaser card at bottom (non-intrusive)

**Deliverable:** Full swipe study loop works end-to-end. Progress survives
app kill/restart. All 120+ cards accessible.

---

## 7. Phase 3 — Learning Engine (Weeks 5–6)

**Goal:** SM-2 spaced repetition for Pro. Daily streaks for all. Interview simulation.

### Tasks

#### 3.1 Spaced Repetition — SM-2 Algorithm (Pro)

Each card tracks a `ReviewSchedule`. After every review, recalculate:

```dart
class SM2 {
  static ReviewSchedule calculate(ReviewSchedule s, int quality) {
    // quality: 0 (failed) → 5 (perfect)
    double ease = s.easiness + (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02));
    if (ease < 1.3) ease = 1.3;

    int reps = quality < 3 ? 0 : s.repetitions + 1;
    int interval = switch (reps) {
      0 => 1,
      1 => 1,
      2 => 6,
      _ => (s.interval * ease).round(),
    };

    return s.copyWith(
      easiness: ease,
      interval: interval,
      repetitions: reps,
      nextReview: DateTime.now().add(Duration(days: interval)),
      lastQuality: quality,
    );
  }
}
```

Quality mapping from user action:
- "Got It!" quickly → 4 — "Got It!" after hint → 3
- "Review Again" → 1 — Did not know at all → 0

#### 3.2 Study Session Engine (Pro)

A `StudySession` is a curated card list for one sitting:

```dart
class StudySessionBuilder {
  List<int> buildQueue({
    required List<ReviewSchedule> schedules,
    required Set<int> mastered,
    int maxNew = 5,
  }) {
    final due = schedules
      .where((s) => s.nextReview.isBefore(DateTime.now()))
      .map((s) => s.conceptId)
      .toList();

    final weak = schedules
      .where((s) => s.lastQuality < 3)
      .map((s) => s.conceptId)
      .toList();

    final newCards = concepts
      .where((c) => !mastered.contains(c.id))
      .take(maxNew)
      .map((c) => c.id)
      .toList();

    return [...due, ...weak, ...newCards]
      .toSet().toList()..shuffle();
  }
}
```

#### 3.3 Daily Streak (all users)

Track `lastStudyDate` in Hive. On app open:
- Studied yesterday → increment streak
- Studied today → preserve streak
- Missed a day → reset to 0

Streak displayed as 🔥 counter in AppBar. On increment, animate with
`TweenAnimationBuilder` scale pulse. On 7-day and 30-day milestones, show
a celebration `BottomSheet`.

#### 3.4 Interview Simulation Mode (Pro)

Timed, scenario-based sessions. Core logic:

```dart
class SimulationSession {
  final String scenario;         // e.g. "Design Twitter Feed"
  final Duration duration;       // 30, 45, or 60 minutes
  final Difficulty level;        // mid | senior | staff
  final List<int> hintCardIds;   // relevant concept cards for hints
  final List<int> requiredConcepts; // concepts expected in a good answer
}
```

Post-session scoring: cross-reference concepts the user viewed as hints
against the required list. Flag missing concepts as "Review these →".

#### 3.5 Weak Area Detection (Pro)

```dart
double weaknessScore(String category) {
  final cards = concepts.where((c) => c.category == category);
  final schedules = cards
    .map((c) => sm2Store.getSchedule(c.id))
    .whereNotNull();
  if (schedules.isEmpty) return 0;
  return schedules
    .map((s) => s.lastQuality < 3 ? 1.0 : 0.0)
    .reduce((a, b) => a + b) / schedules.length;
}
```

Surface top 2 weakest categories on the home screen as "Focus Areas"
with a `FilledButton.tonal` shortcut to start that deck immediately.

#### 3.6 Interview Readiness Score (Pro)

A composite score from 0–100%:

```dart
double readinessScore() {
  final masteredWeight = mastered.length / concepts.length * 0.4;
  final qualityWeight = avgSM2Quality() / 5.0 * 0.4;
  final coverageWeight = categoriesCovered() / totalCategories * 0.2;
  return (masteredWeight + qualityWeight + coverageWeight) * 100;
}
```

Displayed as "🔮 Interview Readiness: 67%" with a projected timeline
("keep going — ~2 more weeks to 80%") based on scheduled review dates.

**Deliverable:** Pro users see a personalised daily queue, interview simulation works,
readiness score updates in real-time. Free users see streak and basic progress.

---

## 8. Phase 4 — Polish & UX (Weeks 7–8)

**Goal:** App feels premium. 60fps. Accessibility complete. Onboarding polished.

### Tasks

#### 4.1 Onboarding flow (3 screens)

Use `PageView` with `SmoothPageIndicator` dots.

Page 1 — Welcome: logo hero, name input, "Start Learning" CTA
Page 2 — How it works: animated card demo, swipe direction guide
Page 3 — Set your goal: daily card goal picker (5 / 10 / 20 / custom)

#### 4.2 Hero animations

| Source | Destination | Tag |
|---|---|---|
| Splash logo | Home AppBar logo | `app_logo` |
| Splash title | Home AppBar title | `app_title` |
| Concept grid card | CardScreen header | `concept_header_{id}` |

#### 4.3 Shared axis transitions

- Home → CardScreen: `SharedAxisTransitionType.horizontal`
- Home → Progress: `SharedAxisTransitionType.vertical`
- Any modal → parent: `FadeThrough`

#### 4.4 Card stack effect

Two ghost cards rendered behind the active card:
```dart
Stack(children: [
  // Ghost 2 — furthest back
  Transform(transform: Matrix4.identity()
    ..translate(0.0, 12.0)..rotateZ(0.04),
    child: _GhostCard(opacity: 0.3)),
  // Ghost 1
  Transform(transform: Matrix4.identity()
    ..translate(0.0, 6.0)..rotateZ(0.02),
    child: _GhostCard(opacity: 0.5)),
  // Active card with drag transform
  _ActiveCard(),
])
```

#### 4.5 Empty states

Design for: no cards due today (celebration), all cards mastered (achievement),
category filter with 0 results. Use `Lottie` animations, keep files < 80KB.

#### 4.6 Accessibility
- Minimum touch target 48×48dp on all interactive elements
- `Semantics` labels on all icons and custom widgets
- Support system font scale up to 200%
- Respect `MediaQuery.disableAnimations` for reduced-motion users
- Colour contrast ratio ≥ 4.5:1 for all text

#### 4.7 Performance targets
- 60fps swipe on mid-range Android (Pixel 4a equivalent)
- `const` constructors everywhere possible
- `RepaintBoundary` isolating drag area
- `AutomaticKeepAliveClientMixin` on tabs to prevent rebuild
- Profile with Flutter DevTools — target < 8ms frame build time

#### 4.8 Settings screen
- Dark / Light / System theme toggle
- Daily study goal (Pro: custom — Free: informational)
- Notification settings (Pro only)
- Restore Pro purchase
- Reset progress (with `AlertDialog` confirmation)
- App version + feedback mailto link

**Deliverable:** App feels indistinguishable from a polished commercial product.
Animations smooth. No jank. Accessibility audit passed.

---

## 9. Phase 5 — Backend & Auth (Weeks 9–10)

**Goal:** Cloud sync and Pro subscription billing. App works fully offline without it.

### Architecture

```
Flutter App
    ↓ HTTPS
Supabase
  ├── Auth  (email + Google OAuth)
  ├── PostgreSQL  (user_progress, user_profiles, subscriptions)
  └── Edge Functions  (billing verification)
```

### Database schema

```sql
-- user_profiles
CREATE TABLE user_profiles (
  user_id        uuid PRIMARY KEY REFERENCES auth.users,
  display_name   text,
  photo_url      text,            -- Google avatar URL (may be null)
  phone          text,            -- from Google People API (often null)
  locale         text,            -- e.g. "en-US" from Google ID token
  streak         integer DEFAULT 0,
  last_study_date date,
  daily_goal     integer DEFAULT 10,
  created_at     timestamp DEFAULT now()
);

-- user_progress
CREATE TABLE user_progress (
  id             uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id        uuid REFERENCES auth.users NOT NULL,
  concept_id     integer NOT NULL,
  mastered       boolean DEFAULT false,
  easiness       float DEFAULT 2.5,
  interval       integer DEFAULT 1,
  repetitions    integer DEFAULT 0,
  next_review    timestamp,
  last_reviewed  timestamp,
  last_quality   integer DEFAULT 0,
  UNIQUE(user_id, concept_id)
);

-- subscriptions
CREATE TABLE subscriptions (
  user_id        uuid PRIMARY KEY REFERENCES auth.users,
  tier           text DEFAULT 'free',    -- 'free' | 'pro'
  plan           text,                   -- 'monthly' | 'annual' | 'lifetime'
  expires_at     timestamp,
  purchase_token text,
  verified_at    timestamp
);
```

### Google Play Billing

```bash
flutter pub add in_app_purchase
```

Product IDs to register in Play Console:
- `pro_monthly` — subscription $5.99/month
- `pro_annual` — subscription $35.99/year
- `pro_lifetime` — one-time $79.99

Server-side verification via Supabase Edge Function → Google Play Developer API.
Never trust client-side purchase confirmation alone.

```dart
class BillingService {
  static const products = {
    'pro_monthly', 'pro_annual', 'pro_lifetime'
  };

  void listenToPurchaseUpdates() {
    InAppPurchase.instance.purchaseStream.listen((purchases) async {
      for (final p in purchases) {
        if (p.status == PurchaseStatus.purchased) {
          final ok = await SubscriptionRepository.verifyWithServer(p);
          if (ok) {
            ref.read(subscriptionProvider.notifier).refresh();
            await InAppPurchase.instance.completePurchase(p);
          }
        }
      }
    });
  }
}
```

### Sync strategy

```
On app open (with internet):
  1. Pull server progress → merge with local (server wins on conflict)
  2. Push any local changes made while offline
  3. Verify subscription status

On review action:
  1. Write to Hive immediately (optimistic)
  2. Queue background sync to Supabase
  3. On failure → retry with exponential backoff (1s, 2s, 4s, max 30s)
```

### Auth flow

```
Sign-in options: Google OAuth · Email + password
Anonymous → signed-in migration:
  → On first sign-in, merge local Hive progress into Supabase
  → Local copy remains as offline cache
  → No progress is ever lost
Offline-first:
  → App functions 100% without internet
  → Sync is additive, never destructive
```

### Google Sign-In — Contact Details Capture

Google Sign-In via the `google_sign_in` package captures richer contact data than
email/password auth. Fields obtained and their reliability:

| Field | Source | Reliability |
|---|---|---|
| Email | Standard OAuth (ID token) | Always present |
| Full name | Standard OAuth (ID token) | Always present |
| Profile photo URL | Standard OAuth (ID token) | Almost always present |
| Locale | Supabase `userMetadata` / `Platform.localeName` fallback | Usually present |
| Phone number | Google People API (extra OAuth scope) | Often empty — optional field |

**OAuth scopes requested:**
- Standard (no extra prompt): `openid`, `profile`, `email`
- Extra (shows additional permission prompt): `https://www.googleapis.com/auth/user.phonenumbers.read`

**Sign-in flow (`lib/services/auth_service.dart`):**

```dart
final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'openid',
    'profile',
    'email',
    'https://www.googleapis.com/auth/user.phonenumbers.read',
  ],
);

Future<void> signInWithGoogle() async {
  // 1. Trigger Google sign-in
  final googleUser = await _googleSignIn.signIn();
  if (googleUser == null) return; // user cancelled

  final googleAuth = await googleUser.authentication;

  // 2. Sign in to Supabase with Google token
  await supabase.auth.signInWithIdToken(
    provider: OAuthProvider.google,
    idToken: googleAuth.idToken!,
    accessToken: googleAuth.accessToken,
  );

  // 3. Fetch phone number from Google People API (optional — never blocks sign-in)
  String? phone;
  try {
    final response = await http.get(
      Uri.parse(
        'https://people.googleapis.com/v1/people/me?personFields=phoneNumbers',
      ),
      headers: {'Authorization': 'Bearer ${googleAuth.accessToken}'},
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      phone = data['phoneNumbers']?[0]?['value'];
    }
  } catch (_) {
    // phone is optional — silently ignore failures
  }

  // 4. Upsert all captured fields into user_profiles
  final user = supabase.auth.currentUser!;
  final meta = user.userMetadata ?? {};

  await supabase.from('user_profiles').upsert({
    'user_id':      user.id,
    'display_name': meta['full_name'] ?? googleUser.displayName,
    'photo_url':    meta['avatar_url'] ?? googleUser.photoUrl,
    'locale':       meta['locale'] ?? Platform.localeName,
    'phone':        phone, // null if not provided — never blocks sign-in
  });
}
```

**Key constraints:**
- `phone` is always optional. Store `null` if absent; never gate sign-in on it.
- Display a brief "What we store" note on the sign-in screen (GDPR requirement).
- Include photo and phone in the existing Settings → data-export flow.

**Supabase migration SQL** (run once against existing `user_profiles` table):
```sql
ALTER TABLE user_profiles
  ADD COLUMN photo_url text,
  ADD COLUMN phone     text,
  ADD COLUMN locale    text;
```

### Privacy & data

- PII stored: email, display name, profile photo URL, locale, and optionally phone number
- Users are informed of stored fields on the sign-in screen (GDPR transparency)
- Progress data is user-owned: export via Settings, delete within 30 days
- Photo, phone, and locale are included in the data-export and deletion flows
- GDPR compliant: data deletion cascades on account deletion
- Pro data kept 30 days after subscription lapses (offer to re-subscribe)

**Deliverable:** Users sign in with Google, progress syncs across devices,
billing works end-to-end with server verification.

---

## 10. Phase 6 — Launch & GTM (Weeks 11–12)

**Goal:** Play Store live. First 1,000 downloads.

### Play Store preparation

```bash
# Generate release keystore (do this once, store securely)
keytool -genkey -v -keystore release-key.jks \
  -alias sysdesign -keyalg RSA -keysize 2048 -validity 10000

# Build release App Bundle
flutter build appbundle --release
```

Play Store listing:
- **App name:** SysDesign Flash
- **Short description (80 chars):** Master system design with visual flashcards. Built for engineers.
- **Category:** Education
- **Screenshots:** 4 phone shots — splash, home grid, card diagram, interview Q&A
- **Feature graphic:** 1024×500 banner
- **Privacy policy:** public URL required before submission

### Pre-launch checklist

- [ ] `flutter analyze` — zero errors, zero warnings
- [ ] All flavours (debug / release) build cleanly
- [ ] Test on minimum SDK: Android 6.0 (API 23)
- [ ] Test on low-end device (2GB RAM, e.g. old Moto G)
- [ ] 30-minute smoke test — no crashes
- [ ] App Bundle size < 20MB
- [ ] Deep links configured and tested
- [ ] ProGuard / R8 rules verified (Hive + in_app_purchase)
- [ ] Privacy policy live at public URL
- [ ] Play Console content rating completed
- [ ] Billing products approved in Play Console (can take 24–48h)

### App icon & splash

```bash
flutter pub add dev:flutter_launcher_icons
flutter pub add flutter_native_splash
```

Icon: 🏗️ motif on deep dark background, orange gradient accent. Designed at 1024×1024.
Splash: match icon background colour for seamless launch experience.

### GTM — week 1 channels

**Organic content:**
- Reddit: r/cscareerquestions, r/ExperiencedDevs, r/leetcode, r/androiddev
- LinkedIn post: "I built a free system design flashcard app"
- Twitter/X thread: "12 system design concepts in 12 tweets" (one tweet per card diagram)
- Dev.to / Hashnode article: building process + lessons learned
- Product Hunt: launch Tuesday 12:01 AM PT for best visibility

**Community:**
- Blind and Levels.fyi communities
- ByteByteGo Discord / newsletter
- FAANG interview prep Telegram groups
- Flutter community Discord + r/FlutterDev

**Content loop:**
- YouTube Shorts: 60-second "system design concept explained visually" series
- Each short = one card diagram animated, app download in bio

**Referral:**
After mastering a concept, share card generates:
```
"Just mastered CAP Theorem on SysDesign Flash 🏗️
Consistency · Availability · Partition Tolerance — pick 2.
[download link]"
```

---

## 11. Phase 7 — Growth (Post-Launch)

**Goal:** Sustainable organic growth. Improve Pro conversion. Build community.

### Growth loops

**Streak share:** On 7-day and 30-day streak milestones, prompt to share a
stats card: "🔥 30-day streak on SysDesign Flash! 94/120 concepts mastered."

**Session share:** After a simulation session, share the scenario + score.
Engineers love showing interview prep discipline on LinkedIn.

**Referral:** "Invite a fellow engineer → both get 2 weeks of Pro free."

### Conversion optimisation

Run A/B tests (see Section 3 for test list) once ≥500 MAU.
Key levers: trial length, paywall default plan, nudge timing.

### Future features backlog

| Feature | Value | Effort | Phase |
|---|---|---|---|
| AI answer grading (Claude API) | High | High | v2 |
| Voice mode: speak answer, get feedback | High | High | v2 |
| Whiteboard mode (draw diagrams) | Medium | High | v3 |
| iPad / tablet optimised layout | Medium | Low | v2 |
| Web app (Flutter Web) | Medium | Low | v2 |
| iOS App Store launch | High | Low | v2 |
| Offline deep-dive notes per concept | High | Medium | v2 |
| Community card contributions + voting | High | High | v3 |
| Apple Watch streak complication | Low | Medium | v3 |
| Teams / cohort feature (if demand emerges) | Medium | High | v3 |

> Teams tier is intentionally deferred. Build it only when you see organic
> team usage in analytics — not before. Premature team features add
> infrastructure complexity before product-market fit is confirmed.

---

## 12. Tech Stack Reference

| Layer | Choice | Reason |
|---|---|---|
| Framework | Flutter 3.x | Single codebase → Android + iOS |
| Language | Dart 3 | Records, sealed classes, null safety |
| State management | Riverpod (code-gen) | Testable, no BuildContext dependency |
| Navigation | go_router | Deep links, named routes, shell routes |
| Local DB | Hive | Fast, no-SQL, true offline-first |
| Cloud DB | Supabase | PostgreSQL + Auth + Realtime + free tier |
| Animations | animations package | SharedAxisTransition, FadeThrough |
| Onboarding dots | smooth_page_indicator | Clean M3-compatible dots |
| Icons | Material Symbols | Consistent with M3 guidelines |
| App icon | flutter_launcher_icons | Automates all density sizes |
| Splash | flutter_native_splash | True native splash, no white flash |
| Billing | in_app_purchase | Official Flutter billing package |
| Analytics | PostHog (self-hostable) | Privacy-respecting, generous free tier |
| Crash reporting | Sentry | Flutter-native, free tier |
| CI/CD | GitHub Actions + Fastlane | Auto build + deploy to Play Store |
| Design system | Material 3 (M3) | Native Android, dynamic colour |

---

## 13. File & Folder Structure

```
sysdesign_flash/
├── android/
├── ios/
├── lib/
│   ├── main.dart
│   ├── app.dart                            ← MaterialApp + go_router config
│   │
│   ├── core/
│   │   ├── theme/
│   │   │   ├── app_theme.dart              ← M3 ThemeData light + dark
│   │   │   └── app_colors.dart             ← colour constants
│   │   ├── routing/
│   │   │   └── app_router.dart             ← go_router routes + guards
│   │   └── utils/
│   │       ├── haptics.dart
│   │       ├── sm2_algorithm.dart          ← pure SM-2 calculation
│   │       └── extensions.dart
│   │
│   ├── data/
│   │   ├── concepts/
│   │   │   ├── concepts_scalability.dart
│   │   │   ├── concepts_distributed.dart
│   │   │   ├── concepts_databases.dart
│   │   │   ├── concepts_messaging.dart
│   │   │   ├── concepts_api.dart
│   │   │   ├── concepts_reliability.dart
│   │   │   ├── concepts_rate_limiting.dart
│   │   │   ├── concepts_microservices.dart
│   │   │   ├── concepts_security.dart
│   │   │   ├── concepts_observability.dart
│   │   │   ├── concepts_networking.dart
│   │   │   ├── concepts_data_engineering.dart
│   │   │   └── concepts_interview_systems.dart
│   │   └── all_concepts.dart               ← aggregates all lists
│   │
│   ├── domain/
│   │   ├── models/
│   │   │   ├── concept.dart
│   │   │   ├── review_schedule.dart
│   │   │   ├── study_session.dart
│   │   │   └── user_profile.dart
│   │   └── repositories/
│   │       ├── concepts_repository.dart
│   │       ├── progress_repository.dart
│   │       ├── profile_repository.dart
│   │       └── subscription_repository.dart
│   │
│   ├── providers/
│   │   ├── concepts_provider.dart
│   │   ├── mastered_provider.dart
│   │   ├── spaced_repetition_provider.dart
│   │   ├── study_session_provider.dart
│   │   ├── streak_provider.dart
│   │   ├── subscription_provider.dart
│   │   └── settings_provider.dart
│   │
│   ├── services/
│   │   ├── auth_service.dart               ← Google Sign-In + People API + Supabase upsert
│   │   ├── billing_service.dart            ← in_app_purchase wrapper
│   │   ├── sync_service.dart               ← Supabase sync logic
│   │   └── notification_service.dart       ← daily reminders (Pro)
│   │
│   ├── screens/
│   │   ├── auth/
│   │   │   └── auth_screen.dart            ← Sign-in UI: Google button + "What we store" note
│   │   ├── splash/
│   │   │   └── splash_screen.dart
│   │   ├── onboarding/
│   │   │   ├── onboarding_screen.dart
│   │   │   └── widgets/
│   │   │       ├── onboarding_page.dart
│   │   │       └── goal_picker.dart
│   │   ├── home/
│   │   │   ├── home_screen.dart
│   │   │   └── widgets/
│   │   │       ├── welcome_banner.dart
│   │   │       ├── concept_grid_card.dart
│   │   │       ├── category_filter_bar.dart
│   │   │       ├── smart_queue_banner.dart  ← Pro: today's queue
│   │   │       └── weak_areas_section.dart  ← Pro: focus areas
│   │   ├── study/
│   │   │   ├── card_screen.dart
│   │   │   └── widgets/
│   │   │       ├── swipeable_card.dart
│   │   │       ├── card_header.dart
│   │   │       ├── diagram_tab.dart
│   │   │       ├── bullets_tab.dart
│   │   │       ├── interview_tab.dart
│   │   │       ├── swipe_label_overlay.dart
│   │   │       ├── card_stack_effect.dart
│   │   │       └── session_complete_sheet.dart
│   │   ├── simulation/                      ← Pro: interview simulation
│   │   │   ├── simulation_setup_screen.dart
│   │   │   ├── simulation_session_screen.dart
│   │   │   └── simulation_results_screen.dart
│   │   ├── progress/
│   │   │   ├── progress_screen.dart
│   │   │   └── widgets/
│   │   │       ├── category_progress_card.dart
│   │   │       ├── heatmap_calendar.dart    ← Pro
│   │   │       ├── readiness_gauge.dart     ← Pro
│   │   │       └── stats_overview.dart
│   │   ├── paywall/
│   │   │   ├── paywall_screen.dart
│   │   │   ├── paywall_sheet.dart           ← contextual bottom sheet
│   │   │   └── upgrade_success_screen.dart
│   │   └── settings/
│   │       └── settings_screen.dart
│   │
│   └── shared/
│       └── widgets/
│           ├── app_scaffold.dart            ← NavigationBar shell
│           ├── pro_gate.dart               ← feature gate wrapper
│           ├── empty_state.dart
│           ├── loading_indicator.dart
│           └── concept_color_dot.dart
│
├── test/
│   ├── unit/
│   │   ├── sm2_algorithm_test.dart
│   │   ├── study_session_builder_test.dart
│   │   ├── readiness_score_test.dart
│   │   └── streak_test.dart
│   └── widget/
│       ├── card_screen_test.dart
│       ├── home_screen_test.dart
│       └── paywall_sheet_test.dart
│
├── pubspec.yaml
├── analysis_options.yaml
└── README.md
```

---

## 14. Summary Timeline

| Phase | Weeks | Key Milestone |
|---|---|---|
| 1. Foundation | 1–2 | App skeleton on device, 25 cards, navigation |
| 2. Core Features | 3–4 | Full swipe loop, all 120+ cards, local persistence |
| 3. Learning Engine | 5–6 | SM-2 (Pro), streaks, simulation mode, readiness score |
| 4. Polish & UX | 7–8 | 60fps animations, hero transitions, accessibility |
| 5. Backend & Auth | 9–10 | Cloud sync, Google sign-in, billing verified |
| 6. Launch | 11–12 | Play Store live, GTM channels, first 1,000 downloads |
| 7. Growth | 13+ | A/B tests, conversion optimisation, iOS launch |

---

*Built with Flutter · Material 3 · Riverpod · Hive · Supabase*
*Pricing must never be a barrier to learning.*
