import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/theme_exports.dart';
import '../../../core/router/app_router.dart';
import '../../../core/providers/app_providers.dart';

enum _PermState { idle, loading, success, error }

class LocationPermissionScreen extends ConsumerStatefulWidget {
  const LocationPermissionScreen({super.key});
  @override
  ConsumerState<LocationPermissionScreen> createState() =>
      _LocationPermissionScreenState();
}

class _LocationPermissionScreenState
    extends ConsumerState<LocationPermissionScreen> {
  _PermState _state = _PermState.idle;

  Future<void> _requestPermission() async {
    setState(() => _state = _PermState.loading);
    final notifier = ref.read(userLocationProvider.notifier);
    await notifier.fetchLocation();
    final loc = ref.read(userLocationProvider);
    loc.when(
      data: (pos) => setState(
          () => _state = pos != null ? _PermState.success : _PermState.error),
      loading: () {},
      error: (_, __) => setState(() => _state = _PermState.error),
    );
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
              const SizedBox(height: 48),
              Text('Enable Location', style: AppTextStyles.displayLg),
              const SizedBox(height: 12),
              Text(
                'CityNav needs your location to find nearby transit, detect your city, and personalise routes.',
                style: AppTextStyles.bodyMuted,
              ),
              const SizedBox(height: 48),
              Center(child: _StateIllustration(state: _state)),
              const SizedBox(height: 32),
              Center(child: _StateMessage(state: _state)),
              const Spacer(),
              if (_state != _PermState.success)
                GestureDetector(
                  onTap: _state == _PermState.loading
                      ? null
                      : _requestPermission,
                  child: Container(
                    width: double.infinity, height: 52,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [AppColors.primary, AppColors.indigo700]),
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      boxShadow: AppShadows.card,
                    ),
                    alignment: Alignment.center,
                    child: _state == _PermState.loading
                        ? const SizedBox(
                            width: 22, height: 22,
                            child: CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 2.5))
                        : Text(
                            _state == _PermState.error
                                ? 'Try Again'
                                : 'Allow Location',
                            style: AppTextStyles.btnLabel
                                .copyWith(color: Colors.white),
                          ),
                  ),
                )
              else
                GestureDetector(
                  onTap: () => context.go(AppRoutes.setupComplete),
                  child: Container(
                    width: double.infinity, height: 52,
                    decoration: BoxDecoration(
                      color: AppColors.success,
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      boxShadow: AppShadows.card,
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.check_circle_rounded,
                            color: Colors.white, size: 20),
                        const SizedBox(width: 8),
                        Text('Continue',
                            style: AppTextStyles.btnLabel
                                .copyWith(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _StateIllustration extends StatelessWidget {
  final _PermState state;
  const _StateIllustration({required this.state});

  @override
  Widget build(BuildContext context) {
    IconData icon;
    Color color, bg;
    switch (state) {
      case _PermState.idle:
        icon = Icons.location_on_outlined; color = AppColors.primary;
        bg = AppColors.primaryLight; break;
      case _PermState.loading:
        icon = Icons.my_location_rounded; color = AppColors.accent;
        bg = AppColors.accentLight; break;
      case _PermState.success:
        icon = Icons.check_circle_rounded; color = AppColors.success;
        bg = AppColors.successLight; break;
      case _PermState.error:
        icon = Icons.location_off_outlined; color = AppColors.danger;
        bg = AppColors.dangerLight; break;
    }
    return Container(
      width: 130, height: 130,
      decoration: BoxDecoration(color: bg,
          borderRadius: BorderRadius.circular(32)),
      child: state == _PermState.loading
          ? Padding(
              padding: const EdgeInsets.all(36),
              child: CircularProgressIndicator(color: color, strokeWidth: 3))
          : Icon(icon, size: 64, color: color),
    );
  }
}

class _StateMessage extends StatelessWidget {
  final _PermState state;
  const _StateMessage({required this.state});

  @override
  Widget build(BuildContext context) {
    String msg;
    switch (state) {
      case _PermState.idle:
        msg = 'Tap below to allow location access'; break;
      case _PermState.loading:
        msg = 'Detecting your location…'; break;
      case _PermState.success:
        msg = 'Location detected! Ready to navigate.'; break;
      case _PermState.error:
        msg = 'Could not get location. Check your settings.'; break;
    }
    return Text(msg, style: AppTextStyles.bodyMuted, textAlign: TextAlign.center);
  }
}