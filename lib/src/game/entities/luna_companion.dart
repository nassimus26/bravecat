import 'package:flutter/material.dart';

class LunaCompanion {
  Offset position = const Offset(160, 200);

  void followHero(Offset heroPosition) {
    // Smooth follow logic towards Milo
    double dx = (heroPosition.dx - 40 - position.dx) * 0.1;
    double dy = (heroPosition.dy + 20 - position.dy) * 0.1;
    position = Offset(position.dx + dx, position.dy + dy);
  }
}
