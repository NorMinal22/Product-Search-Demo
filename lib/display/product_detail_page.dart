import 'package:flutter/material.dart';
import '../data/api/api_product.dart';
import '../data/model/model_export.dart';
import '../service/connection_service.dart';

class ProductDetailDemoPage extends StatefulWidget {
  const ProductDetailDemoPage({super.key});

  @override
  State<ProductDetailDemoPage> createState() => _ProductDetailDemoPageState();
}

class _ProductDetailDemoPageState extends State<ProductDetailDemoPage> {
  // Set variable for UI
  String apiResponseText = 'Test';
  List<ProductDemoModel> products = [];

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

      final productData = response['products'] as List;
      print(productData);

      products = productData.
        map((item) => ProductDemoModel.fromJson(item as Map<String, dynamic>))
        .toList();
      print(products);

      if(productData != null){
        apiResponseText = productData.toString();
      }

    } catch (error){
      throw error.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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