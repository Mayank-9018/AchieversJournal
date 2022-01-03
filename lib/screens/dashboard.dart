import 'package:achievers_journal/components/progress_bar.dart';
import 'package:achievers_journal/models/db_access.dart';
import 'package:achievers_journal/models/goal.dart';
import 'package:achievers_journal/screens/new_goal.dart';
import 'package:achievers_journal/screens/settings.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Database database = Provider.of<Database>(context, listen: false);
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: ListView(
          children: [
            const Center(
              child: DrawerHeader(
                padding: EdgeInsets.only(top: 75.0),
                child: Text(
                  'Achievers Journal',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            ListTile(
              minLeadingWidth: 30.0,
              contentPadding: const EdgeInsets.symmetric(horizontal: 40.0),
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: FutureBuilder<bool>(
          future: database.getSignInStatus(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!) {
                return StreamBuilder<DatabaseEvent>(
                  stream: database.fireData,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView(
                        padding: const EdgeInsets.only(
                          top: 50,
                          left: 20,
                          right: 20,
                        ),
                        children: getProgressBars(
                            (snapshot.data!.snapshot.value ??
                                    <dynamic, dynamic>{'goals': []})
                                as Map<dynamic, dynamic>),
                      );
                    } else {
                      return const CircularProgressIndicator(
                        color: Colors.brown,
                      );
                    }
                  },
                );
              } else {
                return FutureBuilder(
                  future: database.loadFile,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return StreamBuilder(
                        stream: database.getModifyEvents(),
                        builder: (context, snapshot) {
                          return FutureBuilder<Map<String, dynamic>>(
                            future: database.readFile(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ListView(
                                  padding: const EdgeInsets.only(
                                    top: 50,
                                    left: 20,
                                    right: 20,
                                  ),
                                  children: getProgressBars(snapshot.data!),
                                );
                              } else {
                                return const CircularProgressIndicator(
                                  color: Colors.pink,
                                );
                              }
                            },
                          );
                        },
                      );
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        splashColor: Colors.blue.shade300,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const NewGoalScreen(),
          ));
        },
        icon: const Icon(Icons.add),
        label: const Text('New Goal'),
      ),
    );
  }

  List<Widget> getProgressBars(Map<dynamic, dynamic> data) {
    List<Widget> bars = [];
    int i = 0;
    if (data['goals'].isEmpty || data['goals'] == null) {
      bars.add(const Text('No Goals yet!'));
      return bars;
    }
    for (Map<dynamic, dynamic> goal in data['goals']) {
      bars.add(
        ProgressBar.fromGoal(
          Goal.fromMap(goal, i),
        ),
      );
      bars.add(
        const SizedBox(
          height: 10,
        ),
      );
      i++;
    }
    return bars;
  }
}
