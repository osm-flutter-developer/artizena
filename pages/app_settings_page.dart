
import 'package:flutter/material.dart';
import 'package:glassify/providers/locales/glassify_locale.dart';
import 'package:glassify/providers/app_data_provider.dart';
import 'package:provider/provider.dart';



class AppSettingsPage extends StatelessWidget {
  const AppSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final provider = context.read<AppDataProvider>();
    final localization = provider.localization;
    return Scaffold(
      appBar: AppBar(
        title: Text(localization.settingsLabel),
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              ListTile(
                title: Text(localization.languageLabel,
                  style: textTheme.labelMedium,
                ),
                contentPadding: const EdgeInsetsDirectional.only(start: 15, end: 10),
                onTap: () async {
                  final index = GlassifyLocale.supportedLocales.indexWhere((locale) => provider.locale?.languageCode == locale.languageCode);
                  if(index < 0) return;
                  await Future.delayed(const Duration(milliseconds: 500));
                  final locale = GlassifyLocale.supportedLocales[(index + 1) % GlassifyLocale.supportedLocales.length];
                  await provider.changeLocale(locale);
                },
                trailing: SizedBox(
                  width: 72,
                  child: Row(
                    children: [
                      Text(provider.locale?.localeName ?? '',
                        style: textTheme.labelMedium,
                      ),
                      Icon(Icons.expand_more),
                    ],
                  ),
                ),
              ),
              const Divider(height: 0, thickness: 0.50, indent: 20, endIndent: 20),
              ListTile(
                title: Text(localization.currencyLabel,
                  style: textTheme.labelMedium,
                ),
                contentPadding: const EdgeInsetsDirectional.only(start: 15, end: 10),
                onTap: () { },
                trailing: SizedBox(
                  width: 53,
                  child: Row(
                    children: [
                      Text(provider.localization.getCurrencySymbol(provider.country?.currencySymbol ?? ''),
                        style: textTheme.labelMedium,
                      ),
                      Icon(Icons.expand_more,),
                    ],
                  ),
                ),
              ),
              const Divider(height: 0, thickness: 0.50, indent: 20, endIndent: 20),
              ListTile(
                title: Text(localization.countryLabel,
                  style: textTheme.labelMedium,
                ),
                contentPadding: const EdgeInsetsDirectional.only(start: 15, end: 10),
                onTap: () { },
                trailing: SizedBox(
                  width: 62,
                  child: Text('${provider.country?.countryFlag} ${localization.getCountryName(provider.country?.countryCode ?? '')}',
                    style: textTheme.labelMedium,
                  ),
                ),
              ),
              const Divider(height: 0, thickness: 0.50, indent: 20, endIndent: 20),
              ListTile(
                title: Text(localization.notificationsLabel,
                  style: textTheme.labelMedium,
                ),
                contentPadding: const EdgeInsetsDirectional.only(start: 15, end: 10),
                onTap: () { },
                trailing: SizedBox(width: 50, child: Icon(Icons.expand_more)),
              ),
              const Divider(height: 0, thickness: 0.50, indent: 20, endIndent: 20),
              ListTile(
                title: Text(localization.applicationAttributes,
                  style: textTheme.labelMedium,
                ),
                contentPadding: const EdgeInsetsDirectional.only(start: 15, end: 10),
                onTap: () async {
                  await Future.delayed(const Duration(milliseconds: 500));
                  await provider.changeThemeMode(provider.themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark);
                  provider.mainNotifier.value = !provider.mainNotifier.value;
                },
                trailing: InkWell(
                  // splashColor: colors.onPrimary.withValues(alpha: 0.40),
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  child: Tooltip(
                    message: localization.likesLabel,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                      child: Icon(provider.themeMode == ThemeMode.dark ? Icons.dark_mode : Icons.light_mode, size: 26),
                    ),
                  ),
                ),
              ),
              const Divider(height: 0, thickness: 0.50, indent: 20, endIndent: 20),
              ListTile(
                title: Text(localization.applicationVersion,
                  style: textTheme.labelMedium,
                ),
                contentPadding: const EdgeInsetsDirectional.only(start: 15, end: 10),
                onTap: () { },
                trailing: SizedBox(
                  width: 60,
                  child: Text(
                    '1.0.0.1',
                    style: textTheme.labelMedium,
                  ),
                ),
              ),
              const Divider(height: 0, thickness: 0.50, indent: 20, endIndent: 20),
              ListTile(
                title: Text(localization.applicationRating,
                  style: textTheme.labelMedium,
                ),
                contentPadding: const EdgeInsetsDirectional.only(start: 15, end: 10),
                onTap: () { },
                trailing: SizedBox(
                  width: 60,
                  child: Icon(Icons.eighteen_up_rating_outlined),
                ),
              ),
              const Divider(height: 0, thickness: 0.50, indent: 20, endIndent: 20),
            ],
          ),
        ],
      ),
    );
  }
}
