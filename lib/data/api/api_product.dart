import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../config/config_export.dart';
import '../../helper/toast_message.dart';
import 'api_address.dart';
import 'utils.dart';

// api for getting product
class ApiProduct {
  Future<Map> productAPIDemo({int? limit, int? skip, int? id, String? query}) async {
    // Get network client to create header
    final networkClient = http.Client();
    final httpClient = await HTTPClient.create();
    
    var header = httpClient.createHeader(type: RequestType.get);
    var route = httpClient.createUri(ApiAddress.productUrl);

    // Call base on id
    if(id != null){
      route = httpClient.createUri('${ApiAddress.productUrl}/$id');
    // Call base on query
    } else if(query != null){
      route = httpClient.createUri('${ApiAddress.productUrl}/search',{'q': query});
    // Call base on limit and skip
    } else if(limit != null && skip != null){
      route = httpClient.createUri(ApiAddress.productUrl, {'limit': SafeConverter.toStringValue(limit), 'skip': SafeConverter.toStringValue(skip)});
    } else{
    // Call all
      route = httpClient.createUri(ApiAddress.productUrl);
    }

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
      print(jsonResponse);
      return jsonResponse;
    } on TimeoutException{
      throw 'Timeout';
    } catch (error){
      throw 'Fail to load response data ${error.toString()}';
    } finally {
      // Once all done, close
      networkClient.close();
    }
  }
}