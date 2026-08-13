part of 'intro_bloc.dart';

@freezed
sealed class IntroEvent with _$IntroEvent {
  /// The user tapped the CTA on the current page.
  const factory IntroEvent.nextPressed() = IntroNextPressed;

  /// The user swiped the page view to [page].
  const factory IntroEvent.pageSwiped(int page) = IntroPageSwiped;

  /// The view has acted on [IntroState.isFinished] and the flag can be
  /// cleared, so returning to this page does not re-navigate.
  const factory IntroEvent.finishConsumed() = IntroFinishConsumed;
}
