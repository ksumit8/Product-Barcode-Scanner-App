import 'package:flutter/material.dart';
import '../../../core/widgets/common_app_bar.dart';
import 'scanning_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "Landing Page"),
      body:Center(
    child: Column(
    mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "Click the button below to scan a product",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 25),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ScanningPage()),
            );
          },
          child: const Text("Start Scanning"),
        ),
      ],
    ),
    ),

    );
  }
}
