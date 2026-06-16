import 'package:breathe/core/theme/app_colors.dart';
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
    with TickerProviderStateMixin {
  late final AnimationController _breathCtrl;
  late final AnimationController _introCtrl;
  late final Animation<double> _breath;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();

    _breathCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);
    _breath = Tween<double>(
      begin: 0.96,
      end: 1.04,
    ).animate(CurvedAnimation(parent: _breathCtrl, curve: Curves.easeInOut));

    _introCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..forward();
    _fade = CurvedAnimation(parent: _introCtrl, curve: Curves.easeOut);

    _decide();
  }

  Future<void> _decide() async {
    try {
      await Future.delayed(const Duration(milliseconds: 1500));
      if (!mounted) return;

      final user =
          FirebaseAuth.instance.currentUser ??
          await FirebaseAuth.instance.authStateChanges().first;
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
    } catch (_) {
      if (!mounted) return;
      context.go(AppRoute.loginPath);
    }
  }

  @override
  void dispose() {
    _breathCtrl.dispose();
    _introCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          const ColoredBox(color: AppColors.background),
          Image.asset('lib/assets/bg_splash.png', fit: BoxFit.cover),
          Center(
            child: FadeTransition(
              opacity: _fade,
              child: ScaleTransition(
                scale: _breath,
                child: Text(
                  'BREATHE',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontSize: 40,
                    letterSpacing: 8,
                    color: AppColors.surface,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
