import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'notifications.dart';

class Database {
  late bool usingGoogleSignIn;
  FirebaseDatabase? _firebaseInstance;
  late final Notifications notifications;
  late final Future<File> loadFile;
  late final File _file;
  bool fileLoaded = false;
  late SharedPreferences _prefs;
  late String userUID;

  Database() {
    notifications = Notifications();
  }

  /// Updates the userUID after successful sign-in.
  void updateUserUID(String uid) {
    userUID = uid;
  }

  /// Reads the `SharedPreferences` to check if the user is logged in/syncing data;
  /// Returns type `bool`
  Future<bool> getSignInStatus() async {
    _prefs = await SharedPreferences.getInstance();
    bool status = _prefs.getBool('usingGoogleSignIn') ?? false;
    if (!status && fileLoaded == false) {
      loadFile = _loadLocalFile();
    }
    usingGoogleSignIn = status;
    return status;
  }

  /// Reads the `SharedPreferences` to check if the user(local)
  /// had completed onboarding or not.
  bool hasCompletedOnboarding() {
    bool status = _prefs.getBool('hasCompletedOnboarding') ?? false;
    return status;
  }

  /// Takes `bool` `status` and updates SharedPreference key-**usingGoogleSignIn**
  /// with the the `status` value.
  void updateSignInStatus(bool status) {
    _prefs.setBool('usingGoogleSignIn', status);
  }

  /// Takes `bool` `status` and updates SharedPreference key-**hasCompletedOnboarding**
  /// with the the `status` value.
  void updateCompletedOnboardingStatus(bool status) {
    _prefs.setBool('hasCompletedOnboarding', status);
  }

  Future<File> _loadLocalFile() async {
    fileLoaded = true;
    final path = await _localPath;
    _file = File('$path/data.json');
    if (!await _file.exists()) {
      await _file.create();
      _file.writeAsString(
        jsonEncode(
          <String, dynamic>{
            'goals': [],
          },
        ),
      );
    }
    return _file;
  }

  /// Returns a `Stream` of type `DatabaseEvent` from the firebase
  /// realtime database; Used when user opts in to sync data;
  Stream<DatabaseEvent> rdbData() {
    _firebaseInstance = FirebaseDatabase.instance;
    _firebaseInstance!.setPersistenceEnabled(true);
    return _firebaseInstance!.ref('/$userUID/').onValue;
  }

  Stream<DatabaseEvent> getGoalDetails(int position) {
    return _firebaseInstance!.ref('/$userUID/goals/$position/').onValue;
  }

  /// Watches the file for changes and sends FileSystemEvents
  /// on changes to file.
  Stream<FileSystemEvent> getModifyEvents() {
    return _file.watch(events: FileSystemEvent.modify);
  }

  /// Reads the file and returns `jsonDecoded` Map
  Future<Map<String, dynamic>> readFile() async {
    String data = await _file.readAsString();
    return jsonDecode(data);
  }

  void writeToFile(String data) {
    _file.writeAsString(data);
  }

  /// Gets the localPath; Used to get the directory
  /// where to read and store the data from
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  /// Takes `position` in the goals list and a `newValue` to update to.
  void updateAchieved(int position, int newValue) async {
    if (usingGoogleSignIn) {
      _firebaseInstance!
          .ref('/$userUID/goals/$position/history/0/achieved/')
          .set(newValue);
    } else {
      Map<String, dynamic> data = await readFile();
      data['goals'].elementAt(position)['history'].elementAt(0)['achieved'] =
          newValue;
      writeToFile(jsonEncode(data));
    }
  }

  /// Takes `position` in the goals list and `history` and completely updates
  /// the entire history of the goal.
  void updateHistory(int position, List<dynamic> history) async {
    if (usingGoogleSignIn) {
      _firebaseInstance!.ref('/$userUID/goals/$position/history/').set(history);
    } else {
      Map<String, dynamic> data = await readFile();
      data['goals'].elementAt(position)['history'] = history;
      writeToFile(jsonEncode(data));
    }
  }

  /// Takes a Map `newGoal` with details of the new goal and inserts it into the
  /// goals list as the end.
  void addNewGoal(Map<dynamic, dynamic> newGoal) async {
    if (usingGoogleSignIn) {
      List<dynamic> goalsList;
      goalsList =
          (((await _firebaseInstance!.ref('/$userUID/goals').get()).value) ??
              []) as List<dynamic>;
      goalsList = goalsList.toList();
      goalsList.add(newGoal);
      _firebaseInstance!.ref('/$userUID/goals/').set(goalsList);
    } else {
      Map<String, dynamic> data = await readFile();
      data['goals'].add(newGoal);
      writeToFile(jsonEncode(data));
    }
  }

  /// Takes an integer `position` and removes the goal at that position
  /// from the goals list.
  void deleteGoal(int position) async {
    int goalId;
    if (usingGoogleSignIn) {
      List<dynamic> goalsList =
          ((await _firebaseInstance!.ref('/$userUID/goals/').get()).value)
              as List<dynamic>;
      goalsList = goalsList.toList();
      goalId = goalsList.elementAt(position)['id'];
      goalsList.removeAt(position);
      _firebaseInstance!.ref('/$userUID/goals/').set(goalsList);
    } else {
      Map<String, dynamic> data = await readFile();
      goalId = data['goals'].elementAt(position)['id'];
      data['goals'].removeAt(position);
      writeToFile(jsonEncode(data));
    }
    cancelNotification(goalId);
  }

