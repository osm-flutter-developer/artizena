
import 'package:glassify/providers/countries.dart';
import 'package:intl/intl.dart';
import 'package:intl/number_symbols.dart';

import 'glassify_locale.dart';

class EnglishLocale extends GlassifyLocale {
  EnglishLocale() : super(languageCode: 'en', localization: _EnglishLocalization());

  @override
  String get localeName => 'English';

  NumberSymbols? _symbols;
  @override
  NumberSymbols get numberSymbols => _symbols ??= NumberSymbols(
      NAME: "en",
      DECIMAL_SEP: '.',
      GROUP_SEP: ',',
      PERCENT: '%',
      ZERO_DIGIT: '0',
      PLUS_SIGN: '+',
      MINUS_SIGN: '-',
      EXP_SYMBOL: 'E',
      PERMILL: '\u2030',
      INFINITY: '\u221E',
      NAN: 'NaN',
      DECIMAL_PATTERN: '#,##0.###',
      SCIENTIFIC_PATTERN: '#E0',
      PERCENT_PATTERN: '#,##0%',
      CURRENCY_PATTERN: '\u00A4#,##0.00',
      DEF_CURRENCY_CODE: 'USD',
  );

}



class _EnglishLocalization with AppLocalization {

  GlassifyLocale get locale => GlassifyLocale.englishLocale;

  @override
  String get appName => 'Glassify';

  @override
  // TODO: implement chatsLabel
  String get chatsLabel => 'Chats';

  @override
  // TODO: implement likesLabel
  String get likesLabel => 'Likes';

  @override
  // TODO: implement likesLabel
  String get dislikesLabel => 'Dislikes';

  @override
  // TODO: implement notificationsLabel
  String get notificationsLabel => 'Notification';

  @override
  // TODO: implement settingsLabel
  String get settingsLabel => 'Settings';

  @override
  // TODO: implement countryLabel
  String get countryLabel => 'Country';

  @override
  // TODO: implement designLabel
  String get designLabel => 'Design';

  @override
  // TODO: implement buyDesignButton
  String get buyDesignButton => 'Buy It Now';

  @override
  // TODO: implement followersLabel
  String get followersLabel => 'Followers';

  @override
  // TODO: implement followingDesignButton
  String get followDesignerLabel => 'Follow';

  @override
  // TODO: implement followingDesignButton
  String get followedDesignerLabel => 'Followed';

  @override
  // TODO: implement postsLabel
  String get postsLabel => 'Posts';

  @override
  // TODO: implement transactionLabel
  String get transactionLabel => 'Transactions';

  @override
  // TODO: implement commentLabel
  String get commentLabel => 'Comment';

  @override
  // TODO: implement priceLabel
  String get priceLabel => 'Price';

  @override
  // TODO: implement loginLabel
  String get signInLabel => 'Sign In';

  @override
  // TODO: implement passwordLabel
  String get passwordLabel => 'Password';

  @override
  // TODO: implement enterPasswordLabel
  String get enterPasswordLabel => 'Enter Password';

  @override
  // TODO: implement userNameLabel
  String get userNameLabel => 'User Name';

  @override
  // TODO: implement EnterUserNameLabel
  String get enterUserNameLabel => 'Enter User Name';

  @override
  // TODO: implement customerNameLabel
  String get customerNameLabel => 'Customer';

  @override
  // TODO: implement designerNameLabel
  String get designerNameLabel => 'Designer';

  @override
  // TODO: implement systemUserLabel
  String get systemUserLabel => 'System User';

  @override
  // TODO: implement createAccountLabel
  String get createAccountLabel => 'Create New Account';

  @override
  // TODO: implement forgetPasswordLabel
  String get forgetPasswordLabel => 'Forgot Password ?';

  @override
  // TODO: implement localSystemLocale
  String get localSystemLocale => 'System Language';

  @override
  // TODO: implement freePhoneNumberLabel
  String get freePhoneNumberLabel => 'Free Number';

  @override
  String get servicePoints => 'Service Points';

  @override
  String get customersService => 'Customers Service';

  @override
  // TODO: implement similarDesigns
  String get similarDesigns => 'Similar Designs';

  @override
  // TODO: implement ratingLabel
  String get ratingLabel => 'Rating';

  @override
  // TODO: implement reviewsLabel
  String get reviewsLabel => 'Reviews';

  @override
  // TODO: implement writeComment
  String get writeComment => 'Type Comment';

  @override
  // TODO: implement beFirstToComment
  String get beFirstToComment => 'Be the first to comment...';

  @override
  // TODO: implement categoryLabel
  String get categoryLabel => 'Category';

  @override
  // TODO: implement postedAgo
  String get postedAgo => 'Posted Before';

  @override
  // TODO: implement daysName
  String get daysName => 'days';

  @override
  // TODO: implement monthsName
  String get monthsName => 'months';

  @override
  // TODO: implement yearName
  String get yearName => 'years';

  @override
  // TODO: implement reportThisPost
  String get reportThisPost => 'Report this post';

  @override
  // TODO: implement seeMore
  String get seeMore => 'See More';

  @override
  // TODO: implement languageLabel
  String get languageLabel => 'Language';

  @override
  // TODO: implement currencyLabel
  String get currencyLabel => 'Currency';

  @override
  // TODO: implement changePasswordLabel
  String get changePasswordLabel => 'Change Password';

  @override
  // TODO: implement deleteAccountLabel
  String get deleteAccountLabel => 'Delete Account';

