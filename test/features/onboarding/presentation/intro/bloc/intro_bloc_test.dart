import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hubx_flutter_case/features/onboarding/presentation/intro/bloc/intro_bloc.dart';

void main() {
  group('nextPressed', () {
    blocTest<IntroBloc, IntroState>(
      'advances one page at a time',
      build: IntroBloc.new,
      act: (IntroBloc bloc) => bloc.add(const IntroEvent.nextPressed()),
      expect: () => <IntroState>[const IntroState(pageIndex: 1)],
    );

    blocTest<IntroBloc, IntroState>(
      'never skips a page when the CTA is mashed',
      build: IntroBloc.new,
      act: (IntroBloc bloc) => bloc
        ..add(const IntroEvent.nextPressed())
        ..add(const IntroEvent.nextPressed()),
      expect: () => <IntroState>[
        const IntroState(pageIndex: 1),
        const IntroState(pageIndex: 2),
      ],
    );

    blocTest<IntroBloc, IntroState>(
      'finishes the flow on the last page instead of overrunning',
      build: IntroBloc.new,
      seed: () => const IntroState(pageIndex: 2),
      act: (IntroBloc bloc) => bloc.add(const IntroEvent.nextPressed()),
      expect: () => <IntroState>[
        const IntroState(pageIndex: 2, isFinished: true),
      ],
    );
  });

  group('pageSwiped', () {
    blocTest<IntroBloc, IntroState>(
      'follows the page view',
      build: IntroBloc.new,
      act: (IntroBloc bloc) => bloc.add(const IntroEvent.pageSwiped(2)),
      expect: () => <IntroState>[const IntroState(pageIndex: 2)],
    );

    blocTest<IntroBloc, IntroState>(
      'ignores a swipe to the current page',
      build: IntroBloc.new,
      act: (IntroBloc bloc) => bloc.add(const IntroEvent.pageSwiped(0)),
      expect: () => <IntroState>[],
    );

    blocTest<IntroBloc, IntroState>(
      'clamps an out-of-range index rather than throwing',
      build: IntroBloc.new,
      act: (IntroBloc bloc) => bloc.add(const IntroEvent.pageSwiped(99)),
      expect: () => <IntroState>[const IntroState(pageIndex: 2)],
    );
  });

  group('finishConsumed', () {
    blocTest<IntroBloc, IntroState>(
      'clears the flag once the view has navigated',
      build: IntroBloc.new,
      seed: () => const IntroState(pageIndex: 2, isFinished: true),
      act: (IntroBloc bloc) => bloc.add(const IntroEvent.finishConsumed()),
      expect: () => <IntroState>[const IntroState(pageIndex: 2)],
    );

    blocTest<IntroBloc, IntroState>(
      'is a no-op when the flag is already clear',
      build: IntroBloc.new,
      act: (IntroBloc bloc) => bloc.add(const IntroEvent.finishConsumed()),
      expect: () => <IntroState>[],
    );
  });

  group('state getters', () {
    test('isFirstPage and isLastPage bound the range', () {
      expect(const IntroState().isFirstPage, isTrue);
      expect(const IntroState().isLastPage, isFalse);
      expect(const IntroState(pageIndex: 2).isLastPage, isTrue);
    });

    test('the dots are hidden on the first page only', () {
      expect(const IntroState().showsPageIndicator, isFalse);
      expect(const IntroState(pageIndex: 1).showsPageIndicator, isTrue);
    });

    test('humanPageNumber is 1-based for the screen reader', () {
      expect(const IntroState().humanPageNumber, 1);
      expect(const IntroState(pageIndex: 2).humanPageNumber, 3);
    });
  });
}
