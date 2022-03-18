/// {@template translation_api}
/// The interface and models for an API providing
/// a translation of the list of ingredients
/// from local language to english,
/// native language received from ingredients api.
/// {@endtemplate}
abstract class TranslationApi {
  const TranslationApi();

  /// will translate the provided ingredients
  Future<void> translate(String ingredients);
}
