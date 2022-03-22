import 'package:dio/dio.dart';

abstract class Constants {
  static const edamamBaseUrl = 'https://api.edamam.com/api';
  static const wrongEndpoint = '/wrong-endpoint';

  static Map<String, String> edamamPostHeader = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
  static Map<String, String> edamamPostParams = {
    'app_id': '__appId__',
    'app_key': '__appKey__'
  };

  static const responseSuccess = {'message': 'success'};
  static final dioError = DioError(
    error: {'message': 'dio error'},
    requestOptions: RequestOptions(
      path: wrongEndpoint,
      queryParameters: <String, dynamic>{},
    ),
    response: Response<dynamic>(
      statusCode: 500,
      requestOptions: RequestOptions(
        path: wrongEndpoint,
      ),
    ),
    type: DioErrorType.response,
  );
}
