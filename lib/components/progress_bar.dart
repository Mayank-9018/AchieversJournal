import 'package:achievers_journal/models/goal.dart';
import 'package:achievers_journal/screens/goal_detail.dart';
import 'package:flutter/material.dart';

class ProgressBar extends StatefulWidget {
  final IconData? icon;
  final String? goalName;
  final int progress;
  final int maxGoal;
  final Goal? goal;
  final bool isHistory;

  const ProgressBar(this.icon, this.goalName, this.progress, this.maxGoal,
      {Key? key, this.goal})
      : isHistory = false,
        super(key: key);

  ProgressBar.fromGoal(this.goal, {Key? key})
      : icon = goal!.icon != null
            ? IconData(goal.icon!, fontFamily: 'MaterialIcons')
            : null,
        goalName = goal.name,
        progress = goal.history.first['achieved'],
        maxGoal = goal.history.first['goal'],
        isHistory = false,
        super(key: key);

  const ProgressBar.history(this.progress, this.maxGoal, {Key? key})
      : isHistory = true,
        goal = null,
        goalName = null,
        icon = null,
        super(key: key);

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  final _scaleTween = Tween(begin: 1.0, end: 0.95);

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
      scale: _scaleTween.animate(
        CurvedAnimation(parent: _animationController, curve: Curves.linear),
      ),
      child: GestureDetector(
        onTapDown: (_) {
          _animationController.forward();
        },
        onTapCancel: () {
          _animationController.reverse();
        },
        onTap: () async {
          await _animationController.forward();
          if (widget.goal != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GoalDetailScreen(widget.goal!.position!),
              ),
            );
          }
          _animationController.reverse();
        },
        child: Stack(
          children: [
            Container(
              height: 70,
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.white
                    : Colors.grey.shade700,
                border: Border.all(width: 1.5),
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            LayoutBuilder(
              builder: (context, constraints) => Padding(
                padding: const EdgeInsets.only(top: 1.5, left: 1.5, right: 1.5),
                child: Container(
                  height: 70 - 3.0,
                  width: (constraints.maxWidth *
                      (widget.progress / widget.maxGoal)),
                  decoration: BoxDecoration(
                    color: (widget.progress / widget.maxGoal) >= 0.7
                        ? Colors.green
                        : (widget.progress / widget.maxGoal) > 0.3
                            ? Colors.amber
                            : Colors.red,
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                ),
              ),
            ),
            Positioned(
              top: widget.isHistory ? 25 : 16.5,
              left: widget.isHistory
                  ? (MediaQuery.of(context).size.width - 150) *
                          (widget.progress / widget.maxGoal) -
                      ((widget.progress / widget.maxGoal) < 0.5 ? 20 : 0) +
                      ((widget.progress / widget.maxGoal) == 0.0 ? 40 : 0)
                  : 10,
              child: widget.isHistory
                  ? Text(
                      (((widget.progress / widget.maxGoal)) * 100)
                          .round()
                          .toString(),
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontSize: 16.0),
                    )
                  : Row(
                      children: [
                        const SizedBox(
                          width: 15,
                        ),
                        Icon(
                          widget.icon,
                          color: Colors.black,
                          size: 35,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          widget.goalName!,
                          style: Theme.of(context).textTheme.bodyText1,
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
