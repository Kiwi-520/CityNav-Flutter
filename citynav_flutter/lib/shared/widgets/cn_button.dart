import 'package:flutter/material.dart';
import '../../core/theme/theme_exports.dart';

enum CnButtonVariant { primary, secondary, ghost, accent, danger }
enum CnButtonSize { sm, md, lg }

class CnButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final CnButtonVariant variant;
  final CnButtonSize size;
  final IconData? icon;
  final bool loading;
  final bool fullWidth;

  const CnButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = CnButtonVariant.primary,
    this.size = CnButtonSize.md,
    this.icon,
    this.loading = false,
    this.fullWidth = true,
  });

  @override
  State<CnButton> createState() => _CnButtonState();
}

class _CnButtonState extends State<CnButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 120),
        lowerBound: 0, upperBound: 0.03);
    _scale = Tween<double>(begin: 1.0, end: 0.97).animate(
        CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  Color get _bg {
    switch (widget.variant) {
      case CnButtonVariant.primary:   return AppColors.primary;
      case CnButtonVariant.secondary: return AppColors.surface;
      case CnButtonVariant.ghost:     return AppColors.primaryLight;
      case CnButtonVariant.accent:    return AppColors.accent;
      case CnButtonVariant.danger:    return AppColors.danger;
    }
  }

  Color get _fg {
    switch (widget.variant) {
      case CnButtonVariant.primary:   return Colors.white;
      case CnButtonVariant.secondary: return AppColors.textPrimary;
      case CnButtonVariant.ghost:     return AppColors.primary;
      case CnButtonVariant.accent:    return Colors.white;
      case CnButtonVariant.danger:    return Colors.white;
    }
  }

  Border? get _border {
    if (widget.variant == CnButtonVariant.secondary ||
        widget.variant == CnButtonVariant.ghost) {
      return Border.all(color: AppColors.border, width: 1.5);
    }
    return null;
  }

  double get _height {
    switch (widget.size) {
      case CnButtonSize.sm: return 38;
      case CnButtonSize.md: return 50;
      case CnButtonSize.lg: return 56;
    }
  }

  double get _fontSize {
    switch (widget.size) {
      case CnButtonSize.sm: return 13;
      case CnButtonSize.md: return 15;
      case CnButtonSize.lg: return 16;
    }
  }

  @override
  Widget build(BuildContext context) {
    final disabled = widget.onPressed == null || widget.loading;
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) => _ctrl.reverse(),
      onTapCancel: () => _ctrl.reverse(),
      onTap: disabled ? null : widget.onPressed,
      child: ScaleTransition(
        scale: _scale,
        child: AnimatedOpacity(
          opacity: disabled ? 0.6 : 1.0,
          duration: const Duration(milliseconds: 150),
          child: Container(
            height: _height,
            width: widget.fullWidth ? double.infinity : null,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: _bg,
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: _border,
              boxShadow: widget.variant == CnButtonVariant.primary
                  ? AppShadows.card : null,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: widget.fullWidth ? MainAxisSize.max : MainAxisSize.min,
              children: [
                if (widget.loading)
                  SizedBox(width: 18, height: 18,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: _fg))
                else if (widget.icon != null) ...[
                  Icon(widget.icon, size: 18, color: _fg),
                  const SizedBox(width: 8),
                ],
                Text(widget.label,
                    style: TextStyle(
                      fontFamily: 'Syne', fontSize: _fontSize,
                      fontWeight: FontWeight.w700, color: _fg,
                      letterSpacing: 0.3,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}