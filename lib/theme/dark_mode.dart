import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade900,
    primary: Colors.grey.shade800,
    secondary: Colors.grey.shade600,
    inversePrimary: Colors.grey.shade200,
  ),
  textTheme: ThemeData.dark().textTheme.apply(
    bodyColor: Colors.grey[200],
    displayColor: Colors.white,
  ),
);
