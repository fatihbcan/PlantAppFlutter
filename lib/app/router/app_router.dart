import 'package:auto_route/auto_route.dart';
import 'package:hubx_flutter_case/app/router/app_router.gr.dart';
import 'package:hubx_flutter_case/app/router/onboarding_guard.dart';
import 'package:injectable/injectable.dart';

export 'package:hubx_flutter_case/app/router/app_router.gr.dart';

/// The app's only route table.
///
/// Adding a screen means adding it here — a page that exists only in the
/// widget tree is unreachable by deep link and by `replaceAll`.
@AutoRouterConfig()
@lazySingleton
class AppRouter extends RootStackRouter {
  AppRouter(this._onboardingGuard);

  final OnboardingGuard _onboardingGuard;

  @override
  List<AutoRoute> get routes => <AutoRoute>[
    AutoRoute(
      page: IntroRoute.page,
      path: '/',
      initial: true,
      guards: <AutoRouteGuard>[_onboardingGuard],
    ),
    AutoRoute(page: PaywallRoute.page, path: '/paywall'),
    AutoRoute(page: HomeRoute.page, path: '/home'),
  ];
}
