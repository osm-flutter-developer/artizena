
import 'package:glassify/providers/countries.dart';
import 'package:intl/intl.dart';
import 'package:intl/number_symbols.dart';

import 'glassify_locale.dart';

class ArabicLocale extends GlassifyLocale {
  ArabicLocale() : super(languageCode: 'ar', localization: _ArabicLocalization());

  @override
  String get localeName => 'العربية';

  @override
  // TODO: implement numberSymbols
  NumberSymbols get numberSymbols => NumberSymbols(
      NAME: "ar",
      DECIMAL_SEP: '.',
      GROUP_SEP: ',',
      PERCENT: '\u200E%\u200E',
      ZERO_DIGIT: '0',
      PLUS_SIGN: '\u200E+',
      MINUS_SIGN: '\u200E-',
      EXP_SYMBOL: 'E',
      PERMILL: '\u2030',
      INFINITY: '\u221E',
      NAN: '\u0644\u064A\u0633\u00A0\u0631\u0642\u0645\u064B\u0627',
      DECIMAL_PATTERN: '#,##0.###',
      SCIENTIFIC_PATTERN: '#E0',
      PERCENT_PATTERN: '#,##0%',
      CURRENCY_PATTERN:
      '\u200F#,##0.00\u00A0\u00A4;\u200F-#,##0.00\u00A0\u00A4',
      DEF_CURRENCY_CODE: 'YER',
  );


}


class _ArabicLocalization with AppLocalization {

  GlassifyLocale get locale => GlassifyLocale.arabicLocale;

  @override
  // TODO: implement appName
  String get appName => 'قلاسيفاي';

  @override
  // TODO: implement chatsLabel
  String get chatsLabel => 'الدردشات';

  @override
  // TODO: implement likesLabel
  String get likesLabel => 'الإعجابات';

  @override
  // TODO: implement likesLabel
  String get dislikesLabel => 'غير معجب';

  @override
  // TODO: implement notificationsLabel
  String get notificationsLabel => 'الإشعارات';

  @override
  // TODO: implement settingsLabel
  String get settingsLabel => 'الإعدادات';

  @override
  String get countryLabel => 'الدولة';

  @override
  String get designLabel => 'التصميم';

  @override
  // TODO: implement buyDesignButton
  String get buyDesignButton => 'اشتري الآن';

  @override
  // TODO: implement followersLabel
  String get followersLabel => 'متابع';

  @override
  // TODO: implement followingDesignButton
  String get followDesignerLabel => 'متابعة';

  @override
  // TODO: implement followingDesignButton
  String get followedDesignerLabel => 'تم المتابعة';

  @override
  // TODO: implement postsLabel
  String get postsLabel => 'منشور';

  @override
  // TODO: implement transactionLabel
  String get transactionLabel => 'عملية';

  @override
  // TODO: implement commentLabel
  String get commentLabel => 'تعليق';

  @override
  // TODO: implement priceLabel
  String get priceLabel => 'السعر';

  @override
  // TODO: implement loginLabel
  String get signInLabel => 'تسجيل دخول';

  @override
  // TODO: implement passwordLabel
  String get passwordLabel => 'كلمة المرور';

  @override
  // TODO: implement passwordLabel
  String get enterPasswordLabel => 'ادخل كلمة المرور';

  @override
  // TODO: implement userNameLabel
  String get userNameLabel => 'اسم المستخدم';

  @override
  // TODO: implement userNameLabel
  String get enterUserNameLabel => 'ادخل اسم المستخدم';

  @override
  // TODO: implement customerNameLabel
  String get customerNameLabel => 'عميل';

  @override
  // TODO: implement designerNameLabel
  String get designerNameLabel => 'مصمم';

  @override
  // TODO: implement systemUserLabel
  String get systemUserLabel => 'مستخدم نظام';

  @override
  // TODO: implement createAccountLabel
  String get createAccountLabel => 'إنشاء حساب جديد';

  @override
  // TODO: implement forgetPasswordLabel
  String get forgetPasswordLabel => 'نسيت كلمة المرور ؟';

  @override
  // TODO: implement localSystemLocale
  String get localSystemLocale => 'لغة النظام';

  @override
  // TODO: implement freePhoneNumberLabel
  String get freePhoneNumberLabel => 'الرقم المجاني';

  @override
  // TODO: implement servicePoints
  String get servicePoints => 'نقاط الخدمة';

  @override
  // TODO: implement customersService
  String get customersService => 'خدمة العملاء';

