abstract class EnvironmentConfig {
  static const String edamamAppId = String.fromEnvironment(
    EnvironmentKey.edamamAppId,
    defaultValue: '...',
  );
  static const String edamamKey = String.fromEnvironment(
    EnvironmentKey.edamamAppKey,
    defaultValue: '...',
  );
  static const String edamamBaseUrl = String.fromEnvironment(
    EnvironmentKey.edamamBaseUrl,
    defaultValue: '...',
  );
}

abstract class EnvironmentKey {
  static const String edamamAppId = 'EDAMAM_APP_ID';
  static const String edamamAppKey = 'EDAMAM_APP_KEY';
  static const String edamamBaseUrl = 'EDAMAM_BASE_URL';
}
