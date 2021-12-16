import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme(
      primary: Colors.white,
      primaryVariant: Colors.grey.shade300,
      secondary: Colors.blue.shade100,
      secondaryVariant: Colors.blue.shade900,
      surface: Colors.white,
      background: Colors.white,
      error: Colors.red,
      onPrimary: Colors.black,
      onSecondary: Colors.black,
      onSurface: Colors.black,
      onBackground: Colors.black,
      onError: Colors.green,
      brightness: Brightness.light),
  appBarTheme: const AppBarTheme(elevation: 0.0),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      textStyle: MaterialStateProperty.all(
        const TextStyle(fontSize: 16.0),
      ),
      overlayColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.pressed)) {
          return Colors.lightBlue.shade200;
        } else {
          return Colors.transparent;
        }
      }),
      elevation: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.hovered)) {
          return 4.0;
        } else {
          return 0.0;
        }
      }),
      shape: MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      backgroundColor:
          MaterialStateProperty.all<Color>(Colors.lightBlue.shade100),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
        const EdgeInsets.all(20.0),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      textStyle: MaterialStateProperty.all(
        const TextStyle(fontSize: 16.0),
      ),
      overlayColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.pressed)) {
          return Colors.grey.shade100;
        }
      }),
      elevation: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.hovered)) {
          return 4.0;
        }
      }),
      shape: MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          side: BorderSide(width: 0.5, color: Colors.grey.shade900),
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.blue.shade900),
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
        const EdgeInsets.all(20.0),
      ),
    ),
  ),
  // floatingActionButtonTheme: 
);
