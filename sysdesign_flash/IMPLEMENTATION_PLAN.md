# SysDesign Flash — Phased Implementation Plan

> Each phase produces a **device-testable build**. Tell Claude "Start Phase X" to begin.

---

## Phase 1: Project Scaffold & Static Shell

**Goal:** App launches on device, shows placeholder screens, navigation works end-to-end.

**What you can test on device:**
- App launches with splash screen
- Navigating between Home, Progress, and Settings tabs
- Tapping a placeholder card opens the card screen
- Back navigation works
- Light/dark theme toggling (system-based)

### Steps

1. **Flutter project creation**
   ```
   flutter create sysdesign_flash --org com.sysdesignflash
   ```

2. **Dependencies installation**
   - Core: `flutter_riverpod`, `riverpod_annotation`, `go_router`, `animations`
   - Storage: `hive`, `hive_flutter`, `shared_preferences`
   - Dev: `build_runner`, `riverpod_generator`, `hive_generator`
   - Skip billing/supabase/analytics for now

3. **Folder structure** — Create the full directory tree from the spec (Section 13), with empty placeholder files where needed. This prevents restructuring later.

4. **Theme setup** (`lib/core/theme/`)
   - `app_theme.dart` — `ThemeData` for light + dark using `ColorScheme.fromSeed()` with `useMaterial3: true`
   - `app_colors.dart` — Category colour constants, semantic colours
   - Configure: `CardTheme`, `NavigationBarTheme`, `FilledButtonTheme`, `SegmentedButtonTheme`, `SnackBarTheme`

5. **Domain models** (`lib/domain/models/`)
   - `concept.dart` — Immutable `Concept` class with all fields (id, category, color, icon, title, tagline, diagram, bullets, mnemonic, interviewQ, interviewA, difficulty, tags) + `Difficulty` enum + `copyWith`
   - `review_schedule.dart` — SM-2 fields (easiness, interval, repetitions, nextReview, lastQuality) + `copyWith`
   - `study_session.dart` — cardOrder, currentIndex, gotItCount, startedAt + `copyWith`
   - `user_profile.dart` — name, streak, joinDate, dailyGoal + `copyWith`

6. **Router** (`lib/core/routing/app_router.dart`)
   - All routes defined: `/` (splash), `/onboarding`, `/home`, `/home/progress`, `/home/settings`, `/study/:deckId`, `/paywall`
   - `ShellRoute` wrapping Home/Progress/Settings with a `NavigationBar`
   - Placeholder screens for each route (simple `Scaffold` with route name as title)

7. **App entry point**
   - `main.dart` — `ProviderScope` wrapping app, Hive init stub
   - `app.dart` — `MaterialApp.router` with theme + router config

8. **Splash screen** (`lib/screens/splash/`)
   - App logo + title centered
   - 1.5s delay then navigate to `/home` (skip onboarding for now)

9. **Navigation shell** (`lib/shared/widgets/app_scaffold.dart`)
   - Bottom `NavigationBar` with 2 destinations: Concepts, Progress
   - Settings via `AppBar` icon button

10. **Placeholder screens**
    - `HomeScreen` — AppBar with title, empty body with "Concepts will appear here"
    - `ProgressScreen` — "Progress will appear here"
    - `SettingsScreen` — "Settings will appear here"
    - `CardScreen` — Receives a deckId parameter, shows "Card view for deck: {id}"

### Verification checklist
- [ ] `flutter analyze` — zero errors
- [ ] App launches on physical device
- [ ] Splash → Home transition works
- [ ] Bottom nav switches between Home and Progress
- [ ] Settings opens from AppBar
- [ ] CardScreen opens when navigating to `/study/test`
- [ ] Back button returns to Home from Card and Settings
- [ ] Theme respects system light/dark mode

---

## Phase 2: Data Layer & Home Screen

**Goal:** 25 real flashcards rendered in a scrollable grid on the home screen with category filtering.

**What you can test on device:**
- Home screen shows concept cards in a grid
- Category filter chips work (horizontal scroll row)
- Each card shows icon, title, category colour
- Tapping a card navigates to CardScreen (still placeholder content)
- Welcome banner shows at the top

### Steps

1. **Concept data — first 25 cards** (`lib/data/concepts/`)
   - `concepts_scalability.dart` — 10 cards (Section 2.1)
   - `concepts_distributed.dart` — 10 cards (Section 2.2)
   - `concepts_databases.dart` — 5 cards (first 5 from Section 2.3)
   - Each card gets full content: diagram (ASCII), bullets, mnemonic, interview Q&A
   - `all_concepts.dart` — aggregates all lists into a single `List<Concept>`

2. **Concepts provider** (`lib/providers/concepts_provider.dart`)
   - `@riverpod` annotated provider returning all concepts
   - Filtered concepts provider that takes a category string parameter

3. **Deck filter provider** (`lib/providers/`)
   - `deckFilterProvider` — holds selected category string ("All" by default)

