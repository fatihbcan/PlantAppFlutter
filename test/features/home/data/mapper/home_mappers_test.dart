import 'package:flutter_test/flutter_test.dart';
import 'package:hubx_flutter_case/features/home/data/dto/category_dto.dart';
import 'package:hubx_flutter_case/features/home/data/dto/question_dto.dart';
import 'package:hubx_flutter_case/features/home/data/mapper/home_mappers.dart';
import 'package:hubx_flutter_case/features/home/domain/entity/category.dart';
import 'package:hubx_flutter_case/features/home/domain/entity/question.dart';

void main() {
  group('CategoryDtoMapper', () {
    test('maps every field across', () {
      const CategoryDto dto = CategoryDto(
        id: 11,
        title: 'Ferns',
        rank: 3,
        image: CategoryImageDto(url: 'https://cdn.example/6.png'),
      );

      final Category entity = dto.toEntity();

      expect(entity.id, 11);
      expect(entity.title, 'Ferns');
      expect(entity.rank, 3);
      expect(entity.imageUrl, 'https://cdn.example/6.png');
      expect(entity.hasImage, isTrue);
    });

    test('collapses null title, rank and image to safe defaults', () {
      const CategoryDto dto = CategoryDto(id: 1);

      final Category entity = dto.toEntity();

      expect(entity.title, isEmpty);
      expect(entity.rank, 0);
      expect(entity.imageUrl, isEmpty);
      expect(entity.hasImage, isFalse);
    });

    test('handles an image object with a null url', () {
      const CategoryDto dto = CategoryDto(id: 1, image: CategoryImageDto());

      expect(dto.toEntity().imageUrl, isEmpty);
    });
  });

  group('CategoryDtoListMapper', () {
    test('sorts by rank regardless of payload order', () {
      const List<CategoryDto> dtos = <CategoryDto>[
        CategoryDto(id: 1, title: 'Third', rank: 2),
        CategoryDto(id: 2, title: 'First', rank: 0),
        CategoryDto(id: 3, title: 'Second', rank: 1),
      ];

      final List<Category> entities = dtos.toEntities();

      expect(entities.map((Category c) => c.title), <String>[
        'First',
        'Second',
        'Third',
      ]);
    });

    test('returns an unmodifiable list', () {
      final List<Category> entities = const <CategoryDto>[CategoryDto(id: 1)]
          .toEntities();

      expect(
        () => entities.add(const Category(id: 2, title: '', imageUrl: '')),
        throwsUnsupportedError,
      );
    });

    test('maps an empty payload to an empty list', () {
      expect(const <CategoryDto>[].toEntities(), isEmpty);
    });
  });

  group('QuestionDtoMapper', () {
    test('maps snake_case image_uri onto imageUrl', () {
      const QuestionDto dto = QuestionDto(
        id: 1,
        title: 'How to identify plants?',
        subtitle: 'Life Style',
        imageUri: 'https://cdn.example/card.png',
        uri: 'https://plantapp.app/blog/x',
        order: 1,
      );

      final Question entity = dto.toEntity();

      expect(entity.imageUrl, 'https://cdn.example/card.png');
      expect(entity.articleUrl, 'https://plantapp.app/blog/x');
      expect(entity.subtitle, 'Life Style');
      expect(entity.order, 1);
    });

    test('collapses null strings to empty', () {
      const QuestionDto dto = QuestionDto(id: 9);

      final Question entity = dto.toEntity();

      expect(entity.title, isEmpty);
      expect(entity.subtitle, isEmpty);
      expect(entity.imageUrl, isEmpty);
      expect(entity.articleUrl, isEmpty);
      expect(entity.order, 0);
    });
  });

  group('QuestionDtoListMapper', () {
    test('sorts by order', () {
      const List<QuestionDto> dtos = <QuestionDto>[
        QuestionDto(id: 3, title: 'C', order: 3),
        QuestionDto(id: 1, title: 'A', order: 1),
        QuestionDto(id: 2, title: 'B', order: 2),
      ];

      expect(dtos.toEntities().map((Question q) => q.title), <String>[
        'A',
        'B',
        'C',
      ]);
    });
  });
}
