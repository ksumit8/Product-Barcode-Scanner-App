import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/product/presentation/provider/favorites_provider.dart';
import 'features/scanning/presentation/provider/scanner_provider.dart';
import 'features/scanning/presentation/landing_page.dart';

void main() {
  runApp(

    MultiProvider(

      providers: [
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
        ChangeNotifierProvider(create: (_) => ScannerProvider()),
      ],
      child: const MyApp(
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Barcode Scanner Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LandingPage(),
    );
  }
}
