
import 'package:flutter/material.dart';
import 'package:glassify/pages/user_login_page.dart';
import 'package:glassify/providers/countries.dart';
import 'package:glassify/providers/glassify_user_data_provider.dart';
import 'package:glassify/providers/locales/glassify_locale.dart';
import 'package:glassify/providers/app_data_provider.dart';
import 'package:glassify/theme/theme_data.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';





class GlassifyApplication extends StatefulWidget {
  const GlassifyApplication({super.key});

  @override
  State<GlassifyApplication> createState() => _GlassifyApplicationState();

}

class _GlassifyApplicationState extends State<GlassifyApplication> {
  Future<(GlassifyLocale? locale, GlassifyCountry? country, ThemeMode themeMode)> _loadData() async {
    return (await getLocale(), await getCountry(), await getThemeMode());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadData(),
      builder: (_, snap) {
        if(snap.hasError) {
          return _ErrorMaterialApp(error: snap.error.toString());
        }
        if(snap.hasData) {
          final result = snap.data!;
          final (GlassifyLocale? locale, GlassifyCountry? country, ThemeMode themeMode) = result;
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => AppDataProvider(themeMode: themeMode, locale: locale, country: country)),
              ChangeNotifierProvider(create: (_) => UserDataProvider()),
            ],
            child: const _MaterialApp(),
          );
        }
        return _ErrorMaterialApp(error: snap.error.toString());
      },
    );
  }

  @override
  void dispose() {
    try {
      final provider = context.read<AppDataProvider>();
      provider.audioPlayer.dispose();
    } catch (e) {
      // print('$e-----------------------------------------------------------');
    }
    super.dispose();
  }

}


class _ErrorMaterialApp extends StatelessWidget {
  final String error;
  const _ErrorMaterialApp({required this.error});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Glassify',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: Scaffold(
        body: Center(
          child: Text(
            error,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      localeResolutionCallback: (locale, supportedlocales) {
        for(var supportedlocale in supportedlocales) {
          if(supportedlocale.countryCode == locale?.countryCode && supportedlocale.languageCode == locale?.languageCode) {
            return locale;
          }
        }
        return GlassifyLocale.englishLocale;
      },
      // locale: provider.locale,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: GlassifyLocale.supportedLocales,
    );
  }
}


class _MaterialApp extends StatelessWidget {
  const _MaterialApp();

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AppDataProvider>();
    return ValueListenableBuilder<bool>(
      valueListenable: provider.mainNotifier,
      builder: (_, value, widget) {
        final themeOfApplication = Theme.of(context);
        return AnimatedTheme(
          data: themeOfApplication,
          child: MaterialApp(
            title: provider.localization.appName,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: provider.themeMode == ThemeMode.system ? null : provider.themeMode,
            home: const UserLoginPage(user: null),
            debugShowCheckedModeBanner: false,
            localeResolutionCallback: (locale, supportedlocales) {
              for(var supportedlocale in supportedlocales) {
                if(supportedlocale.countryCode == locale?.countryCode && supportedlocale.languageCode == locale?.languageCode) {
                  return locale;
                }
              }
              return GlassifyLocale.englishLocale;
            },
            locale: provider.locale,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: GlassifyLocale.supportedLocales,
            // themeAnimationStyle: AnimationStyle(
            //   duration: const Duration(milliseconds: 500),
            //   reverseDuration: const Duration(milliseconds: 500),
            //   curve: Curves.linear,
            //   reverseCurve: Curves.bounceInOut,
            // ),
          ),
        );
      },
    );
  }
}


