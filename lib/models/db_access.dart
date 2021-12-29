import 'dart:convert';
import 'dart:io';
import 'package:achievers_journal/models/notifications.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Database {
  late Future<bool> isLoggedIn;
  late dynamic data;
  FirebaseDatabase? _firebaseInstance;
  late final Notifications notifications;

  Database() {
    isLoggedIn = getLoginStatus();
    notifications = Notifications();
  }

  /// Reads the `SharedPreferences` to check if the user is logged in/syncing data;
  /// Returns type `bool`
  Future<bool> getLoginStatus() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    bool status = _prefs.getBool('isLoggedIn') ?? false;
    // TODO: Fix this
    if (!status) {
      data = rdbData();
    } else {
      data = localData();
    }
    // TODO: and this
    return !status;
  }

  /// Returns a `Stream` of type `DatabaseEvent` from the firebase
  /// realtime database; Used when user opts in to sync data;
  Stream<DatabaseEvent> rdbData() {
    _firebaseInstance = FirebaseDatabase.instance;
    _firebaseInstance!.setPersistenceEnabled(true);
    return _firebaseInstance!.ref('/userId').onValue;
  }

  Stream<DatabaseEvent> getGoalDetails(int position) {
    return _firebaseInstance!.ref('/userId/goals/$position/').onValue;
  }

  /// Returns a `Future` of Map already jsonDecoded
  /// from the the local data
  Future<Map<String, dynamic>> localData() async {
    final path = await _localPath;
    File _localFile = File('$path/data.json');
    if (await _localFile.exists()) {
      return jsonDecode(_localFile.readAsStringSync());
    } else {
      _localFile.create();
      return {};
    }
  }

  /// Gets the localPath; Used to get the directory
  /// where to read and store the data from
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  /// Takes `position` in the goals list and a `newValue` to update to.
  void updateAchieved(int position, int newValue) {
    _firebaseInstance!
        .ref('/userId/goals/$position/history/0/achieved/')
        .set(newValue);
  }

  /// Takes `position` in the goals list and `history` and competely updates the entire history of the goal.
  void updateHistory(int position, List<dynamic> history) {
    _firebaseInstance!.ref('/userId/goals/$position/history/').set(history);
  }

  /// Takes a Map `newGoal` with details of the new goal and inserts it into the
  /// goals list as the end.
  void addNewGoal(Map<dynamic, dynamic> newGoal) async {
    List<dynamic> goalsList;
    goalsList = ((await _firebaseInstance!.ref('/userId/goals').get()).value)
        as List<dynamic>;
    goalsList = goalsList.toList();
    goalsList.add(newGoal);
    _firebaseInstance!.ref('/userId/goals/').set(goalsList);
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
}
