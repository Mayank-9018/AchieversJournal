import 'package:achievers_journal/components/page_indicator.dart';
import 'package:achievers_journal/components/weekly_analysis.dart';
import 'package:achievers_journal/screens/analytics.dart';
import 'package:flutter/material.dart';

class OnboardingPage2 extends StatelessWidget {
  const OnboardingPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0, bottom: 30),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Text(
                    'In-depth analytics',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  const SizedBox(height: 40),
                  const WeeklyAnalysis([0.2, 0.6, 0.4, 0.5, 0.7, 0.6, 1.0]),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StatCard(
                        Column(
                          children: [
                            Text(
                              'Average Goals\nCompletion Rate',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '56%',
                              style: Theme.of(context).textTheme.headline2,
                            ),
                          ],
                        ),
                      ),
                      StatCard(
                        Column(
                          children: [
                            const SizedBox(height: 10),
                            Text(
                              'Trend',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(fontSize: 26),
                            ),
                            const SizedBox(height: 15),
                            Text(
                              '+12%',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2!
                                  .copyWith(color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const PageIndicator(currentPage: 1, totalPages: 3)
        ],
      ),
    );
  }
}
