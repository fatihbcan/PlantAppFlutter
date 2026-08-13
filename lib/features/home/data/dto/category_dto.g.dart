// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoriesResponseDto _$CategoriesResponseDtoFromJson(
  Map<String, dynamic> json,
) => CategoriesResponseDto(
  data:
      (json['data'] as List<dynamic>?)
          ?.map((e) => CategoryDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

CategoryDto _$CategoryDtoFromJson(Map<String, dynamic> json) => CategoryDto(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String?,
  rank: (json['rank'] as num?)?.toInt(),
  image: json['image'] == null
      ? null
      : CategoryImageDto.fromJson(json['image'] as Map<String, dynamic>),
);

CategoryImageDto _$CategoryImageDtoFromJson(Map<String, dynamic> json) =>
    CategoryImageDto(url: json['url'] as String?);
