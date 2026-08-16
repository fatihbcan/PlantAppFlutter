import 'package:flutter_test/flutter_test.dart';
import 'package:hubx_flutter_case/features/home/presentation/widgets/home_bottom_bar.dart';
import 'package:hubx_flutter_case/l10n/gen/app_localizations.dart';

import '../../../../helpers/pump_app.dart';

void main() {
  testWidgets('renders the four destinations of the design', (
    WidgetTester tester,
  ) async {
    await tester.pumpApp(HomeBottomBar(onScanPressed: () {}));

    final AppL10n l10n = tester.l10n;

    expect(find.text(l10n.navHome), findsOneWidget);
    expect(find.text(l10n.navDiagnose), findsOneWidget);
    expect(find.text(l10n.navMyGarden), findsOneWidget);
    expect(find.text(l10n.navProfile), findsOneWidget);
  });

  testWidgets(
    'marks the three dead destinations disabled for a screen reader',
    (WidgetTester tester) async {
      final SemanticsHandle handle = tester.ensureSemantics();

      await tester.pumpApp(HomeBottomBar(onScanPressed: () {}));

      final AppL10n l10n = tester.l10n;

      // Home is the only destination with a screen behind it: current, and
      // enabled.
      expect(
        tester.getSemantics(find.bySemanticsLabel(l10n.navHome)),
        isSemantics(
          label: l10n.navHome,
          hasEnabledState: true,
          isEnabled: true,
          isSelected: true,
        ),
      );

      // The rest render but do not respond, and say so rather than posing as
      // buttons that silently do nothing.
      for (final String label in <String>[
        l10n.navDiagnose,
        l10n.navMyGarden,
        l10n.navProfile,
      ]) {
        expect(
          tester.getSemantics(find.bySemanticsLabel(label)),
          isSemantics(
            label: label,
            hasEnabledState: true,
            isEnabled: false,
            isSelected: false,
          ),
          reason: '$label should be announced as disabled',
        );
      }

      handle.dispose();
    },
  );

  testWidgets('the scan control is a live button', (WidgetTester tester) async {
    final SemanticsHandle handle = tester.ensureSemantics();
    int scans = 0;

    await tester.pumpApp(HomeBottomBar(onScanPressed: () => scans++));

    final AppL10n l10n = tester.l10n;

    expect(
      tester.getSemantics(find.bySemanticsLabel(l10n.navScan)),
      isSemantics(label: l10n.navScan, isButton: true),
    );

    await tester.tap(find.bySemanticsLabel(l10n.navScan));
    await tester.pump();

    expect(scans, 1);

    handle.dispose();
  });
}
