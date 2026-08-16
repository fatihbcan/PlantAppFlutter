import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hubx_flutter_case/features/home/presentation/widgets/question_card.dart';
import 'package:hubx_flutter_case/shared/widgets/app_network_image.dart';

import '../../../../helpers/pump_app.dart';

void main() {
  testWidgets('renders the title over the photo and reports taps', (
    WidgetTester tester,
  ) async {
    int taps = 0;

    await tester.pumpApp(
      SizedBox(
        height: 180,
        child: QuestionCard(
          title: 'How to identify plants?',
          imageUrl: 'https://example.com/card.png',
          width: 240,
          onTap: () => taps++,
        ),
      ),
    );

    expect(find.text('How to identify plants?'), findsOneWidget);
    expect(find.byType(AppNetworkImage), findsOneWidget);

    await tester.tap(find.byType(QuestionCard));
    await tester.pump();

    expect(taps, 1);
  });

  testWidgets('takes the width the carousel gives it', (
    WidgetTester tester,
  ) async {
    await tester.pumpApp(
      const SizedBox(
        height: 180,
        child: QuestionCard(
          title: 'How to identify plants?',
          imageUrl: '',
          width: 240,
          onTap: _noop,
        ),
      ),
    );

    expect(tester.getSize(find.byType(QuestionCard)).width, 240);
  });

  testWidgets('is announced as a button carrying the article title', (
    WidgetTester tester,
  ) async {
    final SemanticsHandle handle = tester.ensureSemantics();

    await tester.pumpApp(
      const SizedBox(
        height: 180,
        child: QuestionCard(
          title: 'How to identify plants?',
          imageUrl: '',
          width: 240,
          onTap: _noop,
        ),
      ),
    );

    expect(
      tester.getSemantics(find.byType(QuestionCard)),
      isSemantics(label: 'How to identify plants?', isButton: true),
    );

    handle.dispose();
  });
}

void _noop() {}
