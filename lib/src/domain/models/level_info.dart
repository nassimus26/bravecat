class LevelInfo {
  final int id;
  final String name;
  final String environment;
  final String questObjective;
  final String bossName;
  final bool isUnlocked;

  LevelInfo({
    required this.id,
    required this.name,
    required this.environment,
    required this.questObjective,
    required this.bossName,
    this.isUnlocked = false,
  });
}
