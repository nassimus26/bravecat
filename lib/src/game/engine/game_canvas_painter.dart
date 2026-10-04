import 'package:flutter/material.dart';
import '../entities/milo_hero.dart';
import '../entities/luna_companion.dart';
import '../entities/enemy_base.dart';
import 'engine_3d.dart';
import 'particle_system.dart';
import '../../core/constants/app_colors.dart';

class GameCanvasPainter extends CustomPainter {
  final MiloHero hero;
  final LunaCompanion luna;
  final List<EnemyBase> enemies;
  final List<Offset> crates;
  final ParticleSystem particleSystem;
  final int levelId;
  final double animTicks;

  GameCanvasPainter({
    required this.hero,
    required this.luna,
    required this.enemies,
    List<Offset>? crates,
    ParticleSystem? particleSystem,
    required this.levelId,
    this.animTicks = 0.0,
  })  : crates = crates ?? const [],
        particleSystem = particleSystem ?? ParticleSystem();

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Camera framing Milo perfectly in 3D center viewport
    Vector3D miloPos3D = Vector3D(hero.position.dx, 0, hero.position.dy);
    Camera3D camera = Camera3D(
      position: miloPos3D + Vector3D(0, 140, -320),
      pitch: 0.20,
      yaw: 0.0,
      fov: 420.0,
    );

    // 2. Render Sky & Sun
    _draw3DSky(canvas, size);

    // Collect 3D Faces for Depth Sorting
    List<Face3D> all3DFaces = [];

    // A. Ground Tiles
    _add3DSprawlingGroundGrid(all3DFaces, miloPos3D);

    // B. Dojo Pagoda
    _add3DBuilding(all3DFaces, Vector3D(-450, 0, 300), Colors.brown.shade800);
    _add3DTrees(all3DFaces, Vector3D(-320, 0, 250));
    _add3DTrees(all3DFaces, Vector3D(-580, 0, 250));

    // C. Village Houses
    _add3DHouse(all3DFaces, Vector3D(-150, 0, 500), Colors.blueGrey.shade800);
    _add3DHouse(all3DFaces, Vector3D(150, 0, 500), Colors.blueGrey.shade900);

    // D. Clinic District
    _add3DBuilding(all3DFaces, Vector3D(450, 0, 450), Colors.teal.shade800);
    _add3DTrees(all3DFaces, Vector3D(320, 0, 400));

    // E. Quarantine Gate
    _add3DGate(all3DFaces, Vector3D(800, 0, 700));

    // F. Crates
    for (var crate in crates) {
      Vector3D crate3D = Vector3D(crate.dx, 0, crate.dy);
      all3DFaces.addAll(Model3DFactory.createBox(crate3D + Vector3D(0, 14, 0), Vector3D(28, 28, 28), Colors.amber.shade900));
    }

    // G. Enemies
    for (var enemy in enemies) {
      if (enemy.isAlive) {
        Vector3D enemy3D = Vector3D(enemy.position.dx, 0, enemy.position.dy);
        all3DFaces.addAll(Model3DFactory.createBox(enemy3D + Vector3D(0, enemy.radius, 0), Vector3D(enemy.radius * 2, enemy.radius * 2, enemy.radius * 2), enemy.color));
      }
    }

    // H. 3D Milo Hero (Fully Framed in Viewport)
    bool isMoving = (hero.position.dx != 0 || hero.position.dy != 200);
    double runAngle = isMoving ? animTicks * 12 : 0.0;
    all3DFaces.addAll(Model3DFactory.createOrganic3DCatMesh(miloPos3D, runAngle, hero.isDodging, AppColors.accentGold));

    // 3. Z-Depth Sorting
    for (var face in all3DFaces) {
      double avgZ = 0;
      for (var v in face.vertices) {
        avgZ += (v - camera.position).length;
      }
      face.depth = avgZ / face.vertices.length;
    }
    all3DFaces.sort((a, b) => b.depth.compareTo(a.depth));

    // 4. Render Projected 3D Faces
    for (var face in all3DFaces) {
      Path path = Path();
      for (int i = 0; i < face.vertices.length; i++) {
        Offset pt = camera.project(face.vertices[i], size);
        if (i == 0) {
          path.moveTo(pt.dx, pt.dy);
        } else {
          path.lineTo(pt.dx, pt.dy);
        }
      }
      path.close();

      final paint = Paint()..color = face.color;
      canvas.drawPath(path, paint);

      final borderPaint = Paint()
        ..color = Colors.black12
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0;
      canvas.drawPath(path, borderPaint);
    }

    // 5. Draw Particle Overlay
    particleSystem.draw(canvas);
  }

  void _draw3DSky(Canvas canvas, Size size) {
    final skyPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFFFF7E5F), Color(0xFFFEB47B), Color(0xFF2C3E50)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height * 0.55));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height * 0.55), skyPaint);

    final sunPaint = Paint()..color = const Color(0xFFFFF3B0);
    canvas.drawCircle(Offset(size.width * 0.85, size.height * 0.18), 45, sunPaint);
  }

  void _add3DSprawlingGroundGrid(List<Face3D> faces, Vector3D miloPos) {
    for (double x = -1000; x <= 1000; x += 100) {
      for (double z = -200; z <= 1200; z += 100) {
        Color tileColor = ((x / 100).floor() + (z / 100).floor()) % 2 == 0
            ? const Color(0xFF34495E)
            : const Color(0xFF2C3E50);
        faces.addAll(Model3DFactory.createBox(Vector3D(x, -2, z), Vector3D(98, 4, 98), tileColor));
      }
    }
  }

  void _add3DBuilding(List<Face3D> faces, Vector3D pos, Color color) {
    faces.addAll(Model3DFactory.createBox(pos + Vector3D(0, 60, 0), Vector3D(140, 120, 140), color));
    faces.addAll(Model3DFactory.createPyramid(pos + Vector3D(0, 120, 0), Vector3D(180, 50, 180), const Color(0xFF8B0000)));
  }

  void _add3DHouse(List<Face3D> faces, Vector3D pos, Color color) {
    faces.addAll(Model3DFactory.createBox(pos + Vector3D(0, 45, 0), Vector3D(100, 90, 100), color));
    faces.addAll(Model3DFactory.createPyramid(pos + Vector3D(0, 90, 0), Vector3D(130, 40, 130), Colors.brown.shade900));
  }

  void _add3DGate(List<Face3D> faces, Vector3D pos) {
    faces.addAll(Model3DFactory.createBox(pos + Vector3D(-60, 60, 0), Vector3D(20, 120, 20), Colors.grey.shade900));
    faces.addAll(Model3DFactory.createBox(pos + Vector3D(60, 60, 0), Vector3D(20, 120, 20), Colors.grey.shade900));
    faces.addAll(Model3DFactory.createBox(pos + Vector3D(0, 120, 0), Vector3D(140, 18, 18), Colors.grey.shade800));
  }

  void _add3DTrees(List<Face3D> faces, Vector3D pos) {
    faces.addAll(Model3DFactory.createBox(pos + Vector3D(0, 35, 0), Vector3D(18, 70, 18), Colors.brown.shade900));
    faces.addAll(Model3DFactory.createPyramid(pos + Vector3D(0, 70, 0), Vector3D(90, 70, 90), const Color(0xFFFFB7C5)));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
