# SysDesign Flash

A Flutter flashcard app for system design interview prep, targeting backend engineers preparing for FAANG and senior-level interviews.

## Features

- **Flashcard decks** across 13 system design categories: Scalability, Distributed Systems, Databases, Messaging, API Design, Reliability, Rate Limiting, Microservices, Security, Observability, Networking, Data Engineering, and Interview Systems
- **Spaced repetition** (SM-2 algorithm) to surface weak cards at the right time
- **Readiness score** — weighted metric combining mastery, review quality, and coverage
- **Study sessions** with per-concept ASCII diagrams, key points, and mock interview Q&A
- **Simulation mode** (Pro) — end-to-end system design scenario practice
- **Streak tracking** and progress dashboard
- **Cloud sync** via Supabase (Pro), with offline-first Hive storage
- **Push notifications** for daily study reminders

## Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter / Dart |
| State management | Riverpod (codegen) |
| Navigation | GoRouter |
| Local storage | Hive, SharedPreferences |
| Backend | Supabase (auth + sync) |
| Payments | in_app_purchase |
| Animations | animations (Material Motion) |

## Getting Started

### Prerequisites

- Flutter SDK (Dart `^3.11.1`)
- A connected device or emulator

### Run

```bash
flutter pub get
flutter run
```

### Code generation

Required after any `@riverpod` provider change or Hive model change:

```bash
dart run build_runner build --delete-conflicting-outputs
```

### Tests

```bash
# All tests
flutter test

# Single file
flutter test test/unit/sm2_algorithm_test.dart
```

### Release build

```bash
flutter build appbundle --release
```

## Project Structure

```
lib/
├── core/
│   ├── config/       # Supabase configuration
│   ├── routing/      # GoRouter (app_router.dart)
│   ├── theme/        # AppTheme, AppColors
│   └── utils/        # SM-2, readiness score, weakness score, haptics
├── data/
│   ├── all_concepts.dart       # Aggregates all 13 category files
│   ├── concepts/               # Per-category concept data
│   └── simulation_scenarios.dart
├── domain/
│   ├── models/       # Concept, ReviewSchedule, StudySession, UserProfile, etc.
│   └── repositories/ # Profile, Progress, Subscription
├── providers/        # Riverpod providers (*.g.dart are generated — do not edit)
├── services/         # Auth, Billing, Sync, Notification
├── screens/          # One folder per screen
└── shared/widgets/   # AppScaffold, ProGate, EmptyState
```

## Subscription Tiers

| Feature | Free | Pro |
|---|---|---|
| All flashcard decks | Yes | Yes |
| Spaced repetition | Yes | Yes |
| Cloud sync | No | Yes |
| Simulation mode | No | Yes |

The `subscriptionProvider` has a `setTier()` debug override; call `clearDebugOverride()` to reset.
