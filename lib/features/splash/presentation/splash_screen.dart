import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/router/routes.dart';
import '../../profile/domain/profile_providers.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _breath;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);

    _breath = Tween<double>(
      begin: 0.96,
      end: 1.04,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _decide();
  }

  Future<void> _decide() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    if (!mounted) return;

    final user = await FirebaseAuth.instance.authStateChanges().first;
    if (!mounted) return;
    if (user == null) {
      context.go(AppRoute.loginPath);
      return;
    }

    final repository = ref.read(profileRepositoryProvider);
    final profile = await repository.fetchProfile(user.uid);

    if (!mounted) return;

    final done = profile?.onboardingComplete ?? false;
    context.go(done ? AppRoute.homePath : AppRoute.onboardingPath);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF102C26), Color(0xFF1C584B)],
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _breath,
            child: ScaleTransition(
              scale: _breath,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'BREATHE',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: const Color(0xFFE9E0CF),
                      letterSpacing: 8,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Your safe space for peace',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFFA57548),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
