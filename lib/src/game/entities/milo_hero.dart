import 'package:flutter/material.dart';

class MiloHero {
  Offset position = const Offset(0, 200);
  bool isAttacking = false;
  bool isDodging = false;
  double health = 100.0;

  void updatePosition(Offset delta, Size bounds) {
    // Sprawling 3D World Bounds (-1000 to +1000)
    double newX = (position.dx + delta.dx).clamp(-800.0, 800.0);
    double newY = (position.dy + delta.dy).clamp(-200.0, 1000.0);
    position = Offset(newX, newY);
  }

  void performLightAttack() {
    isAttacking = true;
    Future.delayed(const Duration(milliseconds: 300), () {
      isAttacking = false;
    });
  }

  void performHeavyAttack() {
    isAttacking = true;
    Future.delayed(const Duration(milliseconds: 600), () {
      isAttacking = false;
    });
  }

  void performDodge() {
    isDodging = true;
    Future.delayed(const Duration(milliseconds: 400), () {
      isDodging = false;
    });
  }
}
