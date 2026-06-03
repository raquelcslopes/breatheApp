import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../router/routes.dart';
import '../../features/auth/data/auth_repository.dart';

/// Menu lateral partilhado por toda a app.
///
/// Usa-se pondo `drawer: const AppDrawer()` no Scaffold de qualquer ecrã.
/// O ícone de menu (☰) aparece automaticamente no AppBar desse ecrã,
/// e o utilizador também pode deslizar da esquerda para o abrir.
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  Future<void> _signOut(BuildContext context) async {
    Navigator.pop(context); // fecha o drawer primeiro
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
      await AuthRepository().signOut();
      // O router deteta o logout e leva ao login automaticamente.
    }
  }

  @override
  Widget build(BuildContext context) {
    final email = FirebaseAuth.instance.currentUser?.email ?? '';
    final textTheme = Theme.of(context).textTheme;

    return Drawer(
      backgroundColor: const Color(0xFFF4F8F9),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cabeçalho com o nome da app e o email
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('BREATHE', style: textTheme.headlineMedium),
                  const SizedBox(height: 4),
                  Text(email, style: textTheme.bodySmall),
                ],
              ),
            ),
            const Divider(height: 1),

            // Features
            _DrawerItem(
              icon: Icons.menu_book_outlined,
              label: 'Home',
              onTap: () => _go(context, AppRoute.homePath),
            ),
            _DrawerItem(
              icon: Icons.menu_book_outlined,
              label: 'Journal',
              onTap: () => _go(context, AppRoute.journalPath),
            ),
            _DrawerItem(
              icon: Icons.insights_outlined,
              label: 'Weekly summary',
              onTap: () => _go(context, AppRoute.summaryPath),
            ),
            _DrawerItem(
              icon: Icons.favorite_outline,
              label: 'Care team',
              onTap: () => _go(context, AppRoute.careTeamPath),
            ),
            _DrawerItem(
              icon: Icons.emergency_outlined,
              label: 'Emergency',
              onTap: () => _go(context, AppRoute.emergencyPath),
            ),

            const Spacer(),
            const Divider(height: 1),

            // Conta
            _DrawerItem(
              icon: Icons.settings_outlined,
              label: 'Settings',
              onTap: () => _go(context, AppRoute.settingsPath),
            ),
            _DrawerItem(
              icon: Icons.logout,
              label: 'Sign out',
              color: const Color(0xFFB5544C),
              onTap: () => _signOut(context),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  void _go(BuildContext context, String path) {
    Navigator.pop(context); // fecha o drawer
    context.push(path); // abre a feature por cima da Home
  }
}

class _DrawerItem extends StatelessWidget {
  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final c = color ?? const Color(0xFF141514);
    return ListTile(
      leading: Icon(icon, color: c),
      title: Text(label, style: TextStyle(color: c, fontSize: 15)),
      onTap: onTap,
    );
  }
}
