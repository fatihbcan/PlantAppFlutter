part of 'home_bloc.dart';

@freezed
sealed class HomeEvent with _$HomeEvent {
  /// The screen was opened.
  const factory HomeEvent.started() = HomeStarted;

  /// Pull-to-refresh, or a retry after a failure.
  const factory HomeEvent.refreshRequested() = HomeRefreshRequested;

  /// The user typed in the search field.
  const factory HomeEvent.searchChanged(String query) = HomeSearchChanged;

  /// The user cleared the search field.
  const factory HomeEvent.searchCleared() = HomeSearchCleared;
}
