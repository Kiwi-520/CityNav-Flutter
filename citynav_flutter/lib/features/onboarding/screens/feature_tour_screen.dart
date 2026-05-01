import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/theme_exports.dart';
import '../../../core/router/app_router.dart';

class FeatureTourScreen extends StatefulWidget {
  const FeatureTourScreen({super.key});
  @override
  State<FeatureTourScreen> createState() => _FeatureTourScreenState();
}

class _FeatureTourScreenState extends State<FeatureTourScreen> {
  final _ctrl = PageController();
  int _page = 0;

  final _slides = const [
    _Slide(
      icon: Icons.map_outlined,
      title: 'Offline Maps',
      body: 'Navigate Mumbai and Pune without internet. Maps auto-download for your city.',
      color: AppColors.primary,
      bgColor: AppColors.primaryLight,
    ),
    _Slide(
      icon: Icons.alt_route_rounded,
      title: 'Mixed-Mode Routing',
      body: 'Metro + walk + auto-rickshaw — one combined route that saves you time and money.',
      color: AppColors.accent,
      bgColor: AppColors.accentLight,
    ),
    _Slide(
      icon: Icons.shield_outlined,
      title: 'Safety First',
      body: 'Safety-weighted routes, heatmaps, and a one-tap SOS with SMS fallback.',
      color: AppColors.danger,
      bgColor: AppColors.dangerLight,
    ),
    _Slide(
      icon: Icons.group_outlined,
      title: 'Community Intel',
      body: 'Locals report ATM status, restroom cleanliness, and real-time conditions.',
      color: AppColors.success,
      bgColor: AppColors.successLight,
    ),
  ];

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_page > 0)
                    GestureDetector(
                      onTap: () {
                        _ctrl.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOut);
                      },
                      child: Container(
                        width: 38, height: 38,
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(AppRadius.md),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: const Icon(Icons.arrow_back_ios_new_rounded,
                            size: 16),
                      ),
                    )
                  else
                    const SizedBox(width: 38),
                  TextButton(
                    onPressed: () =>
                        context.go(AppRoutes.locationPermission),
                    child: Text('Skip',
                        style: AppTextStyles.bodySm
                            .copyWith(color: AppColors.textSecondary)),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _ctrl,
                onPageChanged: (i) => setState(() => _page = i),
                itemCount: _slides.length,
                itemBuilder: (ctx, i) => _SlideView(slide: _slides[i]),
              ),
            ),
            // Pagination dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_slides.length, (i) {
                final active = i == _page;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: active ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: active ? AppColors.primary : AppColors.border,
                    borderRadius: BorderRadius.circular(999),
                  ),
                );
              }),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: GestureDetector(
                onTap: () {
                  if (_page < _slides.length - 1) {
                    _ctrl.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut);
                  } else {
                    context.go(AppRoutes.locationPermission);
                  }
                },
                child: Container(
                  width: double.infinity, height: 52,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [AppColors.primary, AppColors.indigo700]),
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    boxShadow: AppShadows.card,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    _page == _slides.length - 1 ? 'Get Started' : 'Next',
                    style: AppTextStyles.btnLabel
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _SlideView extends StatelessWidget {
  final _Slide slide;
  const _SlideView({required this.slide});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120, height: 120,
            decoration: BoxDecoration(
              color: slide.bgColor,
              borderRadius: BorderRadius.circular(32),
            ),
            child: Icon(slide.icon, size: 56, color: slide.color),
          ),
          const SizedBox(height: 40),
          Text(slide.title,
              style: AppTextStyles.heading, textAlign: TextAlign.center),
          const SizedBox(height: 16),
          Text(slide.body,
              style: AppTextStyles.bodyMuted, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class _Slide {
  final IconData icon;
  final String title;
  final String body;
  final Color color;
  final Color bgColor;
  const _Slide({
    required this.icon,
    required this.title,
    required this.body,
    required this.color,
    required this.bgColor,
  });
}