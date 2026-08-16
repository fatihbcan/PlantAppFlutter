import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hubx_flutter_case/app/di/injection.dart';
import 'package:hubx_flutter_case/app/router/app_router.gr.dart';
import 'package:hubx_flutter_case/core/theme/theme_extensions.dart';
import 'package:hubx_flutter_case/features/home/presentation/bloc/home_bloc.dart';
import 'package:hubx_flutter_case/features/home/presentation/view/home_view.dart';
import 'package:hubx_flutter_case/features/home/presentation/widgets/home_bottom_bar.dart';

/// Route entry for home: provides the Bloc, kicks off the first load, and owns
/// the one navigation side effect — the premium banner.
@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (_) => getIt<HomeBloc>()..add(const HomeEvent.started()),
      child: Scaffold(
        backgroundColor: context.appColors.canvas,
        body: SafeArea(
          bottom: false,
          child: HomeView(onPremiumTap: () => _openPaywall(context)),
        ),
        // Only Home has a screen in this case; the scan control is the one
        // live affordance in the bar.
        bottomNavigationBar: HomeBottomBar(onScanPressed: () {}),
      ),
    );
  }

  /// Pushes the paywall over home rather than replacing it: onboarding is long
  /// finished by now, so closing the paywall pops straight back to this page
  /// with its state intact.
  void _openPaywall(BuildContext context) {
    unawaited(
      context.router.push(PaywallRoute(completesOnboarding: false)),
    );
  }
}
