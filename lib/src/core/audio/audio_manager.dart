class AudioManager {
  static final AudioManager _instance = AudioManager._internal();
  factory AudioManager() => _instance;
  AudioManager._internal();

  bool isMuted = false;
  double musicVolume = 0.8;
  double sfxVolume = 1.0;

  void playBgm(String trackName) {
    if (isMuted) return;
    // BGM Audio trigger
  }

  void playSfx(String sfxName) {
    if (isMuted) return;
    // SFX Audio trigger
  }

  void toggleMute() {
    isMuted = !isMuted;
  }
}
