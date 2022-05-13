import 'package:ingredients_api/ingredients_api.dart';

abstract class TestConstants {
  static const ingredients = ['1 apple'];
  static const nutrient = Nutrient(
    label: 'carbs',
    quantity: 26,
    unit: 'g',
  );
  static const createdNutrients = TotalNutrients(nutrient: nutrient);
  static RecipeDetail createRecipe({
    String? id = '1',
    TotalNutrients nutrients = createdNutrients,
  }) {
    return RecipeDetail(
      id: id,
      totalNutrients: nutrients,
    );
  }
}
