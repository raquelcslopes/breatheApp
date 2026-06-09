import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/router/routes.dart';
import '../../profile/domain/profile_providers.dart';

/// Onboarding placeholder. O conteudo real (as 3 fases) vem depois,
/// quando a care team e os lembretes estiverem feitos.
/// Por agora so testa: marcar onboardingComplete e ir para a Home.
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  bool _saving = false;

  Future<void> _complete() async {
    setState(() => _saving = true);
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final repository = ref.read(profileRepositoryProvider);
    if (uid == null) return;

    await repository.markOnboardingComplete(uid);

    // invalida o provider do perfil para que da proxima vez leia o novo valor
    ref.invalidate(userProfileProvider);

    if (!mounted) return;
    context.go(AppRoute.homePath);
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
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome to Breathe',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: const Color(0xFFE9E0CF),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Onboarding placeholder — the real steps come later.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFFB9CABF)),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _saving ? null : _complete,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF73937E),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: _saving
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text('Get started'),
                  ),
                ),
                TextButton(
                  onPressed: _saving ? null : _complete,
                  child: const Text(
                    'Skip for now',
                    style: TextStyle(color: Color(0xFFB9CABF)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
