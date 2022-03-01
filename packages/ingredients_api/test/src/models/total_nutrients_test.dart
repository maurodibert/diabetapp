import 'package:ingredients_api/src/models/models.dart';
import 'package:test/test.dart';

void main() {
  group('Total Nutrients', () {
    const nutrient = const Nutrient(
      label: 'carbs',
      quantity: 26,
      unit: 'g',
    );

    Nutrient createNutrient() => nutrient;
    Nutrient createNutrientCopyWith() => nutrient;

    TotalNutrients createSubject({
      Nutrient nutrient = nutrient,
    }) =>
        TotalNutrients(
          nutrient: nutrient,
        );

    group('constructor', () {
      test('works correctly', () {
        expect(createSubject, returnsNormally);
      });
      test('supports value equality', () {
        expect(createSubject(), equals(createSubject()));
      });

      test('props are correct', () {
        expect(createSubject().props, equals([nutrient]));
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
            createSubject().copyWith(nutrient: createNutrient()),
            equals(createSubject(nutrient: createNutrientCopyWith())),
          );
        });
      });

      group('fromJson', () {
        test('works correctly', () {
          expect(
            TotalNutrients.fromJson(<String, dynamic>{
              'CHOCDF': {
                'label': 'carbs',
                'quantity': 26,
                'unit': 'g',
              }
            }),
            equals(createSubject(nutrient: nutrient)),
          );
        });

        test('throws TypeError when wrong key assigned', () {
          try {
            TotalNutrients.fromJson(<String, dynamic>{'carbs': 16});
          } catch (e) {
            expect(e, isA<TypeError>());
          }
        });
      });

      group('toJson', () {
        test('works correctly', () {
          expect(
            createSubject().toJson(),
            equals(<String, dynamic>{
              'CHOCDF': {
                'label': 'carbs',
                'quantity': 26,
                'unit': 'g',
              }
            }),
          );
        });
      });
    });
  });
}
