import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/theme_exports.dart';
import '../../../core/router/app_router.dart';
import '../../../shared/widgets/transit_chip.dart';

class RouteNavigationScreen extends StatefulWidget {
  const RouteNavigationScreen({super.key});
  @override
  State<RouteNavigationScreen> createState() => _RouteNavigationScreenState();
}

class _RouteNavigationScreenState extends State<RouteNavigationScreen> {
  int _step = 0;
  static const _steps = [
    _Step(icon: Icons.directions_walk_rounded, color: AppColors.transitWalk,
        instruction: 'Walk to Andheri Metro Station',
        detail: 'Head north on S.V. Road • 400 m', duration: '4 min'),
    _Step(icon: Icons.subway_rounded, color: AppColors.transitMetro,
        instruction: 'Board Metro Line 1 — Versova to CSMT',
        detail: 'Platform 2 · Towards Versova • 6 stops', duration: '14 min'),
    _Step(icon: Icons.directions_walk_rounded, color: AppColors.transitWalk,
        instruction: 'Walk to BKC destination',
        detail: 'Exit Gate 3 · Head south • 550 m', duration: '6 min'),
  ];

  @override
  Widget build(BuildContext context) {
    final step = _steps[_step];
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [
          // Map placeholder
          Container(
            color: const Color(0xFFDDE4FF),
            child: Center(
              child: Icon(Icons.map_rounded,
                  size: 80,
                  color: AppColors.primary.withOpacity(0.3)),
            ),
          ),
          // Top instruction card
          Positioned(
            top: 0, left: 0, right: 0,
            child: SafeArea(
              child: Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppRadius.xl),
                  border: Border.all(color: AppColors.border),
                  boxShadow: AppShadows.cardLg,
                ),
                child: Column(
                  children: [
                    // Progress
                    Container(
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(18),
                          topRight: Radius.circular(18),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      child: Row(
                        children: [
                          const Icon(Icons.navigation_rounded,
                              color: Colors.white, size: 18),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Step ${_step + 1} of ${_steps.length} • 24 min total',
                              style: AppTextStyles.bodySm
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => context.go(AppRoutes.home),
                            child: const Icon(Icons.close_rounded,
                                color: Colors.white, size: 20),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Container(
                            width: 52, height: 52,
                            decoration: BoxDecoration(
                              color: step.color.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(AppRadius.lg),
                            ),
                            child: Icon(step.icon,
                                color: step.color, size: 26),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(step.instruction,
                                    style: AppTextStyles.bodySemibold,
                                    maxLines: 2),
                                const SizedBox(height: 4),
                                Text(step.detail, style: AppTextStyles.caption),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: AppColors.primaryLight,
                              borderRadius: BorderRadius.circular(AppRadius.md),
                            ),
                            child: Text(step.duration,
                                style: AppTextStyles.bodySm.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w700)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Bottom controls
          Positioned(
            bottom: 32, left: 16, right: 16,
            child: Row(
              children: [
                if (_step > 0)
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _step--),
                      child: Container(
                        height: 52,
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(AppRadius.md),
                          border: Border.all(color: AppColors.border),
                        ),
                        alignment: Alignment.center,
                        child: const Icon(Icons.arrow_back_rounded,
                            color: AppColors.textPrimary),
                      ),
                    ),
                  ),
                if (_step > 0) const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () {
                      if (_step < _steps.length - 1) {
                        setState(() => _step++);
                      } else {
                        context.go(AppRoutes.home);
                      }
                    },
                    child: Container(
                      height: 52,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [AppColors.primary, AppColors.indigo700]),
                        borderRadius: BorderRadius.circular(AppRadius.md),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        _step < _steps.length - 1 ? 'Next Step →' : 'Arrive 🎉',
                        style: AppTextStyles.btnLabel
                            .copyWith(color: Colors.white),
                      ),
                    ),
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

class _Step {
  final IconData icon;
  final Color color;
  final String instruction, detail, duration;
  const _Step({required this.icon, required this.color,
      required this.instruction, required this.detail, required this.duration});
}