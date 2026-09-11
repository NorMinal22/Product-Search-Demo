import 'package:flutter/material.dart';
import '../data/api/api_product.dart';
import '../service/connection_service.dart';

class ProductDemoPage extends StatefulWidget {
  const ProductDemoPage({super.key});

  @override
  State<ProductDemoPage> createState() => _ProductDemoPageState();
}

class _ProductDemoPageState extends State<ProductDemoPage> {
  // Set variable for UI
  String apiResponseText = 'Test';

  // On page load, initialize
  @override
  void initState() {
    super.initState();
    getProductDemo();
  }

  // Get the API response
  Future<void> getProductDemo() async {
    // Call API response
    final api = ApiProduct();

    // Check internet
    final hasInternet = await checkInternet(context);
    // If no internet, stop the process
    if (!hasInternet) {
      return;
    }

    // Always try and catch error from response
    try{
      final response = await api.productAPIDemo();

      // Check if response is success or not
      if(response['success'] != true){
        throw response['message'];
      }

      final productData = response['products'];

      if(productData == null){
        apiResponseText = productData.toString();
      }

    } catch (error){
      throw error.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Center(
          child: Text(apiResponseText, style: TextStyle(color: Colors.black),),
        ),
      ),
    );
  }
}

// Check internet
Future<bool> checkInternet(BuildContext context) async {
  // Create instance
  final connectionService = ConnectionService();
  bool isOnline = await connectionService.check();

  // if offline
  if(!isOnline){
    // Popup message
    return false;
  } else {
    return true;
  }
}