import 'package:flutter/material.dart';

abstract class AppColors {
  static const headerColor = Color(0xFF1E0A41);
  static const deeppurple = Color(0xFF370D3D);
  static const lightgreen = Color(0xFF79BAC0);
  static const grey = Color(0xFF929292);
  static const white = Color(0xFFffffff);
  static const lightpurple = Color(0xFFB2B4E5);

  static const lightAccentBlue = Color(0xFF92E2FF);
  static const darkAccentBlue = Color(0xFF1DBEF9);
  static const lightOrange = Color(0xFFFFD099);
  static const darkOrange = Color(0xFFFE9B48);
  static const lightBlue = Color(0xFF7395CF);
  static const darkBlue = Color(0xFF3C5073);
  static const neviBlue = Color(0xFF45597A);
  static const darkestBlue = Color(0xFF1E2843);
  // Additional colors
  static const lightYellow = Color(0xFFFFF7D2);
  static const darkYellow = Color(0xFFFFCA28);
  static const lightRed = Color(0xFFFFCDD2);
  static const darkRed = Color(0xFFE53935);
  static const lightGreen = Color(0xFFC8E6C9);
  static const darkGreen = Color(0xFF388E3C);

  // More colors
  static const lightTeal = Color(0xFFB2DFDB);
  static const darkTeal = Color(0xFF00897B);
  static const lightPink = Color(0xFFFFD6E0);
  static const darkPink = Color(0xFFD81B60);
  static const lightPurple = Color(0xFFCE93D8);
  static const darkPurple = Color(0xFF6A1B9A);

  // Even more colors
  static const lightBrown = Color(0xFFBCAAA4);
  static const darkBrown = Color(0xFF5D4037);
  static const lightCyan = Color(0xFF80DEEA);
  static const darkCyan = Color(0xFF0097A7);
  static const lightLime = Color(0xFFE6EE9C);
  static const darkLime = Color(0xFFAFB42B);

  // More colors to go
  static const lightAmber = Color(0xFFFFE082);
  static const darkAmber = Color(0xFFFFA000);
  static const lightIndigo = Color(0xFF9FA8DA);
  static const darkIndigo = Color(0xFF3F51B5);
  static const lightDeepOrange = Color(0xFFFFAB91);
  static const darkDeepOrange = Color(0xFFD84315);

  // And more colors
  static const lightLightGreen = Color(0xFFDCEDC8);
  static const darkLightGreen = Color(0xFF689F38);
  static const lightLightBlue = Color(0xFFE1F5FE);
  static const darkLightBlue = Color(0xFF0288D1);
  static const lightLightRed = Color(0xFFFFE0B2);
  static const darkLightRed = Color(0xFFAD1457);
}

// Default values
const defaultPadding = 20.0;
const defaultBorderRadius = BorderRadius.all(Radius.circular(8.0));
const defaultCardElevation = 4.0;
const defaultCardMargin = EdgeInsets.all(8.0);
const defaultCardPadding = EdgeInsets.all(12.0);
const defaultFontSize = 16.0;
const defaultIconSize = 24.0; 

// Theme data
class MyTheme {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    colorScheme: const ColorScheme.dark(),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(),
  );
}
