import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:idea/app_constants.dart';
import 'package:idea/views/notes_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Set the status bar color to dark background with white (light) text
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent, // For transparent status bar
      statusBarIconBrightness: Brightness.light,
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Idea',
      theme: isNightMode
          ? AppThemes.darkTheme
          : AppThemes.lightTheme, // Set the theme based on isNightMode flag

      // theme: ThemeData(
      //     brightness: Brightness.dark,
      //     useMaterial3: true,
      //     scaffoldBackgroundColor: const Color(0xff0c0a0b)),
      home: const NotesView(),
    );
  }
}
