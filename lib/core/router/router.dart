import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'routes.dart';
import 'go_router_refresh_stream.dart';
import '../../features/homescreen/presentation/homescreen.dart';
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
      if (loggedIn && loggingIn) return AppRoute.homePath;
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
        name: AppRoute.home,
        path: AppRoute.homePath,
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
            name: AppRoute.dailyCheck,
            path: 'daily-check',
            builder: (context, state) => const _Placeholder('Daily check'),
          ),
          GoRoute(
            name: AppRoute.journal,
            path: 'journal',
            builder: (context, state) => const _Placeholder('Journal'),
            routes: [
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
            path: 'summary',
            builder: (context, state) => const _Placeholder('Weekly summary'),
          ),
          GoRoute(
            name: AppRoute.careTeam,
            path: 'care-team',
            builder: (context, state) => const _Placeholder('Care team'),
          ),
          GoRoute(
            name: AppRoute.emergency,
            path: 'emergency',
            builder: (context, state) => const _Placeholder('Emergency'),
          ),
          GoRoute(
            name: AppRoute.settings,
            path: 'settings',
            builder: (context, state) => const SettingsScreen(),
          ),
        ],
      ),
    ],

    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text('Route not found: ${state.uri}'))),
  );
}
