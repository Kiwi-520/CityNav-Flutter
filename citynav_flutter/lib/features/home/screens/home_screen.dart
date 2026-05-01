import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/theme_exports.dart';
import '../../../core/router/app_router.dart';
import '../../../core/providers/app_providers.dart';
import '../../../shared/widgets/transit_chip.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final city = ref.watch(userCityProvider);
    final userName = ref.watch(userNameProvider);

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: CustomScrollView(
        slivers: [
          _HomeAppBar(city: city, userName: userName),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 16),
                _SearchBar(),
                const SizedBox(height: 24),
                const _QuickActionsRow(),
                const SizedBox(height: 24),
                const _ActiveRouteCard(),
                const SizedBox(height: 24),
                const _MapPreviewCard(),
                const SizedBox(height: 24),
                _SectionHeader(title: 'Nearby Places', onSeeAll: () {}),
                const SizedBox(height: 12),
                const _NearbyScroll(),
                const SizedBox(height: 24),
                _SectionHeader(
                  title: 'City Apps',
                  onSeeAll: () => context.go(AppRoutes.essentialApps),
                ),
                const SizedBox(height: 12),
                const _CityAppsGrid(),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeAppBar extends StatelessWidget {
  final String city, userName;
  const _HomeAppBar({required this.city, required this.userName});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 0,
      floating: true,
      snap: true,
      backgroundColor: AppColors.bg,
      elevation: 0,
      toolbarHeight: 64,
      flexibleSpace: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              Container(
                width: 36, height: 36,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.indigo700],
                    begin: Alignment.topLeft, end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: const Icon(Icons.explore_rounded,
                    color: Colors.white, size: 20),
              ),
              const SizedBox(width: 10),
              Text('CityNav',
                  style: AppTextStyles.title.copyWith(color: AppColors.primary)),
              const Spacer(),
              GestureDetector(
                onTap: () => context.push(AppRoutes.notifications),
                child: Stack(children: [
                  Container(
                    width: 38, height: 38,
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: const Icon(Icons.notifications_outlined,
                        size: 20, color: AppColors.textPrimary),
                  ),
                  Positioned(
                    top: 8, right: 8,
                    child: Container(
                      width: 8, height: 8,
                      decoration: BoxDecoration(
                        color: AppColors.danger,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.bg, width: 1.5),
                      ),
                    ),
                  ),
                ]),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () => context.push(AppRoutes.profile),
                child: Container(
                  width: 38, height: 38,
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: const Icon(Icons.person_rounded,
                      size: 20, color: AppColors.primary),
                ),
              ),
            ],
          ),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Good morning, $userName 👋',
                  style: AppTextStyles.heading),
              const SizedBox(height: 4),
              Row(children: [
                Text("You're in ", style: AppTextStyles.bodyMuted),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.location_on_rounded,
                          size: 12, color: AppColors.primary),
                      const SizedBox(width: 3),
                      Text(city,
                          style: AppTextStyles.caption.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go(AppRoutes.search),
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(color: AppColors.border, width: 1.5),
          boxShadow: AppShadows.card,
        ),
        child: Row(
          children: [
            const SizedBox(width: 14),
            const Icon(Icons.search_rounded,
                color: AppColors.textTertiary, size: 22),
            const SizedBox(width: 10),
            Expanded(
              child: Text('Where do you want to go?',
                  style: AppTextStyles.body
                      .copyWith(color: AppColors.textTertiary)),
            ),
            Container(
              width: 36, height: 36,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: const Icon(Icons.mic_rounded, color: Colors.white, size: 18),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActionsRow extends StatelessWidget {
  const _QuickActionsRow();

  @override
  Widget build(BuildContext context) {
    final actions = [
      _QA(icon: Icons.map_outlined, label: 'Maps',
          color: AppColors.primary, bg: AppColors.primaryLight,
          route: AppRoutes.map),
      _QA(icon: Icons.alt_route_rounded, label: 'Routes',
          color: AppColors.success, bg: AppColors.successLight,
          route: AppRoutes.routeOptions),
      _QA(icon: Icons.subway_rounded, label: 'Metro',
          color: AppColors.accent, bg: AppColors.accentLight,
          route: AppRoutes.routeOptions),
      _QA(icon: Icons.apps_rounded, label: 'Apps',
          color: AppColors.danger, bg: AppColors.dangerLight,
          route: AppRoutes.essentialApps),
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: actions.map((a) => GestureDetector(
        onTap: () => context.go(a.route),
        child: Column(children: [
          Container(
            width: 62, height: 62,
            decoration: BoxDecoration(
              color: a.bg,
              borderRadius: BorderRadius.circular(AppRadius.xl),
              border: Border.all(color: a.color.withOpacity(0.2)),
            ),
            child: Icon(a.icon, color: a.color, size: 26),
          ),
          const SizedBox(height: 6),
          Text(a.label,
              style: AppTextStyles.caption
                  .copyWith(fontWeight: FontWeight.w500)),
        ]),
      )).toList(),
    );
  }
}

class _QA {
  final IconData icon;
  final String label, route;
  final Color color, bg;
  const _QA({required this.icon, required this.label, required this.color,
      required this.bg, required this.route});
}

class _ActiveRouteCard extends StatelessWidget {
  const _ActiveRouteCard();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFEEF2FF), Color(0xFFE0E7FF)],
          begin: Alignment.topLeft, end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.border),
        boxShadow: AppShadows.card,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Container(width: 8, height: 8,
                decoration: const BoxDecoration(
                    color: AppColors.danger, shape: BoxShape.circle)),
            const SizedBox(width: 6),
            Text('ACTIVE ROUTE',
                style: AppTextStyles.overline.copyWith(color: AppColors.primary)),
          ]),
          const SizedBox(height: 10),
          Row(children: [
            Text('Andheri', style: AppTextStyles.title),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: const Icon(Icons.arrow_forward_rounded,
                  size: 16, color: AppColors.textSecondary),
            ),
            Text('Bandra Kurla', style: AppTextStyles.title),
          ]),
          const SizedBox(height: 12),
          Row(children: [
            _StatChip(value: '24m', label: 'ETA'),
            const SizedBox(width: 16),
            _StatChip(value: '11km', label: 'Distance'),
            const SizedBox(width: 16),
            _StatChip(value: '₹38', label: 'Est. Cost'),
          ]),
          const SizedBox(height: 12),
          const Wrap(
            spacing: 6,
            children: [
              TransitChip(mode: TransitMode.walk, duration: '4 min'),
              TransitChip(mode: TransitMode.metro),
              TransitChip(mode: TransitMode.walk, duration: '6 min'),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String value, label;
  const _StatChip({required this.value, required this.label});
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(value, style: AppTextStyles.subheading.copyWith(color: AppColors.primary)),
      Text(label, style: AppTextStyles.caption),
    ]);
  }
}

