import 'package:achievers_journal/screens/dashboard.dart';
import 'package:achievers_journal/screens/onboarding.dart';
import 'package:achievers_journal/themes/dark_theme.dart';
import 'package:achievers_journal/themes/light_theme.dart';
import 'package:flutter/material.dart';

void main() => runApp(AJApp());

class AJApp extends StatelessWidget {
  const AJApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
      home: DashboardScreen(),
    );
  }
}
