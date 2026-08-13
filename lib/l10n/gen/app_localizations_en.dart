// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppL10nEn extends AppL10n {
  AppL10nEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'PlantApp';

  @override
  String get commonRetry => 'Try again';

  @override
  String get commonContinue => 'Continue';

  @override
  String get commonClose => 'Close';

  @override
  String get commonErrorTitle => 'Something went wrong';

  @override
  String get commonNetworkError =>
      'You appear to be offline. Check your connection and try again.';

  @override
  String get commonServerError =>
      'We couldn\'t reach the server. Please try again in a moment.';

  @override
  String get commonUnknownError =>
      'An unexpected error occurred. Please try again.';

  @override
  String get commonEmptyTitle => 'Nothing here yet';

  @override
  String onboardingWelcomeTitle(String appName) {
    return 'Welcome to $appName';
  }

  @override
  String get onboardingWelcomeBody =>
      'Identify more than 3000+ plants and 88% accuracy.';

  @override
  String get onboardingWelcomeCta => 'Get Started';

  @override
  String get onboardingWelcomeLegal =>
      'By tapping next, you are agreeing to PlantID Terms of Use & Privacy Policy.';

  @override
  String get onboardingIdentifyTitle => 'Take a photo to identify the plant!';

  @override
  String get onboardingIdentifyHighlight => 'identify';

  @override
  String get onboardingIdentifyCta => 'Continue';

  @override
  String get onboardingDiagnoseTitle => 'Get plant care guides';

  @override
  String get onboardingDiagnoseHighlight => 'care guides';

  @override
  String get onboardingDiagnoseCta => 'Continue';

  @override
  String onboardingPageIndicator(int current, int total) {
    return 'Page $current of $total';
  }

  @override
  String get paywallTitle => 'PlantApp Premium';

  @override
  String get paywallSubtitle => 'Access All Features';

  @override
  String get paywallFeatureUnlimitedTitle => 'Unlimited';

  @override
  String get paywallFeatureUnlimitedBody => 'Plant Identify';

  @override
  String get paywallFeatureFasterTitle => 'Faster';

  @override
  String get paywallFeatureFasterBody => 'Process';

  @override
  String get paywallFeatureDetailedTitle => 'Detailed';

  @override
  String get paywallFeatureDetailedBody => 'Plant care';

  @override
  String get paywallPlanMonthlyTitle => '1 Month';

  @override
  String paywallPlanMonthlyBody(String price) {
    return '$price/month, auto renewable';
  }

  @override
  String get paywallPlanYearlyTitle => '1 Year';

  @override
  String paywallPlanYearlyBody(String price) {
    return 'First 3 days free, then $price/year';
  }

  @override
  String get paywallPlanBadge => 'Save 50%';

  @override
  String get paywallCta => 'Try free for 3 days';

  @override
  String paywallLegal(String price) {
    return 'After the 3-day free trial period you\'ll be charged $price per year unless you cancel before the trial expires. Yearly Subscription is Auto-Renewable';
  }

  @override
  String get paywallTerms => 'Terms';

  @override
  String get paywallPrivacy => 'Privacy';

  @override
  String get paywallRestore => 'Restore';

  @override
  String get paywallCloseSemantics => 'Close and continue to home';

  @override
  String get homeGreeting => 'Hi, plant lover!';

  @override
  String get homeQuestion => 'Good Afternoon! ⛅';

  @override
  String get homeSearchHint => 'Search for plants';

  @override
  String get homePremiumBannerTitle => 'FREE Premium Available';

  @override
  String get homePremiumBannerBody => 'Tap to upgrade your account!';

  @override
  String get homeQuestionsError => 'We couldn\'t load the articles.';

  @override
  String get homeCategoriesError => 'We couldn\'t load the categories.';

  @override
  String homeSearchEmpty(String query) {
    return 'No plants match \"$query\".';
  }

  @override
  String homeCategoryItemSemantics(String title) {
    return '$title category';
  }

  @override
  String get navHome => 'Home';

  @override
  String get navDiagnose => 'Diagnose';

  @override
  String get navScan => 'Scan';

  @override
  String get navMyGarden => 'My Garden';

  @override
  String get navProfile => 'Profile';
}