class _MapPreviewCard extends StatelessWidget {
  const _MapPreviewCard();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go(AppRoutes.map),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(color: AppColors.border),
          boxShadow: AppShadows.card,
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(children: [
          Container(
            height: 130,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFDDE4FF), Color(0xFFEEF2FF)],
                begin: Alignment.topLeft, end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: Icon(Icons.map_rounded, size: 64,
                  color: AppColors.primary.withOpacity(0.4)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(children: [
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Explore Mumbai', style: AppTextStyles.title),
                  Text('Open full map view', style: AppTextStyles.caption),
                ],
              )),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: const Text('Open Map →',
                    style: TextStyle(fontFamily: 'Syne', fontSize: 13,
                        fontWeight: FontWeight.w700, color: Colors.white)),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAll;
  const _SectionHeader({required this.title, this.onSeeAll});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title.toUpperCase(), style: AppTextStyles.label),
        if (onSeeAll != null)
          GestureDetector(
            onTap: onSeeAll,
            child: Text('See all',
                style: AppTextStyles.bodySm.copyWith(color: AppColors.primary)),
          ),
      ],
    );
  }
}

class _NearbyScroll extends StatelessWidget {
  const _NearbyScroll();
  static const _places = [
    _Place('🏛️', 'CSMT Station', '2.1 km', Color(0xFF1A1035)),
    _Place('🌿', 'Sanjay Gandhi Park', '4.8 km', Color(0xFF0D3D34)),
    _Place('🍽️', 'Juhu Beach Food', '6.3 km', Color(0xFF3D2C0D)),
    _Place('🏢', 'BKC Business Hub', '3.4 km', Color(0xFF001A2E)),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _places.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (ctx, i) => Container(
          width: 130,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(color: AppColors.border),
            boxShadow: AppShadows.card,
          ),
          clipBehavior: Clip.hardEdge,
          child: Column(children: [
            Container(
              height: 72,
              color: _places[i].color.withOpacity(0.12),
              child: Center(
                  child: Text(_places[i].emoji,
                      style: const TextStyle(fontSize: 30))),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_places[i].name, maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bodySm
                          .copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 2),
                  Row(children: [
                    const Icon(Icons.location_on_rounded,
                        size: 10, color: AppColors.primary),
                    const SizedBox(width: 2),
                    Text(_places[i].dist, style: AppTextStyles.caption),
                  ]),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class _Place {
  final String emoji, name, dist;
  final Color color;
  const _Place(this.emoji, this.name, this.dist, this.color);
}

class _CityAppsGrid extends StatelessWidget {
  const _CityAppsGrid();
  static const _apps = [
    _App('🚌', 'BEST Buses', 'Track live bus locations',
        AppColors.primaryLight, AppColors.primary),
    _App('🏥', 'BMC Health', 'Book govt. hospital appointments',
        AppColors.successLight, AppColors.success),
    _App('💡', 'Adani Power', 'Pay bills & report outages',
        AppColors.accentLight, AppColors.accent),
    _App('🚨', 'Mumbai Police', 'Emergency & complaint portal',
        AppColors.dangerLight, AppColors.danger),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 12, mainAxisSpacing: 12,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: _apps.map((a) => Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(color: AppColors.border),
          boxShadow: AppShadows.card,
        ),
        padding: const EdgeInsets.all(14),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(a.emoji, style: const TextStyle(fontSize: 26)),
          const SizedBox(height: 8),
          Text(a.name, style: AppTextStyles.bodySemibold),
          const SizedBox(height: 4),
          Expanded(
            child: Text(a.desc, style: AppTextStyles.caption,
                maxLines: 2, overflow: TextOverflow.ellipsis),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: a.tagBg,
              borderRadius: BorderRadius.circular(AppRadius.pill),
            ),
            child: Text('Tap to open',
                style: AppTextStyles.caption.copyWith(
                    color: a.tagColor, fontWeight: FontWeight.w600)),
          ),
        ]),
      )).toList(),
    );
  }
}

class _App {
  final String emoji, name, desc;
  final Color tagBg, tagColor;
  const _App(this.emoji, this.name, this.desc, this.tagBg, this.tagColor);
}