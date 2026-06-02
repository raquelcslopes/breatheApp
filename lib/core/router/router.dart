import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'go_router_refresh_stream.dart';

import 'routes.dart';
import '../../features/homescreen/presentation/homescreen.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';

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

final _rootKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final _homeKey = GlobalKey<NavigatorState>(debugLabel: 'home');
final _calendarKey = GlobalKey<NavigatorState>(debugLabel: 'calendar');
final _chatKey = GlobalKey<NavigatorState>(debugLabel: 'chat');
final _settingsKey = GlobalKey<NavigatorState>(debugLabel: 'settings');

GoRouter createRouter({bool isLoggedIn = false}) {
  return GoRouter(
    navigatorKey: _rootKey,
    initialLocation: AppRoute.loginPath,
    debugLogDiagnostics: true,
    refreshListenable: GoRouterRefreshStream(
      FirebaseAuth.instance.authStateChanges(),
    ),

    redirect: (context, state) {
      final loggedIn = FirebaseAuth.instance.currentUser != null;
      final loggingIn = state.matchedLocation == AppRoute.loginPath;

      if (!loggedIn && !loggingIn) return AppRoute.loginPath;
      if (loggedIn && loggingIn) return AppRoute.homePath;
      return null;
    },

    routes: [
      GoRoute(
        name: AppRoute.login,
        path: AppRoute.loginPath,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        name: AppRoute.onboarding,
        path: AppRoute.onboardingPath,
        builder: (context, state) => const _Placeholder('Onboarding'),
      ),
      GoRoute(
        name: AppRoute.dailyCheck,
        path: AppRoute.dailyCheckPath,
        parentNavigatorKey: _rootKey, // abre por cima da bottom nav
        builder: (context, state) => const _Placeholder('Daily check'),
      ),
      GoRoute(
        name: AppRoute.emergency,
        path: AppRoute.emergencyPath,
        parentNavigatorKey: _rootKey,
        builder: (context, state) => const _Placeholder('Emergency'),
      ),

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _homeKey,
            routes: [
              GoRoute(
                name: AppRoute.home,
                path: AppRoute.homePath,
                builder: (context, state) => const _Placeholder('Home'),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _calendarKey,
            routes: [
              GoRoute(
                name: AppRoute.calendar,
                path: AppRoute.calendarPath,
                builder: (context, state) => const _Placeholder('Calendar'),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _chatKey,
            routes: [
              GoRoute(
                name: AppRoute.chat,
                path: AppRoute.chatPath,
                builder: (context, state) => const _Placeholder('Chat'),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _settingsKey,
            routes: [
              GoRoute(
                name: AppRoute.settings,
                path: AppRoute.settingsPath,
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],

    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text('Route not found: ${state.uri}'))),
  );
}
