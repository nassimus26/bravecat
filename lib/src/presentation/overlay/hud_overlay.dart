import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class HudOverlay extends StatelessWidget {
  final double currentHealth;
  final double maxHealth;
  final int potionCount;
  final int treatsCount;
  final int levelId;
  final VoidCallback onPausePressed;

  const HudOverlay({
    super.key,
    required this.currentHealth,
    required this.maxHealth,
    required this.potionCount,
    required this.treatsCount,
    required this.levelId,
    required this.onPausePressed,
  });

  @override
  Widget build(BuildContext context) {
    final healthRatio = (currentHealth / maxHealth).clamp(0.0, 1.0);

    return Positioned(
      top: 16,
      left: 16,
      right: 16,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Health Bar & Info
          Row(
            children: [
              Container(
                width: 140,
                height: 18,
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white24),
                ),
                child: Stack(
                  children: [
                    FractionallySizedBox(
                      widthFactor: healthRatio,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.healthRed,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        "${currentHealth.toInt()} / ${maxHealth.toInt()}",
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              // Potion Count
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "🍶 x$potionCount",
                  style: const TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
              const SizedBox(width: 8),
              // Treats Count
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "🐟 $treatsCount",
                  style: const TextStyle(fontSize: 12, color: AppColors.accentGold),
                ),
              ),
            ],
          ),

          // Pause Button
          IconButton(
            onPressed: onPausePressed,
            icon: const Icon(Icons.pause_circle_filled, color: Colors.white, size: 36),
          ),
        ],
      ),
    );
  }
}
