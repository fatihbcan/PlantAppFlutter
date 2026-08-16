import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hubx_flutter_case/shared/widgets/app_primary_button.dart';

import '../../helpers/pump_app.dart';

void main() {
  testWidgets('renders the label and reports taps', (
    WidgetTester tester,
  ) async {
    int taps = 0;

    await tester.pumpApp(
      AppPrimaryButton(label: 'Continue', onPressed: () => taps++),
    );

    expect(find.text('Continue'), findsOneWidget);

    await tester.tap(find.byType(AppPrimaryButton));
    await tester.pump();

    expect(taps, 1);
  });

  testWidgets('a null callback disables the button', (
    WidgetTester tester,
  ) async {
    await tester.pumpApp(
      const AppPrimaryButton(label: 'Continue', onPressed: null),
    );

    final ElevatedButton button = tester.widget(find.byType(ElevatedButton));
    expect(button.onPressed, isNull);
  });

  testWidgets('loading swaps the label for a spinner and blocks taps', (
    WidgetTester tester,
  ) async {
    int taps = 0;

    await tester.pumpApp(
      AppPrimaryButton(
        label: 'Continue',
        isLoading: true,
        onPressed: () => taps++,
      ),
    );

    expect(find.text('Continue'), findsNothing);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.tap(find.byType(AppPrimaryButton));
    await tester.pump();

    expect(taps, isZero);
  });
}
