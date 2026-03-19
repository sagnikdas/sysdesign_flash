import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../screens/splash/splash_screen.dart';
import '../../screens/onboarding/onboarding_screen.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/progress/progress_screen.dart';
import '../../screens/settings/settings_screen.dart';
import '../../screens/study/card_screen.dart';
import '../../screens/paywall/paywall_screen.dart';
import '../../screens/simulation/simulation_results_screen.dart';
import '../../screens/simulation/simulation_session_screen.dart';
import '../../screens/simulation/simulation_setup_screen.dart';
import '../../shared/widgets/app_scaffold.dart';
import '../../shared/widgets/pro_gate.dart';
import '../../domain/models/simulation_session.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => AppScaffold(child: child),
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/progress',
          builder: (context, state) => const ProgressScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/study/:deckId',
      builder: (context, state) {
        final deckId = state.pathParameters['deckId'] ?? 'all';
        return CardScreen(deckId: deckId);
      },
    ),
    GoRoute(
      path: '/study/concepts',
      builder: (context, state) {
        final extra = state.extra;
        final ids = extra is List<int>
            ? extra
            : (extra is List ? extra.cast<int>() : const <int>[]);
        return CardScreen(deckId: 'concepts', conceptIds: ids);
      },
    ),
    GoRoute(
      path: '/simulation',
      builder: (context, state) => ProGate(
        featureTitle: 'Interview Simulation',
        child: const SimulationSetupScreen(),
      ),
    ),
    GoRoute(
      path: '/simulation/session',
      builder: (context, state) {
        final extra = state.extra;
        final session = extra is SimulationSession ? extra : null;

        return ProGate(
          featureTitle: 'Interview Simulation',
          child: session == null
              ? const Scaffold(
                  body: Center(child: Text('Simulation session unavailable')),
                )
              : SimulationSessionScreen(session: session),
        );
      },
    ),
    GoRoute(
      path: '/simulation/results',
      builder: (context, state) {
        final extra = state.extra;
        final session = extra is SimulationSession ? extra : null;

        return ProGate(
          featureTitle: 'Interview Simulation',
          child: session == null
              ? const Scaffold(
                  body: Center(child: Text('Simulation results unavailable')),
                )
              : SimulationResultsScreen(session: session),
        );
      },
    ),
    GoRoute(
      path: '/paywall',
      builder: (context, state) => const PaywallScreen(),
    ),
  ],
);
