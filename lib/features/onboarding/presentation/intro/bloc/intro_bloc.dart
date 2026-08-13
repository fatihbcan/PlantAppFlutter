import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'intro_bloc.freezed.dart';
part 'intro_event.dart';
part 'intro_state.dart';

/// Drives the three intro pages and decides when the flow moves on.
///
/// It owns no I/O — the completion flag is written by the paywall, since the
/// case ends onboarding at the paywall's close button, not here.
@injectable
class IntroBloc extends Bloc<IntroEvent, IntroState> {
  IntroBloc() : super(const IntroState()) {
    // Sequential: a double-tap on the CTA must advance two pages, not one,
    // and must never drop a page.
    on<IntroNextPressed>(_onNextPressed, transformer: sequential());
    on<IntroPageSwiped>(_onPageSwiped, transformer: sequential());
    on<IntroFinishConsumed>(_onFinishConsumed, transformer: sequential());
  }

  static const int pageCount = 3;

  void _onNextPressed(IntroNextPressed event, Emitter<IntroState> emit) {
    if (state.isLastPage) {
      emit(state.copyWith(isFinished: true));
      return;
    }
    emit(state.copyWith(pageIndex: state.pageIndex + 1));
  }

  void _onPageSwiped(IntroPageSwiped event, Emitter<IntroState> emit) {
    final int page = event.page.clamp(0, state.pageCount - 1);
    if (page == state.pageIndex) return;
    emit(state.copyWith(pageIndex: page));
  }

  void _onFinishConsumed(IntroFinishConsumed event, Emitter<IntroState> emit) {
    if (!state.isFinished) return;
    emit(state.copyWith(isFinished: false));
  }
}
