import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../game/engine/game_canvas_painter.dart';
import '../../game/engine/particle_system.dart';
import '../../game/entities/milo_hero.dart';
import '../../game/entities/luna_companion.dart';
import '../../game/levels/level_manager.dart';
import '../../core/audio/synth_audio.dart';
import '../controls/joystick_widget.dart';
import '../controls/action_buttons_widget.dart';
import '../overlay/hud_overlay.dart';
import '../overlay/pause_menu.dart';
import '../overlay/level_complete_dialog.dart';
import '../overlay/minimap_widget.dart';
import '../../core/i18n/l10n_extension.dart';

class GameScreen extends StatefulWidget {
  final int levelId;

  const GameScreen({super.key, required this.levelId});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with SingleTickerProviderStateMixin {
  late final LevelManager _levelManager;
  final MiloHero _hero = MiloHero();
  final LunaCompanion _luna = LunaCompanion();
  final ParticleSystem _particleSystem = ParticleSystem();
  
  final List<Offset> _crates = [
    const Offset(-200, 300),
    const Offset(100, 450),
    const Offset(350, 400),
    const Offset(650, 600),
  ];

  late final AnimationController _ticker;
  int _fishTreats = 0;
  Size _gameSize = const Size(1280, 720);
  double _animTicks = 0.0;

  @override
  void initState() {
    super.initState();
    _levelManager = LevelManager();
    _levelManager.loadLevel(widget.levelId);

    // 60 FPS Ticker
    _ticker = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(_gameLoop);
    _ticker.repeat();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  void _gameLoop() {
    if (mounted) {
      setState(() {
        _animTicks += 0.05;
        _particleSystem.update(0.016, _gameSize);
        _luna.followHero(_hero.position);
      });
    }
  }

  void _onJoystickMove(Offset delta) {
    setState(() {
      _hero.updatePosition(delta * 16, _gameSize);
    });
  }

  void _onHeal() {
    setState(() {
      _hero.health = (_hero.health + 40).clamp(0.0, 100.0);
      _particleSystem.spawnFloatingText(_hero.position, "+40 ❤️", Colors.greenAccent);
    });
  }

  void _onPause() {
    showDialog(
      context: context,
      builder: (_) => PauseMenuDialog(
        onResume: () => Navigator.pop(context),
        onRestart: () {
          Navigator.pop(context);
          setState(() {
            _hero.health = 100.0;
            _hero.position = const Offset(0, 200);
            _levelManager.loadLevel(widget.levelId);
          });
        },
        onMainMenu: () {
          Navigator.pop(context);
          Navigator.pop(context);
        },
        onLanguageChanged: (newLocale) {
          setState(() {});
        },
      ),
    );
  }

  void _onLightAttack() {
    SynthAudio.playSwordSlashSfx();
    setState(() {
      _hero.performLightAttack();
      _particleSystem.spawnSlashSparks(_hero.position);

      // Hit Enemies
      for (var enemy in _levelManager.currentEnemies) {
        if (enemy.isAlive && (enemy.position - _hero.position).distance < 80) {
          enemy.takeDamage(25);
          SynthAudio.playHitSfx();
          _particleSystem.spawnFloatingText(enemy.position, "-25 HP", Colors.redAccent);
        }
      }

      // Hit & Break Crates
      _crates.removeWhere((cratePos) {
        if ((cratePos - _hero.position).distance < 70) {
          _fishTreats += 10;
          SynthAudio.playTreatPickupSfx();
          _particleSystem.spawnFloatingText(cratePos, "+10 🐟", Colors.amberAccent);
          return true;
        }
        return false;
      });
    });

    _checkBossVictory();
  }

  void _onHeavyAttack() {
    SynthAudio.playSwordSlashSfx();
    setState(() {
      _hero.performHeavyAttack();
      _particleSystem.spawnSlashSparks(_hero.position);

      // Hit Enemies
      for (var enemy in _levelManager.currentEnemies) {
        if (enemy.isAlive && (enemy.position - _hero.position).distance < 100) {
          enemy.takeDamage(50);
          SynthAudio.playHitSfx();
          _particleSystem.spawnFloatingText(enemy.position, "-50 HP", Colors.orangeAccent);
        }
      }
    });

    _checkBossVictory();
  }

  void _checkBossVictory() {
    bool allEnemiesDead = _levelManager.currentEnemies.every((e) => !e.isAlive);
    if (allEnemiesDead) {
      SynthAudio.playBossDefeatSfx();
      final questKey = 'level${widget.levelId}_quest';

      showDialog(
        context: context,
        builder: (_) => LevelCompleteDialog(
          levelId: widget.levelId,
          questItemName: context.l10n.translate(questKey),
          onNextLevel: () {
            Navigator.pop(context);
            if (widget.levelId < 8) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => GameScreen(levelId: widget.levelId + 1),
                ),
              );
            } else {
              Navigator.pop(context);
            }
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: true,
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent) {
          if (event.logicalKey == LogicalKeyboardKey.keyW || event.logicalKey == LogicalKeyboardKey.arrowUp) {
            _onJoystickMove(const Offset(0, 1.2));
          } else if (event.logicalKey == LogicalKeyboardKey.keyS || event.logicalKey == LogicalKeyboardKey.arrowDown) {
            _onJoystickMove(const Offset(0, -1.2));
          } else if (event.logicalKey == LogicalKeyboardKey.keyA || event.logicalKey == LogicalKeyboardKey.arrowLeft) {
            _onJoystickMove(const Offset(-1.2, 0));
          } else if (event.logicalKey == LogicalKeyboardKey.keyD || event.logicalKey == LogicalKeyboardKey.arrowRight) {
            _onJoystickMove(const Offset(1.2, 0));
          } else if (event.logicalKey == LogicalKeyboardKey.space) {
            setState(() => _hero.performDodge());
          } else if (event.logicalKey == LogicalKeyboardKey.keyJ || event.logicalKey == LogicalKeyboardKey.keyZ) {
            _onLightAttack();
          } else if (event.logicalKey == LogicalKeyboardKey.keyK || event.logicalKey == LogicalKeyboardKey.keyX) {
            _onHeavyAttack();
          } else if (event.logicalKey == LogicalKeyboardKey.keyH || event.logicalKey == LogicalKeyboardKey.keyC) {
            _onHeal();
          }
        }
        return KeyEventResult.handled;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF111318),
        body: LayoutBuilder(
          builder: (context, constraints) {
            _gameSize = Size(constraints.maxWidth, constraints.maxHeight);

            return Stack(
              children: [
                // 1. Sprawling 3D Perspective Game Canvas Engine
                CustomPaint(
                  size: _gameSize,
                  painter: GameCanvasPainter(
                    hero: _hero,
                    luna: _luna,
                    enemies: _levelManager.currentEnemies,
                    crates: _crates,
                    particleSystem: _particleSystem,
                    levelId: widget.levelId,
                    animTicks: _animTicks,
                  ),
                ),

                // 2. HUD Overlay (Health, Potions, Fish Treats)
                HudOverlay(
                  currentHealth: _hero.health,
                  maxHealth: 100.0,
                  potionCount: 3,
                  treatsCount: _fishTreats,
                  levelId: widget.levelId,
                  onPausePressed: _onPause,
                ),

                // 3. 3D Live Mini-Map HUD Overlay (Top-Right)
                Positioned(
                  top: 50,
                  right: 16,
                  child: MiniMapWidget(
                    miloPos: _hero.position,
                    enemies: _levelManager.currentEnemies.map((e) => e.position).toList(),
                    dojoPos: const Offset(-450, 300),
                    clinicPos: const Offset(450, 450),
                  ),
                ),

                // 4. Virtual Joystick (Bottom-Left - For Touch/Mouse)
                Positioned(
                  left: 28,
                  bottom: 28,
                  child: JoystickWidget(onDirectionChanged: _onJoystickMove),
                ),

                // 5. Action Buttons (Bottom-Right)
                Positioned(
                  right: 28,
                  bottom: 28,
                  child: ActionButtonsWidget(
                    onLightAttack: _onLightAttack,
                    onHeavyAttack: _onHeavyAttack,
                    onDodge: () {
                      setState(() => _hero.performDodge());
                    },
                    onHeal: _onHeal,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
