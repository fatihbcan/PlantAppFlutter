import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.freezed.dart';

/// A plant category tile on the home grid.
@freezed
abstract class Category with _$Category {
  const factory Category({
    required int id,
    required String title,
    required String imageUrl,
    @Default(0) int rank,
  }) = _Category;

  const Category._();

  bool get hasImage => imageUrl.isNotEmpty;
}
