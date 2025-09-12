import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import '../../../core/widgets/common_app_bar.dart';
import '../../product/presentation/favorites_screen.dart';
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

    void _handleBarcode(BarcodeCapture capture) async {
      if (_navigated) return;

      final code = capture.barcodes.first.rawValue ?? "";
      if (code.isEmpty) return;

      // Immediately stop scanner and set navigated
      _navigated = true;
      scannerController.stop();

      await provider.onScanned(code);

      if (provider.scannedProduct != null) {
        // Navigate to ProductScreen once
        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProductScreen(product: provider.scannedProduct!),
            ),
          ).then((_) {
            // Reset after coming back
            _navigated = false;
            provider.clear();
            scannerController.start();
          });
        }
      } else {
        // Invalid product, just reset navigated so user can scan again
        _navigated = false;
        scannerController.start();
      }
    }

    return Scaffold(
      appBar: CommonAppBar(title: "Scan Barcode",),

      body: Stack(
        children: [
          MobileScanner(
            controller: scannerController,
            onDetect: _handleBarcode,
          ),
          if (provider.isLoading)
            const Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: CircularProgressIndicator(color: Colors.white),
              ),
            ),
          if (provider.scannedResult != null && provider.scannedProduct == null)
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 80,
                color: Colors.black54,
                alignment: Alignment.center,
                child: Text(
                  provider.scannedResult!,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