4. **HomeScreen implementation** (`lib/screens/home/`)
   - `SliverAppBar` with app title
   - `WelcomeBanner` — greeting + placeholder progress bar ("X / Y concepts")
   - `CategoryFilterBar` — horizontal scrolling `FilterChip` row, built from distinct categories in concept data
   - Concept grid — `SliverGrid` of `ConceptGridCard` widgets
   - `ConceptGridCard` — card with category colour accent, icon, title, difficulty indicator
   - Tapping a card navigates to `/study/{conceptId}`

5. **Run code generation**
   ```
   dart run build_runner build --delete-conflicting-outputs
   ```

### Verification checklist
- [ ] Home screen shows grid of 25 concept cards
- [ ] Cards display icon, title, and category colour
- [ ] Filter chips appear for: All, Scalability, Distributed Systems, Databases
- [ ] Selecting a chip filters the grid correctly
- [ ] "All" chip resets to show all cards
- [ ] Tapping a card navigates (even though card screen is still placeholder)
- [ ] Welcome banner shows at top
- [ ] Grid scrolls smoothly

---

## Phase 3: Card Screen — Swipe Study Loop

**Goal:** Fully functional swipe study experience. Diagram/Key Points/Interview tabs. Got It / Review Again actions.

**What you can test on device:**
- Swipe right = "Got It!", swipe left = "Review Again"
- Visual stamp overlays appear during drag
- Three tabs work: Diagram (ASCII art), Key Points (bullets), Interview Q&A
- Interview answer reveal animation
- Card stack visual effect (ghost cards behind)
- Session progresses through cards
- Haptic feedback on swipe

### Steps

1. **CardScreen refactor** (`lib/screens/study/card_screen.dart`)
   - Receives deck filter (category or "all") or list of concept IDs
   - Manages current card index, session state
   - Shows card count progress (e.g., "3 / 25")
   - Bookmark toggle in AppBar

2. **SwipeableCard widget** (`lib/screens/study/widgets/swipeable_card.dart`)
   - `GestureDetector` with `onPanUpdate` / `onPanEnd`
   - Card rotates with drag (`Matrix4.rotateZ` proportional to dx)
   - Threshold: >100px horizontal = commit swipe, else spring back
   - Fling detection via velocity
   - `AnimatedBuilder` for smooth drag tracking

3. **Swipe label overlays** (`lib/screens/study/widgets/swipe_label_overlay.dart`)
   - "GOT IT!" stamp (green, right side) — opacity tied to positive dx
   - "REVIEW AGAIN" stamp (orange, left side) — opacity tied to negative dx
   - Stamps rotate slightly for a "stamped" look

4. **Card stack effect** (`lib/screens/study/widgets/card_stack_effect.dart`)
   - Two ghost cards behind active card
   - Ghost 1: translate(0, 6), rotateZ(0.02), opacity 0.5
   - Ghost 2: translate(0, 12), rotateZ(0.04), opacity 0.3
   - On swipe-away, next card promotes with scale+fade animation

5. **Tab content**
   - `DiagramTab` — ASCII art in monospace font, horizontally scrollable if wide
   - `BulletsTab` — numbered key points list
   - `InterviewTab` — question visible, answer hidden behind "Tap to reveal" button, `SizeTransition` reveal
   - `SegmentedButton` tab switcher
   - `AnimatedSwitcher` for smooth tab transitions

6. **Card header** (`lib/screens/study/widgets/card_header.dart`)
   - Category chip with colour
   - Title + tagline
   - Difficulty indicator

7. **Haptic feedback** (`lib/core/utils/haptics.dart`)
   - `HapticFeedback.mediumImpact` on swipe commit
   - `HapticFeedback.selectionClick` on tab switch

8. **Session complete sheet** (`lib/screens/study/widgets/session_complete_sheet.dart`)
   - Shows when all cards in session are reviewed
   - Stats: cards reviewed, "Got It" count, time spent
   - "Back to Home" button

### Verification checklist
- [ ] Card renders with ASCII diagram, readable in monospace
- [ ] Swiping right shows "GOT IT!" overlay, commits at threshold
- [ ] Swiping left shows "REVIEW AGAIN" overlay, commits at threshold
- [ ] Partial drag snaps back if below threshold
- [ ] Ghost cards visible behind active card
- [ ] Tab switching between Diagram / Key Points / Interview works
- [ ] Interview answer reveal animates smoothly
- [ ] Haptic feedback fires on swipe and tab switch
- [ ] Card progresses to next after swipe
- [ ] Session complete sheet shows after last card
- [ ] Fling gesture (fast swipe) works
- [ ] No jank during swipe animation

---

## Phase 4: Local Persistence & Progress

**Goal:** Progress survives app restarts. Mastered cards tracked. Progress screen shows real data.

**What you can test on device:**
- Swipe "Got It" on cards, kill app, reopen — mastered state preserved
- Home screen shows mastered badge on completed cards
- Progress screen shows real per-category progress bars
- Streak counter increments on daily study
- Welcome banner shows accurate mastered count

### Steps

1. **Hive initialization** (`main.dart`)
   - Open boxes: `mastered` (bool), `review_counts` (int), `profile` (String), `settings` (String), `bookmarks` (bool)
   - Initialize before `runApp`

