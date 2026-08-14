part of 'intro_bloc.dart';

@freezed
abstract class IntroState with _$IntroState {
  const factory IntroState({
    @Default(0) int pageIndex,
    @Default(IntroBloc.pageCount) int pageCount,

    /// Set when the flow should advance to the paywall; the view consumes it
    /// through a [BlocListener] and it is cleared by [IntroBloc].
    @Default(false) bool isFinished,
  }) = _IntroState;

  const IntroState._();

  bool get isFirstPage => pageIndex == 0;

  bool get isLastPage => pageIndex == pageCount - 1;

  /// Page dots are only drawn from the second page onward in the design.
  bool get showsPageIndicator => !isFirstPage;

  /// Which dot is filled. The design's three dots cover the two onboarding
  /// pages and the paywall that follows them — the welcome page sits before
  /// the run and shows no dots at all, so the first dot belongs to page two.
  int get indicatorIndex => pageIndex - 1;

  /// 1-based position, for the screen-reader announcement.
  int get humanPageNumber => pageIndex + 1;
}
