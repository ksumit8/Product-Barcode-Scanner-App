import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import '../../../core/widgets/common_app_bar.dart';
import 'provider/scanner_provider.dart';
import '../../product/presentation/product_screen.dart';

class ScanningPage extends StatefulWidget {
  const ScanningPage({super.key});

  @override
  State<ScanningPage> createState() => _ScanningPageState();
}

class _ScanningPageState extends State<ScanningPage> {
  final MobileScannerController scannerController = MobileScannerController();
  bool _navigated = false;

  @override
  void dispose() {
    scannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ScannerProvider>();

    // MediaQuery values
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final textScaler = MediaQuery.textScalerOf(context);

    void _handleBarcode(BarcodeCapture capture) async {
      if (_navigated) return;

      final code = capture.barcodes.first.rawValue ?? "";
      if (code.isEmpty) return;

      _navigated = true;
      scannerController.stop();

      await provider.onScanned(code);

      if (provider.scannedProduct != null) {
        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProductScreen(product: provider.scannedProduct!),
            ),
          ).then((_) {
            _navigated = false;
            provider.clear();
            scannerController.start();
          });
        }
      } else {
        _navigated = false;
        scannerController.start();
      }
    }

    return Scaffold(
      appBar: CommonAppBar(title: "Scan Barcode"),
      body: Stack(
        children: [
          MobileScanner(
            controller: scannerController,
            onDetect: _handleBarcode,
          ),


          if (provider.isLoading)
            Center(
              child: SizedBox(
                width: screenWidth * 0.2, // responsive size
                height: screenWidth * 0.2,
                child: const CircularProgressIndicator(
                  strokeWidth: 6,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.cyanAccent),
                ),
              ),
            ),


          if (!provider.isLoading &&
              provider.scannedResult != null &&
              provider.scannedProduct == null)
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: screenHeight * 0.1,
                // adaptive height
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                color: Colors.black54,
                alignment: Alignment.center,
                child: Text(
                  provider.scannedResult!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: textScaler.scale(16),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
