import 'package:hubx_flutter_case/features/home/data/dto/category_dto.dart';
import 'package:hubx_flutter_case/features/home/data/dto/question_dto.dart';
import 'package:hubx_flutter_case/features/home/domain/entity/category.dart';
import 'package:hubx_flutter_case/features/home/domain/entity/question.dart';

/// DTO → entity conversions, applied at the repository boundary.
///
/// Nullable wire fields collapse to safe defaults here so no entity, Bloc or
/// widget downstream has to reason about nulls from the API.
extension CategoryDtoMapper on CategoryDto {
  Category toEntity() => Category(
    id: id,
    title: title ?? '',
    imageUrl: image?.url ?? '',
    rank: rank ?? 0,
  );
}

extension QuestionDtoMapper on QuestionDto {
  Question toEntity() => Question(
    id: id,
    title: title ?? '',
    subtitle: subtitle ?? '',
    imageUrl: imageUri ?? '',
    articleUrl: uri ?? '',
    order: order ?? 0,
  );
}

extension CategoryDtoListMapper on List<CategoryDto> {
  /// Sorted by the API's own `rank`, which the payload does not guarantee.
  List<Category> toEntities() {
    final List<Category> categories = map((CategoryDto dto) => dto.toEntity())
        .toList();
    categories.sort((Category a, Category b) => a.rank.compareTo(b.rank));
    return List<Category>.unmodifiable(categories);
  }
}

extension QuestionDtoListMapper on List<QuestionDto> {
  /// Sorted by `order`, for the same reason.
  List<Question> toEntities() {
    final List<Question> questions = map((QuestionDto dto) => dto.toEntity())
        .toList();
    questions.sort((Question a, Question b) => a.order.compareTo(b.order));
    return List<Question>.unmodifiable(questions);
  }
}
