import 'package:breathe/features/care_team/presentation/screens/care_team_screen.dart';
import 'package:breathe/features/emergency/presentation/screens/emergency_screen.dart';
import 'package:breathe/features/journal/presentation/screens/entry_screen.dart';
import 'package:breathe/features/journal/presentation/screens/journal_screen.dart';
import 'package:breathe/features/onboarding/presentation/onboardin_screen.dart';
import 'package:breathe/features/journal/presentation/screens/new_entry_screen.dart';
import 'package:breathe/features/journey/presentation/screens/journey_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'routes.dart';
import 'go_router_refresh_stream.dart';
import '../../features/homescreen/presentation/screens/homescreen.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/splash/presentation/splash_screen.dart';

GoRouter createRouter() {
  final _rootNavigatorKey = GlobalKey<NavigatorState>();
  return GoRouter(
    initialLocation: AppRoute.splashPath,
    debugLogDiagnostics: true,
    refreshListenable: GoRouterRefreshStream(
      FirebaseAuth.instance.authStateChanges(),
    ),

    redirect: (context, state) {
      final loggedIn = FirebaseAuth.instance.currentUser != null;
      final loc = state.matchedLocation;
      final onSplash = loc == AppRoute.splashPath;
      final onAuth =
          loc == AppRoute.loginPath || loc == AppRoute.onboardingPath;

      if (onSplash) return null;

      if (!loggedIn && !onAuth) return AppRoute.loginPath;

      if (loggedIn && loc == AppRoute.loginPath) return AppRoute.homePath;

      return null;
    },

    routes: [
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
        name: AppRoute.onboarding,
        path: AppRoute.onboardingPath,
        builder: (context, state) => const OnboardingScreen(),
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
            name: AppRoute.journalEntry,

            path: 'entry/:id',
            builder: (context, state) {
              final id = state.pathParameters['id'] ?? '';
              return EntryScreen(entryId: id);
            },
          ),
        ],
      ),
      GoRoute(
        name: AppRoute.journalNew,
        path: AppRoute.journalNewPath,
        builder: (context, state) => const NewEntryScreen(),
      ),

      GoRoute(
        name: AppRoute.journey,
        path: AppRoute.journeyPath,
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
    ],
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text('Route not found: ${state.uri}'))),
  );
}
