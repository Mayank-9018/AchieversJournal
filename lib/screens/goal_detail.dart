import 'package:achievers_journal/components/goal_card.dart';
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
      body: ListView(
        padding: const EdgeInsets.all(10.0),
        children: [
          GoalCard(widget.goal),
        ],
      ),
    );
  }
}
