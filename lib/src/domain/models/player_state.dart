class PlayerState {
  double currentHealth;
  double maxHealth;
  int potionCount;
  int treatsCollected;
  List<String> unlockedQuestItems;

  PlayerState({
    this.currentHealth = 100.0,
    this.maxHealth = 100.0,
    this.potionCount = 3,
    this.treatsCollected = 0,
    List<String>? unlockedQuestItems,
  }) : unlockedQuestItems = unlockedQuestItems ?? [];

  void heal(double amount) {
    currentHealth = (currentHealth + amount).clamp(0.0, maxHealth);
  }

  void takeDamage(double amount) {
    currentHealth = (currentHealth - amount).clamp(0.0, maxHealth);
  }

  bool get isDead => currentHealth <= 0;
}
