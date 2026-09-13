import 'package:flutter/material.dart';
import '../../config/global/color.dart';
import '../../data/api/api_product.dart';
import '../../data/model/model_export.dart';
import '../../service/connection_service.dart';
import 'product_page.dart';

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

    } catch (error){
      throw error.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = products.isNotEmpty ? products.first : null;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: darkMode),
          onPressed: (){
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ProductDemoPage())
            );
          },
        ),
      ),
      body: product == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image (Scrollable image)
            SizedBox(
              height: 250,
              child: PageView.builder(
                itemCount: product.images.length,
                controller: PageController(viewportFraction: 0.9),
                itemBuilder: (context, index){
                  final productImage = product.images[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(8),
                      child: Image.network(
                        productImage,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Product Title
                Expanded(
                  child: Text(
                    product.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Poduct Rating
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.orange),
                    Text(product.rating.toString()),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Product Price
            Text(
              'RM ${product.price}',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            // Product Tags
            Wrap(
              spacing: 8,
              children: product.tags.map((tag) => Chip(label: Text(tag))).toList(),
            ),
            const SizedBox(height: 16),
            // Product Description
            Text(
              product.description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            // Comment
            const Text(
              'Reviews',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Column(
              children: product.reviews.map((review){
                return ListTile(
                  title: Column(
                    children: [
                      Text(review.reviewerName),
                      Text(review.reviewerEmail),
                    ],
                  ),
                  subtitle: Text(review.comment),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star, color: Colors.orange),
                      Text(review.rating.toString()),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
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