2. **Mastered provider** (`lib/providers/mastered_provider.dart`)
   - `@riverpod` class backed by Hive `mastered` box
   - `toggle(int conceptId)` — marks/unmarks mastered
   - `isMastered(int conceptId)` — reads from Hive
   - Swiping right on a card calls `toggle` to mark mastered

3. **Bookmark provider** (`lib/providers/`)
   - Backed by Hive `bookmarks` box
   - Toggle bookmark from card screen AppBar

4. **Profile provider** (`lib/providers/`)
   - Reads/writes name, streak, lastStudyDate, joinDate from Hive `profile` box

5. **Streak logic** (`lib/providers/streak_provider.dart`)
   - On completing a study action: check `lastStudyDate`
   - Same day → no change
   - Yesterday → increment streak
   - Older → reset streak to 1
   - Persist to Hive immediately

6. **HomeScreen updates**
   - `ConceptGridCard` shows checkmark/badge on mastered cards
   - `WelcomeBanner` reads from mastered provider for count
   - Category filter chips show mastered count per category

7. **ProgressScreen implementation** (`lib/screens/progress/`)
   - `StatsOverview` — total cards, mastered, remaining with icons
   - `CategoryProgressCard` — per-category `LinearProgressIndicator` (animated on first build)
   - Overall mastery percentage
   - Streak display with fire icon

8. **Settings screen — basic** (`lib/screens/settings/`)
   - Display name (from profile)
   - Reset progress button with `AlertDialog` confirmation (clears Hive mastered box)
   - App version display

### Verification checklist
- [ ] Swipe "Got It" on 3 cards, force-kill app, reopen — 3 cards still mastered
- [ ] Home grid shows mastered badge on those cards
- [ ] Welcome banner shows "3 / 25 mastered"
- [ ] Progress screen shows per-category progress bars
- [ ] Progress bars animate on screen entry
- [ ] Streak increments after a study session
- [ ] Streak resets after skipping a day (change device date to test)
- [ ] Bookmark toggle persists across restarts
- [ ] Reset progress clears all mastered state
- [ ] Category chips show mastered count

---

## Phase 5: Full Content — All 120+ Cards

**Goal:** Complete knowledge bank encoded. All 13 categories populated.

**What you can test on device:**
- All 13 category filter chips visible and functional
- Scrolling through 120+ cards
- Each card has complete content (diagram, bullets, interview Q&A)
- All difficulty levels represented
- Search/filter works across full dataset

### Steps

1. **Encode remaining categories** (`lib/data/concepts/`)
   - `concepts_databases.dart` — complete remaining cards (Section 2.3)
   - `concepts_messaging.dart` — 10 cards (Section 2.4)
   - `concepts_api.dart` — 10 cards (Section 2.5)
   - `concepts_reliability.dart` — 10 cards (Section 2.6)
   - `concepts_rate_limiting.dart` — 9 cards (Section 2.7)
   - `concepts_microservices.dart` — 10 cards (Section 2.8)
   - `concepts_security.dart` — 10 cards (Section 2.9)
   - `concepts_observability.dart` — 10 cards (Section 2.10)
   - `concepts_networking.dart` — 9 cards (Section 2.11)
   - `concepts_data_engineering.dart` — 10 cards (Section 2.12)
   - `concepts_interview_systems.dart` — 24 cards (Section 2.13)

2. **Content quality pass**
   - Every card must have: non-empty diagram, 3-5 bullets, mnemonic, interview Q, interview A
   - Difficulty assigned per spec distribution: ~30 beginner, ~55 intermediate, ~35 advanced
   - Tags assigned for future search functionality

3. **Update `all_concepts.dart`** — Aggregate all 13 category files

4. **Difficulty filter** — Add difficulty filter chips alongside category filter (or as a secondary row)

5. **Search** — Add search icon in HomeScreen AppBar, basic substring search across title + tags + category

### Verification checklist
- [ ] 120+ cards load without performance issues
- [ ] All 13 categories appear in filter chips
- [ ] Each category filter shows correct cards
- [ ] Every card has complete diagram, bullets, and interview Q&A
- [ ] Difficulty distribution roughly matches spec
- [ ] Grid scrolls smoothly at 60fps with all cards
- [ ] Search finds cards by title keyword
- [ ] Search finds cards by category name
- [ ] No duplicate concept IDs

---

## Phase 6: Onboarding & Splash Polish

**Goal:** First-time user experience is polished. Name entry, goal setting, smooth transitions.

**What you can test on device:**
- First launch shows onboarding flow (3 pages)
- Name entry saves and persists
- Subsequent launches skip onboarding
- Splash → Home transition is smooth
- User name appears in welcome banner

### Steps

1. **Splash screen polish** (`lib/screens/splash/`)
   - App logo centered with subtle scale animation
   - 1.5s display, then check if onboarding completed
   - If first launch → `/onboarding`, else → `/home`
   - `shared_preferences` flag: `onboarding_completed`

