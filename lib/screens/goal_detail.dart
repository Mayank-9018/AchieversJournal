import 'package:achievers_journal/components/date_circle.dart';
import 'package:achievers_journal/components/goal_card.dart';
import 'package:achievers_journal/components/progress_bar.dart';
import 'package:achievers_journal/models/goal.dart';
import 'package:flutter/material.dart';

class GoalDetailScreen extends StatefulWidget {
  final Goal goal;
  const GoalDetailScreen(this.goal, {Key? key}) : super(key: key);

  @override
  _GoalDetailScreenState createState() => _GoalDetailScreenState();
}

class _GoalDetailScreenState extends State<GoalDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            GoalCard(widget.goal),
            const SizedBox(height: 20),
            Center(
              child: Text(
                'History',
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(15.0),
                itemCount: widget.goal.history?.length ?? 0,
                itemBuilder: (context, index) => getHistoryBar(index),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getHistoryBar(int index) {
    return Row(
      children: [
        DateCircle(widget.goal.history!.elementAt(index)['date']),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: ProgressBar.history(
            widget.goal.history!.elementAt(index)['achieved'],
            widget.goal.history!.elementAt(index)['goal'],
          ),
        ),
      ],
    );
  }
}
