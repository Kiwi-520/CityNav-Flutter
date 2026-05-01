import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/theme_exports.dart';

class EssentialAppsScreen extends StatefulWidget {
  const EssentialAppsScreen({super.key});
  @override
  State<EssentialAppsScreen> createState() => _EssentialAppsScreenState();
}

class _EssentialAppsScreenState extends State<EssentialAppsScreen> {
  String _selectedCategory = 'All';

  static const _categories = ['All', 'Transit', 'Health', 'Utility', 'Safety'];
  static const _apps = [
    _App('🚌', 'BEST Buses', 'Track live bus locations in Mumbai',
        'Transit', AppColors.primary, AppColors.primaryLight),
    _App('🚇', 'Mumbai Metro', 'Metro schedules, fares & passes',
        'Transit', AppColors.primary, AppColors.primaryLight),
    _App('🚂', 'IRCTC Rail', 'Train booking & PNR status',
        'Transit', AppColors.success, AppColors.successLight),
    _App('🏥', 'BMC Health', 'Book govt. hospital appointments',
        'Health', AppColors.success, AppColors.successLight),
    _App('💊', '1mg Pharmacy', 'Order medicines online',
        'Health', AppColors.success, AppColors.successLight),
    _App('💡', 'Adani Power', 'Pay bills & report outages',
        'Utility', AppColors.accent, AppColors.accentLight),
    _App('💧', 'MCGM Water', 'Water supply info & complaints',
        'Utility', AppColors.accent, AppColors.accentLight),
    _App('🚨', 'Mumbai Police', 'Emergency & complaint portal',
        'Safety', AppColors.danger, AppColors.dangerLight),
    _App('🆘', 'NDRF Alert', 'National disaster response info',
        'Safety', AppColors.danger, AppColors.dangerLight),
  ];

  List<_App> get _filteredApps => _selectedCategory == 'All'
      ? _apps
      : _apps.where((a) => a.category == _selectedCategory).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('City Apps', style: AppTextStyles.heading),
                  Text('Essential apps for Mumbai',
                      style: AppTextStyles.bodyMuted),
                  const SizedBox(height: 16),
                  // Category filter
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _categories.map((cat) {
                        final active = cat == _selectedCategory;
                        return GestureDetector(
                          onTap: () =>
                              setState(() => _selectedCategory = cat),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 180),
                            margin: const EdgeInsets.only(right: 8),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: active
                                  ? AppColors.primary
                                  : AppColors.surface,
                              borderRadius:
                                  BorderRadius.circular(AppRadius.pill),
                              border: Border.all(
                                color: active
                                    ? AppColors.primary
                                    : AppColors.border,
                              ),
                            ),
                            child: Text(cat,
                                style: TextStyle(
                                  fontFamily: 'DMSans',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: active
                                      ? Colors.white
                                      : AppColors.textPrimary,
                                )),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Apps grid
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.88,
                ),
                itemCount: _filteredApps.length,
                itemBuilder: (ctx, i) => _AppCard(app: _filteredApps[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AppCard extends StatelessWidget {
  final _App app;
  const _AppCard({required this.app});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(color: AppColors.border),
          boxShadow: AppShadows.card,
        ),
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(app.emoji, style: const TextStyle(fontSize: 30)),
            const SizedBox(height: 10),
            Text(app.name,
                style: AppTextStyles.bodySemibold, maxLines: 1,
                overflow: TextOverflow.ellipsis),
            const SizedBox(height: 4),
            Expanded(
              child: Text(app.desc,
                  style: AppTextStyles.caption, maxLines: 3,
                  overflow: TextOverflow.ellipsis),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: app.tagBg,
                borderRadius: BorderRadius.circular(AppRadius.pill),
              ),
              child: Text(app.category,
                  style: AppTextStyles.caption
                      .copyWith(color: app.tagColor,
                          fontWeight: FontWeight.w700)),
            ),
          ],
        ),
      ),
    );
  }
}

class _App {
  final String emoji, name, desc, category;
  final Color tagColor, tagBg;
  const _App(this.emoji, this.name, this.desc, this.category,
      this.tagColor, this.tagBg);
}