import 'package:flutter/material.dart';
import '../../core/theme/theme_exports.dart';

class LoadingScreen extends StatefulWidget {
  final String? message;
  const LoadingScreen({super.key, this.message});
  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(width: 100, height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.borderSubtle, width: 1.5),
                    )),
                RotationTransition(
                  turns: _ctrl,
                  child: SizedBox(width: 88, height: 88,
                    child: CustomPaint(painter: _ArcPainter())),
                ),
                Container(
                  width: 52, height: 52,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.primary, AppColors.indigo700],
                      begin: Alignment.topLeft, end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: AppShadows.card,
                  ),
                  child: const Icon(Icons.explore_rounded, color: Colors.white, size: 28),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Text('CityNav', style: AppTextStyles.heading.copyWith(color: AppColors.primary)),
            const SizedBox(height: 8),
            Text(widget.message ?? 'Loading…',
                style: AppTextStyles.bodySm.copyWith(color: AppColors.textSecondary)),
            const SizedBox(height: 24),
            SizedBox(
              width: 160,
              child: LinearProgressIndicator(
                backgroundColor: AppColors.borderSubtle,
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromLTWH(0, 0, size.width, size.height),
      -0.5, 2.5, false, paint,
    );
  }
  @override
  bool shouldRepaint(_) => false;
}