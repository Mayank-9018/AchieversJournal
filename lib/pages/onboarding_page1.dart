import 'package:flutter/material.dart';
import '/components/page_indicator.dart';
import '/components/progress_bar.dart';

class OnboardingPage1 extends StatelessWidget {
  const OnboardingPage1({Key? key}) : super(key: key);

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
                  'Effectively track your goals',
                  style: Theme.of(context).textTheme.headline3,
                ),
                const SizedBox(
                  height: 50,
                ),
                const ProgressBar(
                    Icons.chrome_reader_mode_outlined, 'Read', 60),
                const SizedBox(
                  height: 10,
                ),
                const ProgressBar(Icons.self_improvement, 'Meditate', 100),
                const SizedBox(
                  height: 10,
                ),
                const ProgressBar(Icons.translate, 'Practice German', 15),
              ],
            ),
          ),
          const PageIndicator(currentPage: 0, totalPages: 3)
        ],
      ),
    );
  }
}
