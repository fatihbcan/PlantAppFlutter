import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hubx_flutter_case/core/theme/app_colors.dart';
import 'package:hubx_flutter_case/core/theme/app_dimens.dart';
import 'package:hubx_flutter_case/core/theme/app_typography.dart';
import 'package:hubx_flutter_case/core/theme/theme_extensions.dart';

import '../../helpers/pump_app.dart';

void main() {
  /// Reads the three extensions the way a widget does, from the context it
  /// is built in.
  Future<({AppColors colors, AppDimens dimens, AppTypography text})>
  readExtensions(WidgetTester tester, {required Size surfaceSize}) async {
    late AppColors colors;
    late AppDimens dimens;
    late AppTypography text;

    await tester.pumpApp(
      Builder(
        builder: (BuildContext context) {
          colors = context.appColors;
          dimens = context.appDimens;
          text = context.appText;
          return const SizedBox.shrink();
        },
      ),
      surfaceSize: surfaceSize,
    );

    return (colors: colors, dimens: dimens, text: text);
  }

  testWidgets('all three extensions resolve off the theme', (
    WidgetTester tester,
  ) async {
    final ({AppColors colors, AppDimens dimens, AppTypography text}) read =
        await readExtensions(tester, surfaceSize: defaultSurface);

    expect(read.colors, AppColors.light);
    expect(read.text, AppTypography.regular);
    expect(read.dimens.pageGutter, AppDimens.regular.pageGutter);
  });

  testWidgets('a short viewport drops to the compact scale', (
    WidgetTester tester,
  ) async {
    final ({AppColors colors, AppDimens dimens, AppTypography text}) read =
        await readExtensions(tester, surfaceSize: compactSurface);

    expect(read.dimens.pageGutter, AppDimens.compact.pageGutter);
    expect(read.dimens.controlHeight, AppDimens.compact.controlHeight);
    // Only the metrics shrink; the palette is the same either way.
    expect(read.colors, AppColors.light);
  });

  testWidgets('the breakpoint is a height of 700', (WidgetTester tester) async {
    final ({AppColors colors, AppDimens dimens, AppTypography text}) tall =
        await readExtensions(tester, surfaceSize: const Size(390, 700));
    expect(tall.dimens.pageGutter, AppDimens.regular.pageGutter);

    final ({AppColors colors, AppDimens dimens, AppTypography text}) short =
        await readExtensions(tester, surfaceSize: const Size(390, 699));
    expect(short.dimens.pageGutter, AppDimens.compact.pageGutter);
  });
}
