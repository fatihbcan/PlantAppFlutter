import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hubx_flutter_case/shared/widgets/app_error_view.dart';

import '../../helpers/pump_app.dart';

void main() {
  testWidgets('shows the message, the icon and a working retry', (
    WidgetTester tester,
  ) async {
    int retries = 0;

    await tester.pumpApp(
      AppErrorView(
        message: 'It broke',
        retryLabel: 'Try again',
        onRetry: () => retries++,
      ),
    );

    expect(find.text('It broke'), findsOneWidget);
    expect(find.byIcon(Icons.cloud_off_rounded), findsOneWidget);

    await tester.tap(find.widgetWithText(TextButton, 'Try again'));
    await tester.pump();

    expect(retries, 1);
  });

  testWidgets('the compact variant drops the icon', (
    WidgetTester tester,
  ) async {
    await tester.pumpApp(
      AppErrorView(
        message: 'It broke',
        retryLabel: 'Try again',
        isCompact: true,
        onRetry: () {},
      ),
    );

    expect(find.text('It broke'), findsOneWidget);
    expect(find.byIcon(Icons.cloud_off_rounded), findsNothing);
  });

  testWidgets('announces itself as a live region', (WidgetTester tester) async {
    final SemanticsHandle handle = tester.ensureSemantics();

    await tester.pumpApp(
      AppErrorView(
        message: 'It broke',
        retryLabel: 'Try again',
        onRetry: () {},
      ),
    );

    expect(
      tester.getSemantics(find.text('It broke')),
      isSemantics(isLiveRegion: true),
    );

    handle.dispose();
  });
}
