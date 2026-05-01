import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/theme_exports.dart';
import '../../../core/router/app_router.dart';

class SetupCompleteScreen extends StatefulWidget {
  const SetupCompleteScreen({super.key});
  @override
  State<SetupCompleteScreen> createState() => _SetupCompleteScreenState();
}

class _SetupCompleteScreenState extends State<SetupCompleteScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _scale = CurvedAnimation(parent: _ctrl, curve: Curves.elasticOut);
    _ctrl.forward();
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              ScaleTransition(
                scale: _scale,
                child: Container(
                  width: 120, height: 120,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.primary, AppColors.indigo700],
                      begin: Alignment.topLeft, end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(36),
                    boxShadow: AppShadows.cardLg,
                  ),
                  child: const Icon(Icons.check_rounded,
                      color: Colors.white, size: 60),
                ),
              ),
              const SizedBox(height: 32),
              Text('You\'re all set!', style: AppTextStyles.displayLg,
                  textAlign: TextAlign.center),
              const SizedBox(height: 12),
              Text(
                "CityNav is ready. Mumbai's transit, safety, and city data loaded.",
                style: AppTextStyles.bodyMuted,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              // City badge
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.location_city_rounded,
                        color: AppColors.primary, size: 20),
                    const SizedBox(width: 8),
                    Text('Mumbai, Maharashtra',
                        style: AppTextStyles.bodySemibold
                            .copyWith(color: AppColors.primary)),
                  ],
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => context.go(AppRoutes.home),
                child: Container(
                  width: double.infinity, height: 52,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [AppColors.primary, AppColors.indigo700]),
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    boxShadow: AppShadows.card,
                  ),
                  alignment: Alignment.center,
                  child: Text('Go to Dashboard',
                      style: AppTextStyles.btnLabel
                          .copyWith(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () => context.go(AppRoutes.map),
                icon: const Icon(Icons.map_rounded),
                label: const Text('Explore Map'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(52),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}