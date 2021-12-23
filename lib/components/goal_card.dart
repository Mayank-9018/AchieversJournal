import 'dart:async';

import 'package:achievers_journal/components/custom_cpi_painter.dart';
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
  late double percentage;

  @override
  void initState() {
    super.initState();
    percentage = widget.goal.history!.first['achieved'] /
        widget.goal.history!.first['goal'];
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    animation = Tween<double>(
      begin: 0.0,
      end: percentage,
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
        border: Border.all(),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width / 2 - 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.goal.name,
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 20),
                Text(widget.goal.description ?? ''),
                const SizedBox(height: 5),
                Text(
                    '${widget.goal.history!.first['achieved'].toString()} of ${widget.goal.history!.first['goal'].toString()}'),
              ],
            ),
          ),
          AnimatedBuilder(
            child: Text(
              ((widget.goal.history!.first['achieved'] /
                              widget.goal.history!.first['goal']) *
                          100)
                      .round()
                      .toString() +
                  '%',
              style: Theme.of(context).textTheme.headline5,
            ),
            animation: animation,
            builder: (context, child) => Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                    height: 150,
                    width: 150,
                    child: CustomPaint(
                      painter: CustomCPI(
                          animation.value,
                          percentage > 0.7
                              ? Colors.green
                              : percentage > 0.3
                                  ? Colors.amber
                                  : Colors.red),
                    )),
                child!,
              ],
            ),
          )
        ],
      ),
    );
  }
}
