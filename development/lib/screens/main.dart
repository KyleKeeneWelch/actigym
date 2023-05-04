// CIS099-2 Mobile Application Development.
// Assignment 2.
// ActiGym - Workout creator, tracker and logger.
// Kyle Keene - Welch, 2101940
// main.dart

import 'package:flutter/material.dart';
import 'login.dart';
import 'package:splashscreen/splashscreen.dart';

// The start of the app. Executed first and creates a new app instance.
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Gets rid of debug banner shown at top right.
      debugShowCheckedModeBanner: false,
      // Defines a theme for the application that is shared across all pages. Contains primary, background colours, font family and text themes for different app elements.
      theme: ThemeData(
        primaryColor: Color(0xFF76FF03),
        scaffoldBackgroundColor: Color(0xFF0A0E21),
        fontFamily: 'Helvetica',
        brightness: Brightness.dark,
        textTheme: const TextTheme(
          headline1: TextStyle(
              fontSize: 40.0, fontFamily: 'Helvetica', color: Colors.white),
          headline2: TextStyle(
              fontSize: 25.0, fontFamily: 'Helvetica', color: Colors.white),
          headline3: TextStyle(
              fontSize: 20.0, fontFamily: 'Helvetica', color: Colors.white),
          headline4: TextStyle(
              fontSize: 20.0, fontFamily: 'Helvetica', color: Colors.black),
          bodyText2: TextStyle(
              fontSize: 15.0, fontFamily: 'Helvetica', color: Colors.white),
          bodyText1: TextStyle(
            fontSize: 15.0,
            fontFamily: 'Helvetica',
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        // Defines splash, highlight and divider theme.
        splashColor: Colors.white,
        highlightColor: Color(0xFFC6FF00),
        dividerTheme: DividerThemeData(
          color: Colors.white,
          thickness: 2,
          space: 2,
        ),
      ),
      // Implements a splash screen at the beginning of the app which lasts for 5 seconds then goes to login page.
      home: SplashScreen(
        seconds: 5,
        navigateAfterSeconds: LoginPage(),
        image: new Image.asset('assets/images/actigymicon.jpg'),
        photoSize: 100,
        backgroundColor: Color(0xFF0A0E21),
        loaderColor: Color(0xFFC6FF00),
      ),
    );
  }
}
