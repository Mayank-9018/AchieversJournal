import 'package:achievers_journal/models/goal.dart';
import 'package:flutter/material.dart';

class ProgressBar extends StatefulWidget {
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
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 125),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween(begin: 1.0, end: 0.90).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.linear),
      ),
      child: GestureDetector(
        onTap: widget.goal == null
            ? () {}
            : () async {
                await _animationController.forward();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Scaffold(
                      appBar: AppBar(),
                    ),
                  ),
                );
                _animationController.reverse();
              },
        child: Stack(
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
                  width: (constraints.maxWidth *
                          widget.progress /
                          widget.maxGoal) -
                      3.0,
                  decoration: BoxDecoration(
                    color: widget.progress / widget.maxGoal > 0.7
                        ? Colors.green
                        : widget.progress / widget.maxGoal > 0.3
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
                    widget.icon,
                    size: 35,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    widget.goalName,
                    style: const TextStyle(fontSize: 18),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
