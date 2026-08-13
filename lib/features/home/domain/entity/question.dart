import 'package:freezed_annotation/freezed_annotation.dart';

part 'question.freezed.dart';

/// A "get started" article card on home.
@freezed
abstract class Question with _$Question {
  const factory Question({
    required int id,
    required String title,
    required String subtitle,
    required String imageUrl,
    required String articleUrl,
    @Default(0) int order,
  }) = _Question;

  const Question._();

  bool get hasImage => imageUrl.isNotEmpty;
}
