import 'dart:async';
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

class _GoalDetailScreenState extends State<GoalDetailScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
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
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: GoalCard(widget.goal),
            ),
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
                physics: const BouncingScrollPhysics(),
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
    return FadeTransition(
      opacity: _animationController,
      child: SlideTransition(
        position: Tween<Offset>(
                begin: Offset(0, 5 + index.toDouble() * 5), end: Offset.zero)
            .animate(
          CurvedAnimation(
              parent: _animationController, curve: Curves.decelerate),
        ),
        child: Row(
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
        ),
      ),
    );
  }
}
