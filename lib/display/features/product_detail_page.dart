import 'package:flutter/material.dart';
import '../../data/api/api_product.dart';
import '../../data/model/model_export.dart';
import '../../service/connection_service.dart';

// Class detail product
class ProductDetailDemoPage extends StatefulWidget {
  final int id;
  const ProductDetailDemoPage({super.key, required this.id});

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
    getProductDemo(widget.id);
  }

  // Get the API response
  Future<void> getProductDemo(int id) async {
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
      final response = await api.productAPIDemo(id: id);
      print('Response: $response');
      final productData = ProductDemoModel.fromJson(response as Map<String, dynamic>);

      setState(() {
        products = [productData];
        apiResponseText = productData.title;
      });
      print('Single: $products');
      print('test');

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