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
                  height: 75,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Icon(
                          Icons.trending_up,
                          size: 100,
                        ),
                        Icon(
                          Icons.insights,
                          size: 100,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.bar_chart,
                          size: 150,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Icon(
                          Icons.trending_down,
                          size: 100,
                        ),
                        Icon(
                          Icons.data_usage,
                          size: 75,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const PageIndicator(currentPage: 1, totalPages: 3)
        ],
      ),
    );
  }
}
