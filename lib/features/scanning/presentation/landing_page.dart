import 'package:flutter/material.dart';
import '../../../core/widgets/common_app_bar.dart';
import 'scanning_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    // MediaQuery values
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final textScale = MediaQuery.textScalerOf(context).scale(1.0);

    return Scaffold(
      appBar: CommonAppBar(title: "Landing Page"),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Click the button below to scan a product",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18 * textScale, // adaptive font size
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              SizedBox(
                width: screenWidth * 0.6,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ScanningPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.02,
                    ),
                    textStyle: TextStyle(
                      fontSize: 16 * textScale,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text("Start Scanning"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
