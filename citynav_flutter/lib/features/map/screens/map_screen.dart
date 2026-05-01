import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import '../../../core/theme/theme_exports.dart';
import '../../../core/providers/app_providers.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});
  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  final MapController _mapCtrl = MapController();
  static const _mumbai = LatLng(19.0760, 72.8777);
  LatLng _center = _mumbai;
  bool _locating = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [
          // ── OSM Map ──
          FlutterMap(
            mapController: _mapCtrl,
            options: MapOptions(
              initialCenter: _center,
              initialZoom: 13,
              maxZoom: 19,
              minZoom: 5,
              onMapReady: () {},
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.citynav.app',
                tileProvider: NetworkTileProvider(),
                maxZoom: 19,
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: _center,
                    width: 40,
                    height: 40,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                        boxShadow: AppShadows.card,
                      ),
                      child: const Icon(Icons.my_location_rounded,
                          color: Colors.white, size: 18),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // ── Top Header ──
          Positioned(
            top: 0, left: 0, right: 0,
            child: SafeArea(
              child: Container(
                margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.surfaceOverlay,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  border: Border.all(color: AppColors.border),
                  boxShadow: AppShadows.cardLg,
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search_rounded,
                        color: AppColors.textTertiary, size: 20),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text('Search places, addresses…',
                          style: AppTextStyles.body
                              .copyWith(color: AppColors.textTertiary)),
                    ),
                    const Icon(Icons.tune_rounded,
                        color: AppColors.textSecondary, size: 20),
                  ],
                ),
              ),
            ),
          ),

          // ── Map Controls ──
          Positioned(
            right: 16, bottom: 120,
            child: Column(
              children: [
                _MapBtn(
                  icon: Icons.add_rounded,
                  onTap: () => _mapCtrl.move(
                      _mapCtrl.camera.center,
                      _mapCtrl.camera.zoom + 1),
                ),
                const SizedBox(height: 8),
                _MapBtn(
                  icon: Icons.remove_rounded,
                  onTap: () => _mapCtrl.move(
                      _mapCtrl.camera.center,
                      _mapCtrl.camera.zoom - 1),
                ),
                const SizedBox(height: 8),
                _MapBtn(
                  icon: _locating
                      ? Icons.gps_fixed_rounded
                      : Icons.my_location_rounded,
                  color: _locating ? AppColors.primary : null,
                  onTap: _goToMyLocation,
                ),
              ],
            ),
          ),

          // ── Bottom Sheet ──
          Positioned(
            bottom: 0, left: 0, right: 0,
            child: Container(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 80),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppRadius.xl),
                border: Border.all(color: AppColors.border),
                boxShadow: AppShadows.cardLg,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(children: [
                    Container(
                      width: 4, height: 20,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text('Explore Mumbai',
                        style: AppTextStyles.title),
                  ]),
                  const SizedBox(height: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: const [
                        _FilterChip(label: 'All', active: true),
                        SizedBox(width: 8),
                        _FilterChip(label: 'ATMs'),
                        SizedBox(width: 8),
                        _FilterChip(label: 'Restrooms'),
                        SizedBox(width: 8),
                        _FilterChip(label: 'Pharmacies'),
                        SizedBox(width: 8),
                        _FilterChip(label: 'Water'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _goToMyLocation() async {
    setState(() => _locating = true);
    try {
      final pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      final latLng = LatLng(pos.latitude, pos.longitude);
      setState(() => _center = latLng);
      _mapCtrl.move(latLng, 15);
    } catch (_) {}
    setState(() => _locating = false);
  }
}

class _MapBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color? color;
  const _MapBtn({required this.icon, required this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44, height: 44,
        decoration: BoxDecoration(
          color: color != null ? color : AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: AppColors.border),
          boxShadow: AppShadows.card,
        ),
        child: Icon(icon,
            size: 20,
            color: color != null ? Colors.white : AppColors.textPrimary),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool active;
  const _FilterChip({required this.label, this.active = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: active ? AppColors.primary : AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(
            color: active ? AppColors.primary : AppColors.border),
      ),
      child: Text(label,
          style: TextStyle(
            fontFamily: 'DMSans',
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: active ? Colors.white : AppColors.textPrimary,
          )),
    );
  }
}