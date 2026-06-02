import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../auth/data/auth_repository.dart';

/// Settings — por agora só com o essencial e o logout funcional.
/// Vais acrescentar aqui as restantes secções (quick call, reminders,
/// privacy) mais tarde.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key, AuthRepository? authRepository})
    : authRepository = authRepository;

  final AuthRepository? authRepository;

  Future<void> _signOut(BuildContext context) async {
    final auth = authRepository ?? AuthRepository();

    // Pede confirmação antes de sair.
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign out?'),
        content: const Text('You can always sign back in.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Sign out'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await auth.signOut();
      // Não navegamos aqui — o router deteta o logout e leva ao login.
    }
  }

  @override
  Widget build(BuildContext context) {
    final email = FirebaseAuth.instance.currentUser?.email ?? '';
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('SETTINGS')),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          // Cartão da conta
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0x4D979797), width: 0.5),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 22,
                  backgroundColor: Color(0xFFD9E6DC),
                  child: Icon(Icons.person, color: Color(0xFF3F6B5E)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Signed in as', style: textTheme.bodySmall),
                      const SizedBox(height: 2),
                      Text(
                        email,
                        style: textTheme.titleMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Botão de logout
          OutlinedButton.icon(
            onPressed: () => _signOut(context),
            icon: const Icon(Icons.logout, color: Color(0xFFB5544C)),
            label: const Text(
              'Sign out',
              style: TextStyle(color: Color(0xFFB5544C)),
            ),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFFB5544C)),
              padding: const EdgeInsets.symmetric(vertical: 15),
            ),
          ),
        ],
      ),
    );
  }
}
