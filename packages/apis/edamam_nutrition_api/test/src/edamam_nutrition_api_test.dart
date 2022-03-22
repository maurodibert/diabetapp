// ignore_for_file: prefer_const_constructors

import 'package:dio/dio.dart';
import 'package:edamam_nutrition_api/edamam_nutrition_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:http_service/http_service.dart';
import 'package:ingredients_api/ingredients_api.dart';

import 'constants.dart';

void main() {
  group('EdamamNutritionApi', () {
    const nutrient = Nutrient(
      label: 'Carbohydrate, by difference',
      quantity: 50.26840000000001,
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

    const edamamBaseUrl = Constants.edamamBaseUrl;
    final dio = Dio(
      BaseOptions(
        baseUrl: edamamBaseUrl,
        headers: Constants.edamamPostHeader,
      ),
    );
    final dioAdapter = DioAdapter(dio: dio);

    final httpService = HttpService(
      httpClient: dio,
    );

    EdamamNutritionApi createSubject() => EdamamNutritionApi(
          httpService: httpService,
          baseUrl: edamamBaseUrl,
          headers: Constants.edamamPostHeader,
          params: Constants.edamamPostParams,
        );

    final api = createSubject();
    group('constructor', () {
      test('works properly', () {
        expect(createSubject, returnsNormally);
      });
    });

    group('post request', () {
      test('works correctly', () {
        dioAdapter.onPost(
          Constants.endpoint,
          (server) => server.reply(200, recipe.toJson()),
          data: <String, dynamic>{},
          headers: Constants.edamamPostHeader,
          queryParameters: Constants.edamamPostParams,
        );

        api.requestIngredients(['1 apple']);

        expect(api.getRecipeDetails(), emits(recipe));
      });

      test('should return a -Low Quality- DioError', () {
        dioAdapter.onPost(
          Constants.endpoint,
          (server) => server.throws(
            555,
            DioError(
              response: Response<dynamic>(
                statusCode: 555,
                requestOptions: RequestOptions(
                  data: {'error': 'low quality'},
                  path: Constants.endpoint,
                ),
              ),
              error: 'Http status error [555]',
              requestOptions: RequestOptions(
                path: Constants.endpoint,
              ),
            ),
          ),
          data: <String, dynamic>{},
          headers: Constants.edamamPostHeader,
          queryParameters: Constants.edamamPostParams,
        );

        try {
          api.requestIngredients(['5 cars']);
        } catch (e) {
          e as DioError;
          expect(
            e.error,
            '''Low Quality - Recipe with insufficient quality to process correctly''',
          );
        }
      });
    });
  });
}
