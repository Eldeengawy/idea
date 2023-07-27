import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// abstract class AppThemes {
//   static const Color defaultTextColorDark = Colors.white;
//   static const Color defaultTextColorLight = Colors.black;

//   // Define the dark theme
//   static final darkTheme = ThemeData(
//     brightness: Brightness.dark,
//     useMaterial3: true,
//     scaffoldBackgroundColor: const Color(0xff0c0a0b),
//     colorScheme: const ColorScheme.dark(
//       // primary:
//       //     Colors.orange, // Customize the primary color for dark theme if needed
//       onPrimary:
//           defaultTextColorDark, // Set the default text color for dark theme
//     ),
//     // Add other dark theme properties as needed,

//     textTheme: GoogleFonts.montserratTextTheme().copyWith(
//       // Set Monsterate as default font and change the default text color
//       bodyLarge: const TextStyle(
//         color: Colors.white, // Change the default text color to white
//       ),
//     ),
//   );

//   // Define the light theme
//   static final lightTheme = ThemeData(
//     brightness: Brightness.light,
//     primaryColor:
//         Colors.blue, // Set your desired primary color for the light theme
//     // Add other light theme properties as needed
//     textTheme: GoogleFonts.montserratTextTheme().copyWith(
//       // Set Monsterate as default font and change the default text color
//       bodyLarge: const TextStyle(
//         color: Colors.black, // Change the default text color to black
//       ),
//     ),
//   );
// }
abstract class AppThemes {
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor:
        Colors.orange, // Set your desired primary color for dark theme
    useMaterial3: true,
    scaffoldBackgroundColor: const Color(0xFF0C0A0B),
    textTheme: GoogleFonts.montserratTextTheme().copyWith(
      titleLarge: TextStyle(
        color: Colors.white,
        fontFamily: GoogleFonts.montserrat()
            .fontFamily, // Set the font family for dark theme
      ),
      bodyLarge: TextStyle(
        color: Colors.white, // Change the default text color to white
        fontFamily: GoogleFonts.montserrat()
            .fontFamily, // Set the font family for dark theme
      ),
      bodySmall: TextStyle(
        color: Colors.white
            .withOpacity(0.6), // Change the default text color to white
        fontFamily: GoogleFonts.montserrat()
            .fontFamily, // Set the font family for dark theme
      ),
      // Add more text styles as needed for dark theme
    ),
    // Add more theme properties as needed for dark theme
  );

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue, // Set your desired primary color for light theme
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    textTheme: GoogleFonts.montserratTextTheme().copyWith(
      titleLarge: TextStyle(
        color: Colors.black,
        fontFamily: GoogleFonts.montserrat()
            .fontFamily, // Set the font family for dark theme
      ),
      bodyLarge: TextStyle(
        color: Colors.white, // Change the default text color to black
        fontFamily: GoogleFonts.montserrat()
            .fontFamily, // Set the font family for dark theme
      ),
      bodySmall: TextStyle(
        color: Colors.black
            .withOpacity(0.6), // Change the default text color to black
        fontFamily: GoogleFonts.montserrat()
            .fontFamily, // Set the font family for dark theme
      ),
      // Add more text styles as needed for light theme
    ),
    // Add more theme properties as needed for light theme
  );
}

const kNotesBox = 'notes_box';
