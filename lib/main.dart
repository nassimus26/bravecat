import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'src/core/theme/app_theme.dart';
import 'src/core/i18n/app_localizations.dart';
import 'src/presentation/screens/main_menu_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Only set orientation and immersive UI on mobile (Android/iOS)
  if (!kIsWeb && (defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS)) {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  runApp(const WhiskersGameApp());
}

class WhiskersGameApp extends StatefulWidget {
  const WhiskersGameApp({super.key});

  @override
  State<WhiskersGameApp> createState() => _WhiskersGameAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _WhiskersGameAppState? state = context.findAncestorStateOfType<_WhiskersGameAppState>();
    state?.setLocale(newLocale);
  }
}

class _WhiskersGameAppState extends State<WhiskersGameApp> {
  Locale _locale = const Locale('en');

  void setLocale(Locale newLocale) {
    setState(() {
      _locale = newLocale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Whiskers: Legend of the Celestial Blossom',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      locale: _locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const MainMenuScreen(),
    );
  }
}
