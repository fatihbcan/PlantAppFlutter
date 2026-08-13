/// Endpoints and timeouts for the case API.
abstract final class ApiConfig {
  static const String baseUrl = 'https://dummy-api-jtg6bessta-ey.a.run.app';

  static const String categories = '/getCategories';
  static const String questions = '/getQuestions';

  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 20);
  static const Duration sendTimeout = Duration(seconds: 15);
}
