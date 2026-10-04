# Technical Implementation Spec: Milo & Luna

This document bridges the **Story & Narrative Design** in `concept.md` and `level1` through `level8` into actionable **Unity C# Scripts, 3D Assets, Animations, and Scene Hierarchies**.

---

## 1. 3D Character Model & Animation Inventory

### A. Milo (Hero - Playable)
- **Model:** Low-poly cat warrior with katana sheath, wearing the Silver Blossom Charm.
- **Animations Required (FBX/Mixamo):**
  1. `milo_idle` — Alert standing stance.
  2. `milo_run` — Fast quadruped/biped hybrid sprint.
  3. `milo_slash1`, `milo_slash2`, `milo_slash3` — 3-hit sword attack combo.
  4. `milo_heavy_pounce` — Charged forward leap attack.
  5. `milo_dodge_roll` — Forward evasion roll with invulnerability frames.
  6. `milo_drink_potion` — Brief health potion consumption.
  7. `milo_hurt` & `milo_death` — Hit reaction and collapse.
  8. `milo_reach_hand` — Reaching/catching Luna on collapsing bridges.

### B. Luna (Co-Op / Companion AI)
- **Model:** Agile cat adventurer wearing a flowing Red Scarf and carrying a map pouch.
- **Animations Required:**
  1. `luna_idle_playful` — Rooftop teasing / tail flick.
  2. `luna_run_sprint` — Fast parkour sprint.
  3. `luna_climb_wall` — Climbing narrow passages / walls.
  4. `luna_thief_steal` — Snatching the map / item.
  5. `luna_distract_boss` — Drawing enemy attention during boss fights.
  6. `luna_hang_ledge` — Hanging off collapsing bridges / lava edges.

### C. Major NPCs & Bosses
- **Master Sifu:** Elderly sage cat (Idle, Collapse, Sick, Brew Tea, Bow).
- **Dr. Whiskerfield:** Owl / Cat Doctor (Examine, Hand Medical Pass).
- **Kuro:** Rival Samurai Cat with twin katanas and ink-brush sash (Dual-sword flurry, Parry stance, Defeat bow).
- **Master Botan:** Spectral Spirit Cat (Floating idle, Teach ritual gesture).
- **Umbra (Boss 8):** 
  - *Phase 1:* Shadow Knight with greatsword.
  - *Phase 2:* Cosmic Shadow Dragon Beast (Light beam, shadow nova, orb spit, stun state).

---

## 2. 3D Props & Quest Items Checklist

| Item Name | Level | Mesh Type | Function / Game Trigger |
| :--- | :--- | :--- | :--- |
| **Silver Blossom Charm** | L1-L8 | Accessory / Pendant | Worn by Milo; triggers story dialogue when inspected. |
| **Red Scarf** | L1-L8 | Accessory / Cloth | Worn by Luna; visual storytelling motif. |
| **Medical Pass** | L1 | Flat Scroll Prop | Unlocks Quarantine Gate to Level 2. |
| **Ancient Botanical Tome**| L2 | 3D Book Prop | Unlocks Level 3; map page requires Solar Lens. |
| **Solar Crystal Lens** | L3 | Crystal Artifact Prop| Reveals invisible ink on Tome map. |
| **Thermal Crystal Flask** | L4 | Glowing Glass Flask | Item container for 3 Blossom Petals in Level 8. |
| **Spirit Lantern** | L5 | Glowing Paper Lantern| Generates safe aura zone against swamp miasma. |
| **Celestial Sky Key** | L6 | Crystal Key Prop | Activates Sky Citadel portal in Level 6. |
| **Star Telescope** | L7 | Brass Machine Prop | Projects Starlight Bridge across clouds. |
| **Three Blossom Petals** | L8 | Glowing Flora Prop | Placed in Thermal Flask to complete the cure. |

---

## 3. Unity Scene & Lighting Setup per Level

| Level | Environment Theme | Time / Lighting | Key Scene Trigger / Mechanics |
| :--- | :--- | :--- | :--- |
| **Level 1** | Suburbs & Dojo | Sunrise (Golden 4000K) | Sifu collapse cutscene -> Street combat -> Clinic gate. |
| **Level 2** | Jungle & Tree Library | Midday (Sunbeams 6000K)| Luna map theft chase -> Shortcut lever -> Library altar. |
| **Level 3** | Desert Catacombs | Torchlight (Warm 2700K) | Pressure plates -> Collapsing bridge -> Solar Lens. |
| **Level 4** | Crystal Caverns | Lava Glow (Orange/Cyan) | Heat hazard timer -> Lava edge rescue -> Forge Ignis. |
| **Level 5** | Haunted Swamps | Midnight (Moonlight Blue)| Miasma damage outside lantern aura -> Spirit Botan. |
| **Level 6** | Glacier Pass | Blizzard (Cool Gray) | Ice sliding physics -> Kuro duel -> Sky Key portal. |
| **Level 7** | Sky Citadel | Sunset (Purple/Gold) | Gravity flip pads -> Luna narrow vents -> Telescope. |
| **Level 8** | Celestial Garden | Celestial Twilight | Low gravity jumps -> Umbra 2-Phase Boss -> Epilogue. |

---

## 4. Unity C# Script Architecture Plan

```
Assets/Scripts/
├── Core/
├── GameState/
│   ├── GameManager.cs            # Manages level progression and save state
│   ├── QuestManager.cs           # Tracks 8 quest items and narrative triggers
│   └── AudioController.cs        # Handles ambient music and SFX triggers
├── Player/
│   ├── MiloController.cs         # 3D Movement, Jump, Dodge Roll
│   ├── SwordCombat.cs            # Light Combos, Heavy Pounce, Hitboxes
│   ├── HealthSystem.cs           # Health, Potion Drinking, Damage
│   └── CameraFollow3D.cs         # Third-Person Camera Tracking
├── Companion/
│   ├── LunaAIController.cs       # Companion pathfinding, shortcuts, boss distraction
│   └── DialogueTrigger.cs        # Proximity story banter triggers
├── Enemies/
│   ├── EnemyBase.cs              # Base AI health, aggro, hit reactions
│   ├── BossBase.cs               # Multi-phase boss state machine
│   └── UmbraBossController.cs    # Phase 1 Knight / Phase 2 Cosmic Beast
└── Environment/
    ├── MiasmaZone.cs             # Swamp health drain outside lantern light
    ├── GravityPad.cs             # Inverts player gravity in Sky Citadel
    └── CrystalPrism.cs           # Light beam puzzle reflection logic
```

---

## 5. Implementation Status
- ✅ **Story & Lore:** Fully polished (100% complete).
- ✅ **Level Progression & Boss Logic:** Fully defined (100% complete).
- ✅ **Technical Spec:** Defined above.
- 🚀 **Next Phase:** C# Game Scripts & Unity Project Initialization!
