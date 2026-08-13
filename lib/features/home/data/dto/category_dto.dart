import 'package:json_annotation/json_annotation.dart';

part 'category_dto.g.dart';

/// `getCategories` wraps its payload in a Strapi-style envelope.
@JsonSerializable(createToJson: false)
class CategoriesResponseDto {
  const CategoriesResponseDto({required this.data});

  factory CategoriesResponseDto.fromJson(Map<String, dynamic> json) =>
      _$CategoriesResponseDtoFromJson(json);

  @JsonKey(defaultValue: <CategoryDto>[])
  final List<CategoryDto> data;
}

/// Wire shape of one category. Never leaves `data/`.
@JsonSerializable(createToJson: false)
class CategoryDto {
  const CategoryDto({required this.id, this.title, this.rank, this.image});

  factory CategoryDto.fromJson(Map<String, dynamic> json) =>
      _$CategoryDtoFromJson(json);

  final int id;
  final String? title;
  final int? rank;

  /// Nullable in the payload — some categories ship without artwork.
  final CategoryImageDto? image;
}

@JsonSerializable(createToJson: false)
class CategoryImageDto {
  const CategoryImageDto({this.url});

  factory CategoryImageDto.fromJson(Map<String, dynamic> json) =>
      _$CategoryImageDtoFromJson(json);

  final String? url;
}
