import 'package:flutter/material.dart';
import '../../core/theme/theme_exports.dart';

class CnTextField extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final IconData? prefixIcon;
  final Widget? suffixWidget;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final TextInputAction? textInputAction;
  final VoidCallback? onEditingComplete;

  const CnTextField({
    super.key,
    required this.label,
    required this.hint,
    this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.suffixWidget,
    this.errorText,
    this.onChanged,
    this.textInputAction,
    this.onEditingComplete,
  });

  @override
  State<CnTextField> createState() => _CnTextFieldState();
}

class _CnTextFieldState extends State<CnTextField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    final isPassword = widget.obscureText;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label.toUpperCase(),
          style: AppTextStyles.label,
        ),
        const SizedBox(height: AppSpacing.s2),
        TextField(
          controller: widget.controller,
          obscureText: isPassword && _obscure,
          keyboardType: widget.keyboardType,
          onChanged: widget.onChanged,
          textInputAction: widget.textInputAction,
          onEditingComplete: widget.onEditingComplete,
          style: AppTextStyles.bodyMedium,
          decoration: InputDecoration(
            hintText: widget.hint,
            errorText: widget.errorText,
            prefixIcon: widget.prefixIcon != null
                ? Icon(widget.prefixIcon,
                    color: AppColors.textTertiary, size: 20)
                : null,
            suffixIcon: isPassword
                ? GestureDetector(
                    onTap: () => setState(() => _obscure = !_obscure),
                    child: Icon(
                      _obscure
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppColors.textSecondary,
                      size: 20,
                    ),
                  )
                : widget.suffixWidget,
          ),
        ),
      ],
    );
  }
}