import 'package:auto_route/auto_route.dart';
import 'package:hubx_flutter_case/app/router/app_router.gr.dart';
import 'package:hubx_flutter_case/features/onboarding/domain/result/onboarding_results.dart';
import 'package:hubx_flutter_case/features/onboarding/domain/usecase/get_onboarding_status.dart';
import 'package:injectable/injectable.dart';

/// Keeps users who already finished onboarding out of it.
///
/// The guard sits on the onboarding branch rather than on home, so the
/// decision is made once, at the entry point of the flow, and a deep link
/// into the intro pages is redirected too.
@injectable
class OnboardingGuard extends AutoRouteGuard {
  OnboardingGuard(this._getStatus);

  final GetOnboardingStatus _getStatus;

  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    final OnboardingStatusResult status = await _getStatus();

    switch (status) {
      case OnboardingStatusCompleted():
        // Replace rather than push: onboarding must not sit under home in
        // the back stack.
        await router.replaceAll(<PageRouteInfo<void>>[const HomeRoute()]);
        resolver.next(false);
      case OnboardingStatusPending():
      case OnboardingStatusUnavailable():
        // If the flag cannot be read, show onboarding. Repeating it is a far
        // milder failure than locking someone out of the flow entirely.
        resolver.next();
    }
  }
}
