import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int page = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Achievers Journal')),
      body: PageView(
        onPageChanged: (value) => setState(() {
          page = value;
        }),
        children: const [
          Center(
            child: FlutterLogo(
              size: 50,
            ),
          ),
          Center(
            child: FlutterLogo(
              size: 100,
            ),
          ),
          Center(
            child: FlutterLogo(
              size: 150,
            ),
          ),
          Center(
            child: FlutterLogo(
              size: 200,
            ),
          ),
        ],
      ),
    );
  }
}
