import 'package:ingredients_api/src/models/models.dart';
import 'package:test/test.dart';

void main() {
  group('Nutrients', () {
    Nutrient createSubject({
      String label = 'carbs',
      num quantity = 26,
      String unit = 'g',
    }) =>
        Nutrient(
          label: label,
          quantity: quantity,
          unit: unit,
        );

    group('constructor', () {
      test('works correctly', () {
        expect(createSubject, returnsNormally);
      });
      test('supports value equality', () {
        expect(createSubject(), equals(createSubject()));
      });

      test('props are correct', () {
        expect(createSubject().props, equals(['carbs', 26, 'g']));
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
              label: 'non-null',
              quantity: 10,
              unit: 'kg',
            ),
            equals(createSubject(
              label: 'non-null',
              quantity: 10,
              unit: 'kg',
            )),
          );
        });
      });

      group('fromJson', () {
        test('works correctly', () {
          expect(
            Nutrient.fromJson(<String, dynamic>{
              'label': 'carbs',
              'quantity': 26,
              'unit': 'g',
            }),
            equals(createSubject()),
          );
        });

        test('throws TypeError when wrong key assigned', () {
          try {
            Nutrient.fromJson(<String, dynamic>{'carbs': 16});
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
              'label': 'carbs',
              'quantity': 26,
              'unit': 'g'
            }),
          );
        });
      });
    });
  });
}
