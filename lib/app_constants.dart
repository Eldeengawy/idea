import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppThemes {
  static const Color defaultTextColorDark = Colors.white;
  static const Color defaultTextColorLight = Colors.black;

  // Define the dark theme
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    scaffoldBackgroundColor: const Color(0xff0c0a0b),
    colorScheme: const ColorScheme.dark(
      // primary:
      //     Colors.orange, // Customize the primary color for dark theme if needed
      onPrimary:
          defaultTextColorDark, // Set the default text color for dark theme
    ),
    // Add other dark theme properties as needed,

    textTheme: GoogleFonts.montserratTextTheme().copyWith(
      // Set Monsterate as default font and change the default text color
      bodyLarge: const TextStyle(
        color: Colors.white, // Change the default text color to white
      ),
    ),
  );

  // Define the light theme
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor:
        Colors.blue, // Set your desired primary color for the light theme
    // Add other light theme properties as needed
    textTheme: GoogleFonts.montserratTextTheme().copyWith(
      // Set Monsterate as default font and change the default text color
      bodyLarge: const TextStyle(
        color: Colors.black, // Change the default text color to black
      ),
    ),
  );
}

bool isNightMode =
    true; // This is not related to the font, just leaving it as it is.
