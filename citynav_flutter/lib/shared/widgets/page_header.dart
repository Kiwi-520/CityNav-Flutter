import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/theme_exports.dart';

class PageHeader extends StatelessWidget {
  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;
  final bool showBack;
  final Widget? trailing;

  const PageHeader({
    super.key,
    required this.title,
    this.actionLabel,
    this.onAction,
    this.showBack = true,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      decoration: const BoxDecoration(
        color: AppColors.surfaceOverlay,
        border: Border(
          bottom: BorderSide(color: AppColors.borderSubtle, width: 1),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            if (showBack) ...[
              _BackBtn(onTap: () => context.pop()),
              const SizedBox(width: 12),
            ],
            Expanded(
              child: Text(title, style: AppTextStyles.title),
            ),
            if (actionLabel != null)
              GestureDetector(
                onTap: onAction,
                child: Text(actionLabel!,
                    style: AppTextStyles.bodySemibold
                        .copyWith(color: AppColors.primary)),
              ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}

class _BackBtn extends StatelessWidget {
  final VoidCallback onTap;
  const _BackBtn({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38, height: 38,
        decoration: BoxDecoration(
          color: AppColors.bgSubtle,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: AppColors.border),
        ),
        child: const Icon(Icons.arrow_back_ios_new_rounded,
            size: 16, color: AppColors.textPrimary),
      ),
    );
  }
}