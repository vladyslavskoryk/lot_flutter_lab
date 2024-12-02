import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryRed = Color(0xFFDC143C); // Custom red
  static const Color secondaryWhite = Color(0xFFFFFFFF); // Custom white
  static const Color customGray = Color(0xFF808080); // Example gray

  // Create a MaterialColor if you want a color swatch
  static const MaterialColor primarySwatch = MaterialColor(
    0xFFFF0000,
    <int, Color>{
      50: Color(0xFFFFE5E5),
      100: Color(0xFFFFCCCC),
      200: Color(0xFFFF9999),
      300: Color(0xFFFF6666),
      400: Color(0xFFFF3333),
      500: Color(0xFFFF0000), // Default
      600: Color(0xFFCC0000),
      700: Color(0xFF990000),
      800: Color(0xFF660000),
      900: Color(0xFF330000),
    },
  );
}
