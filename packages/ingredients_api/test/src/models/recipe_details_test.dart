import 'package:ingredients_api/src/models/models.dart';
import 'package:test/test.dart';

void main() {
  group('RecipeDetails', () {
    const nutrient = const Nutrient(
      label: 'carbs',
      quantity: 26,
      unit: 'g',
    );

    TotalNutrients createTotalNutrients({
      Nutrient nutrient = nutrient,
    }) =>
        TotalNutrients(
          nutrient: nutrient,
        );

    const createdNutrients = const TotalNutrients(nutrient: nutrient);

    RecipeDetail createSubject({
      String? id = '1',
      TotalNutrients nutrients = createdNutrients,
    }) {
      return RecipeDetail(
        id: id,
        totalNutrients: nutrients,
      );
    }

    group('constructor', () {
      test('works correctly', () {
        expect(createSubject, returnsNormally);
      });

      test('throws AssertionError when id is empty', () {
        expect(
          () => createSubject(id: ''),
          throwsA(isA<AssertionError>()),
        );
      });

      test('sets id if not provided', () {
        expect(
          createSubject(id: null).id,
          isNotEmpty,
        );
      });

      test('supports value equality', () {
        expect(createSubject(), equals(createSubject()));
      });

      test('props are correct', () {
        expect(createSubject().props, equals(['1', createTotalNutrients()]));
      });

      group('copyWith', () {
        test('returns same object if no argument are provided', () {
          expect(
            createSubject().copyWith(),
            equals(createSubject()),
          );
        });

        test('replaces every non-null parameter', () {
          expect(
            createSubject().copyWith(
                totalNutrients: createTotalNutrients(nutrient: nutrient)),
            equals(createSubject()),
          );
        });
      });

      group('fromJson', () {
        test('works correctly', () {
          expect(
            RecipeDetail.fromJson(<String, dynamic>{
              'id': '1',
              'totalNutrients': {
                'CHOCDF': {
                  'label': 'carbs',
                  'quantity': 26,
                  'unit': 'g',
                }
              }
            }),
            equals(createSubject(nutrients: createdNutrients)),
          );
        });
      });

      group('toJson', () {
        test('works correctly', () {
          expect(
            RecipeDetail(
              id: '1',
              totalNutrients: createTotalNutrients(),
            ).toJson(),
            equals(<String, dynamic>{
              'id': '1',
              'totalNutrients': {
                'CHOCDF': {
                  'label': 'carbs',
                  'quantity': 26,
                  'unit': 'g',
                }
              }
            }),
          );
        });
      });
    });
  });
}
