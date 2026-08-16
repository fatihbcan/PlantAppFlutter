import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hubx_flutter_case/core/theme/app_theme.dart';
import 'package:hubx_flutter_case/l10n/gen/app_localizations.dart';

/// The surface every widget test renders on unless it asks for another.
///
/// Tall enough to stay above the 700dp breakpoint at which `context.appDimens`
/// swaps to the compact scale, so tests exercise the same metrics a phone
/// does.
const Size defaultSurface = Size(390, 844);

/// A surface tall enough that a whole screen is laid out at once.
///
/// Slivers only build what the viewport reaches, so a test that counts every
/// card or taps a footer control needs the page to fit rather than a scroll
/// per assertion.
const Size tallSurface = Size(390, 2000);

/// A short surface, below the compact breakpoint.
const Size compactSurface = Size(360, 640);

extension PumpApp on WidgetTester {
  /// Pumps [child] inside the theme, localisations and Material ancestor the
  /// views read from, on a [surfaceSize] viewport.
  ///
  /// This is the only way widget tests build a view: pumping a bare widget
  /// would miss the three ThemeExtensions and `AppL10n`, both of which every
  /// screen dereferences in `build`.
  Future<void> pumpApp(
    Widget child, {
    Size surfaceSize = defaultSurface,
  }) async {
    view.devicePixelRatio = 1;
    view.physicalSize = surfaceSize;
    addTearDown(view.reset);

    await pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        localizationsDelegates: AppL10n.localizationsDelegates,
        supportedLocales: AppL10n.supportedLocales,
        home: Scaffold(body: _Host(child: child)),
      ),
    );
  }

  /// The localisations the pumped tree resolved, so tests assert against the
  /// same strings the widget rendered instead of copies of them.
  AppL10n get l10n => AppL10n.of(element(find.byType(_Host)));
}

/// A known type under the localisations delegate, for [PumpApp.l10n] to
/// resolve against.
class _Host extends StatelessWidget {
  const _Host({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => child;
}
