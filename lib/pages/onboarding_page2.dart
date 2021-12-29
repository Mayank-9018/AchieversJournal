import 'package:achievers_journal/components/page_indicator.dart';
import 'package:flutter/material.dart';

class OnboardingPage2 extends StatelessWidget {
  const OnboardingPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 60.0, left: 40.0, right: 40.0, bottom: 30),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Text(
                  'Analytics coming soon!',
                  style: Theme.of(context).textTheme.headline3,
                ),
                const SizedBox(
                  height: 50,
                ),
                Image.asset(
                  'assets/analytics.png',
                  height: 250,
                )
              ],
            ),
          ),
          const PageIndicator(currentPage: 1, totalPages: 3)
        ],
      ),
    );
  }
}
