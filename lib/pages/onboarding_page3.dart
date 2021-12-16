import 'package:flutter/material.dart';
import '/components/notification_demo.dart';
import '/components/page_indicator.dart';

class OnboardingPage3 extends StatelessWidget {
  const OnboardingPage3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 80.0, horizontal: 40.0),
      child: Column(
        children: [
          Text(
            'Reminders to keep you on track',
            style: Theme.of(context).textTheme.headline3,
          ),
          const SizedBox(
            height: 50,
          ),
          const NotificationDemo(),
          const SizedBox(
            height: 100,
          ),
          const PageIndicator(currentPage: 2, totalPages: 3)
        ],
      ),
    );
  }
}