2. **Onboarding screen** (`lib/screens/onboarding/`)
   - `PageView` with 3 pages
   - Add `smooth_page_indicator` dependency
   - **Page 1 — Welcome:** Logo, app name, "Master system design visually" tagline, name text field, "Continue" button
   - **Page 2 — How it works:** Swipe demo illustration (static), "Swipe right = Got it, Left = Review again" explanation, tab overview
   - **Page 3 — Set your goal:** Daily card goal picker (5 / 10 / 20), "Start Learning" CTA
   - Save name to Hive profile, goal to Hive settings
   - Mark onboarding completed in shared_preferences
   - Navigate to `/home`

3. **Welcome banner personalization**
   - "Hey, {name}!" greeting
   - Show daily goal if set
   - Motivational subtitle based on progress tier

4. **Goal picker widget** (`lib/screens/onboarding/widgets/goal_picker.dart`)
   - Three selectable options with icons
   - Animated selection state

### Verification checklist
- [ ] Fresh install shows onboarding (clear app data to test)
- [ ] Page dots update as you swipe through onboarding
- [ ] Name entry field works, keyboard appears
- [ ] Goal selection highlights chosen option
- [ ] "Start Learning" navigates to Home
- [ ] Second launch skips straight to Home
- [ ] Welcome banner shows entered name
- [ ] Entered name persists across restarts

---

## Phase 7: SM-2 Spaced Repetition Engine (Pro Feature)

**Goal:** SM-2 algorithm works. Due cards surface. Quality rating on card review. Smart study queue.

**What you can test on device:**
- Cards get scheduled after review
- "Due today" count appears on home screen
- Quality rating affects next review interval
- Smart session builder creates prioritized queue
- Review schedule persists across restarts

### Steps

1. **SM-2 algorithm** (`lib/core/utils/sm2_algorithm.dart`)
   - Pure function: `SM2.calculate(ReviewSchedule, int quality) → ReviewSchedule`
   - Quality 0-5 mapping
   - Easiness floor at 1.3
   - Interval calculation per spec
   - Unit tests for all quality values

2. **Review schedule Hive adapter**
   - Register `ReviewSchedule` Hive adapter (or serialize to JSON string in Hive box)
   - Box: `review_schedules` — conceptId → serialized ReviewSchedule

3. **Spaced repetition provider** (`lib/providers/spaced_repetition_provider.dart`)
   - Reads/writes review schedules from Hive
   - `recordReview(int conceptId, int quality)` — runs SM2, persists result
   - `getDueCards()` — returns concepts where `nextReview <= now`
   - `getWeakCards()` — returns concepts where `lastQuality < 3`

4. **Subscription provider stub** (`lib/providers/subscription_provider.dart`)
   - For now: hardcode `SubscriptionTier.pro` for development
   - `ProGate` widget — conditionally shows Pro content or paywall teaser
   - Easy toggle in provider for testing free vs pro experience

5. **Study session builder** (`lib/providers/study_session_provider.dart`)
   - For Pro: builds queue from due cards + weak cards + new cards
   - For Free: sequential order by category, all cards
   - `maxNew` parameter for controlling new card flow

6. **CardScreen integration**
   - After swipe, call `recordReview` with quality:
     - Right swipe (Got It) → quality 4
     - Left swipe (Review Again) → quality 1
   - Pro users see next review date after swipe (brief toast/snackbar)

7. **HomeScreen — smart queue banner** (Pro)
   - `SmartQueueBanner` shows: due today count, weak cards count, new cards count
   - "Start Smart Session" button → enters study session with SM-2 queue

8. **SM-2 unit tests** (`test/unit/sm2_algorithm_test.dart`)
   - Test: quality 5 produces increasing intervals
   - Test: quality 0 resets repetitions
   - Test: easiness never drops below 1.3
   - Test: first review always interval=1

### Verification checklist
- [ ] Review a card with "Got It" → check schedule shows future date
- [ ] Review a card with "Review Again" → schedule shows tomorrow
- [ ] Kill app, reopen — schedules persist
- [ ] Smart queue banner shows due card count
- [ ] Starting smart session presents due cards first
- [ ] After reviewing all due cards, new cards appear
- [ ] Quality 0 (fail) resets the card to short interval
- [ ] Toggle subscription to free — SM-2 features hidden, regular study still works
- [ ] Unit tests pass: `flutter test test/unit/sm2_algorithm_test.dart`

---

## Phase 8: Streaks, Readiness Score & Analytics UI

**Goal:** Streak system polished. Interview readiness score. Progress analytics with heatmap.

**What you can test on device:**
- Streak counter with fire icon in AppBar, animates on increment
- Milestone celebrations at 7-day and 30-day streaks
- Interview readiness score percentage (Pro)
- Activity heatmap calendar (Pro)
- Weak area detection with "Focus on" shortcuts (Pro)
- Pro analytics teaser on Progress screen for free users

### Steps

1. **Streak polish**
   - Streak display in HomeScreen AppBar
   - `TweenAnimationBuilder` scale pulse on increment
   - Milestone `BottomSheet` at 7 and 30 days with celebration message
   - Streak reset warning if about to lose streak (app open after missed day)

