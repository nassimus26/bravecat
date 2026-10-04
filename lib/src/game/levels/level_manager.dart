import '../../domain/models/player_state.dart';
import '../entities/enemy_base.dart';
import 'package:flutter/material.dart';

class LevelManager {
  int currentLevelId = 1;
  final PlayerState playerState = PlayerState();
  List<EnemyBase> currentEnemies = [];

  void loadLevel(int levelId) {
    currentLevelId = levelId;
    currentEnemies = _generateEnemiesForLevel(levelId);
  }

  List<EnemyBase> _generateEnemiesForLevel(int levelId) {
    return [
      EnemyBase(
        position: const Offset(400, 180),
        name: "Level $levelId Guard 1",
      ),
      EnemyBase(
        position: const Offset(520, 260),
        name: "Level $levelId Guard 2",
      ),
      EnemyBase(
        position: const Offset(650, 200),
        name: "Boss Level $levelId",
        health: 120.0,
        maxHealth: 120.0,
        radius: 28.0,
        color: Colors.purpleAccent,
      ),
    ];
  }
}
