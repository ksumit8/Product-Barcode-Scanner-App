import 'package:flutter/material.dart';

/// Common color palette used across the app
class AppColors {
  // AppBar Gradient
  static const Color appBarGradientStart = Color(0xFF4A00E0);
  static const Color appBarGradientEnd = Color(0xFF8E2DE2);

  // Heart Button Gradient
  static const Color heartGradientStart = Colors.pink;
  static const Color heartGradientEnd = Colors.redAccent;

  // Card Gradient
  static const Color cardGradientStart = Color(0xFFD0E8FF);
  static const Color cardGradientEnd = Color(0xFFE0CCFF);

  // Shadows
  static Color heartShadow = Colors.redAccent.withOpacity(0.4);
  static Color cardShadow = Colors.grey.withOpacity(0.2);

  // Text
  static const Color appBarText = Colors.white;
  static const Color textPrimary = Colors.black87;
  static const Color textMuted = Colors.grey;

  // Price
  static const Color priceGreen = Colors.green;

  // Loader / Progress
  static const Color loader = Colors.white;

  // Icons
  static const Color iconGrey = Colors.grey;

  // Buttons
  static const Color buttonBackground = Color(0xFFF5F5F5);

  // General UI
  static const Color background = Colors.white;
  static const Color error = Colors.red;
  static const Color success = Colors.green;
}
