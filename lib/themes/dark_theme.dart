import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData.dark().copyWith(
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xff303030),
    foregroundColor: Colors.white,
    elevation: 0.0,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(fontSize: 18.0, color: Colors.black),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      textStyle: MaterialStateProperty.all(
        const TextStyle(fontSize: 16.0),
      ),
      overlayColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.pressed)) {
          return Colors.blue.shade600;
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
      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue.shade800),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
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
          return Colors.grey.shade800;
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
        const BorderSide(width: 0.5, color: Colors.white),
      ),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
        const EdgeInsets.all(20.0),
      ),
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.blue.shade800,
    splashColor: Colors.blue.shade700,
    foregroundColor: Colors.white,
  ),
  listTileTheme: const ListTileThemeData(
    textColor: Colors.white,
  ),
  radioTheme: RadioThemeData(
    fillColor: MaterialStateProperty.all(Colors.blue.shade800),
    overlayColor: MaterialStateProperty.all(Colors.lightBlue.shade100),
  ),
  inputDecorationTheme: InputDecorationTheme(
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.white),
      borderRadius: BorderRadius.circular(14.0),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.shade300,
      ),
      borderRadius: BorderRadius.circular(14.0),
    ),
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.grey.shade200,
    selectionColor: Colors.grey.shade800,
    selectionHandleColor: Colors.grey.shade200,
  ),
  timePickerTheme: TimePickerThemeData(
    dialHandColor: Colors.grey.shade600,
    dialTextColor: Colors.white,
    dayPeriodColor: Colors.grey.shade400,
    backgroundColor: const Color(0xff303030),
    hourMinuteColor: Colors.grey.shade400,
    dayPeriodTextColor: MaterialStateColor.resolveWith(
      (states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.black;
        } else {
          return Colors.grey;
        }
      },
    ),
    entryModeIconColor: Colors.white,
    dialBackgroundColor: const Color(0xff303030),
    hourMinuteTextColor: Colors.black,
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      textStyle: MaterialStateProperty.all(
        const TextStyle(fontSize: 16.0),
      ),
      overlayColor: MaterialStateProperty.resolveWith(
        (states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.grey.shade700;
          } else {
            return Colors.transparent;
          }
        },
      ),
      backgroundColor:
          MaterialStateProperty.all<Color>(const Color(0xff303030)),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    ),
  ),
);
