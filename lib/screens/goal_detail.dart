import 'dart:async';
import 'dart:io';
import 'package:achievers_journal/components/date_circle.dart';
import 'package:achievers_journal/components/goal_card.dart';
import 'package:achievers_journal/screens/goal_edit_dialog.dart';
import 'package:achievers_journal/components/progress_bar.dart';
import 'package:achievers_journal/models/db_access.dart';
import 'package:achievers_journal/models/goal.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GoalDetailScreen extends StatefulWidget {
  final int position;

  const GoalDetailScreen(this.position, {Key? key}) : super(key: key);

  @override
  _GoalDetailScreenState createState() => _GoalDetailScreenState();
}

class _GoalDetailScreenState extends State<GoalDetailScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late Goal _goal;

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
    Database database = Provider.of<Database>(context, listen: false);
    return FutureBuilder<bool>(
      future: database.getSignInStatus(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!) {
            return StreamBuilder<DatabaseEvent>(
              stream: database.getGoalDetails(widget.position),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
                  _goal = Goal.fromMap(
                      snapshot.data!.snapshot.value as Map, widget.position);
                }
                return insideContent(
                    snapshot.hasData && snapshot.data!.snapshot.value != null);
              },
            );
          } else {
            return StreamBuilder<FileSystemEvent>(
              stream: database.getModifyEvents(),
              builder: (context, snapshot) {
                return FutureBuilder<Map<String, dynamic>>(
                  future: database.readFile(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (!snapshot.data!['goals'].isEmpty) {
                        _goal = Goal.fromMap(
                            snapshot.data!['goals'].elementAt(widget.position),
                            widget.position);
                      }
                    }
                    return insideContent(
                        (snapshot.hasData && !snapshot.data!['goals'].isEmpty));
                  },
                );
              },
            );
          }
        } else {
          return insideContent(false);
        }
      },
    );
  }

  Widget insideContent(bool hasData) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    late List<Widget> components = [
      GoalCard(_goal, isLandscape),
      Expanded(
        child: Column(
          children: [
            Center(
              child: Text(
                'History',
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(15.0),
                itemCount: _goal.history.isEmpty ? 0 : _goal.history.length - 1,
                itemBuilder: (context, index) => getHistoryBar(index + 1),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
              ),
            ),
          ],
        ),
      ),
    ];
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => GoalEditDialog(_goal),
                    fullscreenDialog: true));
              },
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              onPressed: _showTimePickerDialog,
              icon: const Icon(Icons.alarm),
              tooltip: 'Add a reminder',
            ),
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Confirm goal delete'),
                    content: RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyText2,
                        children: [
                          const TextSpan(text: 'Confirm delete goal - '),
                          TextSpan(
                            text: _goal.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      OutlinedButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 15,
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 15,
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          Provider.of<Database>(context, listen: false)
                              .deleteGoal(widget.position);
                        },
                        child: const Text('Confirm'),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.delete_outline),
            ),
          ],
        ),
        body: hasData
            ? Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 10,
                  right: 10,
                ),
                child: isLandscape
                    ? Row(children: components)
                    : Column(children: components),
              )
            : null);
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
            DateCircle(_goal.history.elementAt(index)['date']),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: ProgressBar.history(
                _goal.history.elementAt(index)['achieved'],
                _goal.history.elementAt(index)['goal'],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showTimePickerDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => TimePickerDialog(
        initialTime: _goal.reminderTime != null
            ? TimeOfDay(
                hour: int.parse(_goal.reminderTime!.split(':').first),
                minute: int.parse(
                  _goal.reminderTime!.split(':').elementAt(1),
                ),
              )
            : TimeOfDay.now(),
        cancelText: _goal.reminderTime != null ? 'Cancel reminder' : null,
      ),
    ).then(
      (value) {
        if (value == null && _goal.reminderTime == null) {
          return;
        }
        Database database = Provider.of<Database>(context, listen: false);
        if (value == null) {
          database.cancelNotification(_goal.id);
        } else {
          database.scheduleNotification(
            value.hour,
            value.minute,
            _goal.id,
            _goal.name,
            _goal.description ?? 'Time to ${_goal.name}',
          );
        }
        database.updateReminderTime(_goal.position!,
            value == null ? null : '${value.hour}:${value.minute}');
      },
    );
  }
}