2. **Interview readiness score** (`lib/core/utils/`)
   - `readinessScore()` — composite: 40% mastered ratio + 40% avg SM-2 quality + 20% category coverage
   - Provider that computes and exposes score
   - Unit tests for edge cases (0 cards reviewed, all mastered, etc.)

3. **Weak area detection**
   - `weaknessScore(String category)` — ratio of cards with lastQuality < 3
   - Surface top 2 weakest categories on HomeScreen as "Focus Areas" section (Pro)
   - Each has a "Study now" button that starts a session filtered to that category

4. **Progress screen — Pro analytics**
   - `ReadinessGauge` — circular or linear gauge showing readiness %
   - Projected timeline text ("~2 weeks to 80%")
   - `HeatmapCalendar` — grid showing study activity per day for last 30 days
     - Read from Hive: store `studyDates` box with date → cards reviewed count
     - Colour intensity based on cards reviewed that day
   - Mastery confidence bars per category (based on avg SM-2 quality, not just mastered count)

5. **Progress screen — free tier**
   - Basic stats + per-category bars (already done)
   - Pro analytics teaser card at bottom: "Unlock readiness score, heatmap, and more"
   - Teaser navigates to paywall (placeholder for now)

6. **Study date tracking**
   - On each review action, record today's date + increment cards-reviewed count in Hive `study_dates` box

### Verification checklist
- [ ] Streak shows in AppBar with fire icon
- [ ] Reviewing a card today increments streak (if not already studied today)
- [ ] 7-day milestone triggers celebration bottom sheet (set dates manually to test)
- [ ] Readiness score shows on Progress screen (Pro)
- [ ] Score updates after reviewing cards
- [ ] Heatmap shows coloured cells for days with study activity
- [ ] Weak areas section shows on Home (Pro) with correct categories
- [ ] "Study now" on weak area starts filtered session
- [ ] Free users see teaser card instead of Pro analytics
- [ ] Readiness score unit tests pass

---

## Phase 9: Interview Simulation Mode (Pro)

**Goal:** Timed interview simulation with scenario selection, concept hints, and post-session review.

**What you can test on device:**
- Select a system design scenario (e.g., "Design Twitter Feed")
- Choose duration and difficulty level
- Timer counts down during session
- Relevant concept cards available as hints
- Post-session review shows which concepts you covered vs missed

### Steps

1. **Simulation data** (`lib/data/`)
   - `simulation_scenarios.dart` — List of scenarios from Section 2.13
   - Each scenario maps to: name, description, required concept IDs, hint card IDs, difficulty tiers

2. **Simulation models** (`lib/domain/models/`)
   - `simulation_session.dart` — scenario, duration, level, hintCardIds, requiredConcepts, viewedHints, startedAt

3. **Simulation setup screen** (`lib/screens/simulation/simulation_setup_screen.dart`)
   - Scenario picker (scrollable list or grid)
   - Duration selector: 30 / 45 / 60 min (SegmentedButton)
   - Level selector: Mid / Senior / Staff (SegmentedButton)
   - "Random" option that picks a scenario
   - "Start Interview" CTA

4. **Simulation session screen** (`lib/screens/simulation/simulation_session_screen.dart`)
   - Countdown timer (prominent, top of screen)
   - Scenario name and description
   - "Hint cards" section — collapsed by default, expandable
   - Each hint card is tappable to view the full concept card in a modal
   - Track which hints the user viewed
   - "End Session" button (with confirmation)
   - Auto-ends when timer reaches zero

5. **Simulation results screen** (`lib/screens/simulation/simulation_results_screen.dart`)
   - Duration taken
   - Required concepts list with status:
     - Viewed as hint → green checkmark
     - Not viewed → red X with "You should have covered this"
   - Score: hints viewed / required concepts
   - "Review missed concepts" button → starts study session with missed concept IDs
   - "Back to Home" button

6. **Navigation integration**
   - Add simulation entry point on HomeScreen (Pro only) — e.g., a card or FAB
   - Add routes: `/simulation`, `/simulation/session`, `/simulation/results`
   - Gate behind `ProGate` widget

### Verification checklist
- [ ] Simulation setup shows scenario list
- [ ] Can select duration and level
- [ ] Timer counts down in real time
- [ ] Hint cards are viewable during session
- [ ] Ending session (or timer expiry) shows results
- [ ] Results correctly mark viewed vs missed concepts
- [ ] "Review missed concepts" opens a study session with those cards
- [ ] Simulation is hidden/gated for free users
- [ ] "Random" scenario selection works

---

## Phase 10: Paywall & Subscription UI

**Goal:** Paywall screens built. Free/Pro experience properly gated. Purchase flow UI ready (no real billing yet).

**What you can test on device:**
- Tapping a Pro feature shows contextual paywall bottom sheet
- Full paywall screen with plan selection (monthly/annual/lifetime)
- Annual plan pre-selected
- "Start free trial" CTA
- Mock purchase flow (toggling subscription state)
- Pro features unlock/lock correctly based on state
- Downgrade experience preserves content access

