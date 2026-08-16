import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hubx_flutter_case/app/di/injection.dart';
import 'package:hubx_flutter_case/app/router/app_router.gr.dart';
import 'package:hubx_flutter_case/core/theme/theme_extensions.dart';
import 'package:hubx_flutter_case/features/onboarding/presentation/intro/bloc/intro_bloc.dart';
import 'package:hubx_flutter_case/features/onboarding/presentation/intro/view/intro_view.dart';

/// Route entry for the intro pages: provides the Bloc, owns the one
/// navigation side effect, and delegates all layout to [IntroView].
@RoutePage()
class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<IntroBloc>(
      create: (_) => getIt<IntroBloc>(),
      child: BlocListener<IntroBloc, IntroState>(
        listenWhen: (IntroState previous, IntroState current) =>
            !previous.isFinished && current.isFinished,
        listener: (BuildContext context, IntroState state) {
          context.read<IntroBloc>().add(const IntroEvent.finishConsumed());
          unawaited(context.router.push(PaywallRoute()));
        },
        child: Scaffold(
          backgroundColor: context.appColors.canvas,
          body: const SafeArea(bottom: false, child: IntroView()),
        ),
      ),
    );
  }
}
