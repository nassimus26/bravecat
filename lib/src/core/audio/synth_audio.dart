import 'package:flutter/services.dart';

class SynthAudio {
  static void playSwordSlashSfx() {
    SystemSound.play(SystemSoundType.click);
  }

  static void playTreatPickupSfx() {
    SystemSound.play(SystemSoundType.click);
  }

  static void playHitSfx() {
    HapticFeedback.lightImpact();
  }

  static void playBossDefeatSfx() {
    HapticFeedback.heavyImpact();
  }
}
