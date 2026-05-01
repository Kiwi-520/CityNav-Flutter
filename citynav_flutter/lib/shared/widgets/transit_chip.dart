import 'package:flutter/material.dart';
import '../../core/theme/theme_exports.dart';

enum TransitMode { metro, bus, walk, taxi, auto }

class TransitChip extends StatelessWidget {
  final TransitMode mode;
  final String? duration;

  const TransitChip({super.key, required this.mode, this.duration});

  @override
  Widget build(BuildContext context) {
    Color bg, fg;
    IconData icon;
    String label;
    switch (mode) {
      case TransitMode.metro:
        bg = AppColors.transitMetroBg; fg = AppColors.transitMetro;
        icon = Icons.subway_rounded; label = 'Metro'; break;
      case TransitMode.bus:
        bg = AppColors.transitBusBg; fg = AppColors.transitBus;
        icon = Icons.directions_bus_rounded; label = 'Bus'; break;
      case TransitMode.walk:
        bg = AppColors.transitWalkBg; fg = AppColors.transitWalk;
        icon = Icons.directions_walk_rounded; label = 'Walk'; break;
      case TransitMode.taxi:
        bg = AppColors.transitTaxiBg; fg = AppColors.transitTaxi;
        icon = Icons.local_taxi_rounded; label = 'Taxi'; break;
      case TransitMode.auto:
        bg = AppColors.transitAutoBg; fg = AppColors.transitAuto;
        icon = Icons.electric_rickshaw_rounded; label = 'Auto'; break;
    }
    final displayLabel = duration != null ? "$label · $duration" : label;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: fg.withOpacity(0.3), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: fg),
          const SizedBox(width: 4),
          Text(displayLabel,
              style: TextStyle(
                fontFamily: 'DMSans',
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: fg,
              )),
        ],
      ),
    );
  }
}
