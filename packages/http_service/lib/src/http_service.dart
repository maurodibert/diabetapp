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
    required String baseUrl,
    required Map<String, dynamic> headers,
    required Map<String, dynamic> params,
  })  : _httpClient = httpClient,
        _baseUrl = baseUrl,
        _headers = headers,
        _params = params {
    init();
  }

  final Dio _httpClient;
  final String _baseUrl;
  final Map<String, dynamic> _headers;
  final Map<String, dynamic> _params;

  /// service initialization and configuration
  Future<void> init() async {
    _httpClient.options.baseUrl = _baseUrl;
    _httpClient.options.headers = _headers;
    _httpClient.options.queryParameters = _params;
  }

  /// help in handling request methods
  Future<Response> request({
    required String endpoint,
    required Method method,
    Map<String, dynamic>? params,
  }) async {
    Response response;

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
        response =
            await _httpClient.get<dynamic>(endpoint, queryParameters: params);
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
