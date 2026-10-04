class QuestItem {
  final int levelId;
  final String title;
  final String description;
  final String iconName;
  bool isUnlocked;

  QuestItem({
    required this.levelId,
    required this.title,
    required this.description,
    required this.iconName,
    this.isUnlocked = false,
  });
}
