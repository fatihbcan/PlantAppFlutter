import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hubx_flutter_case/core/theme/app_colors.dart';
import 'package:hubx_flutter_case/shared/widgets/app_network_image.dart';

import '../../helpers/pump_app.dart';

void main() {
  // The placeholder is a private widget, so it is identified by the one thing
  // that is observable about it: the themed ground it paints.
  final Finder placeholder = find.byWidgetPredicate(
    (Widget widget) =>
        widget is Container && widget.color == AppColors.light.surfaceMuted,
  );

  testWidgets('an empty url renders the placeholder without a network image', (
    WidgetTester tester,
  ) async {
    await tester.pumpApp(
      const SizedBox(width: 100, height: 100, child: AppNetworkImage(url: '')),
    );

    expect(placeholder, findsOneWidget);
    expect(find.byType(Image), findsNothing);
    // No glyph: an absent url is not a failure, so it stays a plain ground.
    expect(find.byIcon(Icons.image_not_supported_outlined), findsNothing);
  });

  testWidgets('a request that fails falls back to the placeholder', (
    WidgetTester tester,
  ) async {
    // The test binding fails every HTTP request, which is exactly the case
    // this widget's errorBuilder exists for.
    await tester.pumpApp(
      const SizedBox(
        width: 100,
        height: 100,
        child: AppNetworkImage(url: 'https://example.com/leaf.png'),
      ),
    );
    await tester.pump();

    expect(placeholder, findsOneWidget);
    expect(find.byIcon(Icons.image_not_supported_outlined), findsOneWidget);
  });

  testWidgets('a semantic label is published for the image', (
    WidgetTester tester,
  ) async {
    await tester.pumpApp(
      const SizedBox(
        width: 100,
        height: 100,
        child: AppNetworkImage(
          url: 'https://example.com/leaf.png',
          semanticLabel: 'A fern',
        ),
      ),
    );

    final Image image = tester.widget(find.byType(Image));
    expect(image.semanticLabel, 'A fern');
    expect(image.excludeFromSemantics, isFalse);
  });
}
