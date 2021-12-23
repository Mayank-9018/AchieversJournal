import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:achievers_journal/screens/onboarding.dart';
import 'package:achievers_journal/themes/dark_theme.dart';
import 'package:achievers_journal/themes/light_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const AJApp());
}

class AJApp extends StatelessWidget {
  const AJApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      home: const OnboardingScreen(),
    );
  }
}
