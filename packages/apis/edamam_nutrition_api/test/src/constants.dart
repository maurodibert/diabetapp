import 'package:dio/dio.dart';

abstract class Constants {
  static const edamamBaseUrl = 'https://api.edamam.com/api';
  static const endpoint = '/nutrition-details';
  static const worngEndpoint = '/wrong-endpoint';

  static Map<String, String> edamamPostHeader = {
    'Content-Type': 'application/json',
    'Accept': 'application/json'
  };
  static Map<String, String> edamamPostParams = {
    'app_id': '__appId__',
    'app_key': '__appKey__'
  };

  static const responseSuccess = {
    'uri':
        'http://www.edamam.com/ontologies/edamam.owl#recipe_0018e345393a4e93acb6203435f8d0d0',
    'yield': 2,
    'calories': 189,
    'totalWeight': 364,
    'dietLabels': <String>[],
    'healthLabels': <String>[],
    'cautions': <String>[],
    'totalNutrients': {
      'CHOCDF': {
        'label': 'Carbohydrate, by difference',
        'quantity': 50.26840000000001,
        'unit': 'g'
      },
    }
  };

  static final wrongEndpointError = DioError(
    error: {'message': 'wrong endpoint'},
    requestOptions: RequestOptions(
      path: endpoint,
      queryParameters: <String, dynamic>{},
    ),
    response: Response<dynamic>(
      statusCode: 500,
      requestOptions: RequestOptions(
        path: endpoint,
      ),
    ),
    type: DioErrorType.response,
  );
}
