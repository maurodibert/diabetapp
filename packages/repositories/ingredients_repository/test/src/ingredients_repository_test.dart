// ignore_for_file: prefer_const_constructors
import 'package:ingredients_api/ingredients_api.dart';
import 'package:ingredients_repository/ingredients_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockIngredientsApi extends Mock implements IngredientsApi {}

void main() {
  group('IngredientsRepository', () {
    late IngredientsApi ingredientsApi;

    const ingredients = ['1 apple'];
    const nutrient = Nutrient(
      label: 'carbs',
      quantity: 26,
      unit: 'g',
    );
    const createdNutrients = TotalNutrients(nutrient: nutrient);
    RecipeDetail createRecipe({
      String? id = '1',
      TotalNutrients nutrients = createdNutrients,
    }) {
      return RecipeDetail(
        id: id,
        totalNutrients: nutrients,
      );
    }

    final recipe = createRecipe();

    setUp(() {
      ingredientsApi = MockIngredientsApi();
      when(() => ingredientsApi.requestIngredients(ingredients))
          .thenAnswer((_) async => recipe.toJson());
      when(() => ingredientsApi.getRecipeDetails())
          .thenAnswer((_) => Stream.value(recipe));
    });

    IngredientsRepository createSubject() =>
        IngredientsRepository(ingredientsApi: ingredientsApi);

    group('constructor', () {
      test('works correctly', () {
        expect(createSubject, returnsNormally);
      });
    });

    group('detailsStream', () {
      test('returns the stream of current recipeDetail', () {
        final subject = createSubject()..getDetails(ingredients);

        expect(subject.getRecipeDetails(), emits(recipe));
      });
    });

    group('getDetails', () {
      test('return a Future<void>', () {
        final subject = createSubject();
        expect(
          subject.getDetails(ingredients),
          isA<Future<void>>(),
        );
        verify(() => subject.getDetails(ingredients)).called(1);
      });
    });
  });
}
