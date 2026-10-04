import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations) ??
        AppLocalizations(const Locale('en'));
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const List<Locale> supportedLocales = [
    Locale('en'), // English
    Locale('fr'), // French
    Locale('es'), // Spanish
    Locale('ja'), // Japanese
  ];

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'gameTitle': 'Whiskers: Legend of the Celestial Blossom',
      'subTitle': 'An 8-Level 3D Cat Adventure',
      'play': 'PLAY GAME',
      'levelSelect': 'LEVEL SELECT',
      'store': 'PREMIUM STORE',
      'settings': 'SETTINGS',
      'back': 'BACK',
      'pause': 'PAUSED',
      'resume': 'RESUME',
      'restart': 'RESTART',
      'mainMenu': 'MAIN MENU',
      'health': 'HEALTH',
      'potions': 'POTIONS',
      'treats': 'TREATS',
      'questObjective': 'QUEST OBJECTIVE',
      'levelComplete': 'LEVEL COMPLETE!',
      'questItemClaimed': 'QUEST ITEM CLAIMED:',
      'nextLevel': 'NEXT LEVEL',
      'buySkin': 'BUY SKIN',
      'removeAds': 'REMOVE ADS',
      'purchased': 'PURCHASED',
      'language': 'Language',

      // Level Titles
      'level1_title': 'Level 1: The Dojo & City Suburbs',
      'level1_quest': 'Find Dr. Whiskerfield & get Medical Pass',
      'level2_title': 'Level 2: The Whispering Jungle',
      'level2_quest': 'Retrieve the Ancient Botanical Tome',
      'level3_title': 'Level 3: Sunken Desert Ruins',
      'level3_quest': 'Find the Solar Crystal Lens',
      'level4_title': 'Level 4: Crystal Caverns',
      'level4_quest': 'Forge the Thermal Crystal Flask',
      'level5_title': 'Level 5: Haunted Swamps',
      'level5_quest': 'Consult Master Botan for Brew Recipe',
      'level6_title': 'Level 6: Misty Mountain Crags',
      'level6_quest': 'Duel Kuro for the Sky Key',
      'level7_title': 'Level 7: The Sky Citadel',
      'level7_quest': 'Align Telescope to Project Starlight Bridge',
      'level8_title': 'Level 8: The Celestial Garden',
      'level8_quest': 'Defeat Umbra & Seal 3 Petals for Master Sifu',
    },
    'fr': {
      'gameTitle': 'Whiskers: La Légende de la Fleur Céleste',
      'subTitle': 'Une Aventure 3D pour Chat en 8 Niveaux',
      'play': 'JOUER',
      'levelSelect': 'CHOIX DU NIVEAU',
      'store': 'BOUTIQUE PREMIUM',
      'settings': 'PARAMÈTRES',
      'back': 'RETOUR',
      'pause': 'PAUSE',
      'resume': 'REPRENDRE',
      'restart': 'RECOMMENCER',
      'mainMenu': 'MENU PRINCIPAL',
      'health': 'SANTÉ',
      'potions': 'POTIONS',
      'treats': 'FRIANDISES',
      'questObjective': 'OBJECTIF DE QUÊTE',
      'levelComplete': 'NIVEAU TERMINÉ !',
      'questItemClaimed': 'OBJET DE QUÊTE OBTENU :',
      'nextLevel': 'NIVEAU SUIVANT',
      'buySkin': 'ACHETER APPARENCE',
      'removeAds': 'SUPPRIMER LES PUBS',
      'purchased': 'ACHETÉ',
      'language': 'Langue',

      // Level Titles
      'level1_title': 'Niveau 1: Le Dojo et les Faubourgs',
      'level1_quest': 'Trouver le Dr. Whiskerfield et le Pass Médical',
      'level2_title': 'Niveau 2: La Jungle Chuchotante',
      'level2_quest': 'Récupérer le Grimoire Botanique Antique',
      'level3_title': 'Niveau 3: Les Ruines du Désert',
      'level3_quest': 'Trouver la Lentille de Cristal Solaire',
      'level4_title': 'Niveau 4: Les Cavernes de Cristal',
      'level4_quest': 'Forger la Fiole de Cristal Thermique',
      'level5_title': 'Niveau 5: Les Marais Hantés',
      'level5_quest': 'Consulter Maître Botan pour la Recette',
      'level6_title': 'Niveau 6: Les Pics Brumeux',
      'level6_quest': 'Duel contre Kuro pour la Clé Céleste',
      'level7_title': 'Niveau 7: La Citadelle Céleste',
      'level7_quest': 'Aligner le Télescope et le Pont d\'Étoiles',
      'level8_title': 'Niveau 8: Le Jardin Céleste',
      'level8_quest': 'Vaincre Umbra et Récolter les 3 Pétales',
    },
    'es': {
      'gameTitle': 'Whiskers: La Leyenda de la Flor Celestial',
      'subTitle': 'Una Aventura de Gatos en 3D de 8 Niveles',
      'play': 'JUGAR',
      'levelSelect': 'SELECCIONAR NIVEL',
      'store': 'TIENDA PREMIUM',
      'settings': 'AJUSTES',
      'back': 'VOLVER',
      'pause': 'PAUSA',
      'resume': 'CONTINUAR',
      'restart': 'REINICIAR',
      'mainMenu': 'MENÚ PRINCIPAL',
      'health': 'SALUD',
      'potions': 'POCIONES',
      'treats': 'PREMIOS',
      'questObjective': 'OBJETIVO DE LA MISIÓN',
      'levelComplete': '¡NIVEL COMPLETADO!',
      'questItemClaimed': 'OBJETO DE MISIÓN OBTENIDO:',
      'nextLevel': 'SIGUIENTE NIVEL',
      'buySkin': 'COMPRAR ASPECTO',
      'removeAds': 'QUITAR ANUNCIOS',
      'purchased': 'COMPRADO',
      'language': 'Idioma',

      'level1_title': 'Nivel 1: El Dojo y los Suburbios',
      'level1_quest': 'Encuentra al Dr. Whiskerfield y el Pase Médico',
      'level2_title': 'Nivel 2: La Selva Susurrante',
      'level2_quest': 'Recupera el Antiguo Tomo Botánico',
      'level3_title': 'Nivel 3: Ruinas del Desierto',
      'level3_quest': 'Encuentra la Lente de Cristal Solar',
      'level4_title': 'Nivel 4: Cavernas de Cristal',
      'level4_quest': 'Forja el Frasco de Cristal Térmico',
      'level5_title': 'Nivel 5: Pantanos Embrujados',
      'level5_quest': 'Consulta al Maestro Botan para la Receta',
      'level6_title': 'Nivel 6: Cumbres Brumosas',
      'level6_quest': 'Duelo con Kuro por la Llave Celestial',
      'level7_title': 'Nivel 7: La Ciudadela Celestial',
      'level7_quest': 'Alinea el Telescopio para Crear el Puente',
      'level8_title': 'Nivel 8: El Jardín Celestial',
      'level8_quest': 'Derrota a Umbra y Sella los 3 Pétalos',
    },
    'ja': {
      'gameTitle': 'ウィスカーズ：天界の花の伝説',
      'subTitle': '全8ステージの3Dキャットアクションアドベンチャー',
      'play': 'ゲーム開始',
      'levelSelect': 'ステージ選択',
      'store': 'プレミアムショップ',
      'settings': '設定',
      'back': '戻る',
      'pause': 'ポーズ',
      'resume': '再開',
      'restart': 'やり直し',
      'mainMenu': 'メインメニュー',
      'health': '体力',
      'potions': 'ポーション',
      'treats': 'おやつ',
      'questObjective': 'クエスト目標',
      'levelComplete': 'ステージクリア！',
      'questItemClaimed': 'クエストアイテム獲得：',
      'nextLevel': '次のステージへ',
      'buySkin': 'スキン購入',
      'removeAds': '広告を非表示',
      'purchased': '購入済み',
      'language': '言語',

      'level1_title': 'ステージ1：道場と郊外の街',
      'level1_quest': 'ウィスカーフィールド医師を探し通行証を入手せよ',
      'level2_title': 'ステージ2：ささやきのジャングル',
      'level2_quest': '古代の植物図鑑を取り戻せ',
      'level3_title': 'ステージ3：砂漠の地下遺跡',
      'level3_quest': '太陽のクリスタルレンズを見つけ出せ',
      'level4_title': 'ステージ4：水晶とマグマの洞窟',
      'level4_quest': '耐熱のクリスタルボトルを鍛造せよ',
      'level5_title': 'ステージ5：幽霊の沼地',
      'level5_quest': 'ボタン師から秘薬のレシピを伝授されよ',
      'level6_title': 'ステージ6：霧の霊峰',
      'level6_quest': 'クロとの決闘で天空の鍵を勝ち取れ',
      'level7_title': 'ステージ7：天空の要塞',
      'level7_quest': '望遠鏡を調整し星の架け橋を架けよ',
      'level8_title': 'ステージ8：天界の花園',
      'level8_quest': 'ウンブラを倒し3枚の花びらで師匠を救え',
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ??
        _localizedValues['en']?[key] ??
        key;
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'fr', 'es', 'ja'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