### Steps

1. **Paywall screen** (`lib/screens/paywall/paywall_screen.dart`)
   - Feature benefits list (SM-2, simulation, analytics, cloud sync)
   - Plan selection radio: Annual ($35.99/yr, pre-selected), Monthly ($5.99/mo), Lifetime ($79.99)
   - "Start 7-day Free Trial" CTA button
   - Social proof quote at bottom
   - "Cancel anytime / Restore / Privacy" links

2. **Contextual paywall sheet** (`lib/screens/paywall/paywall_sheet.dart`)
   - `ModalBottomSheet` triggered when tapping a gated feature
   - Shows the specific feature name + description
   - "Start 7-day Free Trial" CTA
   - "See all Pro features" → navigates to full paywall
   - "Not now" dismisses

3. **Session-end nudge**
   - After every 5th session (tracked in Hive), show a `BottomSheet` nudge
   - "Pro users master concepts 3x faster"
   - "Try Pro free for 7 days" / "Continue without Pro"
   - Only for free users

4. **ProGate widget** (`lib/shared/widgets/pro_gate.dart`)
   - Wraps any Pro-only widget
   - If Pro → renders child
   - If Free → renders a teaser/locked version that opens contextual paywall on tap
   - Used on: smart queue, simulation, analytics, heatmap, readiness score

5. **Subscription provider — proper implementation**
   - Remove hardcoded Pro state
   - Default to `free`
   - Add dev toggle in Settings screen: "Debug: Toggle Pro" (only in debug builds)
   - This allows testing both experiences on device without real billing

6. **Upgrade success screen** (`lib/screens/paywall/upgrade_success_screen.dart`)
   - "Welcome to Pro!" message
   - Confetti or celebration animation (simple, no Lottie dependency yet)
   - "Start Smart Session" CTA

### Verification checklist
- [ ] App defaults to free tier
- [ ] Tapping smart queue (Pro feature) shows contextual paywall sheet
- [ ] "See all Pro features" navigates to full paywall screen
- [ ] Annual plan is pre-selected on paywall
- [ ] Debug toggle switches to Pro mode
- [ ] Pro features immediately appear after toggling
- [ ] Toggling back to free hides Pro features
- [ ] All content (cards, categories) remains accessible in free tier
- [ ] Session-end nudge appears after 5 sessions (for free users)
- [ ] Upgrade success screen displays correctly

---

## Phase 11: Animations & Polish

**Goal:** 60fps performance. Hero transitions. Smooth shared axis transitions. Accessibility complete.

**What you can test on device:**
- Hero animation from grid card to card screen header
- Shared axis transitions between screens
- Card enter animation (scale + fade)
- Empty states for edge cases
- Accessibility: large fonts, screen reader labels
- No jank anywhere at 60fps

### Steps

1. **Hero animations**
   - Splash logo → Home AppBar logo (`app_logo` tag)
   - Concept grid card → CardScreen header (`concept_header_{id}` tag)
   - Wrap appropriate widgets with `Hero` and matching tags

2. **Shared axis transitions** (using `animations` package)
   - Home → CardScreen: `SharedAxisTransitionType.horizontal`
   - Home → Progress: `SharedAxisTransitionType.vertical`
   - Modals: `FadeThrough`
   - Configure via `go_router` page builder with `CustomTransitionPage`

3. **Card enter animation**
   - New card scales from 0.8 → 1.0 with `easeOutBack` curve
   - Combined with fade 0.0 → 1.0
   - Duration: 300ms

4. **Progress bar animations**
   - `TweenAnimationBuilder` on `LinearProgressIndicator` values
   - Animate from 0 to actual value on screen entry
   - Stagger per-category animations by 50ms each

5. **Empty states** (`lib/shared/widgets/empty_state.dart`)
   - No cards due today → "All caught up!" with checkmark illustration
   - All cards mastered → "You've mastered everything!" celebration
   - Category filter with 0 results → "No cards in this category"
   - Simple illustrations (icon + text, no heavy assets)

6. **Performance optimization**
   - `const` constructors on all stateless widgets
   - `RepaintBoundary` around swipeable card area
   - `AutomaticKeepAliveClientMixin` on tab views
   - Profile with DevTools — target < 8ms frame build

7. **Accessibility**
   - `Semantics` labels on all icons, custom widgets, and interactive elements
   - Minimum 48x48dp touch targets on all buttons
   - Test with system font scaled to 200%
   - Respect `MediaQuery.disableAnimations` — skip animations for reduced-motion
   - Colour contrast ≥ 4.5:1 verified on all text

8. **Settings screen — complete**
   - Theme toggle: Light / Dark / System
   - Daily study goal display
   - Notification settings placeholder (Pro)
   - Restore purchase placeholder
   - Reset progress with confirmation
   - App version + "Send Feedback" link
   - Debug: toggle Pro (debug builds only)

