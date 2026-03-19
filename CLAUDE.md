# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**SysDesign Flash** — a Flutter flashcard app for system design interview preparation, targeting backend engineers preparing for FAANG/senior-level interviews. The full specification is in `SYSDESIGN_FLASH_COMPLETE_PLAN.md`.

## Status

This project is in the **planning phase** — specification documents exist but no source code has been implemented yet.

## Tech Stack

| Concern | Technology |
|---|---|
| Language | Dart 3 |
| Framework | Flutter 3.x |
| State Management | Riverpod (code-gen) |
| Navigation | go_router |
| Local Storage | Hive (offline-first) |
| Cloud Backend | Supabase (PostgreSQL + Auth) |
| Billing | in_app_purchase |
| Analytics | PostHog |
| Crash Reporting | Sentry |

## Commands

```bash
# Initial project setup
flutter create sysdesign_flash --org com.yourname
cd sysdesign_flash

# Install dependencies
flutter pub add flutter_riverpod riverpod_annotation go_router animations hive hive_flutter shared_preferences in_app_purchase
flutter pub add dev:build_runner dev:riverpod_generator dev:hive_generator

# Code generation (Riverpod + Hive adapters)
dart run build_runner build --delete-conflicting-outputs

# Run app
flutter run

# Run tests
flutter test
flutter test test/unit/sm2_algorithm_test.dart  # single test file

# Release build
flutter build appbundle --release
```

## Architecture

### Folder Structure

```
lib/
├── core/         # Theme (Material 3), routing (go_router), utils
├── data/         # Static concept data (120+ flashcards)
├── domain/       # Models (Concept, UserProgress, etc.) and repository interfaces
├── providers/    # Riverpod state containers
├── services/     # Billing, cloud sync, push notifications
├── screens/      # 8 major UI screens
└── shared/       # Reusable widgets
```

### State Management (Riverpod with code-gen)

All providers use `@riverpod` annotation with `build_runner`. Key providers:

- `conceptsProvider` — static flashcard data (read-only)
- `masteredProvider` — user mastery state, persisted in Hive
- `spacedRepetitionProvider` — SM-2 scheduling data (Pro only)
- `studySessionProvider` — current study session state
- `subscriptionProvider` — subscription tier (`SubscriptionTier.free` | `.pro`)

### Data Flow

1. UI reads from Riverpod providers
2. Providers read from Hive (local) — optimistic writes always go to Hive first
3. Background sync service pushes diffs to Supabase with exponential backoff
4. Server-wins conflict resolution on sync

### Key Domain Logic

**SM-2 Spaced Repetition (Pro):** Quality 0–5 → interval × ease factor → `next_review` timestamp. Quality mapping: "Got It!" → 4, "Review Again" → 1.

**Interview Readiness Score (Pro):**
```
score = (mastered_weight × 0.4 + quality_weight × 0.4 + coverage_weight × 0.2) × 100
```

**Daily Streak:** `lastStudyDate` in Hive; auto-resets on missed days.

### Monetisation Logic

- **Free tier:** All 120+ cards, basic progress, streaks, bookmarks, local-only
- **Pro tier:** SM-2 scheduling, interview simulation, analytics heatmap, cloud sync, custom reminders
- Paywalls are contextual (triggered at Pro feature touch points), never blocking content access
- Pricing: $5.99/mo · $35.99/yr · $79.99 lifetime · 7-day free trial

### Supabase Schema

```sql
user_profiles(user_id, display_name, streak, last_study_date, daily_goal)
user_progress(id, user_id, concept_id, mastered, easiness, interval, repetitions, next_review, last_reviewed, last_quality)
subscriptions(user_id, tier, plan, expires_at, purchase_token)
```

## Content

120+ system design concepts across 13 categories (Scalability, Distributed Systems, Databases, Messaging, API Design, Reliability, Rate Limiting, Microservices, Security, Observability, Networking, Data Engineering, Classic Interview Designs). Each card has three tabs: **Diagram** (ASCII art), **Key Points** (3–5 bullets), **Interview Q&A** (hidden question → reveal answer).

## Performance Targets

- 60fps swipe animations on mid-range Android (Pixel 4a)
- <8ms frame build time
- App bundle < 20MB
- Use `const` constructors throughout; 48×48dp minimum touch targets
