import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/theme_exports.dart';
import '../../../core/router/app_router.dart';
import '../../../core/providers/app_providers.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.watch(userNameProvider);

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            backgroundColor: AppColors.primary,
            leading: GestureDetector(
              onTap: () => context.pop(),
              child: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: Colors.white, size: 18),
            ),
            actions: [
              TextButton(
                onPressed: () {},
                child: const Text('Edit',
                    style: TextStyle(color: Colors.white,
                        fontFamily: 'Syne', fontWeight: FontWeight.w700)),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primary, AppColors.indigo700],
                    begin: Alignment.topLeft, end: Alignment.bottomRight,
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 32),
                      Container(
                        width: 80, height: 80,
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                              color: Colors.white.withOpacity(0.4), width: 3),
                        ),
                        child: Center(
                          child: Text(
                            name.isNotEmpty ? name[0].toUpperCase() : 'G',
                            style: AppTextStyles.displayLg
                                .copyWith(color: AppColors.primary),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(name,
                          style: AppTextStyles.subheading
                              .copyWith(color: Colors.white)),
                      Text('Member since 2024 · Mumbai',
                          style: AppTextStyles.caption
                              .copyWith(color: Colors.white60)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Stats
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                      border: Border.all(color: AppColors.border),
                      boxShadow: AppShadows.card,
                    ),
                    child: const Row(
                      children: [
                        Expanded(child: _StatItem(value: '142', label: 'Routes')),
                        _VertDiv(),
                        Expanded(child: _StatItem(value: '389km', label: 'Navigated')),
                        _VertDiv(),
                        Expanded(child: _StatItem(value: '₹2.1k', label: 'Saved')),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  _MenuSection(title: 'Account', items: const [
                    _MenuItem(icon: Icons.person_outline_rounded,
                        label: 'Personal Info', subtitle: 'Name, email, mobile'),
                    _MenuItem(icon: Icons.emoji_events_outlined,
                        label: 'Achievements', subtitle: '8 badges earned'),
                    _MenuItem(icon: Icons.bookmark_border_rounded,
                        label: 'Saved Places', subtitle: 'Home, work & 6 more'),
                    _MenuItem(icon: Icons.history_rounded,
                        label: 'Trip History', subtitle: 'Last 30 days · 18 trips'),
                  ]),
                  const SizedBox(height: 16),
                  _MenuSection(title: 'Preferences', items: [
                    _MenuItem(
                      icon: Icons.settings_outlined,
                      label: 'Settings',
                      onTap: () => context.push(AppRoutes.settings),
                    ),
                    const _MenuItem(icon: Icons.language_rounded,
                        label: 'Language', subtitle: 'English (India)'),
                    const _MenuItem(icon: Icons.notifications_outlined,
                        label: 'Notifications'),
                  ]),
                  const SizedBox(height: 16),
                  _MenuSection(title: 'Support', items: [
                    const _MenuItem(icon: Icons.help_outline_rounded,
                        label: 'Help & Support'),
                    const _MenuItem(icon: Icons.star_outline_rounded,
                        label: 'Rate CityNav'),
                    _MenuItem(
                      icon: Icons.logout_rounded,
                      label: 'Sign Out',
                      subtitle: 'guest@citynav.app',
                      textColor: AppColors.danger,
                      onTap: () => context.go(AppRoutes.login),
                    ),
                  ]),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value, label;
  const _StatItem({required this.value, required this.label});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(children: [
        Text(value,
            style: AppTextStyles.heading.copyWith(color: AppColors.primary)),
        const SizedBox(height: 2),
        Text(label, style: AppTextStyles.caption),
      ]),
    );
  }
}

class _VertDiv extends StatelessWidget {
  const _VertDiv();
  @override
  Widget build(BuildContext context) =>
      Container(width: 1, height: 40, color: AppColors.border);
}

class _MenuSection extends StatelessWidget {
  final String title;
  final List<_MenuItem> items;
  const _MenuSection({required this.title, required this.items});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title.toUpperCase(), style: AppTextStyles.label),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(color: AppColors.border),
            boxShadow: AppShadows.card,
          ),
          child: Column(
            children: items.asMap().entries.map((e) {
              return Column(children: [
                if (e.key > 0)
                  const Divider(height: 1, color: AppColors.borderSubtle),
                _MenuRowTile(item: e.value),
              ]);
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _MenuRowTile extends StatelessWidget {
  final _MenuItem item;
  const _MenuRowTile({required this.item});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: item.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        child: Row(
          children: [
            Container(
              width: 36, height: 36,
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: Icon(item.icon, size: 18, color: AppColors.primary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.label,
                      style: AppTextStyles.bodyMedium.copyWith(
                          color: item.textColor ?? AppColors.textPrimary)),
                  if (item.subtitle != null)
                    Text(item.subtitle!, style: AppTextStyles.caption),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded,
                size: 20, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String label;
  final String? subtitle;
  final Color? textColor;
  final VoidCallback? onTap;
  const _MenuItem({required this.icon, required this.label,
      this.subtitle, this.textColor, this.onTap});
}