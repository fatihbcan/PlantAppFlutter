// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionDto _$QuestionDtoFromJson(Map<String, dynamic> json) => QuestionDto(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String?,
  subtitle: json['subtitle'] as String?,
  imageUri: json['image_uri'] as String?,
  uri: json['uri'] as String?,
  order: (json['order'] as num?)?.toInt(),
);
