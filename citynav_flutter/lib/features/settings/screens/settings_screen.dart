import 'package:flutter/material.dart';
import '../../../core/theme/theme_exports.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _pushNotifs    = true;
  bool _trafficAlerts = true;
  bool _transitAlerts = true;
  bool _promotions    = false;
  bool _avoidTolls    = true;
  bool _shareLocation = false;
  bool _analytics     = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              decoration: const BoxDecoration(
                color: AppColors.surface,
                border: Border(
                    bottom: BorderSide(color: AppColors.border, width: 1)),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 38, height: 38,
                      decoration: BoxDecoration(
                        color: AppColors.bgSubtle,
                        borderRadius: BorderRadius.circular(AppRadius.md),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: const Icon(Icons.arrow_back_ios_new_rounded, size: 16),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text('Settings', style: AppTextStyles.title),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  _SettingsGroup(title: 'Navigation', rows: [
                    _ToggleRow(label: 'Avoid toll roads',
                        subtitle: 'Route calculation',
                        icon: Icons.toll_rounded,
                        value: _avoidTolls,
                        onChanged: (v) => setState(() => _avoidTolls = v)),
                    _SelectRow(label: 'Default map view',
                        icon: Icons.map_outlined, value: 'Standard'),
                    _SelectRow(label: 'Preferred transport',
                        icon: Icons.directions_bus_rounded, value: 'Metro + Walk'),
                  ]),
                  const SizedBox(height: 16),
                  _SettingsGroup(title: 'Notifications', rows: [
                    _ToggleRow(label: 'Push notifications',
                        icon: Icons.notifications_outlined,
                        value: _pushNotifs,
                        onChanged: (v) => setState(() => _pushNotifs = v)),
                    _ToggleRow(label: 'Traffic alerts',
                        icon: Icons.traffic_rounded,
                        value: _trafficAlerts,
                        onChanged: (v) => setState(() => _trafficAlerts = v)),
                    _ToggleRow(label: 'Transit updates',
                        icon: Icons.subway_rounded,
                        value: _transitAlerts,
                        onChanged: (v) => setState(() => _transitAlerts = v)),
                    _ToggleRow(label: 'Promotions',
                        icon: Icons.campaign_outlined,
                        value: _promotions,
                        onChanged: (v) => setState(() => _promotions = v)),
                  ]),
                  const SizedBox(height: 16),
                  _SettingsGroup(title: 'Privacy', rows: [
                    _ToggleRow(label: 'Share location',
                      subtitle: 'With trusted contacts',
                      icon: Icons.location_on_outlined,
                        value: _shareLocation,
                        onChanged: (v) => setState(() => _shareLocation = v)),
                    _ToggleRow(label: 'Usage analytics',
                        subtitle: 'Help improve CityNav',
                        icon: Icons.analytics_outlined,
                        value: _analytics,
                        onChanged: (v) => setState(() => _analytics = v)),
                  ]),
                  const SizedBox(height: 16),
                  _SettingsGroup(title: 'Danger Zone', rows: [
                    _ActionRow(label: 'Clear cache & data',
                        icon: Icons.delete_outline_rounded,
                        textColor: AppColors.danger,
                        onTap: () {}),
                  ]),
                  const SizedBox(height: 32),
                  Center(
                    child: Column(
                      children: [
                        Text('CityNav v1.0.0',
                            style: AppTextStyles.caption),
                        Text('Build 20240101 · India Edition',
                            style: AppTextStyles.caption
                                .copyWith(color: AppColors.textTertiary)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsGroup extends StatelessWidget {
  final String title;
  final List<Widget> rows;
  const _SettingsGroup({required this.title, required this.rows});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title.toUpperCase(), style: AppTextStyles.label),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(color: AppColors.border),
            boxShadow: AppShadows.card,
          ),
          child: Column(
            children: rows.asMap().entries.map((e) => Column(
              children: [
                if (e.key > 0)
                  const Divider(height: 1, color: AppColors.borderSubtle),
                e.value,
              ],
            )).toList(),
          ),
        ),
      ],
    );
  }
}

class _ToggleRow extends StatelessWidget {
  final String label;
  final String? subtitle;
  final IconData icon;
  final bool value;
  final ValueChanged<bool> onChanged;
  const _ToggleRow({required this.label, this.subtitle,
      required this.icon, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 34, height: 34,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: Icon(icon, size: 16, color: AppColors.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppTextStyles.bodyMedium),
                if (subtitle != null)
                  Text(subtitle!, style: AppTextStyles.caption),
              ],
            ),
          ),
          Switch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}

class _SelectRow extends StatelessWidget {
  final String label, value;
  final IconData icon;
  const _SelectRow({required this.label, required this.icon, required this.value});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 34, height: 34,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: Icon(icon, size: 16, color: AppColors.primary),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(label, style: AppTextStyles.bodyMedium)),
          Text(value, style: AppTextStyles.bodySm
              .copyWith(color: AppColors.textSecondary)),
          const SizedBox(width: 4),
          const Icon(Icons.chevron_right_rounded,
              size: 18, color: AppColors.textSecondary),
        ],
      ),
    );
  }
}

class _ActionRow extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color? textColor;
  final VoidCallback onTap;
  const _ActionRow({required this.label, required this.icon,
      this.textColor, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 34, height: 34,
              decoration: BoxDecoration(
                color: AppColors.dangerLight,
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: Icon(icon, size: 16, color: AppColors.danger),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(label,
                  style: AppTextStyles.bodyMedium.copyWith(
                      color: textColor ?? AppColors.textPrimary)),
            ),
            const Icon(Icons.chevron_right_rounded,
                size: 18, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}