  @override
  // TODO: implement similarDesigns
  String get similarDesigns => 'تصاميم مشابهه';

  @override
  // TODO: implement ratingLabel
  String get ratingLabel => 'التقييم';

  @override
  // TODO: implement reviewsLabel
  String get reviewsLabel => 'تقييمآ';

  @override
  // TODO: implement writeComment
  String get writeComment => 'اكتب تعليقا';

  @override
  // TODO: implement beFirstToComment
  String get beFirstToComment => 'كن اول من يعلق...';

  @override
  // TODO: implement categoryLabel
  String get categoryLabel => 'صنف';

  @override
  // TODO: implement postedAgo
  String get postedAgo => 'تم النشر قبل';

  @override
  // TODO: implement daysName
  String get daysName => 'أيام';

  @override
  // TODO: implement monthsName
  String get monthsName => 'اشهر';

  @override
  // TODO: implement yearName
  String get yearName => 'سنة';

  @override
  // TODO: implement reportThisPost
  String get reportThisPost => 'تقرير هذا المنشور';

  @override
  // TODO: implement seeMore
  String get seeMore => 'عرض المزيد';

  @override
  String getCurrencySymbol(String currencySymbol) {
    switch(currencySymbol) {
      case 'USD': return '\$';
      case 'YER': return 'ر.ي';
    }
    return currencySymbol;
  }

  @override
  String getCountryName(String countryCode) {
    switch(countryCode) {
      case 'YE': return 'اليمن';
      case 'US': return 'الولايات المتحدة';
    }
    return countryCode;
  }

  @override
  String get ago => 'منذ';

  @override
  // TODO: implement describeYourDesign
  String get describeDesign => 'اوصف التصميم';

  @override
  // TODO: implement popularDesigns
  String get popularDesigns => 'تصاميم شعبية';

  @override
  // TODO: implement popularDesigns
  String get suggestedDesigns => 'تصاميم مقترحة';

  @override
  // TODO: implement languageLabel
  String get languageLabel => 'اللغة';

  @override
  // TODO: implement currencyLabel
  String get currencyLabel => 'العملة';

  @override
  // TODO: implement changePasswordLabel
  String get changePasswordLabel => 'تغيير كلمة المرور';

  @override
  // TODO: implement deleteAccountLabel
  String get deleteAccountLabel => 'حذف الحساب';

  @override
  // TODO: implement applicationAttributes
  String get applicationAttributes => 'سمة التطبيق';

  @override
  // TODO: implement applicationVersion
  String get applicationVersion => 'إصدار التطبيق';

  @override
  // TODO: implement applicationRating
  String get applicationRating => 'تقييم التطبيق';

  @override
  // TODO: implement phoneNumberLabel
  String get phoneNumberLabel => 'رقم الهاتف';

  @override
  // TODO: implement signOutLabel
  String get signOutLabel => 'تسجيل خروج';

  @override
  // TODO: implement editProfileLabel
  String get editProfileLabel => 'تعديل الحساب';

  @override
  // TODO: implement walletsLabel
  String get walletsLabel => 'المحافظ';

  @override
  // TODO: implement joinedIn
  String get joinedIn => 'انضم في';

  @override
  // TODO: implement discountLabel
  String get discountLabel => 'خصم';

  @override
  // TODO: implement writeMessage
  String get writeMessage => 'اكتب رسالة';

  @override
  // TODO: implement searchHere
  String get searchHere => 'ابحث هنا';

  @override
  String getDaysName(int countDays) {
    if(countDays == 1) {
      return 'يوم';
    }
    if(countDays == 2) {
      return 'يومين';
    }
    if(countDays > 2 && countDays < 11) {
      return '$countDays أيام';
    }
    return '$countDays يوم';
  }

  @override
  String getHoursName(int inHours) {
    if(inHours == 1) {
      return 'ساعة';
    }
    if(inHours == 2) {
      return 'ساعتين';
    }
    if(inHours > 2 && inHours < 11) {
      return '$inHours ساعات';
    }
    return '$inHours ساعة';
  }

  @override
  String getMinutesName(int inMinutes) {
    if(inMinutes == 1) {
      return 'دقيقة';
    }
    if(inMinutes == 2) {
      return 'دقيقتين';
    }
    if(inMinutes > 2 && inMinutes < 11) {
      return '$inMinutes دقائق';
    }
    return '$inMinutes دقيقة';
  }

