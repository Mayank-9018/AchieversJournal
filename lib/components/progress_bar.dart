import 'package:achievers_journal/models/goal.dart';
import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final IconData icon;
  final String goalName;
  final int progress;
  final int maxGoal;
  final Goal? goal;
  const ProgressBar(this.icon, this.goalName, this.progress, this.maxGoal,
      {Key? key, this.goal})
      : super(key: key);

  ProgressBar.fromGoal(this.goal, {Key? key})
      : icon = IconData(goal!.icon!, fontFamily: 'MaterialIcons'),
        goalName = goal.name,
        progress = goal.history!.first['achieved'],
        maxGoal = goal.history!.first['goal'],
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 1.5),
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) => Padding(
            padding: const EdgeInsets.only(top: 1.5, left: 1.5),
            child: Container(
              height: 70 - 3.0,
              width: (constraints.maxWidth * progress / maxGoal) - 3.0,
              decoration: BoxDecoration(
                color: progress / maxGoal > 0.7
                    ? Colors.green
                    : progress / maxGoal > 0.3
                        ? Colors.amber
                        : Colors.red,
                borderRadius: BorderRadius.circular(14.0),
              ),
            ),
          ),
        ),
        Positioned(
          top: 16.5,
          left: 10,
          child: Row(
            children: [
              const SizedBox(
                width: 15,
              ),
              Icon(
                icon,
                size: 35,
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                goalName,
                style: const TextStyle(fontSize: 18),
              )
            ],
          ),
        )
      ],
    );
  }
}
