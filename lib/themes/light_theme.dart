import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    elevation: 0.0,
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.lightBlue.shade100,
    splashColor: Colors.lightBlue.shade200,
    foregroundColor: Colors.black,
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      textStyle: MaterialStateProperty.all(
        const TextStyle(fontSize: 16.0),
      ),
      overlayColor: MaterialStateProperty.resolveWith(
        (states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.grey.shade300;
          } else {
            return Colors.transparent;
          }
        },
      ),
      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
    ),
  ),
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
  outlinedButtonTheme: OutlinedButtonThemeData(
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
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      side: MaterialStateProperty.all<BorderSide>(
        BorderSide(width: 0.5, color: Colors.grey.shade900),
      ),
      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.blue.shade900),
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
        const EdgeInsets.all(20.0),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(),
      borderRadius: BorderRadius.circular(14.0),
    ),
    border: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.grey,
      ),
      borderRadius: BorderRadius.circular(14.0),
    ),
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.black,
    selectionColor: Colors.grey.shade200,
    selectionHandleColor: Colors.black,
  ),
  radioTheme: RadioThemeData(
    fillColor: MaterialStateProperty.all(Colors.blue.shade900),
    overlayColor: MaterialStateProperty.all(Colors.lightBlue.shade100),
  ),
  timePickerTheme: TimePickerThemeData(
    dialHandColor: Colors.grey,
    dialTextColor: Colors.black,
    dayPeriodColor: Colors.grey.shade200,
    backgroundColor: Colors.white,
    hourMinuteColor: Colors.grey.shade200,
    dayPeriodTextColor: MaterialStateColor.resolveWith(
      (states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.black;
        } else {
          return Colors.grey;
        }
      },
    ),
    entryModeIconColor: Colors.black,
    dialBackgroundColor: Colors.white,
    hourMinuteTextColor: Colors.black,
  ),
  textTheme: const TextTheme(
    headline1: TextStyle(color: Color(0xff444444)),
    headline2: TextStyle(color: Color(0xff444444)),
    headline3: TextStyle(color: Color(0xff444444)),
    headline4: TextStyle(color: Color(0xff444444)),
    headline5: TextStyle(color: Color(0xff444444)),
    headline6: TextStyle(color: Color(0xff444444)),
    bodyText1: TextStyle(fontSize: 18.0, color: Colors.black),
    bodyText2: TextStyle(color: Colors.black),
  ),
);
