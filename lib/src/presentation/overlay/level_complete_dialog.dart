import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/i18n/l10n_extension.dart';

class LevelCompleteDialog extends StatelessWidget {
  final int levelId;
  final String questItemName;
  final VoidCallback onNextLevel;

  const LevelCompleteDialog({
    super.key,
    required this.levelId,
    required this.questItemName,
    required this.onNextLevel,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.cardBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 360,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context.l10n.translate('levelComplete'),
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.accentGold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              context.l10n.translate('questItemClaimed'),
              style: const TextStyle(color: AppColors.textMuted, fontSize: 13),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.accentCyan),
              ),
              child: Text(
                "✨ $questItemName",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.accentPink,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onNextLevel,
              child: Center(child: Text(context.l10n.translate('nextLevel'))),
            ),
          ],
        ),
      ),
    );
  }
}
