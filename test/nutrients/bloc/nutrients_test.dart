import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ingredients_api/ingredients_api.dart';
import 'package:ingredients_repository/ingredients_repository.dart';
import 'package:diabetapp/nutrients/helpers/nutrients_helpers.dart';
import 'package:diabetapp/nutrients/nutrients.dart';
import 'package:mocktail/mocktail.dart';

class MockIngredientsApi extends Mock implements IngredientsApi {}

void main() {
  final ingredientsApi = MockIngredientsApi();
  final ingredientsRepository =
      IngredientsRepository(ingredientsApi: ingredientsApi);
  void mockedScrolling() {}
  final initialLoadingNutrientsState = NutrientsState(
    status: NutrientsStatus.loading,
    ingredients: [],
    recipeDetail: null,
    insuline: 0,
    sugar: 0,
    error: null,
    result: null,
    objective: 110,
    fsi: 50,
  );

  NutrientsBloc buildBloc() =>
      NutrientsBloc(ingredientsRepository: ingredientsRepository);

  group('constructor', () {
    test('works properly', () {
      expect(buildBloc, returnsNormally);
    });

    test('has correct initial state', () {
      expect(buildBloc().state, const NutrientsState());
    });
  });

  group('helpers method', () {
    group('sugatToBalance', () {
      test('returns 110, in initial state', () {
        final sugarToBalance = NutrientsHelpers.sugarToBalance(
          objective: 110,
          insuline: 0,
          sugar: 0,
          fsi: 50,
        );
        expect(sugarToBalance, 110);
      });

      test('returns 60, if current sugar is 50', () {
        final sugarToBalance = NutrientsHelpers.sugarToBalance(
          objective: 110,
          insuline: 0,
          sugar: 50,
          fsi: 50,
        );
        expect(sugarToBalance, 60);
      });

      test('returns -40, if current sugar is 150', () {
        final sugarToBalance = NutrientsHelpers.sugarToBalance(
          objective: 110,
          insuline: 0,
          sugar: 150,
          fsi: 50,
        );
        expect(sugarToBalance, -40);
      });
    });

    group('calculateResult', () {
      test('returns UserShould.addInsuline if sugar is higher than objective',
          () {
        final _base = NutrientsHelpers.calculateResult(
            objective: 110, sugar: 160, insuline: 0, fsi: 50);
        final _result =
            ResultedCalculation(userShould: UserShould.addInsuline, amount: 1);
        expect(_base.amount, _result.amount);
      });

      test('returns UserShould.addFood if sugar is lower than objective', () {
        final _base = NutrientsHelpers.calculateResult(
            objective: 110, sugar: 60, insuline: 0, fsi: 50);
        final _result =
            ResultedCalculation(userShould: UserShould.addFood, amount: 50);
        expect(_base.amount, _result.amount);
      });

      test('returns UserShould.nothing if sugar is the same as objective', () {
        final _base = NutrientsHelpers.calculateResult(
            objective: 110, sugar: 110, insuline: 0, fsi: 50);
        final _result = ResultedCalculation(userShould: UserShould.doNothing);
        expect(_base.userShould, _result.userShould);
      });

      test(
          'returns UserShould.nothing if sugar is higher than objective but has already active insuline',
          () {
        final _base = NutrientsHelpers.calculateResult(
            objective: 110, sugar: 160, insuline: 1, fsi: 50);
        final _result =
            ResultedCalculation(userShould: UserShould.doNothing, amount: 0);
        expect(_base.userShould, _result.userShould);
      });

      test(
          'returns UserShould.addFood if sugar is same as objective but has already active insuline beyond the needs',
          () {
        final _base = NutrientsHelpers.calculateResult(
            objective: 110, sugar: 110, insuline: 1, fsi: 50);
        final _result =
            ResultedCalculation(userShould: UserShould.addFood, amount: 50);
        expect(_base.amount, _result.amount);
      });

      test(
          'returns UserShould.addInsuline if sugar is higher than objective and active insuline is not enough',
          () {
        final _base = NutrientsHelpers.calculateResult(
            objective: 110, sugar: 210, insuline: 1, fsi: 50);
        final _result =
            ResultedCalculation(userShould: UserShould.addInsuline, amount: 1);
        expect(_base.amount, _result.amount);
      });
    });
  });

  group('onSubscriptionRequested', () {
    blocTest<NutrientsBloc, NutrientsState>(
      'starts listening to repository getRecipeDetails stream',
      build: buildBloc,
      setUp: () {
        when(() => ingredientsApi.getRecipeDetails())
            .thenAnswer((_) => Stream.empty());
      },
      act: (bloc) => bloc.add(const NutrientsSubscriptionRequested()),
      verify: (bloc) {
        verify(() => ingredientsApi.getRecipeDetails()).called(1);
      },
      expect: () => <NutrientsState>[],
    );
  });

  group('onGetResult', () {
    blocTest<NutrientsBloc, NutrientsState>(
      'calculate result if ingredients is empty',
      build: buildBloc,
      seed: () => NutrientsState(),
      setUp: () {
        when(() => ingredientsApi.getRecipeDetails())
            .thenAnswer((_) => Stream.empty());
      },
      act: (bloc) => bloc.add(NutrientsGetResultEvent(
        scrollingBottom: mockedScrolling,
        scrollingTop: mockedScrolling,
      )),
      expect: () => <NutrientsState>[
        initialLoadingNutrientsState,
        NutrientsState(
          status: NutrientsStatus.calculationSuccess,
          recipeDetail: RecipeDetail.empty(),
          ingredients: <String>[],
          result:
              ResultedCalculation(amount: 110, userShould: UserShould.addFood),
        )
      ],
    );
  });

  group('onSetIngredients', () {
    blocTest<NutrientsBloc, NutrientsState>(
      'emits state with new ingredient if ingredients is empty',
      build: () => buildBloc(),
      act: (bloc) => bloc.add(NutrientsSetIngredientsEvent(
          ingredient: '1 apple', scrollingBottom: mockedScrolling)),
      expect: () => const <NutrientsState>[
        NutrientsState(ingredients: ['1 apple'])
      ],
    );

    blocTest<NutrientsBloc, NutrientsState>(
      'emits state with new added ingredient',
      build: () => buildBloc(),
      seed: () => const NutrientsState(ingredients: ['1 apple']),
      act: (bloc) => bloc.add(NutrientsSetIngredientsEvent(
          ingredient: '1 orange', scrollingBottom: mockedScrolling)),
      expect: () => const <NutrientsState>[
        NutrientsState(ingredients: ['1 apple', '1 orange'])
      ],
    );
  });

  group('onCleanIngredients', () {
    blocTest<NutrientsBloc, NutrientsState>(
      'emit state with an empty ingredients list',
      build: () => buildBloc(),
      seed: () => const NutrientsState(ingredients: ['1 apple']),
      act: (bloc) => bloc
          .add(NutrientsCleanIngredientsEvent(scrollingTop: mockedScrolling)),
      expect: () => const <NutrientsState>[NutrientsState(ingredients: [])],
    );
  });

  group('onRemoveIngredient', () {
    blocTest<NutrientsBloc, NutrientsState>(
      'removes an ingredient that is present on the ingredients list',
      build: () => buildBloc(),
      seed: () => const NutrientsState(ingredients: ['1 apple', '1 orange']),
      act: (bloc) =>
          bloc.add(NutrientsRemoveIngredientEvent(ingredient: '1 orange')),
      expect: () => const <NutrientsState>[
        NutrientsState(ingredients: ['1 apple'])
      ],
    );

    blocTest<NutrientsBloc, NutrientsState>(
      'emit empty list if there are no more ingredients to remove',
      build: () => buildBloc(),
      seed: () => const NutrientsState(ingredients: ['1 apple']),
      act: (bloc) =>
          bloc.add(NutrientsRemoveIngredientEvent(ingredient: '1 apple')),
      expect: () => const <NutrientsState>[NutrientsState(ingredients: [])],
    );
  });

  group('onSetInsuline', () {
    blocTest<NutrientsBloc, NutrientsState>(
      'emits state with new insuline amount',
      build: () => buildBloc(),
      act: (bloc) => bloc.add(NutrientsSetInsulineEvent(insuline: 0.5)),
      expect: () => const <NutrientsState>[NutrientsState(insuline: 0.5)],
    );
  });

  group('onSetSugar', () {
    blocTest<NutrientsBloc, NutrientsState>(
      'emits state with new sugar amount',
      build: () => buildBloc(),
      act: (bloc) => bloc.add(NutrientsSetSugarEvent(sugar: 70)),
      expect: () => const <NutrientsState>[NutrientsState(sugar: 70)],
    );
  });
}
