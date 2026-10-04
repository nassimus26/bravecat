import 'package:flutter/material.dart';

class EnemyBase {
  Offset position;
  double health;
  final double maxHealth;
  final String name;
  final Color color;
  final double radius;
  bool isAlive = true;

  EnemyBase({
    required this.position,
    required this.name,
    this.health = 50.0,
    this.maxHealth = 50.0,
    this.color = Colors.redAccent,
    this.radius = 18.0,
  });

  void takeDamage(double amount) {
    health -= amount;
    if (health <= 0) {
      health = 0;
      isAlive = false;
    }
  }
}
