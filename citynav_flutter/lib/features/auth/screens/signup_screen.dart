import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/theme_exports.dart';
import '../../../core/router/app_router.dart';
import '../../../shared/widgets/cn_text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _firstCtrl  = TextEditingController();
  final _lastCtrl   = TextEditingController();
  final _emailCtrl  = TextEditingController();
  final _phoneCtrl  = TextEditingController();
  final _passCtrl   = TextEditingController();
  bool _agreed = false;
  bool _loading = false;
  int _strength = 0;

  void _onPasswordChanged(String v) {
    int s = 0;
    if (v.length >= 8) s++;
    if (v.contains(RegExp(r'[A-Z]'))) s++;
    if (v.contains(RegExp(r'[0-9]'))) s++;
    if (v.contains(RegExp(r'[!@#\$%^&*]'))) s++;
    setState(() => _strength = s);
  }

  Color _strengthColor(int i) {
    if (_strength == 0) return AppColors.border;
    if (i >= _strength) return AppColors.border;
    if (_strength == 1) return AppColors.danger;
    if (_strength == 2) return AppColors.warning;
    if (_strength == 3) return AppColors.warning;
    return AppColors.success;
  }

  @override
  void dispose() {
    _firstCtrl.dispose(); _lastCtrl.dispose(); _emailCtrl.dispose();
    _phoneCtrl.dispose(); _passCtrl.dispose(); super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
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
              const SizedBox(height: 24),
              Text('Create\naccount ✨', style: AppTextStyles.displayLg),
              const SizedBox(height: 8),
              Text('Join CityNav and start navigating smarter.',
                  style: AppTextStyles.bodyMuted),
              const SizedBox(height: 28),
              Row(children: [
                Expanded(
                  child: CnTextField(
                    label: 'First name', hint: 'Priya',
                    controller: _firstCtrl,
                    prefixIcon: Icons.person_outline_rounded,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CnTextField(
                    label: 'Last name', hint: 'Sharma',
                    controller: _lastCtrl,
                  ),
                ),
              ]),
              const SizedBox(height: 16),
              CnTextField(
                label: 'Email address', hint: 'priya@example.com',
                controller: _emailCtrl,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icons.mail_outline_rounded,
              ),
              const SizedBox(height: 16),
              CnTextField(
                label: 'Mobile number', hint: '98765 43210',
                controller: _phoneCtrl,
                keyboardType: TextInputType.phone,
                prefixIcon: Icons.phone_outlined,
              ),
              const SizedBox(height: 16),
              CnTextField(
                label: 'Password', hint: 'Min. 8 characters',
                controller: _passCtrl,
                obscureText: true,
                prefixIcon: Icons.lock_outline_rounded,
                onChanged: _onPasswordChanged,
              ),
              const SizedBox(height: 8),
              Row(
                children: List.generate(4, (i) => Expanded(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: 3,
                    margin: EdgeInsets.only(right: i < 3 ? 4 : 0),
                    decoration: BoxDecoration(
                      color: _strengthColor(i + 1),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                )),
              ),
              const SizedBox(height: 20),
              // Terms
              GestureDetector(
                onTap: () => setState(() => _agreed = !_agreed),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      width: 22, height: 22,
                      decoration: BoxDecoration(
                        color: _agreed
                            ? AppColors.primary
                            : AppColors.surface,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: _agreed
                              ? AppColors.primary
                              : AppColors.border,
                          width: 1.5,
                        ),
                      ),
                      child: _agreed
                          ? const Icon(Icons.check_rounded,
                              color: Colors.white, size: 14)
                          : null,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'I agree to CityNav\'s Terms of Service and Privacy Policy.',
                        style: AppTextStyles.bodySm
                            .copyWith(color: AppColors.textSecondary),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: _agreed && !_loading
                    ? () async {
                        setState(() => _loading = true);
                        await Future.delayed(const Duration(seconds: 1));
                        if (mounted) context.go(AppRoutes.verifyOtp);
                      }
                    : null,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: double.infinity, height: 52,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: _agreed
                          ? [AppColors.primary, AppColors.indigo700]
                          : [AppColors.indigo200, AppColors.indigo300],
                    ),
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    boxShadow: _agreed ? AppShadows.card : null,
                  ),
                  alignment: Alignment.center,
                  child: _loading
                      ? const SizedBox(width: 22, height: 22,
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2.5))
                      : Text('Create My Account',
                          style: AppTextStyles.btnLabel
                              .copyWith(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account? ',
                        style: AppTextStyles.bodySm
                            .copyWith(color: AppColors.textSecondary)),
                    GestureDetector(
                      onTap: () => context.go(AppRoutes.login),
                      child: Text('Sign in',
                          style: AppTextStyles.bodySm.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}