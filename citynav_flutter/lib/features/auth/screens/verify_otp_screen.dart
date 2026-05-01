import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/theme_exports.dart';
import '../../../core/router/app_router.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key});
  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final List<TextEditingController> _ctrls =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());
  int _resendSeconds = 60;
  Timer? _timer;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => _focusNodes[0].requestFocus());
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_resendSeconds == 0) { t.cancel(); return; }
      setState(() => _resendSeconds--);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var c in _ctrls) c.dispose();
    for (var f in _focusNodes) f.dispose();
    super.dispose();
  }

  String get _otp => _ctrls.map((c) => c.text).join();

  Future<void> _verify() async {
    if (_otp.length < 4) return;
    setState(() => _loading = true);
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) context.go(AppRoutes.setupComplete);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () => context.pop(),
                child: Container(
                  width: 38, height: 38,
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: const Icon(Icons.arrow_back_ios_new_rounded,
                      size: 16, color: AppColors.textPrimary),
                ),
              ),
              const SizedBox(height: 32),
              // Progress bar
              Row(children: List.generate(3, (i) => Expanded(
                child: Container(
                  height: 3,
                  margin: EdgeInsets.only(right: i < 2 ? 6 : 0),
                  decoration: BoxDecoration(
                    color: i < 2 ? AppColors.primary : AppColors.border,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ))),
              const SizedBox(height: 32),
              Text('Verify your\nphone 📲', style: AppTextStyles.displayLg),
              const SizedBox(height: 12),
              RichText(
                text: TextSpan(
                  style: AppTextStyles.bodyMuted,
                  children: const [
                    TextSpan(text: 'We sent a 4-digit OTP to '),
                    TextSpan(
                      text: '+91 98765 43210',
                      style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              // OTP boxes
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(4, (i) => _OtpBox(
                  controller: _ctrls[i],
                  focusNode: _focusNodes[i],
                  onChanged: (v) {
                    if (v.isNotEmpty && i < 3) {
                      _focusNodes[i + 1].requestFocus();
                    } else if (v.isEmpty && i > 0) {
                      _focusNodes[i - 1].requestFocus();
                    }
                    setState(() {});
                  },
                )),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _resendSeconds > 0
                        ? 'Resend in 00:${_resendSeconds.toString().padLeft(2, '0')}'
                        : 'Didn\'t receive it?',
                    style: AppTextStyles.caption,
                  ),
                  if (_resendSeconds == 0)
                    GestureDetector(
                      onTap: () {
                        setState(() => _resendSeconds = 60);
                        _startTimer();
                      },
                      child: Text('Resend OTP',
                          style: AppTextStyles.bodySm.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600)),
                    ),
                ],
              ),
              const Spacer(),
              GestureDetector(
                onTap: _loading ? null : _verify,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: double.infinity, height: 52,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: _otp.length == 4
                          ? [AppColors.primary, AppColors.indigo700]
                          : [AppColors.indigo200, AppColors.indigo300],
                    ),
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    boxShadow: _otp.length == 4 ? AppShadows.card : null,
                  ),
                  alignment: Alignment.center,
                  child: _loading
                      ? const SizedBox(width: 22, height: 22,
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2.5))
                      : Text('Verify & Continue',
                          style: AppTextStyles.btnLabel
                              .copyWith(color: Colors.white)),
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

class _OtpBox extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  const _OtpBox({
    required this.controller,
    required this.focusNode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 68, height: 68,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: onChanged,
        style: const TextStyle(
          fontFamily: 'Syne',
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: AppColors.primary,
        ),
        decoration: InputDecoration(
          counterText: '',
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
            borderSide: const BorderSide(color: AppColors.border, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
            borderSide:
                const BorderSide(color: AppColors.primary, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
            borderSide: const BorderSide(color: AppColors.border, width: 1.5),
          ),
          fillColor: controller.text.isNotEmpty
              ? AppColors.primaryLight
              : AppColors.surface,
          filled: true,
        ),
      ),
    );
  }
}