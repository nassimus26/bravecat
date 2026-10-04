import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/i18n/l10n_extension.dart';

class PauseMenuDialog extends StatelessWidget {
  final VoidCallback onResume;
  final VoidCallback onRestart;
  final VoidCallback onMainMenu;
  final Function(Locale) onLanguageChanged;

  const PauseMenuDialog({
    super.key,
    required this.onResume,
    required this.onRestart,
    required this.onMainMenu,
    required this.onLanguageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.cardBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 320,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context.l10n.translate('pause'),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.accentGold,
              ),
            ),
            const SizedBox(height: 16),

            // Language Selector Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("${context.l10n.translate('language')}: "),
                const SizedBox(width: 8),
                DropdownButton<String>(
                  dropdownColor: AppColors.cardBackground,
                  value: Localizations.localeOf(context).languageCode,
                  items: const [
                    DropdownMenuItem(value: 'en', child: Text('🇺🇸 English')),
                    DropdownMenuItem(value: 'fr', child: Text('🇫🇷 Français')),
                    DropdownMenuItem(value: 'es', child: Text('🇪🇸 Español')),
                    DropdownMenuItem(value: 'ja', child: Text('🇯🇵 日本語')),
                  ],
                  onChanged: (lang) {
                    if (lang != null) {
                      onLanguageChanged(Locale(lang));
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: onResume,
              child: Center(child: Text(context.l10n.translate('resume'))),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: onRestart,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
              child: Center(child: Text(context.l10n.translate('restart'))),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: onMainMenu,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              child: Center(child: Text(context.l10n.translate('mainMenu'))),
            ),
          ],
        ),
      ),
    );
  }
}
