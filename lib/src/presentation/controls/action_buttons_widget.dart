import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class ActionButtonsWidget extends StatelessWidget {
  final VoidCallback onLightAttack;
  final VoidCallback onHeavyAttack;
  final VoidCallback onDodge;
  final VoidCallback onHeal;

  const ActionButtonsWidget({
    super.key,
    required this.onLightAttack,
    required this.onHeavyAttack,
    required this.onDodge,
    required this.onHeal,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 180,
      child: Stack(
        children: [
          // Button 1: Light Attack (⚔️)
          Positioned(
            right: 0,
            bottom: 60,
            child: _buildActionButton('⚔️', AppColors.buttonPrimary, onLightAttack),
          ),
          // Button 2: Heavy Attack (💥)
          Positioned(
            right: 60,
            bottom: 0,
            child: _buildActionButton('💥', Colors.redAccent, onHeavyAttack),
          ),
          // Button 3: Dodge Roll (🛡️)
          Positioned(
            right: 120,
            bottom: 60,
            child: _buildActionButton('🛡️', AppColors.accentCyan, onDodge),
          ),
          // Button 4: Heal Potion (🍶)
          Positioned(
            right: 60,
            bottom: 120,
            child: _buildActionButton('🍶', AppColors.potionGreen, onHeal),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String emoji, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: 54,
        height: 54,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.85),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.4),
              blurRadius: 6,
              spreadRadius: 1,
            )
          ],
        ),
        child: Center(
          child: Text(
            emoji,
            style: const TextStyle(fontSize: 22),
          ),
        ),
      ),
    );
  }
}
