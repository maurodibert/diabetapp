import 'package:http_service/http_service.dart';
import 'package:translation_api/translation_api.dart';

/// {@template google_translation_api}
/// A Flutter implementation of Google Translation Api
/// {@endtemplate}

class GoogleTranslationApi implements TranslationApi {
  /// {@macro google_translation_api}
  GoogleTranslationApi({
    required HttpService httpService,
  }) : _httpService = httpService;

  final HttpService _httpService;

  @override
  Future<void> translate(String ingredients) {
    // TODO: implement translate
    throw UnimplementedError();
  }

  // @override
  // Future<void> translate(String ingredients) {}
}
