import 'package:flutter_test/flutter_test.dart';
import 'package:diabetapp/features/nutrients/bloc/nutrients_bloc.dart';

void main() {
  group('NutrientsState', () {
    NutrientsState createSubject({
      NutrientsStatus status = NutrientsStatus.initial,
    }) {
      return NutrientsState(status: status);
    }

    test('supports value equality', () {
      expect(
        createSubject(),
        equals(createSubject()),
      );
    });

    test('props are correct', () {
      expect(
          createSubject().props,
          equals(<Object?>[
            NutrientsStatus.initial,
            const <String>[],
            null,
            0,
            0,
            null,
            null,
            110,
            50,
          ]));
    });

    group('copyWith', () {
      test('returns the same object if no arguments are provided', () {
        expect(
          createSubject().copyWith(),
          equals(createSubject()),
        );
      });

      test('replaces every non-null parameter', () {
        expect(
          createSubject()
              .copyWith(status: NutrientsStatus.apiCalculationSuccess),
          equals(createSubject(status: NutrientsStatus.apiCalculationSuccess)),
        );
      });
    });
  });
}