  @override
  // TODO: implement applicationAttributes
  String get applicationAttributes => 'Application Mode';

  @override
  // TODO: implement applicationVersion
  String get applicationVersion => 'Application Version';

  @override
  // TODO: implement applicationRating
  String get applicationRating => 'Application Rating';

  @override
  // TODO: implement phoneNumberLabel
  String get phoneNumberLabel => 'Phone Number';

  @override
  // TODO: implement signOutLabel
  String get signOutLabel => 'Log Out';

  @override
  // TODO: implement editProfileLabel
  String get editProfileLabel => 'ُEdit Profile';

  @override
  // TODO: implement walletsLabel
  String get walletsLabel => 'Wallets';

  @override
  // TODO: implement joinedIn
  String get joinedIn => 'Joined in';

  @override
  // TODO: implement discountLabel
  String get discountLabel => 'off';

  @override
  // TODO: implement writeMessage
  String get writeMessage => 'Type A Message';

  @override
  // TODO: implement searchHere
  String get searchHere => 'Search Here';

  @override
  String getCurrencySymbol(String currencySymbol) {
    switch(currencySymbol) {
      case 'USD': return '\$';
      case 'YER': return currencySymbol;
    }
    return currencySymbol;
  }

  @override
  String getCountryName(String countryCode) {
    switch(countryCode) {
      case 'YE': return 'Yemen';
      case 'US': return 'United States';
    }
    return countryCode;
  }

  @override
  String get ago => 'Ago';

  @override
  // TODO: implement describeDesign
  String get describeDesign => 'Describe Design';

  @override
  // TODO: implement popularDesigns
  String get popularDesigns => 'Popular Designs';

  @override
  // TODO: implement popularDesigns
  String get suggestedDesigns => 'Suggested Designs';

  @override
  String getDaysName(int countDays) {
    return '$countDays day${countDays > 1 ? 's' : ''}';
  }

  @override
  String getHoursName(int inHours) {
    return '$inHours hour${inHours > 1 ? 's' : ''}';
  }

  @override
  String getMinutesName(int inMinutes) {
    return '$inMinutes minute${inMinutes > 1 ? 's' : ''}';
  }

  @override
  String getMonthsName(int months) {
    return '$months month${months > 1 ? 's' : ''}';
  }

  @override
  String getSecondsName(int inSeconds) {
    return '$inSeconds second${inSeconds > 1 ? 's' : ''}';
  }

  @override
  String getYearName(int years) {
    return '$years year${years > 1 ? 's' : ''}';
  }

  @override
  String getUserNameLabel(String name) {
    switch(name) {
      case 'customer': return 'Customer';
      case 'designer': return 'Designer';
      case 'systemUser': return 'System User';
    }
    return name;
  }

  @override
  String getDesignLabel({bool withPrefix = true, int? counter}) {
    var designLabel = '${withPrefix ? 'The ' : ''}Design';
    if((counter ?? 0) > 0) designLabel = '$counter $designLabel${counter! > 1 ? 's' : ''}';
    return designLabel;
  }

  @override
  String formatCurrency(double value, {GlassifyCountry<GlassifyLocale<AppLocalization>>? country}) {
    return '${country != null ? '${getCurrencySymbol(country.currencySymbol)} ' : ''}' '${formatNumber(value)}';
  }

  @override
  String formatNumber(num value) {
    return NumberFormat.decimalPattern(locale.languageCode).format(value);
  }

  @override
  String formatPostedDate(DateTime dateTime) {
    return 'Posted ${differenceDateFormat(dateTime)} ago';
  }

  @override
  String get mostPopularLabel => 'Most Popular';

  @override
  // TODO: implement mostRecentLabel
  String get mostRecentLabel => 'Most Recent';

  @override
  // TODO: implement mostRelevantLabel
  String get mostRelevantLabel => 'Most Relevant';

  @override
  // TODO: implement priceHighToLow
  String get priceLowToHighLabel => 'Price: Low to High';

  @override
  // TODO: implement priceLowToHighLabel
  String get priceHighToLowLabel => 'Price: High to Low';

  @override
  // TODO: implement colorLabel
  String get colorLabel => 'Color';

  @override
  // TODO: implement listingTypeLabel
  String get listingTypeLabel => 'Listing Type';

  @override
  // TODO: implement modelLabel
  String get modelLabel => 'Model';

  @override
  // TODO: implement originLabel
  String get originLabel => 'Origin';

  @override
  // TODO: implement filterDesignsLabel
  String get filterDesignsLabel => 'Filter Designs';

  @override
  // TODO: implement logoLabel
  String get logoLabel => 'Logo Designs';

  @override
  // TODO: implement decorateLabel
  String get decorateLabel => 'Decorate Designs';

  @override
  // TODO: implement graphicLabel
  String get graphicLabel => 'Graphic Designs';

  @override
  // TODO: implement homeLabel
  String get homeLabel => 'Home';

  @override
  // TODO: implement searchLabel
  String get searchLabel => 'Search';

  @override
  // TODO: implement cartLabel
  String get cartLabel => 'Cart';

  @override
  // TODO: implement profileLabel
  String get profileLabel => 'Profile';

  @override
  // TODO: implement dashboardLabel
  String get dashboardLabel => 'Dashboard';

  @override
  // TODO: implement totalPriceLabel
  String get totalPriceLabel => 'Total Price';

}