  /// Takes `position` and `newValue` and updates the reminder time.
  void updateReminderTime(int position, String? newValue) async {
    if (usingGoogleSignIn) {
      _firebaseInstance!
          .ref('/$userUID/goals/$position/reminderTime/')
          .set(newValue);
    } else {
      Map<String, dynamic> data = await readFile();
      data['goals'].elementAt(position)['reminderTime'] = newValue;
      writeToFile(jsonEncode(data));
    }
  }

  /// Takes a `Map<String,dynamic>` with _key_ being the value to change
  /// and the _value_ to the respective key being the new value
  void updateGoal(int position, Map<String, dynamic> changes) async {
    if (usingGoogleSignIn) {
      for (var change in changes.entries) {
        _firebaseInstance!
            .ref('/$userUID/goals/$position/${change.key}/')
            .set(change.value);
      }
    } else {
      Map<String, dynamic> data = await readFile();
      for (var change in changes.entries) {
        data['goals'].elementAt(position)[change.key] = change.value;
      }
      writeToFile(jsonEncode(data));
    }
  }

  /// Takes `hour` in **24 hours**, `minutes`,`notificationId`,
  /// `notificationTitle`,`notificationBody` and schedules daily repeating
  /// notifications.
  void scheduleNotification(
    int hour,
    int min,
    int notificationId,
    String notificationTitle,
    String notificationBody,
  ) {
    notifications.scheduleNotification(
      hour,
      min,
      notificationId,
      notificationTitle,
      notificationBody,
    );
  }

  /// Cancel notification with the assigned `goalId`
  void cancelNotification(int goalId) {
    notifications.cancelNotifications(goalId);
  }

  /// Get analytics data
  /// avg_completion_rate -> `[int]` Average Goals Completion Rate
  /// weekly_data -> `[List<double>]` Percentage of Goals completely in the last 7 days
  /// trend -> `[int]` Percentage change over last week in goal completion
  Future<Map<String, dynamic>?> getAnalytics() async {
    Map<String, dynamic> returnData = {};
    List<Map<dynamic, dynamic>> data;
    if (usingGoogleSignIn) {
      data = (((await _firebaseInstance!.ref('/$userUID/goals/').get()).value ??
              []) as List<dynamic>)
          .cast<Map<dynamic, dynamic>>();
    } else {
      data = (await readFile())['goals'].cast<Map<dynamic, dynamic>>();
    }
    if (data.isEmpty) {
      return null;
    }
    returnData['avg_completion_rate'] = _calculateAvgCompletionRate(data);
    returnData['weekly_data'] = _getWeeklyData(data);
    returnData['trend'] = _getTrend(data);
    return returnData;
  }

  int _calculateAvgCompletionRate(List<Map<dynamic, dynamic>> data) {
    List<String> dates = _getDates(30);
    double avg = 0.0;
    for (String date in dates) {
      for (Map<dynamic, dynamic> goal in data) {
        if (goal['history'] == null || goal['history'].isEmpty) {
          goal['history'] = [
            {
              'achieved': 0,
              'date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
              'goal': goal['currentGoal'],
            }
          ];
        }
        double avgGoal = 0.0;
        for (int i = 0; i < min(30, goal['history'].length); i++) {
          var history = goal['history'].elementAt(i);
          if (history['date'] == date) {
            avgGoal += history['achieved'] / history['goal'];
          }
        }
        avg += (avgGoal / min(30, goal['history'].length));
      }
    }
    return (avg / data.length * 100).round();
  }

  List<double> _getWeeklyData(List<Map<dynamic, dynamic>> data, {weeks = 1}) {
    List<double> weeklyData = List.generate(weeks * 7, (index) => 0.0);
    List<String> dates = _getDates(weeks * 7);
    for (int j = 0; j < dates.length; j++) {
      String date = dates.elementAt(j);
      for (Map<dynamic, dynamic> goal in data) {
        List<Map<dynamic, dynamic>> history =
            goal['history'].cast<Map<dynamic, dynamic>>();
        for (int i = 0; i < min(history.length, weeks * 7); i++) {
          if (history.elementAt(i)['date'] == date) {
            weeklyData[j] +=
                history.elementAt(i)['achieved'] / history.elementAt(i)['goal'];
          }
        }
      }
      weeklyData[j] /= data.length;
      weeklyData[j] = double.parse(weeklyData[j].toStringAsFixed(2));
    }
    return weeklyData;
  }

  int? _getTrend(List<Map<dynamic, dynamic>> data) {
    List<double> weeklyData = _getWeeklyData(data, weeks: 2);
    List<double> lastWeek = weeklyData.sublist(0, 7);
    List<double> currentWeek = weeklyData.sublist(7, 14);
    double lastWeekAvg = 0.0;
    double currentWeekAvg = 0.0;
    for (double num in lastWeek) {
      lastWeekAvg += num;
    }
    for (double num in currentWeek) {
      currentWeekAvg += num;
    }
    lastWeekAvg /= 7;
    currentWeekAvg /= 7;
    double trend = (currentWeekAvg - lastWeekAvg) * 100;

    return trend.round();
  }

  List<String> _getDates(int n) {
    List<String> dates = [];
    DateTime today = DateTime.now();
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    for (int i = n - 1; i >= 0; i--) {
      DateTime newDate = today.subtract(Duration(days: i));
      dates.add(dateFormat.format(newDate));
    }
    return dates;
  }
}
