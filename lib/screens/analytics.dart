import 'package:achievers_journal/components/weekly_analysis.dart';
import 'package:achievers_journal/models/db_access.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics'),
        centerTitle: true,
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: Provider.of<Database>(context).getAnalytics(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (isLandscape) {
              return Row(
                children: [
                  WeeklyAnalysis(
                    snapshot.data!['weekly_data'],
                    isLandscape: true,
                  ),
                  Expanded(
                    child: getChildren(snapshot, isLandscape, context),
                  ),
                ],
              );
            } else {
              return Column(children: [
                WeeklyAnalysis(snapshot.data!['weekly_data']),
                Expanded(child: getChildren(snapshot, isLandscape, context))
              ]);
            }
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.auto_graph_outlined,
                    size: 150,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    'No Data yet',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontSize: 24.0),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget getChildren(snapshot, isLandscape, context) {
    return GridView(
      padding: const EdgeInsets.all(15.0),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 250,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
      ),
      children: [
        StatCard(
          Column(
            children: [
              Text(
                'Average Goals\nCompletion Rate',
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                snapshot.data!['avg_completion_rate'].toString() + "%",
                style: Theme.of(context).textTheme.headline2,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('last 30 days'),
            ],
          ),
        ),
        StatCard(
          Column(
            children: [
              const SizedBox(
                height: 7.5,
              ),
              Text('Trend',
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontSize: 25)),
              const SizedBox(
                height: 12.5,
              ),
              Text(
                (snapshot.data!['trend'] > 0
                        ? "+"
                        : snapshot.data!['trend'] < 0
                            ? "-"
                            : "") +
                    snapshot.data!['trend'].toString() +
                    "%",
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: snapshot.data!['trend'] > 0
                          ? Colors.green
                          : snapshot.data!['trend'] < 0
                              ? Colors.red
                              : Colors.grey,
                    ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text('over last week'),
            ],
          ),
        )
      ],
    );
  }
}

class StatCard extends StatelessWidget {
  final Widget? child;

  const StatCard(this.child, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width / 2 - 25;
    return Container(
      height: size > 175 ? 175 : size,
      width: size > 175 ? 175 : size,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.grey.shade300
                : Colors.grey.shade800,
            blurRadius: 15.0,
            spreadRadius: 2.0,
          ),
        ],
      ),
      child: FittedBox(
        alignment: Alignment.topCenter,
        child: child,
        fit: BoxFit.scaleDown,
      ),
    );
  }
}