### Verification checklist
- [ ] Hero animation from grid card to card screen is smooth
- [ ] Shared axis transition when navigating to card screen
- [ ] New card slides in with scale+fade animation
- [ ] Progress bars animate on Progress screen entry
- [ ] Empty states render for: no due cards, all mastered, empty filter
- [ ] System font at 200% — all text readable, nothing clipped
- [ ] TalkBack/screen reader reads card content and buttons
- [ ] All buttons have ≥ 48dp touch targets
- [ ] Reduced motion setting disables animations
- [ ] Swipe animation at 60fps on mid-range device (check DevTools)
- [ ] Theme toggle works: light/dark/system

---

## Phase 12: Supabase Backend & Auth

**Goal:** Supabase project set up. Auth works (Google + Email). Data syncs to cloud for Pro users.

**What you can test on device:**
- Sign in with Google
- Sign in with email/password
- User profile created in Supabase
- Progress syncs to cloud after sign-in
- Sign out and sign in on another device — progress restored
- Offline usage still works without auth
- Anonymous-to-signed-in migration preserves local progress

### Steps

1. **Supabase project setup** (external)
   - Create Supabase project
   - Run SQL migrations: `user_profiles`, `user_progress`, `subscriptions` tables (from spec Section 9)
   - Configure Row Level Security (RLS) policies
   - Enable Google OAuth provider in Supabase Auth settings

2. **Add dependencies**
   ```
   flutter pub add supabase_flutter google_sign_in http
   ```

3. **Supabase initialization** (`main.dart`)
   - Initialize Supabase client with project URL and anon key
   - Must not block app launch if offline

4. **Auth service** (`lib/services/auth_service.dart`)
   - `signInWithGoogle()` — Google OAuth → Supabase auth → upsert profile (per spec)
   - `signInWithEmail(email, password)` — email/password auth
   - `signUp(email, password, name)` — create account
   - `signOut()` — clear session, keep local data
   - Phone number fetch from People API (optional, never blocks sign-in)

5. **Auth screen** (`lib/screens/auth/auth_screen.dart`)
   - Google Sign-In button (prominent)
   - Email/password form (secondary)
   - "What we store" GDPR note
   - "Continue without account" option (stays free, local-only)

6. **Sync service** (`lib/services/sync_service.dart`)
   - On sign-in: merge local Hive data → Supabase (upload local, then pull server, server-wins conflict)
   - On app open (authenticated + online): pull → merge → push
   - On review action (authenticated): optimistic Hive write + queue background Supabase upsert
   - Exponential backoff on sync failure (1s, 2s, 4s, max 30s)
   - Sync only runs for authenticated Pro users

7. **Profile repository** (`lib/domain/repositories/profile_repository.dart`)
   - Local: read/write Hive
   - Cloud: read/write Supabase `user_profiles`

8. **Progress repository** (`lib/domain/repositories/progress_repository.dart`)
   - Local: read/write Hive
   - Cloud: read/write Supabase `user_progress`
   - Conflict resolution: server timestamp wins

9. **Navigation updates**
   - Add auth check to router: if not signed in, auth screen accessible from Settings
   - Auth is never required — purely opt-in for sync

### Verification checklist
- [ ] Google Sign-In flow completes successfully
- [ ] User profile appears in Supabase `user_profiles` table
- [ ] Email sign-up and sign-in work
- [ ] Local progress uploads to Supabase on first sign-in
- [ ] Reviewing cards while signed in updates Supabase
- [ ] Sign out → sign in on fresh install → progress restored from cloud
- [ ] Airplane mode — app works fully, no crashes
- [ ] Coming back online after offline session — queued changes sync
- [ ] "Continue without account" works, no cloud features
- [ ] GDPR note visible on auth screen
- [ ] Phone number is optional and doesn't block sign-in

---

## Phase 13: In-App Purchase & Billing

**Goal:** Real billing integration. Users can subscribe to Pro via Google Play. Server-side verification.

**What you can test on device:**
- Paywall "Start Free Trial" triggers Google Play purchase flow
- Test purchases work (Google Play test tracks)
- Successful purchase unlocks Pro features
- Subscription status persists across restarts
- Restore purchase works
- Subscription expiry reverts to free tier

### Steps

1. **Google Play Console setup** (external)
   - Create in-app products:
     - `pro_monthly` — subscription $5.99/month with 7-day free trial
     - `pro_annual` — subscription $35.99/year with 7-day free trial
     - `pro_lifetime` — one-time purchase $79.99
   - Add test license accounts

2. **Billing service** (`lib/services/billing_service.dart`)
   - Initialize `InAppPurchase.instance`
   - `fetchProducts()` — load product details for the 3 SKUs
   - `purchaseProduct(ProductDetails)` — initiate purchase
   - `listenToPurchaseUpdates()` — handle purchase stream
   - On successful purchase: verify with server → update subscription state → complete purchase

3. **Supabase Edge Function** — purchase verification
   - Receives purchase token
   - Validates against Google Play Developer API
   - Updates `subscriptions` table with tier, plan, expiry
   - Returns verification result to client

