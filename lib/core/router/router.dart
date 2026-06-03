import 'package:breathe/features/care%20team/presentation/care_team_screen.dart';
import 'package:breathe/features/emergency/presentation/emergency_screen.dart';
import 'package:breathe/features/journal/presentation/journal_screen.dart';
import 'package:breathe/features/onboarding/presentation/onboardin_screen.dart';
import 'package:breathe/features/weekly%20summary/presentation/weekly_summary_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'routes.dart';
import 'go_router_refresh_stream.dart';
import '../../features/homescreen/presentation/screens/homescreen.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/splash/presentation/splash_screen.dart';

class _Placeholder extends StatelessWidget {
  const _Placeholder(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(label.toUpperCase())),
      body: Center(
        child: Text(label, style: Theme.of(context).textTheme.titleLarge),
      ),
    );
  }
}

GoRouter createRouter() {
  return GoRouter(
    initialLocation: AppRoute.splashPath,
    debugLogDiagnostics: true,
    refreshListenable: GoRouterRefreshStream(
      FirebaseAuth.instance.authStateChanges(),
    ),

    redirect: (context, state) {
      final loggedIn = FirebaseAuth.instance.currentUser != null;
      final onSplash = state.matchedLocation == AppRoute.splashPath;
      final loggingIn = state.matchedLocation == AppRoute.loginPath;

      if (onSplash) return null;

      if (!loggedIn && !loggingIn) return AppRoute.loginPath;
      return null;
    },

    routes: [
      GoRoute(
        name: AppRoute.onboarding,
        path: AppRoute.onboardingPath,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        name: AppRoute.splash,
        path: AppRoute.splashPath,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        name: AppRoute.login,
        path: AppRoute.loginPath,
        builder: (context, state) => const LoginScreen(),
      ),

      GoRoute(
        name: AppRoute.home,
        path: AppRoute.homePath,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        name: AppRoute.journal,
        path: AppRoute.journalPath,
        builder: (context, state) => const JournalScreen(),
        routes: [
          GoRoute(
            name: AppRoute.journalNew,
            path: 'new',
            builder: (context, state) => const _Placeholder('New entry'),
          ),
          GoRoute(
            name: AppRoute.journalEntry,
            path: 'entry/:id',
            builder: (context, state) {
              final id = state.pathParameters['id'] ?? '';
              return _Placeholder('Journal entry $id');
            },
          ),
        ],
      ),
      GoRoute(
        name: AppRoute.summary,
        path: AppRoute.summaryPath,
        builder: (context, state) => const JourneyScreen(),
      ),
      GoRoute(
        name: AppRoute.careTeam,
        path: AppRoute.careTeamPath,
        builder: (context, state) => const CareTeamScreen(),
      ),
      GoRoute(
        name: AppRoute.emergency,
        path: AppRoute.emergencyPath,
        builder: (context, state) => const EmergencyScreen(),
      ),
      GoRoute(
        name: AppRoute.settings,
        path: AppRoute.settingsPath,
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text('Route not found: ${state.uri}'))),
  );
}
