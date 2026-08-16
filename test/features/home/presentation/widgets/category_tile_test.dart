import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hubx_flutter_case/features/home/presentation/widgets/category_tile.dart';
import 'package:hubx_flutter_case/shared/widgets/app_network_image.dart';

import '../../../../helpers/pump_app.dart';

void main() {
  testWidgets('renders the title over the artwork and reports taps', (
    WidgetTester tester,
  ) async {
    int taps = 0;

    await tester.pumpApp(
      SizedBox(
        width: 160,
        height: 160,
        child: CategoryTile(
          title: 'Ferns',
          imageUrl: 'https://example.com/fern.png',
          semanticsLabel: 'Ferns category',
          onTap: () => taps++,
        ),
      ),
    );

    expect(find.text('Ferns'), findsOneWidget);
    expect(find.byType(AppNetworkImage), findsOneWidget);

    await tester.tap(find.byType(CategoryTile));
    await tester.pump();

    expect(taps, 1);
  });

  testWidgets('is one button to a screen reader, labelled by the caller', (
    WidgetTester tester,
  ) async {
    final SemanticsHandle handle = tester.ensureSemantics();

    await tester.pumpApp(
      SizedBox(
        width: 160,
        height: 160,
        child: CategoryTile(
          title: 'Ferns',
          imageUrl: '',
          semanticsLabel: 'Ferns category',
          onTap: () {},
        ),
      ),
    );

    // The tile excludes its own children's semantics, so the title is not
    // announced a second time next to the label.
    expect(
      tester.getSemantics(find.byType(CategoryTile)),
      isSemantics(label: 'Ferns category', isButton: true),
    );
    expect(find.bySemanticsLabel('Ferns'), findsNothing);

    handle.dispose();
  });
}
