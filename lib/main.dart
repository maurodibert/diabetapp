import 'package:dio/dio.dart';
// Project imports:
import 'package:edamam_nutrition_api/edamam_nutrition_api.dart';
import 'package:flutter_services_binding/flutter_services_binding.dart';
import 'package:http_service/http_service.dart';

import 'bootstrap.dart';
import 'environment.dart';

void main() {
  FlutterServicesBinding.ensureInitialized();

  final dio = Dio();
  final httpService = HttpService(
    httpClient: dio,
  );

  final edamamApi = EdamamNutritionApi(
    httpService: httpService,
    baseUrl: EnvironmentConfig.edamamBaseUrl,
    headers: <String, dynamic>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
    params: <String, dynamic>{
      'app_id': EnvironmentConfig.edamamAppId,
      'app_key': EnvironmentConfig.edamamKey,
    },
  );
  bootstrap(ingredientsApi: edamamApi);
}
