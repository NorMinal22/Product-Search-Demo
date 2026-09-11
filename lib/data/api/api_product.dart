import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:product_search_demo/data/api/api_address.dart';
import '../../config/config_export.dart';
import 'utils.dart';

// api for getting product
class ApiProduct {
  Future<Map> productAPIDemo() async {
    // Get network client to create header
    final networkClient = http.Client();
    final httpClient = await HTTPClient.create();
    
    var header = httpClient.createHeader(type: RequestType.get);
    var route = httpClient.craeteUri(ApiAddress.apiBaseUrl);
    
    // Always use try and catch to track error
    // Mainly for response
    try{
      // The time setting is set in global
      final response = await networkClient.get(route, headers: header).timeout(const Duration(seconds: AppSetting.timeLimit));

      // A null safety method. This will throw error if fails
      final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      // This check what API response is
      if(response.statusCode != 200 || (jsonResponse['isMaintenance'] == false && !jsonResponse['status'])){
        // For error return from api
        throw jsonResponse['message'];
      }
      // otherwise, return the response data (statusCode = 200)
      return jsonResponse;
    } on TimeoutException{
      throw 'Timeout';
    } catch (error){
      throw error.toString();
    } finally {
      // Once all done, close
      networkClient.close();
    }
  }
}