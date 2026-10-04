import 'dart:math';
import 'package:flutter/material.dart';

class Particle {
  Offset position;
  Offset velocity;
  Color color;
  double size;
  double opacity;
  double maxLife;
  double currentLife;
  String? text;

  Particle({
    required this.position,
    required this.velocity,
    required this.color,
    this.size = 4.0,
    this.opacity = 1.0,
    this.maxLife = 1.0,
    this.text,
  }) : currentLife = maxLife;

  bool get isDead => currentLife <= 0;

  void update(double dt) {
    position += velocity * dt * 60;
    currentLife -= dt;
    opacity = (currentLife / maxLife).clamp(0.0, 1.0);
  }
}

class ParticleSystem {
  final List<Particle> particles = [];
  final Random _random = Random();

  void spawnCherryBlossomPetals(Size bounds) {
    if (particles.length < 30) {
      particles.add(
        Particle(
          position: Offset(_random.nextDouble() * bounds.width, -10),
          velocity: Offset(_random.nextDouble() * 1.5 - 0.75, _random.nextDouble() * 1.5 + 0.5),
          color: const Color(0xFFFFB7C5),
          size: _random.nextDouble() * 4 + 3,
          maxLife: 6.0,
        ),
      );
    }
  }

  void spawnSlashSparks(Offset pos) {
    for (int i = 0; i < 12; i++) {
      double angle = _random.nextDouble() * 2 * pi;
      double speed = _random.nextDouble() * 4 + 2;
      particles.add(
        Particle(
          position: pos,
          velocity: Offset(cos(angle) * speed, sin(angle) * speed),
          color: Colors.cyanAccent,
          size: 3.0,
          maxLife: 0.4,
        ),
      );
    }
  }

  void spawnFloatingText(Offset pos, String text, Color color) {
    particles.add(
      Particle(
        position: pos,
        velocity: const Offset(0, -1.2),
        color: color,
        size: 14.0,
        maxLife: 1.2,
        text: text,
      ),
    );
  }

  void update(double dt, Size bounds) {
    spawnCherryBlossomPetals(bounds);
    for (var p in particles) {
      p.update(dt);
    }
    particles.removeWhere((p) => p.isDead);
  }

  void draw(Canvas canvas) {
    for (var p in particles) {
      if (p.text != null) {
        final textPainter = TextPainter(
          text: TextSpan(
            text: p.text,
            style: TextStyle(
              color: p.color.withValues(alpha: p.opacity),
              fontSize: p.size,
              fontWeight: FontWeight.bold,
              shadows: const [Shadow(blurRadius: 3, color: Colors.black)],
            ),
          ),
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();
        textPainter.paint(canvas, p.position);
      } else {
        final paint = Paint()
          ..color = p.color.withValues(alpha: p.opacity)
          ..style = PaintingStyle.fill;
        canvas.drawCircle(p.position, p.size, paint);
      }
    }
  }
}
