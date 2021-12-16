import 'package:flutter/material.dart';
import '/components/page_indicator.dart';

class OnboardingPage3 extends StatelessWidget {
  const OnboardingPage3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 60.0,
        left: 40.0,
        right: 40.0,
        bottom: 30,
      ),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Text(
                  'Reminders to keep you on track',
                  style: Theme.of(context).textTheme.headline3,
                ),
                const SizedBox(
                  height: 25,
                ),
                Image.asset(
                  'assets/notif.jpg',
                  height: 270,
                )
              ],
            ),
          ),
          const PageIndicator(currentPage: 2, totalPages: 3)
        ],
      ),
    );
  }
}
