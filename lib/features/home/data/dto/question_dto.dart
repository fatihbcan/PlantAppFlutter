import 'package:json_annotation/json_annotation.dart';

part 'question_dto.g.dart';

/// Wire shape of one "get started" article.
///
/// `getQuestions` returns a bare JSON array, so there is no envelope DTO here.
@JsonSerializable(createToJson: false)
class QuestionDto {
  const QuestionDto({
    required this.id,
    this.title,
    this.subtitle,
    this.imageUri,
    this.uri,
    this.order,
  });

  factory QuestionDto.fromJson(Map<String, dynamic> json) =>
      _$QuestionDtoFromJson(json);

  final int id;
  final String? title;
  final String? subtitle;

  @JsonKey(name: 'image_uri')
  final String? imageUri;

  final String? uri;
  final int? order;
}
