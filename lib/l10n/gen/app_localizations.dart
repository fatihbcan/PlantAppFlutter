import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppL10n
/// returned by `AppL10n.of(context)`.
///
/// Applications need to include `AppL10n.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppL10n.localizationsDelegates,
///   supportedLocales: AppL10n.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppL10n.supportedLocales
/// property.
abstract class AppL10n {
  AppL10n(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppL10n of(BuildContext context) {
    return Localizations.of<AppL10n>(context, AppL10n)!;
  }

  static const LocalizationsDelegate<AppL10n> delegate = _AppL10nDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// Application name, shown as the task title.
  ///
  /// In en, this message translates to:
  /// **'PlantApp'**
  String get appTitle;

  /// No description provided for @commonRetry.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get commonRetry;

  /// No description provided for @commonContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get commonContinue;

  /// No description provided for @commonClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get commonClose;

  /// No description provided for @commonErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get commonErrorTitle;

  /// No description provided for @commonNetworkError.
  ///
  /// In en, this message translates to:
  /// **'You appear to be offline. Check your connection and try again.'**
  String get commonNetworkError;

  /// No description provided for @commonServerError.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t reach the server. Please try again in a moment.'**
  String get commonServerError;

  /// No description provided for @commonUnknownError.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred. Please try again.'**
  String get commonUnknownError;

  /// No description provided for @commonEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Nothing here yet'**
  String get commonEmptyTitle;

  /// Headline of the first onboarding page.
  ///
  /// In en, this message translates to:
  /// **'Welcome to {appName}'**
  String onboardingWelcomeTitle(String appName);

  /// No description provided for @onboardingWelcomeBody.
  ///
  /// In en, this message translates to:
  /// **'Identify more than 3000+ plants and 88% accuracy.'**
  String get onboardingWelcomeBody;

  /// No description provided for @onboardingWelcomeCta.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get onboardingWelcomeCta;

  /// No description provided for @onboardingWelcomeLegal.
  ///
  /// In en, this message translates to:
  /// **'By tapping next, you are agreeing to PlantID Terms of Use & Privacy Policy.'**
  String get onboardingWelcomeLegal;

  /// Substring of onboardingWelcomeLegal the design underlines.
  ///
  /// In en, this message translates to:
  /// **'Terms of Use'**
  String get onboardingTermsOfUse;

  /// Substring of onboardingWelcomeLegal the design underlines.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get onboardingPrivacyPolicy;

  /// No description provided for @onboardingIdentifyTitle.
  ///
  /// In en, this message translates to:
  /// **'Take a photo to identify the plant!'**
  String get onboardingIdentifyTitle;

  /// No description provided for @onboardingIdentifyHighlight.
  ///
  /// In en, this message translates to:
  /// **'identify'**
  String get onboardingIdentifyHighlight;

  /// No description provided for @onboardingIdentifyCta.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get onboardingIdentifyCta;

  /// No description provided for @onboardingDiagnoseTitle.
  ///
  /// In en, this message translates to:
  /// **'Get plant care guides'**
  String get onboardingDiagnoseTitle;

  /// No description provided for @onboardingDiagnoseHighlight.
  ///
  /// In en, this message translates to:
  /// **'care guides'**
  String get onboardingDiagnoseHighlight;

  /// No description provided for @onboardingDiagnoseCta.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get onboardingDiagnoseCta;

  /// Screen reader label for the onboarding page dots.
  ///
  /// In en, this message translates to:
  /// **'Page {current} of {total}'**
  String onboardingPageIndicator(int current, int total);

  /// No description provided for @paywallTitle.
  ///
  /// In en, this message translates to:
  /// **'PlantApp Premium'**
  String get paywallTitle;

  /// No description provided for @paywallSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Access All Features'**
  String get paywallSubtitle;

  /// No description provided for @paywallFeatureUnlimitedTitle.
  ///
  /// In en, this message translates to:
  /// **'Unlimited'**
  String get paywallFeatureUnlimitedTitle;

  /// No description provided for @paywallFeatureUnlimitedBody.
  ///
  /// In en, this message translates to:
  /// **'Plant Identify'**
  String get paywallFeatureUnlimitedBody;

  /// No description provided for @paywallFeatureFasterTitle.
  ///
  /// In en, this message translates to:
  /// **'Faster'**
  String get paywallFeatureFasterTitle;

  /// No description provided for @paywallFeatureFasterBody.
  ///
  /// In en, this message translates to:
  /// **'Process'**
  String get paywallFeatureFasterBody;

  /// No description provided for @paywallFeatureDetailedTitle.
  ///
  /// In en, this message translates to:
  /// **'Detailed'**
  String get paywallFeatureDetailedTitle;

  /// No description provided for @paywallFeatureDetailedBody.
  ///
  /// In en, this message translates to:
  /// **'Plant care'**
  String get paywallFeatureDetailedBody;

  /// No description provided for @paywallPlanMonthlyTitle.
  ///
  /// In en, this message translates to:
  /// **'1 Month'**
  String get paywallPlanMonthlyTitle;

  /// No description provided for @paywallPlanMonthlyBody.
  ///
  /// In en, this message translates to:
  /// **'{price}/month, auto renewable'**
  String paywallPlanMonthlyBody(String price);

  /// No description provided for @paywallPlanYearlyTitle.
  ///
  /// In en, this message translates to:
  /// **'1 Year'**
  String get paywallPlanYearlyTitle;

  /// No description provided for @paywallPlanYearlyBody.
  ///
  /// In en, this message translates to:
  /// **'First 3 days free, then {price}/year'**
  String paywallPlanYearlyBody(String price);

  /// No description provided for @paywallPlanBadge.
  ///
  /// In en, this message translates to:
  /// **'Save 50%'**
  String get paywallPlanBadge;

  /// No description provided for @paywallCta.
  ///
  /// In en, this message translates to:
  /// **'Try free for 3 days'**
  String get paywallCta;

  /// No description provided for @paywallLegal.
  ///
  /// In en, this message translates to:
  /// **'After the 3-day free trial period you\'ll be charged {price} per year unless you cancel before the trial expires. Yearly Subscription is Auto-Renewable'**
  String paywallLegal(String price);

  /// No description provided for @paywallTerms.
  ///
  /// In en, this message translates to:
  /// **'Terms'**
  String get paywallTerms;

  /// No description provided for @paywallPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get paywallPrivacy;

  /// No description provided for @paywallRestore.
  ///
  /// In en, this message translates to:
  /// **'Restore'**
  String get paywallRestore;

  /// No description provided for @paywallCloseSemantics.
  ///
  /// In en, this message translates to:
  /// **'Close and continue to home'**
  String get paywallCloseSemantics;

  /// No description provided for @homeGreeting.
  ///
  /// In en, this message translates to:
  /// **'Hi, plant lover!'**
  String get homeGreeting;

  /// No description provided for @homeQuestion.
  ///
  /// In en, this message translates to:
  /// **'Good Afternoon! ⛅'**
  String get homeQuestion;

  /// No description provided for @homeSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search for plants'**
  String get homeSearchHint;

  /// No description provided for @homePremiumBannerTitle.
  ///
  /// In en, this message translates to:
  /// **'FREE Premium Available'**
  String get homePremiumBannerTitle;

  /// No description provided for @homePremiumBannerBody.
  ///
  /// In en, this message translates to:
  /// **'Tap to upgrade your account!'**
  String get homePremiumBannerBody;

  /// No description provided for @homeQuestionsError.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t load the articles.'**
  String get homeQuestionsError;

  /// No description provided for @homeCategoriesError.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t load the categories.'**
  String get homeCategoriesError;

  /// No description provided for @homeSearchEmpty.
  ///
  /// In en, this message translates to:
  /// **'No plants match \"{query}\".'**
  String homeSearchEmpty(String query);

  /// No description provided for @homeCategoryItemSemantics.
  ///
  /// In en, this message translates to:
  /// **'{title} category'**
  String homeCategoryItemSemantics(String title);

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navDiagnose.
  ///
  /// In en, this message translates to:
  /// **'Diagnose'**
  String get navDiagnose;

  /// No description provided for @navScan.
  ///
  /// In en, this message translates to:
  /// **'Scan'**
  String get navScan;

  /// No description provided for @navMyGarden.
  ///
  /// In en, this message translates to:
  /// **'My Garden'**
  String get navMyGarden;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;
}

class _AppL10nDelegate extends LocalizationsDelegate<AppL10n> {
  const _AppL10nDelegate();

  @override
  Future<AppL10n> load(Locale locale) {
    return SynchronousFuture<AppL10n>(lookupAppL10n(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppL10nDelegate old) => false;
}

AppL10n lookupAppL10n(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppL10nEn();
  }

  throw FlutterError(
    'AppL10n.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
