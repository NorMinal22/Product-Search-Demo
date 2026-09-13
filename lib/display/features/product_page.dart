import 'package:flutter/material.dart';
import 'package:product_search_demo/display/widgets/export_widget.dart';
import '../../config/config_export.dart';
import '../../data/api/api_product.dart';
import '../../data/model/product_model.dart';
import '../../service/connection_service.dart';
import 'product_detail_page.dart';

class ProductDemoPage extends StatefulWidget {
  const ProductDemoPage({super.key});

  @override
  State<ProductDemoPage> createState() => _ProductDemoPageState();
}

class _ProductDemoPageState extends State<ProductDemoPage> {
  // Set variable for UI
  // Store selected tags when click on checkbox
  final List<String> selectedTags = [];
  List<ProductDemoModel> products = [];
  final ScrollController _scrollController = ScrollController();
  int skipLimit = 0;
  // On page load, initialize
  @override
  void initState() {
    super.initState();
    getProductDemo();
    // Initialize scroll event
    _scrollController.addListener(scrollPagination);
  }

  // scroll method
  void scrollPagination(){
    if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
      // Reach the bottom, load the next skip
      skipLimit += 1;
      // Update skip value and pass to API
      getProductDemo(skip: skipLimit);
    }
  }

  // Tag filtering
  List<ProductDemoModel> get filteredProducts {
    if(selectedTags.isEmpty) return products;
    return products.where((prod){
      // Check the product for tag reference
      return prod.tags.any((tag) => selectedTags.contains(tag));
    }).toList();
  }

  // Get the API response
  Future<void> getProductDemo({int? skip, int? id, String? searchQuery}) async {
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
      final response = await api.productAPIDemo(limit: AppSetting.itemLimit, skip: SafeConverter.toInt(skipLimit), id: id, query: searchQuery);

      final productData = response['products'] as List;

      final newProducts = productData.
        map((item) => ProductDemoModel.fromJson(item as Map<String, dynamic>))
        .toList();

      setState(() {
        // Whenever skip is updated, add into the list, not replace
        products.addAll(newProducts);
      });
    } catch (error){
      throw error.toString();
    }
  }

  // Show tag dialog box
  void showTagDialog(){
    showDialog(
      context: context,
      builder: (_) => TagPopupWidget(
        selectedTags: selectedTags,
        onSave: (updatedList){
          setState(() {
            selectedTags
              ..clear()
              ..addAll(updatedList);
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Search
            Padding(
              padding: const EdgeInsetsGeometry.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width*0.7,
                    child: TextField(
                      onSubmitted: (value){
                        getProductDemo(searchQuery: value);
                      },
                      decoration: const InputDecoration(
                        hintText: "Search...",border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  // Refresh button
                  IconButton(
                      onPressed: (){

                      },
                      icon: Icon(Icons.refresh),
                  ),
                ],
              ),
            ),

            // Tag Section
            ElevatedButton(
              onPressed: showTagDialog,
              child: const Text('TAGS'),
            ),
            // Content
            Expanded(
              child: GridView.builder(
                controller: _scrollController,
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 4 / 5,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12
                ),
                itemCount: filteredProducts.length,
                itemBuilder: (BuildContext context, index){
                  final product = filteredProducts[index];
                  return GestureDetector(
                    onTap: (){
                      // Navigate to product detail page
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => ProductDetailDemoPage(id: product.id))
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: lightMode,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: darkMode,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: darkMode.withValues(alpha: 0.2),
                            blurRadius: 3,
                            offset: const Offset(1, 2),
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Product image
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadiusGeometry.vertical(top: Radius.circular(5)),
                              child: Image.network(
                                product.thumbnail,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          ),
                          // Title
                          Text(
                            product.title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: darkMode,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          // Price
                          Text(
                            '${product.price}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: darkMode,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
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