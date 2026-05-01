import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/theme_exports.dart';
import '../../../core/router/app_router.dart';
import '../../../shared/widgets/cn_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _emailCtrl.dispose(); _passCtrl.dispose(); super.dispose();
  }

  Future<void> _login() async {
    setState(() => _loading = true);
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() => _loading = false);
      context.go(AppRoutes.home);
    }
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
              const SizedBox(height: 48),
              Row(children: [
                Container(
                  width: 42, height: 42,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [AppColors.primary, AppColors.indigo700]),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: const Icon(Icons.explore_rounded,
                      color: Colors.white, size: 22),
                ),
                const SizedBox(width: 10),
                Text('CityNav',
                    style: AppTextStyles.subheading
                        .copyWith(color: AppColors.primary)),
              ]),
              const SizedBox(height: 36),
              Text('Welcome\nback 👋', style: AppTextStyles.displayLg),
              const SizedBox(height: 8),
              Text("Sign in to continue navigating your city.",
                  style: AppTextStyles.bodyMuted),
              const SizedBox(height: 32),
              // Social buttons
              Row(children: [
                Expanded(child: _SocialBtn(label: 'Google', icon: Icons.g_mobiledata_rounded)),
                const SizedBox(width: 12),
                Expanded(child: _SocialBtn(label: 'Apple', icon: Icons.apple_rounded)),
              ]),
              const SizedBox(height: 24),
              Row(children: [
                const Expanded(child: Divider(color: AppColors.border)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text('or sign in with email',
                      style: AppTextStyles.caption),
                ),
                const Expanded(child: Divider(color: AppColors.border)),
              ]),
              const SizedBox(height: 24),
              CnTextField(
                label: 'Email address',
                hint: 'priya@example.com',
                controller: _emailCtrl,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icons.mail_outline_rounded,
              ),
              const SizedBox(height: 16),
              CnTextField(
                label: 'Password',
                hint: '••••••••',
                controller: _passCtrl,
                obscureText: true,
                prefixIcon: Icons.lock_outline_rounded,
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text('Forgot password?',
                      style: AppTextStyles.bodySm
                          .copyWith(color: AppColors.primary)),
                ),
              ),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: _loading ? null : _login,
                child: Container(
                  width: double.infinity, height: 52,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [AppColors.primary, AppColors.indigo700]),
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    boxShadow: AppShadows.card,
                  ),
                  alignment: Alignment.center,
                  child: _loading
                      ? const SizedBox(width: 22, height: 22,
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2.5))
                      : Text('Sign In',
                          style: AppTextStyles.btnLabel
                              .copyWith(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("New to CityNav? ",
                        style: AppTextStyles.bodySm
                            .copyWith(color: AppColors.textSecondary)),
                    GestureDetector(
                      onTap: () => context.go(AppRoutes.signup),
                      child: Text('Create account',
                          style: AppTextStyles.bodySm.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
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

class _SocialBtn extends StatelessWidget {
  final String label;
  final IconData icon;
  const _SocialBtn({required this.label, required this.icon});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border, width: 1.5),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.textPrimary, size: 20),
          const SizedBox(width: 8),
          Text(label, style: AppTextStyles.bodyMedium),
        ],
      ),
    );
  }
}