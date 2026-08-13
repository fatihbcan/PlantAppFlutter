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
/// This screen closes the onboarding flow: whichever way the user leaves it,
/// the Bloc has already recorded completion, so the router replaces the whole
/// stack with home rather than popping back into the intro pages.
@RoutePage()
class PaywallPage extends StatelessWidget {
  const PaywallPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PaywallBloc>(
      create: (_) => getIt<PaywallBloc>()..add(const PaywallEvent.started()),
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

          unawaited(
            context.router.replaceAll(<PageRouteInfo<void>>[const HomeRoute()]),
          );
        },
        child: Scaffold(
          backgroundColor: context.appColors.premiumCanvas,
          body: const PaywallView(),
        ),
      ),
    );
  }
}
