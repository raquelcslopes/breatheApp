import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:breathe/core/router/routes.dart';
import 'package:breathe/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class _NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}

class MainScaffold extends StatelessWidget {
  final Widget child;

  const MainScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;

    int currentIndex = switch (location) {
      AppRoute.homePath => 0,
      AppRoute.journalPath => 1,
      AppRoute.journeyPath => 2,
      AppRoute.careTeamPath => 3,
      AppRoute.emergencyPath => 4,
      _ => 0,
    };

    return Scaffold(
      body: child,
      bottomNavigationBar: CustomBottomNav(
        currentIndex: currentIndex,
        onTap: (index) {
          switch (index) {
            case 0:
              context.go(AppRoute.homePath);
              break;
            case 1:
              context.go(AppRoute.journalPath);
              break;
            case 2:
              context.go(AppRoute.journeyPath);
              break;
            case 3:
              context.go(AppRoute.careTeamPath);
              break;
            case 4:
              context.go(AppRoute.emergencyPath);
              break;
          }
        },
      ),
    );
  }
}

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  List<_NavItem> items(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return [
      _NavItem(
        icon: Icons.home_outlined,
        activeIcon: Icons.home,
        label: l10n.navHome,
      ),
      _NavItem(
        icon: Icons.menu_book_outlined,
        activeIcon: Icons.menu_book,
        label: l10n.navJournal,
      ),
      _NavItem(
        icon: Icons.explore_outlined,
        activeIcon: Icons.explore,
        label: l10n.navJourney,
      ),
      _NavItem(
        icon: Icons.groups_outlined,
        activeIcon: Icons.groups,
        label: l10n.navCareTeam,
      ),
      _NavItem(
        icon: Icons.warning_amber_outlined,
        activeIcon: Icons.warning,
        label: l10n.navEmergency,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final navItems = items(context);

    return Container(
      decoration: BoxDecoration(
        color: context.colors.surface,
        border: Border(
          top: BorderSide(color: context.colors.outline, width: 0.05),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(navItems.length, (index) {
          final item = navItems[index];
          final selected = currentIndex == index;

          return GestureDetector(
            onTap: () => onTap(index),
            behavior: HitTestBehavior.opaque,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: selected ? context.colors.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(900),
                boxShadow: [
                  selected
                      ? BoxShadow(
                          color: Color.fromARGB(
                            255,
                            0,
                            0,
                            0,
                          ).withValues(alpha: 0.60),
                          offset: Offset(0, 20),
                          blurRadius: 25,
                          spreadRadius: -5,
                        )
                      : BoxShadow(color: Colors.transparent),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    selected ? item.activeIcon : item.icon,
                    color: selected
                        ? context.colors.onPrimary
                        : const Color.fromARGB(197, 158, 158, 158),
                    size: 18,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.label,
                    style: TextStyle(
                      fontSize: 11,
                      color: selected
                          ? context.colors.onPrimary
                          : const Color.fromARGB(197, 158, 158, 158),
                      fontWeight: selected
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
