import 'package:achievers_journal/components/weekly_analysis.dart';
import 'package:achievers_journal/models/db_access.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics'),
        centerTitle: true,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: Provider.of<Database>(context).getAnalytics(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              padding: const EdgeInsets.symmetric(
                vertical: 15.0,
                horizontal: 20.0,
              ),
              children: [
                WeeklyAnalysis(snapshot.data!['weekly_data']),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    StatCard(
                      Column(
                        children: [
                          Text(
                            'Average Goals Completion Rate',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            snapshot.data!['avg_completion_rate'].toString() +
                                "%",
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text('last 30 days'),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final Widget? child;

  const StatCard(this.child, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 175,
      width: 175,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Theme.of(context).cardColor,
        boxShadow: const [
          BoxShadow(color: Colors.grey, blurRadius: 10.0, spreadRadius: 0.0)
        ],
      ),
      child: child,
    );
  }
}
