import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/i18n/l10n_extension.dart';
import 'game_screen.dart';
import 'level_select_screen.dart';
import 'store_screen.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // Menu Overlay
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '🐱 ⚔️',
                    style: TextStyle(fontSize: 48),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    context.l10n.translate('gameTitle'),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: AppColors.accentGold,
                      shadows: [
                        Shadow(
                          color: Colors.black.withValues(alpha: 0.8),
                          blurRadius: 8,
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    context.l10n.translate('subTitle'),
                    style: const TextStyle(fontSize: 14, color: AppColors.textMuted),
                  ),
                  const SizedBox(height: 32),

                  // Menu Buttons
                  SizedBox(
                    width: 220,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const GameScreen(levelId: 1),
                          ),
                        );
                      },
                      child: Text(context.l10n.translate('play')),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: 220,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LevelSelectScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.buttonSecondary),
                      child: Text(context.l10n.translate('levelSelect')),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: 220,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const StoreScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.shadowPurple),
                      child: Text(context.l10n.translate('store')),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
