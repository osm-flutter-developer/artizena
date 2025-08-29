
import 'locales/glassify_locale.dart';

class GlassifyCountry<Local extends GlassifyLocale> {
  final String countryName;
  final Local local;
  final String dialCode;
  String get languageCode => local.languageCode;
  final String currencySymbol;

  late final String _countryCode;
  String get countryCode => _countryCode;

  GlassifyCountry({required this.local,
    required this.countryName,
    required String countryCode,
    required this.dialCode,
    required this.currencySymbol,
  }) {
    _countryCode = countryCode;
  }

  String get countryFlag {
    return
      String.fromCharCode(countryCode.codeUnitAt(0) - 0x41 + 0x1F1E6) +
      String.fromCharCode(countryCode.codeUnitAt(1) - 0x41 + 0x1F1E6);
  }

  static List<GlassifyCountry> countries = [
    GlassifyCountry(
      countryName: 'اليمن',
      countryCode: 'YE',
      local: GlassifyLocale.arabicLocale,
      dialCode: '+967',
      currencySymbol: 'YER',
    ),
    GlassifyCountry(
      countryName: 'الولايات المتخدة',
      countryCode: 'US',
      local: GlassifyLocale.englishLocale,
      dialCode: '+1',
      currencySymbol: 'USD',
    ),
  ];

}