import 'package:ingredients_api/ingredients_api.dart';

/// {@template ingredients_repository}
/// A repository that handles ingredients related requests
/// {@endtemplate}
class IngredientsRepository {
  /// {@macro ingredients_repository}
  const IngredientsRepository({required IngredientsApi ingredientsApi})
      : _ingredientsApi = ingredientsApi;

  final IngredientsApi _ingredientsApi;

  /// will return a [Stream] of RecipeDetail
  Stream<RecipeDetail> getRecipeDetails() => _ingredientsApi.getRecipeDetails();

  /// Provides the list of [Nutrient] of a given recipe
  Future<void> getDetails(List<String> ingredients) =>
      _ingredientsApi.requestIngredients(ingredients);
}
