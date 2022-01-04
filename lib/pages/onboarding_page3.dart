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
            child: Column(
              children: [
                Text(
                  'Reminders to keep you on track',
                  style: Theme.of(context).textTheme.headline3,
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  child: Image.asset(
                    'assets/notif.png',
                    height: 300,
                  ),
                  foregroundDecoration: BoxDecoration(
                    gradient: LinearGradient(
                      stops: const [0.7, 1.0],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Theme.of(context).brightness == Brightness.light
                            ? Colors.white
                            : const Color(0xff303030)
                      ],
                    ),
                  ),
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
