import 'package:achievers_journal/components/progress_bar.dart';
import 'package:achievers_journal/models/db_access.dart';
import 'package:achievers_journal/models/goal.dart';
import 'package:achievers_journal/screens/new_goal.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => Database(),
      builder: (context, child) {
        return Scaffold(
          body: Center(
            child: FutureBuilder<bool>(
              future: Provider.of<Database>(context, listen: false).isLoggedIn,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!) {
                    return StreamBuilder<DatabaseEvent>(
                      stream: Provider.of<Database>(context, listen: false).data
                          as Stream<DatabaseEvent>,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView(
                            children: getProgressBars(snapshot
                                .data!.snapshot.value as Map<dynamic, dynamic>),
                          );
                        } else {
                          return const CircularProgressIndicator(
                            color: Colors.red,
                          );
                        }
                      },
                    );
                  } else {
                    return FutureBuilder<Map<String, dynamic>>(
                      future: Provider.of<Database>(context, listen: false)
                          .localData(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(snapshot.data!.toString());
                        } else {
                          return const CircularProgressIndicator(
                            color: Colors.green,
                          );
                        }
                      },
                    );
                  }
                } else {
                  return const CircularProgressIndicator(
                    color: Colors.blue,
                  );
                }
              },
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton.extended(
            splashColor: Colors.blue.shade300,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NewGoalScreen(),
              ));
            },
            icon: const Icon(Icons.add),
            label: const Text('New Goal'),
          ),
        );
      },
    );
  }

  List<Widget> getProgressBars(Map<dynamic, dynamic> data) {
    List<Widget> bars = [];
    for (Map<dynamic, dynamic> goal in data['goals']) {
      bars.add(
        ProgressBar.fromGoal(
          Goal.fromMap(
            goal,
          ),
        ),
      );
      bars.add(
        const SizedBox(
          height: 10,
        ),
      );
    }
    return bars;
  }
}
