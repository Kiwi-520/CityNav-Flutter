import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/theme_exports.dart';
import '../../core/router/app_router.dart';

class AppShell extends StatelessWidget {
  final Widget child;
  const AppShell({super.key, required this.child});

  int _tabIndex(BuildContext context) {
    final loc = GoRouterState.of(context).uri.toString();
    if (loc.startsWith(AppRoutes.map))           return 3;
    if (loc.startsWith(AppRoutes.search))        return 1;
    if (loc.startsWith(AppRoutes.routeOptions))  return 2;
    if (loc.startsWith(AppRoutes.essentialApps)) return 4;
    return 0;
  }

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0: context.go(AppRoutes.home); break;
      case 1: context.go(AppRoutes.search); break;
      case 2: context.go(AppRoutes.routeOptions); break;
      case 3: context.go(AppRoutes.map); break;
      case 4: context.go(AppRoutes.essentialApps); break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final idx = _tabIndex(context);
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: child,
      bottomNavigationBar: _CityNavBar(
        currentIndex: idx,
        onTap: (i) => _onTap(context, i),
      ),
    );
  }
}

class _CityNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  const _CityNavBar({required this.currentIndex, required this.onTap});

  static const _items = [
    _NavItem(icon: Icons.home_rounded, label: 'Home'),
    _NavItem(icon: Icons.search_rounded, label: 'Search'),
    _NavItem(icon: Icons.alt_route_rounded, label: 'Route'),
    _NavItem(icon: Icons.map_rounded, label: 'Maps'),
    _NavItem(icon: Icons.apps_rounded, label: 'Apps'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surfaceOverlay,
        border: Border(top: BorderSide(color: AppColors.border, width: 1)),
        boxShadow: AppShadows.nav,
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 60,
          child: Row(
            children: List.generate(_items.length, (i) {
              final item = _items[i];
              final active = i == currentIndex;
              return Expanded(
                child: GestureDetector(
                  onTap: () => onTap(i),
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        height: 3,
                        width: active ? 22 : 0,
                        margin: const EdgeInsets.only(bottom: 5),
                        decoration: BoxDecoration(
                          color: active ? AppColors.primary : Colors.transparent,
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                      Icon(item.icon, size: 22,
                          color: active ? AppColors.primary : AppColors.textSecondary),
                      const SizedBox(height: 2),
                      Text(item.label,
                          style: TextStyle(
                            fontFamily: 'DMSans',
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: active ? AppColors.primary : AppColors.textSecondary,
                          )),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem({required this.icon, required this.label});
}