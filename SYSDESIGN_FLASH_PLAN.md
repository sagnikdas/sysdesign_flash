# SysDesign Flash — End-to-End Flutter App Plan

> A visual, swipeable system design flashcard app for backend engineers preparing for interviews or building intuition for large-scale systems.

---

## Table of Contents

1. [Vision & Goals](#1-vision--goals)
2. [Full System Design Knowledge Bank](#2-full-system-design-knowledge-bank)
3. [App Architecture](#3-app-architecture)
4. [Phase 1 — Foundation](#4-phase-1--foundation-weeks-12)
5. [Phase 2 — Core Features](#5-phase-2--core-features-weeks-34)
6. [Phase 3 — Learning Engine](#6-phase-3--learning-engine-weeks-56)
7. [Phase 4 — Polish & UX](#7-phase-4--polish--ux-weeks-78)
8. [Phase 5 — Backend & Auth](#8-phase-5--backend--auth-weeks-910)
9. [Phase 6 — Launch & GTM](#9-phase-6--launch--gtm-weeks-1112)
10. [Phase 7 — Growth & Monetisation](#10-phase-7--growth--monetisation-post-launch)
11. [Tech Stack Reference](#11-tech-stack-reference)
12. [File & Folder Structure](#12-file--folder-structure)

---

## 1. Vision & Goals

### What it is
A mobile-first flashcard app that teaches system design through **visual ASCII diagrams**, **mnemonics**, **key bullet points**, and **real interview questions** — all in a swipeable card format optimised for quick revision sessions.

### Target users
- Backend engineers preparing for FAANG / senior-level interviews
- Mid-level engineers building system design intuition
- Computer science students learning distributed systems
- Engineering managers brushing up on architectural patterns

### Core learning principles
- **Spaced repetition** — surface weak concepts more often
- **Visual memory** — diagrams + icons for right-brain retention
- **Active recall** — interview question reveal mechanic
- **Micro-sessions** — each card takes 60–90 seconds, usable on a commute

---

## 2. Full System Design Knowledge Bank

This is the complete curriculum. Every category below maps to a deck of flashcards in the app.

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
| CQRS (Command Query Responsibility Segregation) | Read/write optimisation vs complexity | Design a bank account view |
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
| Domain-Driven Design (DDD) | Bounded contexts vs upfront cost | Define service boundaries for an e-commerce system |
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
| The Four Golden Signals (Latency, Traffic, Errors, Saturation) | Simplicity vs completeness | Define monitoring strategy for a new service |
| Centralized Log Aggregation (ELK, Loki) | Searchability vs cost | Design log pipeline for 10k req/sec |
| On-Call & Incident Management | Response speed vs engineer burnout | Design an escalation policy |
| Runbooks & Playbooks | Consistency vs maintenance overhead | Write a runbook for DB failover |
| Canary Deployments | Safety vs release speed | Roll out a risky DB migration safely |
| Feature Flags | Decoupled releases vs complexity | Design gradual feature rollout |
| Capacity Planning | Cost vs over-provisioning | Plan infrastructure for 10x growth |

---

### 2.11 Classic Interview System Designs

These are the canonical questions every backend engineer must be ready for. Each maps to a card series in the app.

| System | Core Challenges | Key Components |
|---|---|---|
| URL Shortener (bit.ly) | High read, redirect speed, analytics | Hashing, Redis cache, Cassandra |
| Pastebin | Storage, expiry, abuse prevention | Object storage, TTL, rate limiting |
| Twitter Feed | Fan-out at scale, timeline assembly | Kafka, Redis sorted sets, sharding |
| Instagram | Media upload, CDN, feed generation | S3, CDN, PostgreSQL + Cassandra |
| WhatsApp / Chat | Real-time delivery, offline support | WebSocket, Kafka, message store |
| Uber / Ride Sharing | Geo-matching, surge pricing, maps | Geohash, Redis, WebSocket, Kafka |
| Netflix | Video encoding, adaptive streaming, recommendations | CDN, Spark, Cassandra, Kafka |
| Google Search | Web crawling, indexing, ranking, query serving | Distributed crawler, inverted index, MapReduce |
| Google Drive / Dropbox | File sync, versioning, conflict resolution | Block storage, CDC, diff-sync protocol |
| Notification System | Scale, multi-channel, rate limiting | Kafka, FCM/APNs, SendGrid, Redis |
| Rate Limiter | Distributed counters, accuracy, Redis | Token bucket, Redis INCR+TTL |
| Web Crawler | Distributed crawling, politeness, dedup | BFS/DFS, bloom filter, queue |
| Search Autocomplete | Latency, ranking, prefix matching | Trie, Redis, Elasticsearch |
| Design YouTube | Upload, transcode, stream, recommendations | S3, FFmpeg, CDN, Kafka, Cassandra |
| Design a Payment System | Idempotency, ACID, fraud, reconciliation | PostgreSQL, Kafka, Saga, Vault |
| Design a Distributed Cache | Eviction, consistency, partitioning | Consistent hashing, Redis Cluster |
| Design a Key-Value Store | Durability, partitioning, replication | LSM tree, consistent hashing, Raft |
| Design a Distributed Message Queue | Ordering, durability, at-least-once | Kafka internals, ISR, consumer groups |
| Design a Typeahead / Search | Latency < 100ms, ranking, update lag | Trie, Elasticsearch, Redis |
| Design a News Feed | Fan-out on read vs write, ranking | Redis, Kafka, ML ranking model |
| Design a Hotel Booking System | Inventory, double-booking prevention | Optimistic locking, distributed lock |
| Design a Stock Exchange | Order matching, latency, fairness | In-memory order book, Kafka, CQRS |
| Design a Task Scheduler | Distributed scheduling, exactly-once | Zookeeper, Kafka, partition assignment |
| Proximity Service / Yelp | Geo-search, radius query efficiency | Geohash, Quadtree, PostGIS |

---

### 2.12 Networking & Infrastructure

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

### 2.13 Data Engineering & Processing

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

## 3. App Architecture

### State Management
Use **Riverpod** (code-gen version) for all state. Clean, testable, no BuildContext dependency.

```
Providers:
  conceptsProvider        → List<Concept> (static data)
  masteredProvider        → Set<int> (persisted)
  deckFilterProvider      → String (selected category)
  studySessionProvider    → StudySession (current card index, session stats)
  spacedRepetitionProvider → Map<int, ReviewSchedule>
  userProfileProvider     → UserProfile (name, streak, joined date)
  settingsProvider        → AppSettings (theme, daily goal)
```

### Navigation
Use **go_router** with named routes and deep linking support.

```
/                → SplashScreen
/home            → HomeScreen (concepts grid)
/home/progress   → ProgressScreen
/study/:deckId   → CardScreen (swipeable study session)
/study/:deckId/:conceptId → SingleConceptScreen
/settings        → SettingsScreen
/onboarding      → OnboardingScreen
```

### Data Layer
```
local/
  hive_store.dart         → Hive boxes: mastered, schedules, profile, settings
  concepts_repository.dart → loads static data + overlay of user annotations

domain/
  concept.dart            → data model
  review_schedule.dart    → SM-2 spaced repetition fields
  study_session.dart      → in-progress session model
  user_profile.dart       → name, streak, join date
```

---

## 4. Phase 1 — Foundation (Weeks 1–2)

**Goal:** Working skeleton. App runs on device. Navigation works. Data loads.

### Tasks

#### 1.1 Project setup
```bash
flutter create sysdesign_flash --org com.yourname
cd sysdesign_flash
flutter pub add riverpod flutter_riverpod riverpod_annotation
flutter pub add go_router
flutter pub add animations
flutter pub add hive hive_flutter
flutter pub add shared_preferences
flutter pub add flutter_launcher_icons
flutter pub add dev:build_runner dev:riverpod_generator dev:hive_generator
```

#### 1.2 Folder structure
Create the full structure (see Section 12) before writing any feature code.

#### 1.3 App theme
Implement `AppTheme` with `useMaterial3: true`, `ColorScheme.fromSeed()`, dark and light variants. Define all token colours as constants so the whole UI can be reskinned from one file.

#### 1.4 Data models
Define `Concept`, `ReviewSchedule`, `StudySession`, `UserProfile` as immutable classes with `copyWith`.

#### 1.5 Knowledge bank — Phase 1 deck
Encode the first **25 concepts** (Sections 2.1 and 2.2) into `lib/data/concepts.dart`. Each card needs:
- `id`, `category`, `color`, `icon`, `title`, `tagline`
- `diagram` (ASCII art)
- `bullets` (List of 3–5 strings)
- `mnemonic`
- `interviewQ`, `interviewA`
- `difficulty` (beginner / intermediate / advanced)
- `tags` (e.g. `['database', 'consistency']`)

#### 1.6 Navigation shell
Wire up go_router with all routes. Implement the `NavigationBar` shell with Concepts, Progress, and Settings tabs.

#### 1.7 Splash + onboarding
Implement name entry with `shared_preferences` persistence. Hero animation for logo → home AppBar.

**Deliverable:** App launches, shows concept grid, tapping a card opens CardScreen. No state persistence yet.

---

## 5. Phase 2 — Core Features (Weeks 3–4)

**Goal:** Full swipeable study experience. All 80+ concepts encoded. Progress saved locally.

### Tasks

#### 2.1 Complete knowledge bank
Encode all concepts from Section 2. Target: **80 cards minimum** across all 13 categories.

Card difficulty tagging:
- 🟢 Beginner (20 cards) — scaling, caching, SQL vs NoSQL basics
- 🟡 Intermediate (35 cards) — CAP, messaging, API design, reliability
- 🔴 Advanced (25 cards) — consensus, distributed transactions, stream processing

#### 2.2 CardScreen — full swipe UX
- Drag gesture with card rotation (`Matrix4.rotateZ`)
- GOT IT / REVIEW stamp overlays (fade in on drag)
- Haptic feedback (`HapticFeedback.mediumImpact`)
- Card enter animation (scale + fade, `easeOutBack` curve)
- SegmentedButton tab switcher: Diagram / Key Points / Interview
- AnimatedSwitcher for smooth tab content transitions
- Interview answer reveal with `SizeTransition`
- Swipe velocity detection for fling gesture

#### 2.3 Local persistence — Hive
```dart
// Boxes to open at app start
Hive.openBox<bool>('mastered')           // conceptId → bool
Hive.openBox<int>('review_counts')       // conceptId → times reviewed
Hive.openBox<String>('profile')          // user name, join date
Hive.openBox<String>('settings')         // theme, daily goal
```

Persist mastered set across app restarts. Show mastered badge on grid cards.

#### 2.4 HomeScreen — category filter + search
- Horizontal `FilterChip` row for category selection
- `SliverAppBar` with search `IconButton` that expands inline
- Animated grid that rebuilds when filter changes (use `AnimatedSwitcher`)
- Mastered count badge per category chip

#### 2.5 Progress tab — per-category breakdown
- Animated `LinearProgressIndicator` per category (draw on first render with `TweenAnimationBuilder`)
- Overall mastery percentage
- Cards remaining count
- "Start weakest deck" shortcut button

**Deliverable:** Full swipe study loop works end-to-end. Progress survives app kill. All 80 cards accessible.

---

## 6. Phase 3 — Learning Engine (Weeks 5–6)

**Goal:** Smart card surfacing via spaced repetition. Daily streaks. Study sessions.

### Tasks

#### 3.1 Spaced Repetition — SM-2 Algorithm
Implement the SuperMemo SM-2 algorithm. Each card tracks:
```dart
class ReviewSchedule {
  final int conceptId;
  final double easiness;       // starts at 2.5
  final int interval;          // days until next review
  final int repetitions;       // times reviewed successfully
  final DateTime nextReview;   // when to show again
  final int lastQuality;       // 0–5 rating from last review
}
```

Quality mapping from user action:
- Tap "Got it" after seeing diagram → quality 4
- Tap "Got it" after needing hint → quality 3
- Tap "Review Again" → quality 1 (resets interval)
- Explicitly mark as known without studying → quality 5

After each review, recalculate:
```
if quality < 3: reset repetitions = 0, interval = 1
else:
  if repetitions == 0: interval = 1
  elif repetitions == 1: interval = 6
  else: interval = round(interval * easiness)
  easiness = easiness + (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02))
  if easiness < 1.3: easiness = 1.3
  repetitions += 1
nextReview = today + interval days
```

#### 3.2 Study Session Engine
A `StudySession` is a curated list of cards for one sitting:
- **Due today** (from spaced repetition schedule) — shown first
- **New cards** (never studied) — introduced gradually, max 5/session
- **Weak cards** (low quality score) — always included if due

Session configuration:
```dart
class StudySession {
  final List<int> cardOrder;    // ordered concept IDs for this session
  final int totalCards;
  final int currentIndex;
  final int gotItCount;
  final int reviewAgainCount;
  final DateTime startedAt;
}
```

#### 3.3 Daily Streak
Track last study date in Hive. On app open:
- If studied yesterday → increment streak
- If studied today already → preserve streak
- If missed a day → reset to 0 (with grace period option in settings)

Show streak as a flame counter 🔥 in the AppBar. Animate it with a scale pulse when it increments.

#### 3.4 Daily Goal
Let users set a daily card goal (5 / 10 / 20 / custom). Show a ring progress indicator on the home banner. Notify when goal is hit with a `BottomSheet` celebration widget.

#### 3.5 Weak Areas Detection
Compute a weakness score per category:
```
weakness_score = (review_again_count / total_reviews) for all cards in category
```
Surface the top 2 weakest categories as "Focus Areas" on the home screen with a `FilledButton.tonal` shortcut to start that deck.

**Deliverable:** App surfaces the right cards at the right time. Streak and goal work. Users see personalised weak areas.

---

## 7. Phase 4 — Polish & UX (Weeks 7–8)

**Goal:** App feels premium. Animations are smooth. Accessibility is solid.

### Tasks

#### 4.1 Onboarding Flow (3 screens)
Use `PageView` with a `SmoothPageIndicator` for dot indicators. Three pages:
1. **Welcome** — logo hero, name input
2. **How it works** — diagram card animation demo, swipe direction guide
3. **Set your goal** — daily card goal picker (SegmentedButton: 5 / 10 / 20)

#### 4.2 Card Design Polish
- Add a subtle card stack effect (2 ghost cards behind the active one, slightly offset and rotated)
- Card shadow colour tinted by the concept's brand colour
- Smooth swipe-back snap animation when drag doesn't clear threshold
- Long press on card → shows `BottomSheet` with full details without swiping

#### 4.3 Hero Animations
| Source | Destination | Hero Tag |
|---|---|---|
| Splash logo | Home AppBar logo | `app_logo` |
| Splash title | Home AppBar title | `app_title` |
| Concept grid card | CardScreen header | `concept_header_{id}` |
| Category chip | CardScreen category label | `category_{name}` |

#### 4.4 Shared Axis Transitions
- Home → CardScreen: horizontal shared axis
- Home → Progress: vertical shared axis
- Any modal → parent: fade through transition

#### 4.5 Empty States
Design illustrated empty states for:
- No cards due today (celebration)
- Category filter with 0 results
- All cards mastered (achievement)

Use `Lottie` animations for these. Keep file sizes small.

#### 4.6 Accessibility
- Minimum touch target 48×48dp for all interactive elements
- `Semantics` labels on all icons and custom widgets
- Support system font scale up to 200%
- Respect `MediaQuery.disableAnimations` for reduced motion users
- Colour contrast ratio ≥ 4.5:1 for all text

#### 4.7 Performance
- `const` constructors everywhere possible
- `AutomaticKeepAliveClientMixin` on tabs to avoid rebuilds
- `RepaintBoundary` on the card to isolate drag repaints
- Profile with Flutter DevTools, target 60fps on a mid-range Android device (e.g. Pixel 4a)

#### 4.8 Settings Screen
- Dark / Light / System theme toggle
- Daily study goal
- Reset progress option (with confirmation dialog)
- App version number
- Feedback link (mailto)

**Deliverable:** App feels production-quality. Animations at 60fps. No jank on swipe.

---

## 8. Phase 5 — Backend & Auth (Weeks 9–10)

**Goal:** Optional cloud sync. User account. Progress backed up to cloud.

> Note: The app works fully offline. Backend is an optional enhancement.

### Architecture

```
Flutter App
    ↓ HTTPS
Supabase (or Firebase)
  ├── Auth (email + Google OAuth)
  ├── PostgreSQL (user_progress table)
  └── Realtime (optional — sync across devices)
```

### Tasks

#### 5.1 Supabase Setup
```bash
flutter pub add supabase_flutter
```

Create tables:
```sql
-- users (managed by Supabase Auth)

-- user_progress
CREATE TABLE user_progress (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid REFERENCES auth.users NOT NULL,
  concept_id integer NOT NULL,
  mastered boolean DEFAULT false,
  easiness float DEFAULT 2.5,
  interval integer DEFAULT 1,
  repetitions integer DEFAULT 0,
  next_review timestamp,
  last_reviewed_at timestamp,
  created_at timestamp DEFAULT now(),
  UNIQUE(user_id, concept_id)
);

-- user_profiles
CREATE TABLE user_profiles (
  user_id uuid PRIMARY KEY REFERENCES auth.users,
  display_name text,
  streak integer DEFAULT 0,
  last_study_date date,
  daily_goal integer DEFAULT 10,
  created_at timestamp DEFAULT now()
);
```

#### 5.2 Auth Flow
- Email + password sign up / sign in
- Google OAuth sign in
- Anonymous → signed-in migration (merge local progress into cloud on first sign-in)
- Graceful offline fallback (Hive as source of truth, sync when online)

#### 5.3 Sync Strategy
```
On app open with internet:
  1. Pull server progress → merge with local (server wins for last_reviewed_at)
  2. Push any local changes made while offline
  3. Subscribe to realtime changes (optional — for multi-device sync)

On review action:
  1. Write to Hive immediately (optimistic)
  2. Queue background sync to Supabase
  3. On failure → retry with exponential backoff
```

#### 5.4 Data Privacy
- No PII beyond email + display name
- Progress data is user-owned, deletable via Settings → Delete Account
- Comply with GDPR: data export endpoint, deletion within 30 days

**Deliverable:** Users can sign in and have progress synced across phone reinstalls and multiple devices.

---

## 9. Phase 6 — Launch & GTM (Weeks 11–12)

**Goal:** Ship to Play Store. First 1,000 users.

### Tasks

#### 6.1 Play Store Preparation
```bash
# Generate release keystore
keytool -genkey -v -keystore release-key.jks -alias sysdesign -keyalg RSA -keysize 2048 -validity 10000

# Build release APK
flutter build appbundle --release

# App signing config in android/app/build.gradle
```

Play Store listing checklist:
- App name: **SysDesign Flash**
- Short description (80 chars): "Master system design with visual flashcards. Built for engineers."
- Full description: highlight interview prep, spaced repetition, offline use
- Screenshots: 4 phone screenshots (splash, home grid, card front, interview answer)
- Feature graphic: 1024×500 banner
- Privacy policy URL (required)
- Content rating: Everyone

#### 6.2 App Icon & Splash
```bash
flutter pub add dev:flutter_launcher_icons
flutter pub add flutter_native_splash
```

Icon: `🏗️` motif on dark background with orange gradient. Design at 1024×1024.

#### 6.3 Pre-launch checklist
- [ ] `flutter analyze` passes with 0 errors
- [ ] All flavours (debug/release) build successfully
- [ ] Test on minimum SDK (Android 6 / API 23)
- [ ] Test on low-end device (2GB RAM)
- [ ] No crashes in 30-minute smoke test
- [ ] Privacy policy live at public URL
- [ ] App size < 25MB (use `flutter build appbundle` not APK)
- [ ] Deep links configured
- [ ] ProGuard/R8 rules correct

#### 6.4 GTM — Week 1 Launch Channels
**Organic:**
- Post on r/cscareerquestions, r/ExperiencedDevs, r/leetcode, r/androiddev
- LinkedIn post: "I built a free system design flashcard app. Here's what I learned."
- Twitter/X thread: "12 system design concepts in 12 tweets" (each tweet = one card diagram)
- Dev.to article: "How I built a system design flashcard app in Flutter"
- Product Hunt launch (schedule for Tuesday 12:01 AM PT for best visibility)

**Community:**
- Post in Blind and Levels.fyi communities
- Share in ByteByteGo Discord / newsletter
- FAANG interview prep Telegram groups
- Flutter community Discord / Reddit r/FlutterDev

**Content marketing:**
- YouTube Shorts: 60-second "system design concept explained visually" series
- Each short = one card from the app, with the app download in bio

---

## 10. Phase 7 — Growth & Monetisation (Post-Launch)

**Goal:** Sustainable growth. Revenue to fund ongoing development.

### Growth Loops

#### Share mechanic
After mastering a concept, show a share sheet with a pre-generated image:
```
"Just mastered CAP Theorem on SysDesign Flash 🏗️
Consistency, Availability, Partition tolerance — pick 2.
[download link]"
```

#### Streak share
On 7-day and 30-day streak milestones, show a share card with the user's stats.

#### Referral
"Invite a friend studying for interviews → both get 1 week of Pro free."

---

### Monetisation Tiers

#### Free Tier
- All 80 core concept cards
- Basic swipe study mode
- Local progress tracking
- Limited spaced repetition (simple "mastered / not mastered")

#### Pro — $7.99/month or $49.99/year
- Full SM-2 spaced repetition engine with smart scheduling
- 40 additional advanced cards (distributed systems deep dives, real interview questions)
- Interview simulation mode: timed, pressure-simulated Q&A
- Progress analytics: heatmap calendar, weak area charts
- Cloud sync across devices
- Daily reminders with custom time

#### Teams — $29/month per team (up to 10 engineers)
- Shared progress dashboard for interview prep cohorts
- Custom decks (upload your own cards)
- Manager view: see team's weak areas for technical mentorship
- Bulk invite via email domain

#### One-time DLC Packs — $4.99 each
- "Payments & Fintech Systems" pack (20 cards)
- "ML Systems Design" pack (15 cards)
- "Real-Time Systems" pack (15 cards)
- "Database Internals Deep Dive" pack (20 cards)

---

### Future Features (Backlog)

| Feature | Value | Effort |
|---|---|---|
| AI-powered answer grading (Claude API) | High | High |
| Voice-mode: speak your answer, get feedback | High | High |
| Custom card creator | Medium | Medium |
| Whiteboard mode (draw diagrams) | Medium | High |
| Interview timer / mock session | High | Medium |
| Apple Watch complication for daily streak | Low | Medium |
| iPad / tablet optimised layout | Medium | Low |
| Web app (Flutter Web) | Medium | Low |
| Offline Wikipedia-style deep dives per concept | High | High |
| Community card voting and contribution | High | High |

---

## 11. Tech Stack Reference

| Layer | Choice | Reason |
|---|---|---|
| Framework | Flutter 3.x | iOS + Android from one codebase |
| Language | Dart 3 | Records, sealed classes, null safety |
| State management | Riverpod (code-gen) | Testable, no context dependency |
| Navigation | go_router | Deep links, named routes, shell routes |
| Local DB | Hive | Fast, no-SQL, works offline |
| Cloud DB | Supabase | PostgreSQL + Auth + Realtime + free tier |
| Animations | animations package | SharedAxisTransition, OpenContainer |
| Onboarding | smooth_page_indicator | Dot indicators |
| Icons | Material Symbols | Consistent with M3 |
| App icon | flutter_launcher_icons | Automates all sizes |
| Splash | flutter_native_splash | True native splash |
| Analytics | PostHog (self-hostable) | Privacy-respecting, free tier |
| Crash reporting | Sentry | Free tier, Flutter-native |
| CI/CD | GitHub Actions + Fastlane | Auto build + deploy to Play Store |
| Design system | Material 3 (M3) | Native Android, dynamic colour |

---

## 12. File & Folder Structure

```
sysdesign_flash/
├── android/
├── ios/
├── lib/
│   ├── main.dart
│   ├── app.dart                          ← MaterialApp + go_router config
│   │
│   ├── core/
│   │   ├── theme/
│   │   │   ├── app_theme.dart            ← M3 ThemeData light + dark
│   │   │   └── app_colors.dart           ← colour constants
│   │   ├── routing/
│   │   │   └── app_router.dart           ← go_router routes
│   │   └── utils/
│   │       ├── haptics.dart              ← haptic feedback helpers
│   │       └── extensions.dart           ← Dart extension methods
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
│   │   └── all_concepts.dart             ← aggregates all concept lists
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
│   │       └── profile_repository.dart
│   │
│   ├── providers/
│   │   ├── concepts_provider.dart
│   │   ├── mastered_provider.dart
│   │   ├── spaced_repetition_provider.dart
│   │   ├── study_session_provider.dart
│   │   ├── streak_provider.dart
│   │   └── settings_provider.dart
│   │
│   ├── screens/
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
│   │   │       └── weak_areas_section.dart
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
│   │   ├── progress/
│   │   │   ├── progress_screen.dart
│   │   │   └── widgets/
│   │   │       ├── category_progress_card.dart
│   │   │       ├── streak_calendar.dart
│   │   │       └── stats_overview.dart
│   │   └── settings/
│   │       └── settings_screen.dart
│   │
│   └── shared/
│       └── widgets/
│           ├── app_scaffold.dart          ← NavigationBar shell
│           ├── empty_state.dart
│           ├── loading_indicator.dart
│           └── concept_color_dot.dart
│
├── test/
│   ├── unit/
│   │   ├── sm2_algorithm_test.dart
│   │   ├── study_session_test.dart
│   │   └── streak_test.dart
│   └── widget/
│       ├── card_screen_test.dart
│       └── home_screen_test.dart
│
├── pubspec.yaml
├── analysis_options.yaml
└── README.md
```

---

## Summary Timeline

| Phase | Weeks | Key Milestone |
|---|---|---|
| 1. Foundation | 1–2 | App skeleton runs on device, first 25 cards |
| 2. Core Features | 3–4 | Full swipe loop, all 80 cards, local persistence |
| 3. Learning Engine | 5–6 | Spaced repetition, streaks, weak area detection |
| 4. Polish & UX | 7–8 | 60fps animations, hero transitions, accessibility |
| 5. Backend & Auth | 9–10 | Cloud sync, multi-device, Google sign-in |
| 6. Launch | 11–12 | Play Store live, first 1,000 users |
| 7. Growth | 13+ | Pro tier, referrals, DLC packs, iOS |

---

*Built with Flutter · Material 3 · Riverpod · Hive · Supabase*
