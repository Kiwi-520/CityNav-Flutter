import 'package:flutter/material.dart';
import '../../../core/theme/theme_exports.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});
  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  String _filter = 'All';
  static const _filters = ['All', 'Traffic', 'Transit', 'Places', 'System'];

  static const _notifications = [
    _Notif(icon: Icons.traffic_rounded, iconColor: AppColors.primary,
        iconBg: AppColors.primaryLight,
        title: 'Heavy traffic on Western Expressway',
        body: 'Andheri–Bandra stretch delayed by 22 min. Alternative via SV Rd.',
        time: '2 min ago', isUnread: true, unreadColor: AppColors.primary,
        category: 'Traffic',
        actions: ['Reroute', 'Dismiss']),
    _Notif(icon: Icons.subway_rounded, iconColor: AppColors.success,
        iconBg: AppColors.successLight,
        title: 'Metro Line 2A — Service restored',
        body: 'Normal operations resumed after signal fault at DN Nagar.',
        time: '18 min ago', isUnread: true, unreadColor: AppColors.success,
        category: 'Transit', actions: []),
    _Notif(icon: Icons.emoji_events_rounded, iconColor: AppColors.accent,
        iconBg: AppColors.accentLight,
        title: 'You unlocked "City Explorer" badge!',
        body: 'Navigated 10 unique Mumbai neighbourhoods. Keep exploring!',
        time: '1 hr ago', isUnread: true, unreadColor: AppColors.accent,
        category: 'System', actions: []),
    _Notif(icon: Icons.warning_amber_rounded, iconColor: AppColors.danger,
        iconBg: AppColors.dangerLight,
        title: 'Road closure: Linking Road',
        body: 'Bandra market area closed until 6 PM for civic works.',
        time: '2 hr ago', isUnread: false, unreadColor: AppColors.danger,
        category: 'Traffic', actions: ['View map']),
    _Notif(icon: Icons.location_on_rounded, iconColor: AppColors.primary,
        iconBg: AppColors.primaryLight,
        title: 'New place saved — Juhu Beach',
        body: 'Tap to set as favourite or add a reminder.',
        time: 'Yesterday, 7:32 PM', isUnread: false,
        unreadColor: AppColors.primary, category: 'Places', actions: []),
  ];

  List<_Notif> get _filtered => _filter == 'All'
      ? _notifications
      : _notifications.where((n) => n.category == _filter).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          children: [
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
                  Expanded(
                      child: Text('Notifications', style: AppTextStyles.title)),
                  TextButton(
                    onPressed: () => setState(() {}),
                    child: Text('Mark all read',
                        style: AppTextStyles.bodySm
                            .copyWith(color: AppColors.primary)),
                  ),
                ],
              ),
            ),
            // Filter chips
            Container(
              color: AppColors.surface,
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _filters.map((f) {
                    final active = f == _filter;
                    return GestureDetector(
                      onTap: () => setState(() => _filter = f),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 7),
                        decoration: BoxDecoration(
                          color: active
                              ? AppColors.primaryLight
                              : AppColors.bgSubtle,
                          borderRadius: BorderRadius.circular(AppRadius.pill),
                          border: Border.all(
                            color: active ? AppColors.primary : AppColors.border,
                          ),
                        ),
                        child: Text(f,
                            style: TextStyle(
                              fontFamily: 'DMSans', fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: active
                                  ? AppColors.primary
                                  : AppColors.textPrimary,
                            )),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: _filtered.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (ctx, i) => _NotifCard(notif: _filtered[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotifCard extends StatelessWidget {
  final _Notif notif;
  const _NotifCard({required this.notif});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border(
          left: notif.isUnread
              ? BorderSide(color: notif.unreadColor, width: 3)
              : BorderSide(color: AppColors.border, width: 1),
          top: const BorderSide(color: AppColors.border, width: 1),
          right: const BorderSide(color: AppColors.border, width: 1),
          bottom: const BorderSide(color: AppColors.border, width: 1),
        ),
        boxShadow: AppShadows.card,
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42, height: 42,
            decoration: BoxDecoration(
              color: notif.iconBg,
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Icon(notif.icon, size: 20, color: notif.iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(notif.title, style: AppTextStyles.bodySemibold,
                    maxLines: 2, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                Text(notif.body, style: AppTextStyles.caption,
                    maxLines: 2, overflow: TextOverflow.ellipsis),
                if (notif.actions.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Row(children: notif.actions.asMap().entries.map((e) {
                    final isPrimary = e.key == 0;
                    return Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(
                        color: isPrimary
                            ? AppColors.primaryLight
                            : AppColors.bgSubtle,
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                        border: Border.all(
                          color: isPrimary
                              ? AppColors.primary
                              : AppColors.border,
                        ),
                      ),
                      child: Text(e.value,
                          style: TextStyle(
                            fontFamily: 'DMSans', fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: isPrimary
                                ? AppColors.primary
                                : AppColors.textSecondary,
                          )),
                    );
                  }).toList()),
                ],
                const SizedBox(height: 6),
                Text(notif.time, style: AppTextStyles.caption
                    .copyWith(color: AppColors.textTertiary)),
              ],
            ),
          ),
          if (notif.isUnread)
            Container(
              width: 8, height: 8,
              margin: const EdgeInsets.only(top: 4),
              decoration: BoxDecoration(
                color: notif.unreadColor, shape: BoxShape.circle),
            ),
        ],
      ),
    );
  }
}

class _Notif {
  final IconData icon;
  final Color iconColor, iconBg, unreadColor;
  final String title, body, time, category;
  final bool isUnread;
  final List<String> actions;
  const _Notif({
    required this.icon, required this.iconColor, required this.iconBg,
    required this.title, required this.body, required this.time,
    required this.isUnread, required this.unreadColor, required this.category,
    required this.actions,
  });
}