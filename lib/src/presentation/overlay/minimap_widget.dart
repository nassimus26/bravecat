import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class MiniMapWidget extends StatelessWidget {
  final Offset miloPos;
  final List<Offset> enemies;
  final Offset dojoPos;
  final Offset clinicPos;

  const MiniMapWidget({
    super.key,
    required this.miloPos,
    required this.enemies,
    required this.dojoPos,
    required this.clinicPos,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 110,
      decoration: BoxDecoration(
        color: Colors.black87,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.accentGold, width: 2),
        boxShadow: const [BoxShadow(color: Colors.black54, blurRadius: 6)],
      ),
      child: ClipOval(
        child: CustomPaint(
          painter: _MiniMapPainter(
            miloPos: miloPos,
            enemies: enemies,
            dojoPos: dojoPos,
            clinicPos: clinicPos,
          ),
        ),
      ),
    );
  }
}

class _MiniMapPainter extends CustomPainter {
  final Offset miloPos;
  final List<Offset> enemies;
  final Offset dojoPos;
  final Offset clinicPos;

  _MiniMapPainter({
    required this.miloPos,
    required this.enemies,
    required this.dojoPos,
    required this.clinicPos,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    const double scale = 0.08;

    // 1. Draw Dojo Icon
    Offset dojoMapPt = center + (dojoPos - miloPos) * scale;
    canvas.drawCircle(dojoMapPt, 4, Paint()..color = Colors.brown);

    // 2. Draw Clinic Icon
    Offset clinicMapPt = center + (clinicPos - miloPos) * scale;
    canvas.drawCircle(clinicMapPt, 4, Paint()..color = Colors.teal);

    // 3. Draw Enemies
    for (var enemy in enemies) {
      Offset enemyMapPt = center + (enemy - miloPos) * scale;
      canvas.drawCircle(enemyMapPt, 3, Paint()..color = Colors.redAccent);
    }

    // 4. Draw Milo Player Center Icon
    canvas.drawCircle(center, 5, Paint()..color = AppColors.accentGold);
    canvas.drawCircle(center, 2, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
