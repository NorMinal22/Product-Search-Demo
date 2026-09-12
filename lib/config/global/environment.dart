class EnvironmentConfig{
  static late final String apiUrl;

  static void initialize(){
    const environment = String.fromEnvironment('ENV');
    switch (environment){
      case 'develop': // For testing
        apiUrl = 'https://dummyjson.com';
        break;
      default:
        apiUrl = 'https://dummyjson.com';
    }
  }
}