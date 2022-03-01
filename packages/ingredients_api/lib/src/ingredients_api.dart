import 'package:ingredients_api/ingredients_api.dart';

/// {@template ingredients_api}
/// The interface and models for an API providing access
/// to nutrition details of a list of ingredients
/// {@endtemplate}
abstract class IngredientsApi {
  /// {@macro ingredients_api}
  const IngredientsApi();

  /// will return a Stream of RecipeDetail
  Stream<RecipeDetail> getRecipeDetails();

  /// Provides a list of nutrients given a list of ingredients
  Future<void> requestIngredients(List<String> ingredients);
}
