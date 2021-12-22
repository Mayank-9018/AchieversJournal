import 'dart:async';

import 'package:achievers_journal/models/goal.dart';
import 'package:flutter/material.dart';

class GoalCard extends StatefulWidget {
  final Goal goal;

  const GoalCard(this.goal, {Key? key}) : super(key: key);

  @override
  State<GoalCard> createState() => _GoalCardState();
}

class _GoalCardState extends State<GoalCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    animation = Tween<double>(
      begin: 0.0,
      end: widget.goal.history!.first['achieved'] /
          widget.goal.history!.first['goal'],
    ).animate(_animationController);
    Timer(const Duration(milliseconds: 500), () {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.green.shade200,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.goal.name,
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 10),
              Text(widget.goal.description ?? ''),
              // DateTime.tryParse(goal.history.where((element) => false))
              Text(
                  '${widget.goal.history!.first['achieved'].toString()} of ${widget.goal.history!.first['goal'].toString()}'),
            ],
          ),
          AnimatedBuilder(
            child: Text(((widget.goal.history!.first['achieved'] /
                        widget.goal.history!.first['goal']) *
                    100)
                .round()
                .toString()),
            animation: animation,
            builder: (context, child) => Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: CircularProgressIndicator( // Create a custom circular progress indicator with boder and rounded corners
                    color: Colors.red, // TODO: Fix color
                    strokeWidth: 10.0,
                    value: animation.value,
                  ),
                ),
                child!,
              ],
            ),
          )
          // TweenAnimationBuilder<double>(
          //   tween: Tween<double>(
          //       begin: 0.0,
          //       end: widget.goal.history!.first['achieved'] /
          //           widget.goal.history!.first['goal']),
          //   duration: const Duration(milliseconds: 4000),
          //   builder: (context, value, _) =>
          //       CircularProgressIndicator(value: value),
          // ),
        ],
      ),
    );
  }
}
