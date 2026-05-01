import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/theme_exports.dart';
import '../../../core/router/app_router.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  String _selectedLang = 'en';
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  final _langs = const [
    {'code': 'en', 'label': 'English'},
    {'code': 'hi', 'label': 'हिंदी'},
    {'code': 'mr', 'label': 'मराठी'},
    {'code': 'ta', 'label': 'தமிழ்'},
  ];

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _slide = Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));
    _ctrl.forward();
  }

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
        child: FadeTransition(
          opacity: _fade,
          child: SlideTransition(
            position: _slide,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 48),
                  // Logo
                  Row(children: [
                    Container(
                      width: 44, height: 44,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.primary, AppColors.indigo700],
                          begin: Alignment.topLeft, end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: AppShadows.card,
                      ),
                      child: const Icon(Icons.explore_rounded,
                          color: Colors.white, size: 24),
                    ),
                    const SizedBox(width: 12),
                    Text('CityNav',
                        style: AppTextStyles.subheading
                            .copyWith(color: AppColors.primary)),
                  ]),
                  const SizedBox(height: 40),
                  // Hero illustration
                  Center(
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Center(
                        child: Icon(Icons.location_city_rounded,
                            size: 80, color: AppColors.primary.withOpacity(0.6)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text('Navigate your\ncity smarter',
                      style: AppTextStyles.displayLg),
                  const SizedBox(height: 12),
                  Text(
                    'Offline maps, multimodal routing, and safety tools — designed for Indian cities.',
                    style: AppTextStyles.bodyMuted,
                  ),
                  const SizedBox(height: 32),
                  // Language selector
                  Text('CHOOSE LANGUAGE', style: AppTextStyles.label),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8, runSpacing: 8,
                    children: _langs.map((lang) {
                      final sel = _selectedLang == lang['code'];
                      return GestureDetector(
                        onTap: () =>
                            setState(() => _selectedLang = lang['code']!),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 10),
                          decoration: BoxDecoration(
                            color: sel ? AppColors.primary : AppColors.surface,
                            borderRadius: BorderRadius.circular(AppRadius.pill),
                            border: Border.all(
                              color: sel
                                  ? AppColors.primary
                                  : AppColors.border,
                              width: 1.5,
                            ),
                          ),
                          child: Text(
                            lang['label']!,
                            style: TextStyle(
                              fontFamily: 'DMSans',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: sel
                                  ? Colors.white
                                  : AppColors.textPrimary,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const Spacer(),
                  // CTA
                  _PrimaryBtn(
                    label: 'Get Started',
                    onTap: () => context.go(AppRoutes.featureTour),
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: TextButton(
                      onPressed: () => context.go(AppRoutes.featureTour),
                      child: Text('Skip intro',
                          style: AppTextStyles.bodySm
                              .copyWith(color: AppColors.textSecondary)),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PrimaryBtn extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _PrimaryBtn({required this.label, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity, height: 52,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.primary, AppColors.indigo700],
          ),
          borderRadius: BorderRadius.circular(AppRadius.md),
          boxShadow: AppShadows.card,
        ),
        alignment: Alignment.center,
        child: Text('Get Started',
            style: AppTextStyles.btnLabel.copyWith(color: Colors.white)),
      ),
    );
  }
}