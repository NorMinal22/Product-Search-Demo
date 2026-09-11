import '../../config/config_export.dart';

// Call the api base on path
class ApiAddress{
  // Call environment config to get the apiUrl
  static final String baseUrl = EnvironmentConfig.apiUrl;

  // base APU URL dynamically
  static String get apiBaseUrl => baseUrl;

  // For detail api path
  // static get loginApi => '/login';
}