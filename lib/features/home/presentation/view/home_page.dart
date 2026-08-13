import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hubx_flutter_case/app/di/injection.dart';
import 'package:hubx_flutter_case/core/theme/theme_extensions.dart';
import 'package:hubx_flutter_case/features/home/presentation/bloc/home_bloc.dart';
import 'package:hubx_flutter_case/features/home/presentation/view/home_view.dart';

/// Route entry for home: provides the Bloc and kicks off the first load.
@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (_) => getIt<HomeBloc>()..add(const HomeEvent.started()),
      child: Scaffold(
        backgroundColor: context.appColors.canvas,
        body: const SafeArea(bottom: false, child: HomeView()),
      ),
    );
  }
}
