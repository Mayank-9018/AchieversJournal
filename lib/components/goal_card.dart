import 'dart:async';
import 'dart:math';
import 'package:achievers_journal/components/custom_cpi_painter.dart';
import 'package:achievers_journal/models/db_access.dart';
import 'package:achievers_journal/models/goal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  late double oldPercentage;

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
    percentage = widget.goal.history!.first['achieved'] /
        widget.goal.history!.first['goal'];
    oldPercentage = percentage;
    animation = Tween<double>(begin: 0.0, end: percentage)
        .animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    percentage = widget.goal.history!.first['achieved'] /
        widget.goal.history!.first['goal'];
    runAnimation();
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
                    '${widget.goal.history!.first['achieved'].toString()} of ${widget.goal.history!.first['goal'].toString()} ${widget.goal.unit}'),
                const SizedBox(height: 10),
                Center(
                  child: OutlinedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(horizontal: 40),
                      ),
                    ),
                    onPressed: () {
                      Provider.of<Database>(context, listen: false)
                          .updateAchieved(
                        widget.goal.position!,
                        Random().nextInt(
                          widget.goal.history!.first['goal'] + 1,
                        ),
                      );
                    },
                    child: const Text('Update'),
                  ),
                ),
              ],
            ),
          ),
          AnimatedBuilder(
            child: Text(
              (percentage * 100).round().toString() + '%',
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

  void runAnimation() async {
    if (percentage > oldPercentage || oldPercentage > percentage) {
      await _animationController.reverse();
      animation = Tween<double>(
        begin: 0,
        end: percentage,
      ).animate(_animationController);
      _animationController.forward();
    }
    oldPercentage = percentage;
  }
}
