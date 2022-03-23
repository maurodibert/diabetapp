import 'package:flutter_test/flutter_test.dart';
import 'package:diabetapp/features/nutrients/nutrients.dart';

void main() {
  group('NutrientsEvent', () {
    const ingredient = '1 apple';
    const insuline = 1;
    const sugar = 53;
    void mockedScrolling() {}

    group('NutrientsSubscriptionRequested', () {
      test('supports value equality', () {
        expect(NutrientsSubscriptionRequested(),
            equals(NutrientsSubscriptionRequested()));
      });
    });

    group('NutrientsGetResultEvent', () {
      test('supports value equality', () {
        expect(
            NutrientsGetResultEvent(
                scrollingBottom: mockedScrolling,
                scrollingTop: mockedScrolling),
            equals(NutrientsGetResultEvent(
                scrollingBottom: mockedScrolling,
                scrollingTop: mockedScrolling)));
      });
    });

    group('NutrientsSetIngredientsEvent', () {
      test('supports value equality', () {
        expect(
            NutrientsSetIngredientsEvent(
                ingredient: ingredient, scrollingBottom: mockedScrolling),
            equals(NutrientsSetIngredientsEvent(
                ingredient: ingredient, scrollingBottom: mockedScrolling)));
      });

      test('props are correct', () {
        expect(
            NutrientsSetIngredientsEvent(
                    ingredient: ingredient, scrollingBottom: mockedScrolling)
                .props,
            equals(NutrientsSetIngredientsEvent(
                    ingredient: ingredient, scrollingBottom: mockedScrolling)
                .props));
      });
    });

    group('NutrientsCleanIngredientsEvent', () {
      test('supports value equality', () {
        expect(
            NutrientsCleanIngredientsEvent(scrollingTop: mockedScrolling),
            equals(
                NutrientsCleanIngredientsEvent(scrollingTop: mockedScrolling)));
      });
    });

    group('NutrientsRemoveIngredientEvent', () {
      test('supports value equality', () {
        expect(NutrientsRemoveIngredientEvent(ingredient: ingredient),
            equals(NutrientsRemoveIngredientEvent(ingredient: ingredient)));
      });

      test('props are correct', () {
        expect(
            NutrientsRemoveIngredientEvent(ingredient: ingredient).props,
            equals(
                NutrientsRemoveIngredientEvent(ingredient: ingredient).props));
      });
    });

    group('NutrientsSetInsulineEvent', () {
      test('supports value equality', () {
        expect(NutrientsSetInsulineEvent(insuline: insuline),
            equals(NutrientsSetInsulineEvent(insuline: insuline)));
      });

      test('props are correct', () {
        expect(NutrientsSetInsulineEvent(insuline: insuline).props,
            equals(NutrientsSetInsulineEvent(insuline: insuline).props));
      });
    });

    group('NutrientsSetSugarEvent', () {
      test('supports value equality', () {
        expect(NutrientsSetSugarEvent(sugar: sugar),
            equals(NutrientsSetSugarEvent(sugar: sugar)));
      });

      test('props are correct', () {
        expect(NutrientsSetSugarEvent(sugar: sugar).props,
            equals(NutrientsSetSugarEvent(sugar: sugar).props));
      });
    });
  });
}