  @override
  String getMonthsName(int months) {
    if(months == 1) {
      return 'شهر';
    }
    if(months == 2) {
      return 'شهرين';
    }
    if(months > 2 && months < 11) {
      return '$months أشهر';
    }
    return '$months شهر';
  }

  @override
  String getSecondsName(int inSeconds) {
    if(inSeconds == 1) {
      return 'ثانية';
    }
    if(inSeconds == 2) {
      return 'ثانيتين';
    }
    if(inSeconds > 2 && inSeconds < 11) {
      return '$inSeconds ثواني';
    }
    return '$inSeconds ثانية';
  }

  @override
  String getYearName(int years) {
    if(years == 1) {
      return 'سنة';
    }
    if(years == 2) {
      return 'سنتين';
    }
    if(years > 2 && years < 11) {
      return '$years سنوات';
    }
    return '$years سنة';
  }

  @override
  String getUserNameLabel(String name) {
    switch(name) {
      case 'customer': return 'عميل';
      case 'designer': return 'مصمم';
      case 'systemUser': return 'مستخدم نظام';
    }
    return name;
  }

  @override
  String getDesignLabel({bool withPrefix = true, int? counter}) {
    if(counter == null || counter < 1) return '${withPrefix ? 'ال' : ''}تصميم';
    if(counter > 2 && counter < 11) {
      return '${formatNumber(counter)} تصاميم';
    }
    return '${formatNumber(counter)} تصميم';
  }

  @override
  String formatNumber(num value) {
    return NumberFormat.decimalPattern(GlassifyLocale.arabicLocale.languageCode).format(value).split('').map((e) => _numbers[e] ?? e).join();
  }

  @override
  String formatValue(String value) {
    return _numbers[value[0]] ?? value;
  }

  @override
  String formatCurrency(double value, {GlassifyCountry? country}) {
    return
      '${NumberFormat.decimalPattern(GlassifyLocale.arabicLocale.languageCode).format(value).split('').map((e) => _numbers[e] ?? e).join()}'
          '${country != null ? ' ${getCurrencySymbol(country.currencySymbol)}' : ''}';
  }

  static const _numbers = {
    '0' : '٠',
    '1': '١',
    '2': '٢',
    '3': '٣',
    '4': '٤',
    '5': '٥',
    '6': '٦',
    '7': '٧',
    '8': '٨',
    '9': '٩',
    '-': '-',
    '+': '+',
    ',': ',',
  };

  @override
  String formatPostedDate(DateTime dateTime) {
    return 'تم النشر قبل ${differenceDateFormat(dateTime)}';
  }

  @override
  String get mostRecentLabel => 'الأحدث أولآ';

  @override
  // TODO: implement mostRecentLabel
  String get mostPopularLabel => 'الأكثر شعبيه';

  @override
  // TODO: implement mostRelevantLabel
  String get mostRelevantLabel => 'الاكثر صلة بالبحث';

  @override
  // TODO: implement priceHighToLow
  String get priceLowToHighLabel => 'السعر من الأرخص للأغلى';

  @override
  // TODO: implement priceLowToHighLabel
  String get priceHighToLowLabel => 'السعر من الأغلى للأرخص';

  @override
  // TODO: implement colorLabel
  String get colorLabel => 'اللون';

  @override
  // TODO: implement listingTypeLabel
  String get listingTypeLabel => 'نوع القائمة';

  @override
  // TODO: implement modelLabel
  String get modelLabel => 'الموديل';

  @override
  // TODO: implement originLabel
  String get originLabel => 'البلد المنشأ';

  @override
  // TODO: implement filterDesignsLabel
  String get filterDesignsLabel => 'فلترة التصاميم';

  @override
  // TODO: implement logoLabel
  String get logoLabel => 'تصاميم شعارات';

  @override
  // TODO: implement decorateLabel
  String get decorateLabel => 'تصماميم ديكور';

  @override
  // TODO: implement graphicLabel
  String get graphicLabel => 'تصاميم جرافيك';

  @override
  // TODO: implement homeLabel
  String get homeLabel => 'الرئيسية';

  @override
  // TODO: implement searchLabel
  String get searchLabel => 'البحث';

  @override
  // TODO: implement cartLabel
  String get cartLabel => 'السلة';

  @override
  // TODO: implement profileLabel
  String get profileLabel => 'الشخصي';

  @override
  // TODO: implement dashboardLabel
  String get dashboardLabel => 'لوحة التحكم';

  @override
  // TODO: implement totalPriceLabel
  String get totalPriceLabel => 'إجمالي السعر';

}
