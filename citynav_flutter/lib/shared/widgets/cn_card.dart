import 'package:flutter/material.dart';
import '../../core/theme/theme_exports.dart';

class CnCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final bool tinted;

  const CnCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.backgroundColor,
    this.tinted = false,
  });

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ??
        (tinted ? AppColors.surfaceTinted : AppColors.surface);
    final borderColor =
        tinted ? AppColors.borderSubtle : AppColors.border;

    Widget card = Container(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: borderColor, width: 1),
        boxShadow: tinted ? null : AppShadows.card,
      ),
      padding: padding ?? const EdgeInsets.all(AppSpacing.s4),
      child: child,
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: card,
      );
    }
    return card;
  }
}