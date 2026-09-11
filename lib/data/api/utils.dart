// preset Request Type
import '../../config/config_export.dart';

enum RequestType {post, get, put, delete}

class HTTPClient{
  HTTPClient._();

  static Future<HTTPClient> create() async {
    final client = HTTPClient._();
    return client;
  }

  // Common header for all request
  /// Add login checking or license here.
  Map<String, String> _baseHeaders(){
    final headers = <String, String>{
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };

    return headers;
  }

  // Create header base on request type
  Map<String, String> createHeader({required RequestType type, String? bodyLength}){
    final headers = <String, String>{
      ..._baseHeaders(),
    };

    if (type == RequestType.post && bodyLength != null){
      headers['Content-Length'] = bodyLength;
    }

    return headers;
  }

  // create URL
  Uri craeteUri(String route, [Map<String, dynamic> param = const {}]){
    // Call api base on environment
    var baseUri = Uri.parse(EnvironmentConfig.apiUrl + route);

    // Only add query if map is not empty
    if(param.isNotEmpty){
      var urlWithParams = baseUri.replace(queryParameters: param);
      return urlWithParams;
    }
    return baseUri;
  }
}