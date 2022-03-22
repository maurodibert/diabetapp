// ignore_for_file: prefer_const_constructors

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:http_service/http_service.dart';

import '../constants.dart';

void main() {
  group('HttpService', () {
    const edamamBaseUrl = Constants.edamamBaseUrl;
    const responseSuccess = Constants.responseSuccess;
    final dio = Dio(
      BaseOptions(
        baseUrl: edamamBaseUrl,
        headers: Constants.edamamPostHeader,
      ),
    );
    final dioAdapter = DioAdapter(dio: dio);

    HttpService createSubject() {
      return HttpService(
        httpClient: dio,
      );
    }

    final httpService = createSubject();

    group('constructor', () {
      test('works properly', () {
        expect(createSubject, returnsNormally);
      });
    });

    group('post request', () {
      test('works correctly on success response', () async {
        dioAdapter.onPost(
          edamamBaseUrl,
          (server) => server.reply(200, responseSuccess),
          data: <String, dynamic>{},
          headers: Constants.edamamPostHeader,
          queryParameters: Constants.edamamPostParams,
        );

        final response = await httpService.request(
          endpoint: edamamBaseUrl,
          method: Method.post,
          params: <String, dynamic>{},
          baseUrl: edamamBaseUrl,
          headers: Constants.edamamPostHeader,
          queryParams: Constants.edamamPostParams,
        );
        expect(response.data, responseSuccess);
      });

      test('should return a DioError', () async {
        dioAdapter.onPost(
          Constants.wrongEndpoint,
          (server) => server.throws(500, Constants.dioError),
          data: <String, dynamic>{},
          headers: Constants.edamamPostHeader,
          queryParameters: Constants.edamamPostParams,
        );

        expect(
          () async => httpService.request(
            endpoint: Constants.wrongEndpoint,
            method: Method.post,
            params: <String, dynamic>{},
            baseUrl: edamamBaseUrl,
            headers: Constants.edamamPostHeader,
            queryParams: Constants.edamamPostParams,
          ),
          throwsA(isA<DioError>()),
        );
      });
    });
  });
}
