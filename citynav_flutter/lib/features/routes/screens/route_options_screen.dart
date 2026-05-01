import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/theme_exports.dart';
import '../../../core/router/app_router.dart';
import '../../../shared/widgets/transit_chip.dart';

class RouteOptionsScreen extends StatefulWidget {
  const RouteOptionsScreen({super.key});
  @override
  State<RouteOptionsScreen> createState() => _RouteOptionsScreenState();
}

class _RouteOptionsScreenState extends State<RouteOptionsScreen> {
  int _selected = 0;

  static const _routes = [
    _RouteOption(
      label: 'Fastest',
      duration: '24 min',
      distance: '11.2 km',
      cost: '₹38',
      carbon: 'Low',
      modes: [TransitMode.walk, TransitMode.metro, TransitMode.walk],
      modeLabels: ['4 min', '14 min', '6 min'],
      isPreferred: true,
    ),
    _RouteOption(
      label: 'Cheapest',
      duration: '38 min',
      distance: '9.8 km',
      cost: '₹12',
      carbon: 'Low',
      modes: [TransitMode.walk, TransitMode.bus, TransitMode.walk],
      modeLabels: ['6 min', '26 min', '6 min'],
      isPreferred: false,
    ),
    _RouteOption(
      label: 'Comfortable',
      duration: '22 min',
      distance: '13.1 km',
      cost: '₹180',
      carbon: 'High',
      modes: [TransitMode.taxi],
      modeLabels: ['22 min'],
      isPreferred: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              decoration: const BoxDecoration(
                color: AppColors.surface,
                border: Border(
                    bottom: BorderSide(color: AppColors.border, width: 1)),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.go(AppRoutes.home),
                    child: Container(
                      width: 38, height: 38,
                      decoration: BoxDecoration(
                        color: AppColors.bgSubtle,
                        borderRadius: BorderRadius.circular(AppRadius.md),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: const Icon(Icons.arrow_back_ios_new_rounded,
                          size: 16),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Route Options', style: AppTextStyles.title),
                        Text('Andheri → Bandra Kurla',
                            style: AppTextStyles.caption),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // From / To
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppRadius.lg),
                border: Border.all(color: AppColors.border),
                boxShadow: AppShadows.card,
              ),
              child: Column(
                children: [
                  _LocationRow(icon: Icons.radio_button_checked_rounded,
                      iconColor: AppColors.success, label: 'Andheri West, Mumbai'),
                  Container(
                    height: 24,
                    margin: const EdgeInsets.only(left: 10),
                    child: VerticalDivider(
                        color: AppColors.border, width: 1, thickness: 1),
                  ),
                  _LocationRow(icon: Icons.location_on_rounded,
                      iconColor: AppColors.danger, label: 'Bandra Kurla Complex'),
                ],
              ),
            ),
            // Route cards
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                itemCount: _routes.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (ctx, i) => _RouteCard(
                  route: _routes[i],
                  isSelected: i == _selected,
                  onTap: () => setState(() => _selected = i),
                  onStart: () => context.go(AppRoutes.routeNavigation),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LocationRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  const _LocationRow({required this.icon, required this.iconColor, required this.label});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: iconColor),
        const SizedBox(width: 12),
        Expanded(child: Text(label, style: AppTextStyles.bodyMedium)),
      ],
    );
  }
}

class _RouteCard extends StatelessWidget {
  final _RouteOption route;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onStart;
  const _RouteCard({
    required this.route, required this.isSelected,
    required this.onTap, required this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected ? AppShadows.cardLg : AppShadows.card,
        ),
        child: Column(
          children: [
            // Header strip
            if (route.isPreferred)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 6),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(14),
                    topRight: Radius.circular(14),
                  ),
                ),
                child: Text('⭐ Recommended',
                    style: AppTextStyles.caption
                        .copyWith(color: Colors.white,
                            fontWeight: FontWeight.w600)),
              ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight,
                          borderRadius: BorderRadius.circular(AppRadius.pill),
                        ),
                        child: Text(route.label,
                            style: AppTextStyles.caption.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700)),
                      ),
                      Text(route.duration,
                          style: AppTextStyles.heading
                              .copyWith(color: AppColors.primary)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(children: [
                    _InfoBadge(label: route.distance,
                        icon: Icons.straighten_rounded),
                    const SizedBox(width: 12),
                    _InfoBadge(label: route.cost,
                        icon: Icons.currency_rupee_rounded),
                    const SizedBox(width: 12),
                    _InfoBadge(label: '${route.carbon} CO₂',
                        icon: Icons.eco_rounded),
                  ]),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 6, runSpacing: 6,
                    children: List.generate(route.modes.length, (i) =>
                      TransitChip(
                          mode: route.modes[i],
                          duration: route.modeLabels[i])),
                  ),
                  if (isSelected) ...[
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: onStart,
                      child: Container(
                        width: double.infinity, height: 46,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              colors: [AppColors.primary, AppColors.indigo700]),
                          borderRadius: BorderRadius.circular(AppRadius.md),
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.navigation_rounded,
                                color: Colors.white, size: 18),
                            const SizedBox(width: 8),
                            Text('Start Navigation',
                                style: AppTextStyles.btnLabelSm
                                    .copyWith(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoBadge extends StatelessWidget {
  final String label;
  final IconData icon;
  const _InfoBadge({required this.label, required this.icon});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: AppColors.textSecondary),
        const SizedBox(width: 3),
        Text(label, style: AppTextStyles.bodySm
            .copyWith(color: AppColors.textSecondary)),
      ],
    );
  }
}

class _RouteOption {
  final String label, duration, distance, cost, carbon;
  final List<TransitMode> modes;
  final List<String> modeLabels;
  final bool isPreferred;
  const _RouteOption({
    required this.label, required this.duration, required this.distance,
    required this.cost, required this.carbon, required this.modes,
    required this.modeLabels, required this.isPreferred,
  });
}