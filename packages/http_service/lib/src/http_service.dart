import 'dart:io';
import 'package:dio/dio.dart';

/// Dio requests types
enum Method {
  /// post
  post,

  /// get
  get,

  /// put
  put,

  /// delete
  delete,

  /// patch
  patch,
}

/// {@template http_service}
/// A service for managing requests
/// {@endtemplate}
class HttpService {
  /// {@macro http_service}
  HttpService({
    required Dio httpClient,
  }) : _httpClient = httpClient;

  final Dio _httpClient;

  /// help in handling request methods
  Future<Response> request({
    required String endpoint,
    required Method method,
    required String baseUrl,
    required Map<String, dynamic> headers,
    required Map<String, dynamic> params,
    required Map<String, dynamic> queryParams,
  }) async {
    Response response;
    _httpClient.options.baseUrl = baseUrl;
    _httpClient.options.headers = headers;
    _httpClient.options.queryParameters = queryParams;

    try {
      await _hasInternetConnection();

      if (method == Method.post) {
        response = await _httpClient.post<dynamic>(
          endpoint,
          data: params,
        );
      } else if (method == Method.delete) {
        response = await _httpClient.delete<dynamic>(endpoint);
      } else if (method == Method.patch) {
        response = await _httpClient.patch<dynamic>(endpoint);
      } else {
        response = await _httpClient.get<dynamic>(
          endpoint,
          queryParameters: params,
        );
      }

      if (response.statusCode == 200) {
        return response;
      }
    } on SocketException catch (_) {
      throw Exception('Not Internet Connection');
    } on DioError catch (_) {
      rethrow;
    } catch (e) {
      throw Exception("Something wen't wrong");
    }
    throw Exception("Something wen't wrong");
  }

  Future<void> _hasInternetConnection() async =>
      InternetAddress.lookup('google.com');
}