4. **Subscription repository** (`lib/domain/repositories/subscription_repository.dart`)
   - `verifyWithServer(PurchaseDetails)` — calls Edge Function
   - `getCurrentTier()` — checks local cache first, then server
   - `restorePurchases()` — calls `InAppPurchase.instance.restorePurchases()`

5. **Subscription provider — real implementation**
   - Replaces debug toggle with real billing state
   - On app start: check cached tier → verify with server in background
   - On purchase: optimistic unlock → verify → confirm or revert
   - Keep debug toggle in debug builds as fallback

6. **Paywall integration**
   - Paywall screen fetches real product prices from Play Store
   - "Start Free Trial" calls `purchaseProduct` with selected plan
   - Loading state during purchase flow
   - Error handling: purchase cancelled, purchase failed, already subscribed

7. **Restore flow**
   - Settings → "Restore Purchase" triggers `restorePurchases()`
   - Finds active subscription → updates tier

### Verification checklist
- [ ] Paywall shows real prices from Google Play (or test prices)
- [ ] Tapping "Start Free Trial" opens Google Play purchase sheet
- [ ] Test purchase completes successfully
- [ ] Pro features unlock immediately after purchase
- [ ] Kill app, reopen — Pro status persists
- [ ] Restore purchase works on fresh install (same Google account)
- [ ] Purchase cancellation is handled gracefully (no crash, stays on paywall)
- [ ] Subscription table updated in Supabase
- [ ] Edge Function verification works (check Supabase logs)
- [ ] Free trial period applied correctly

---

## Phase 14: Notifications, Final Polish & Launch Prep

**Goal:** Push notifications for Pro reminders. Final bug fixes. Play Store ready.

**What you can test on device:**
- Daily study reminder notification at configured time (Pro)
- Trial expiry reminder notification
- App icon and splash screen match brand
- App bundle < 20MB
- No crashes in 30-minute smoke test
- All flows work end-to-end

### Steps

1. **Notification service** (`lib/services/notification_service.dart`)
   - Add `flutter_local_notifications` dependency
   - Daily reminder: scheduled at user's chosen time (Pro only)
   - Settings screen: time picker for reminder, day-of-week toggles
   - Trial expiry reminder: day 6 notification ("Your trial ends tomorrow")

2. **App icon**
   - Add `flutter_launcher_icons` dev dependency
   - Configure in `pubspec.yaml` with 1024x1024 icon asset
   - Generate all density sizes

3. **Native splash**
   - Add `flutter_native_splash` dependency
   - Configure background colour matching app icon
   - Generate native splash assets

4. **ProGuard/R8 rules**
   - Add keep rules for Hive generated adapters
   - Add keep rules for in_app_purchase
   - Verify release build doesn't strip needed classes

5. **Release build verification**
   ```
   flutter build appbundle --release
   ```
   - Verify bundle size < 20MB
   - Install release build on device
   - Full smoke test in release mode

6. **Pre-launch checklist** (from spec Section 10)
   - `flutter analyze` — zero errors, zero warnings
   - Debug and release builds clean
   - Test on Android 6.0+ (API 23 minimum)
   - 30-minute smoke test — no crashes
   - Deep links tested (if configured)
   - Privacy policy at public URL
   - Play Console content rating completed
   - Billing products approved in Play Console

7. **Analytics setup** (optional, lower priority)
   - PostHog integration for key events
   - Sentry for crash reporting
   - Key events: session_start, card_reviewed, subscription_started, milestone_reached

8. **Final bug sweep**
   - Test all navigation paths
   - Test offline → online transitions
   - Test free → pro → free transitions
   - Test on multiple screen sizes
   - Test with system font scaling
   - Test with dark mode

### Verification checklist
- [ ] Daily notification fires at configured time
- [ ] Notification tap opens the app
- [ ] App icon displays correctly on home screen
- [ ] Splash screen shows brand colours
- [ ] Release APK/bundle installs and runs
- [ ] Bundle size < 20MB
- [ ] `flutter analyze` passes with zero issues
- [ ] 30-minute smoke test: no crashes
- [ ] All user flows work end-to-end in release mode
- [ ] Offline mode works completely
- [ ] Pro/Free feature gating correct in release build

---

## Quick Reference: Phase Dependencies

```
Phase 1  (Scaffold)
  ↓
Phase 2  (Data + Home)
  ↓
Phase 3  (Card Swipe)
  ↓
Phase 4  (Persistence)
  ↓
Phase 5  (All 120+ Cards)     ← can run parallel with Phase 6
  ↓
Phase 6  (Onboarding)         ← can run parallel with Phase 5
  ↓
Phase 7  (SM-2 Engine)
  ↓
Phase 8  (Streaks + Analytics)
  ↓
Phase 9  (Interview Sim)      ← can run parallel with Phase 10
  ↓
Phase 10 (Paywall UI)         ← can run parallel with Phase 9
  ↓
Phase 11 (Animations)
  ↓
Phase 12 (Auth + Sync)
  ↓
Phase 13 (Billing)
  ↓
Phase 14 (Launch Prep)
```

---

*Tell Claude: "Start Phase X" to begin implementation of any phase.*
