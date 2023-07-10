import 'package:flutter/material.dart';

class AppColor {
  MaterialColor lightColors = MaterialColor(
    0xFFFE7240,
    <int, Color>{
      50: Color(0xFFFFF8F6),
      100: Color(0xFFFFF1EC),
      200: Color(0xFFFFDCD0),
      300: Color(0xFFFFC6B1),
      400: Color(0xFFFF9D7A),
      500: Color(0xFFFE7240),
      600: Color(0xFFE36639),
      700: Color(0xFF994527),
      800: Color(0xFF73341D),
      900: Color(0xFF4A2213),
    },
  );

  MaterialColor darkColors = MaterialColor(
    0xFFFE7240,
    <int, Color>{
      50: Color(0xFF4A4E52),
      100: Color(0xFF404448),
      200: Color(0xFF353A3D),
      300: Color(0xFF2B3032),
      400: Color(0xFF202427),
      500: Color(0xFF161A1B),
      600: Color(0xFF0C0D0E),
      700: Color(0xFF030304),
      800: Color(0xFF000000),
      900: Color(0xFF000000),
    },
  );
}
