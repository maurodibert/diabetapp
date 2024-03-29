import 'package:dio/dio.dart';
import 'package:http_service/http_service.dart';
import 'package:ingredients_api/ingredients_api.dart';

import 'package:rxdart/rxdart.dart';
import 'package:translator/translator.dart';

/// {@template edamam_nutrition_api}
/// A Flutter implementation of MealsApi that uses Edamam Nutrition Api
/// {@endtemplate}
class EdamamNutritionApi extends IngredientsApi {
  /// {@macro edamam_nutrition_api}
  EdamamNutritionApi({
    required HttpService httpService,
    required String baseUrl,
    required Map<String, dynamic> headers,
    required Map<String, dynamic> params,
  })  : _httpService = httpService,
        _baseUrl = baseUrl,
        _headers = headers,
        _params = params;

  final HttpService _httpService;
  final String _baseUrl;
  final Map<String, dynamic> _headers;
  final Map<String, dynamic> _params;
  final _detailsStreamController = PublishSubject<RecipeDetail>();
  final _translator = GoogleTranslator();

  /// will return a Stream of RecipeDetail
  @override
  Stream<RecipeDetail> getRecipeDetails() =>
      _detailsStreamController.asBroadcastStream();

  /// will translate the list of ingredients from local language to english,
  /// native language of edamam nutrition api
  Future<List<String>> translateIngredients(List<String> ingredients) async {
    final translatedIngredients = <String>[];
    try {
      for (final ingredient in ingredients) {
        final translated = await _translator.translate(ingredient);
        translatedIngredients.add(translated.text);
      }
      return translatedIngredients;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> requestIngredients(List<String> ingredients) async {
    final translatedIngredients = await translateIngredients(ingredients);
    const endpoint = '/nutrition-details';
    final body = <String, dynamic>{
      'title': 'getDetails',
      'ingr': [...translatedIngredients]
    };

    try {
      final response = await _httpService.request(
        endpoint: endpoint,
        method: Method.post,
        params: body,
        baseUrl: _baseUrl,
        headers: _headers,
        queryParams: _params,
      );
      if (response.data != null) {
        final detail =
            RecipeDetail.fromJson(response.data! as Map<String, dynamic>);
        _detailsStreamController.add(detail);
        return;
      }
      throw Exception(
        '''JSON Parse Failure - Response data was null or has inconsistencies with model''',
      );
    } catch (e) {
      e as DioError;
      if (e.response!.statusCode == 404) {
        throw DioError(
          error:
              '''Not Found - The specified URL was not found or couldn't be retrieved''',
          requestOptions: RequestOptions(
            path: endpoint,
          ),
        );
      } else if (e.response!.statusCode == 422) {
        throw DioError(
          error:
              '''Unprocessable Entity - Couldn't parse the recipe or the nutritional info''',
          requestOptions: RequestOptions(
            path: endpoint,
          ),
        );
      } else if (e.response!.statusCode == 555) {
        throw DioError(
          error:
              '''Low Quality - Recipe with insufficient quality to process correctly''',
          requestOptions: RequestOptions(
            path: endpoint,
          ),
        );
      } else if (e.response!.statusCode == 500) {
        throw DioError(
          error: '''Unknown error - Sorry! We don't know what went wrong''',
          requestOptions: RequestOptions(
            path: endpoint,
          ),
        );
      }
      throw Exception('Something went wrong');
    }
  }
}
