import 'package:flutter/material.dart';
import 'package:hubx_flutter_case/app/di/injection.dart';
import 'package:hubx_flutter_case/app/router/app_router.dart';
import 'package:hubx_flutter_case/core/theme/app_theme.dart';
import 'package:hubx_flutter_case/l10n/gen/app_localizations.dart';

/// Root widget: theme, localisations and the router. No business logic.
class App extends StatelessWidget {
  App({super.key});

  final AppRouter _router = getIt<AppRouter>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      onGenerateTitle: (BuildContext context) => AppL10n.of(context).appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      // Both themes are first-class; the platform decides which one shows.
      // AppL10n.localizationsDelegates already bundles the Material, Widgets
      // and Cupertino delegates.
      localizationsDelegates: AppL10n.localizationsDelegates,
      supportedLocales: AppL10n.supportedLocales,
      routerConfig: _router.config(),
    );
  }
}
