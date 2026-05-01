import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/theme_exports.dart';
import '../../../core/router/app_router.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _ctrl = TextEditingController();
  final _focusNode = FocusNode();
  String _query = '';

  static const _recent = ['Andheri Station', 'BKC', 'Juhu Beach', 'Dadar'];
  static const _suggestions = [
    _Suggestion('🏛️', 'CSMT Railway Station', 'Fort, Mumbai', '3.2 km'),
    _Suggestion('🏥', 'Lilavati Hospital', 'Bandra, Mumbai', '4.1 km'),
    _Suggestion('🛒', 'Phoenix Palladium', 'Lower Parel, Mumbai', '5.8 km'),
    _Suggestion('🌊', 'Marine Drive', 'Churchgate, Mumbai', '8.2 km'),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => _focusNode.requestFocus());
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              color: AppColors.bg,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.go(AppRoutes.home),
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
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(AppRadius.lg),
                        border: Border.all(
                            color: AppColors.borderFocus, width: 1.5),
                      ),
                      child: TextField(
                        controller: _ctrl,
                        focusNode: _focusNode,
                        onChanged: (v) => setState(() => _query = v),
                        style: AppTextStyles.bodyMedium,
                        decoration: InputDecoration(
                          hintText: 'Search places, addresses…',
                          prefixIcon: const Icon(Icons.search_rounded,
                              size: 20, color: AppColors.textTertiary),
                          suffixIcon: _query.isNotEmpty
                              ? GestureDetector(
                                  onTap: () {
                                    _ctrl.clear();
                                    setState(() => _query = '');
                                  },
                                  child: const Icon(Icons.close_rounded,
                                      size: 18, color: AppColors.textSecondary),
                                )
                              : null,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 13),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  if (_query.isEmpty) ...[
                    const SizedBox(height: 8),
                    Text('RECENT SEARCHES', style: AppTextStyles.label),
                    const SizedBox(height: 8),
                    ..._recent.map((r) => _RecentItem(label: r,
                        onTap: () => setState(() {
                          _ctrl.text = r; _query = r;
                        }))),
                    const SizedBox(height: 16),
                    Text('SUGGESTED PLACES', style: AppTextStyles.label),
                    const SizedBox(height: 8),
                  ],
                  ..._suggestions
                      .where((s) => _query.isEmpty ||
                          s.name.toLowerCase().contains(_query.toLowerCase()))
                      .map((s) => _SuggestionItem(
                            suggestion: s,
                            onTap: () => context.go(AppRoutes.routeOptions),
                          )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RecentItem extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _RecentItem({required this.label, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            const Icon(Icons.history_rounded, size: 18, color: AppColors.textSecondary),
            const SizedBox(width: 12),
            Expanded(child: Text(label, style: AppTextStyles.bodyMedium)),
            const Icon(Icons.north_west_rounded, size: 16, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}

class _SuggestionItem extends StatelessWidget {
  final _Suggestion suggestion;
  final VoidCallback onTap;
  const _SuggestionItem({required this.suggestion, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(color: AppColors.border),
          boxShadow: AppShadows.card,
        ),
        child: Row(
          children: [
            Container(
              width: 44, height: 44,
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              child: Center(
                  child: Text(suggestion.emoji,
                      style: const TextStyle(fontSize: 22))),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(suggestion.name, style: AppTextStyles.bodySemibold),
                  Text(suggestion.address, style: AppTextStyles.caption),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(AppRadius.pill),
              ),
              child: Text(suggestion.distance,
                  style: AppTextStyles.caption.copyWith(
                      color: AppColors.primary, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }
}

class _Suggestion {
  final String emoji, name, address, distance;
  const _Suggestion(this.emoji, this.name, this.address, this.distance);
}