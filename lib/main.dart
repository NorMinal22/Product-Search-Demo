import 'package:flutter/material.dart';
import 'config/config_export.dart';
import 'display/features/product_page.dart';

void main() {
  // For language or shared preference
  // WidgetsFlutterBinding.ensureInitialized();

  // Initialize environment variables
  EnvironmentConfig.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Go to home page
      home: ProductDemoPage(),
    );
  }
}
