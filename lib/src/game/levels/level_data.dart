import '../../domain/models/level_info.dart';

class LevelData {
  static final List<LevelInfo> levels = [
    LevelInfo(
      id: 1,
      name: "The Dojo & City Suburbs",
      environment: "Asian Suburb Streets",
      questObjective: "Find Dr. Whiskerfield & get Medical Pass",
      bossName: "Grimfang the Alley King",
      isUnlocked: true,
    ),
    LevelInfo(
      id: 2,
      name: "The Whispering Jungle",
      environment: "Bamboo Forest Canopy",
      questObjective: "Retrieve the Ancient Botanical Tome",
      bossName: "Kaa'thor Serpent Sovereign",
    ),
    LevelInfo(
      id: 3,
      name: "Sunken Desert Ruins",
      environment: "Ancient Underground Catacombs",
      questObjective: "Find the Solar Crystal Lens",
      bossName: "Anubis Obsidian Golem",
    ),
    LevelInfo(
      id: 4,
      name: "Crystal Caverns",
      environment: "Volcanic Magma Chasms",
      questObjective: "Forge the Thermal Crystal Flask",
      bossName: "Ignis the Magma Drake",
    ),
    LevelInfo(
      id: 5,
      name: "Haunted Swamps",
      environment: "Mist-shrouded Ghost Village",
      questObjective: "Consult Master Botan for Brew Recipe",
      bossName: "Yurei Phantom Empress",
    ),
    LevelInfo(
      id: 6,
      name: "Misty Mountain Crags",
      environment: "Glacier Pass & Blizzard Summit",
      questObjective: "Duel Kuro for the Sky Key",
      bossName: "Kuro Rogue Samurai",
    ),
    LevelInfo(
      id: 7,
      name: "The Sky Citadel",
      environment: "Floating Brass Observatory",
      questObjective: "Align Telescope to Project Starlight Bridge",
      bossName: "Orion Clockwork Sentinel",
    ),
    LevelInfo(
      id: 8,
      name: "The Celestial Garden",
      environment: "Floating Sky Peak & Divine Altar",
      questObjective: "Defeat Umbra & Seal 3 Petals for Master Sifu",
      bossName: "Umbra Shadow Guardian",
    ),
  ];
}
