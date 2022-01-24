import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/progress_bar.dart';
import '../models/db_access.dart';
import '../models/goal.dart';
import 'analytics.dart';
import 'new_goal.dart';
import 'settings.dart';

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
            Center(
              child: DrawerHeader(
                padding: const EdgeInsets.only(top: 75.0),
                child: Text(
                  'Achievers Journal',
                  style: Theme.of(context).textTheme.headline5!,
                ),
              ),
            ),
            ListTile(
              minLeadingWidth: 30.0,
              contentPadding: const EdgeInsets.symmetric(horizontal: 40.0),
              leading: const Icon(Icons.analytics_outlined),
              title: const Text('Analytics'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AnalyticsScreen(),
                  ),
                );
              },
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
                  stream: database.rdbData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.snapshot.value == null ||
                          (snapshot.data!.snapshot.value
                                  as Map<dynamic, dynamic>)['goals']
                              .isEmpty) {
                        return getEmpty(context);
                      } else {
                        return ListView(
                          padding: const EdgeInsets.only(
                            top: 50,
                            left: 20,
                            right: 20,
                          ),
                          children: getProgressBars(snapshot
                              .data!.snapshot.value as Map<dynamic, dynamic>),
                        );
                      }
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
                                if (snapshot.data!['goals'].isEmpty) {
                                  return getEmpty(context);
                                } else {
                                  return ListView(
                                    padding: const EdgeInsets.only(
                                      top: 50,
                                      left: 20,
                                      right: 20,
                                    ),
                                    children: getProgressBars(snapshot.data!),
                                  );
                                }
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

  Widget getEmpty(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/mountain.png',
          height: 150,
        ),
        const SizedBox(
          height: 25,
        ),
        Text(
          'No Goals yet',
          style:
              Theme.of(context).textTheme.headline6!.copyWith(fontSize: 24.0),
        ),
        const SizedBox(
          height: 50,
        ),
      ],
    );
  }

  List<Widget> getProgressBars(Map<dynamic, dynamic> data) {
    List<Widget> bars = [];
    int i = 0;

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
