import 'dart:convert';
import 'dart:io';
import 'package:achievers_journal/models/notifications.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Database {
  late bool usingGoogleSignIn;
  FirebaseDatabase? _firebaseInstance;
  late final Notifications notifications;
  late final Future<File> loadFile;
  late final File _file;
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
    if (!status) {
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
    final path = await _localPath;
    _file = File('$path/data.json');
    if (!await _file.exists()) {
      await _file.create();
      _file.writeAsString(
        jsonEncode(
          <String, dynamic>{
            "goals": [],
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
    if (usingGoogleSignIn) {
      List<dynamic> goalsList =
          ((await _firebaseInstance!.ref('/$userUID/goals/').get()).value)
              as List<dynamic>;
      goalsList = goalsList.toList();
      goalsList.removeAt(position);
      _firebaseInstance!.ref('/$userUID/goals/').set(goalsList);
    } else {
      Map<String, dynamic> data = await readFile();
      data['goals'].removeAt(position);
      writeToFile(jsonEncode(data));
    }
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

  void cancelNotification(int goalId) {
    notifications.cancelNotifications(goalId);
  }
}
