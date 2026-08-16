import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hubx_flutter_case/app/di/injection.dart';
import 'package:hubx_flutter_case/app/router/app_router.gr.dart';
import 'package:hubx_flutter_case/core/theme/theme_extensions.dart';
import 'package:hubx_flutter_case/features/onboarding/presentation/paywall/bloc/paywall_bloc.dart';
import 'package:hubx_flutter_case/features/onboarding/presentation/paywall/view/paywall_view.dart';
import 'package:hubx_flutter_case/l10n/gen/app_localizations.dart';

/// Route entry for the paywall.
///
/// The screen serves two entries. As the last step of onboarding it closes the
/// flow: the Bloc has recorded completion by the time the user leaves, so the
/// router replaces the whole stack with home rather than popping back into the
/// intro pages. Opened later as an upsell — from the home premium banner — it
/// is an ordinary page on top of home, so it pops back to the screen that
/// pushed it and leaves the stack alone.
@RoutePage()
class PaywallPage extends StatelessWidget {
  const PaywallPage({this.completesOnboarding = true, super.key});

  /// Whether leaving this screen also ends onboarding, which is what decides
  /// between replacing the stack and popping. True by default so a deep link
  /// to `/paywall` behaves like the onboarding entry.
  final bool completesOnboarding;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PaywallBloc>(
      create: (_) => getIt<PaywallBloc>()
        ..add(PaywallEvent.started(completesOnboarding: completesOnboarding)),
      child: BlocListener<PaywallBloc, PaywallState>(
        listenWhen: (PaywallState previous, PaywallState current) =>
            !previous.shouldExit && current.shouldExit,
        listener: (BuildContext context, PaywallState state) {
          context.read<PaywallBloc>().add(const PaywallEvent.exitConsumed());

          if (state.error == PaywallError.completionFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(AppL10n.of(context).commonUnknownError)),
            );
          }

          if (completesOnboarding) {
            unawaited(
              context.router.replaceAll(<PageRouteInfo<void>>[
                const HomeRoute(),
              ]),
            );
          } else {
            unawaited(context.router.maybePop());
          }
        },
        child: Scaffold(
          backgroundColor: context.appColors.premiumCanvas,
          body: const PaywallView(),
        ),
      ),
    );
  }
}
