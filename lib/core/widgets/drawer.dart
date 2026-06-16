import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:breathe/features/auth/data/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:ui';

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
      child: Row(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: context.colors.primary.withAlpha(40),
            child: Icon(Icons.spa, color: context.colors.primary),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Olá, Ana',
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Como te sentes hoje?',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colors.surfaceContainerHighest,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerFooter extends StatelessWidget {
  const _DrawerFooter({AuthRepository? authRepository})
    : authRepository = authRepository;

  final AuthRepository? authRepository;

  Future<void> _signOut(BuildContext context) async {
    final auth = authRepository ?? AuthRepository();

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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
      child: Row(
        children: [
          Icon(
            Icons.logout,
            size: 20,
            color: context.colors.surfaceContainerHighest,
          ),
          const SizedBox(width: 12),
          TextButton(
            onPressed: () => _signOut,
            child: Text(
              'Log out',
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colors.surfaceContainerHighest,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.path,
    required this.currentLocation,
  });

  final IconData icon;
  final String label;
  final String path;
  final String currentLocation;

  @override
  Widget build(BuildContext context) {
    final selected =
        currentLocation == path || currentLocation.startsWith('$path/');

    final activeColor = context.colors.onPrimaryContainer;
    final inactiveColor = context.colors.surfaceContainerHighest;
    final color = selected ? activeColor : inactiveColor;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 4,
            height: 28,
            decoration: BoxDecoration(
              color: selected ? activeColor : Colors.transparent,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          Expanded(
            child: ListTile(
              leading: Icon(icon, color: color),
              title: Text(
                label,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: color,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
              selected: selected,
              selectedTileColor: activeColor.withAlpha(20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              onTap: () {
                Navigator.pop(context);
                context.go(path);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  final double blur;
  final int fillAlpha;

  const CustomDrawer({super.key, this.blur = 12, this.fillAlpha = 31});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;

    return Drawer(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  context.colors.surface.withAlpha(fillAlpha + 13),
                  context.colors.surface.withAlpha((fillAlpha * 0.5).round()),
                ],
              ),
              border: Border.all(
                color: context.colors.surface.withAlpha(64),
                width: 1,
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  const _DrawerHeader(),

                  Divider(
                    height: 1,
                    color: context.colors.surfaceContainerHighest.withAlpha(40),
                  ),

                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(10),
                      children: [
                        _DrawerItem(
                          icon: Icons.home_outlined,
                          label: 'Home',
                          path: '/home',
                          currentLocation: location,
                        ),
                        _DrawerItem(
                          icon: Icons.menu_book_outlined,
                          label: 'Journal',
                          path: '/journal',
                          currentLocation: location,
                        ),
                        _DrawerItem(
                          icon: Icons.show_chart,
                          label: 'Journey',
                          path: '/journey',
                          currentLocation: location,
                        ),
                        _DrawerItem(
                          icon: Icons.group_outlined,
                          label: 'Care Team',
                          path: '/care-team',
                          currentLocation: location,
                        ),
                        _DrawerItem(
                          icon: Icons.emergency_outlined,
                          label: 'Emergency',
                          path: '/emergency',
                          currentLocation: location,
                        ),
                        _DrawerItem(
                          icon: Icons.settings_outlined,
                          label: 'Settings',
                          path: '/settings',
                          currentLocation: location,
                        ),
                      ],
                    ),
                  ),

                  Divider(
                    height: 1,
                    color: context.colors.surfaceContainerHighest.withAlpha(40),
                  ),
                  const _DrawerFooter(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
