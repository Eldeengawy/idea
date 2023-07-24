import 'package:flutter/material.dart';

abstract class AppThemes {
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    scaffoldBackgroundColor: const Color(0xff0c0a0b),
    // Add other dark theme properties as needed
  );

// Define the light theme
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor:
        Colors.blue, // Set your desired primary color for the light theme
    // Add other light theme properties as needed
  );
}

bool isNightMode = true;
