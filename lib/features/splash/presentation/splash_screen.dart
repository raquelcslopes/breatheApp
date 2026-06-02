import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/router/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
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
    _goNext();
  }

  Future<void> _goNext() async {
    await Future.delayed(const Duration(milliseconds: 2600));
    if (!mounted) return;

    final loggedIn = FirebaseAuth.instance.currentUser != null;
    context.go(loggedIn ? AppRoute.homePath : AppRoute.loginPath);
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
