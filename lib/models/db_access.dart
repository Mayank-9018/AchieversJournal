import 'dart:convert';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Database {
  late Future<bool> isLoggedIn;
  late dynamic data;

  Database() {
    isLoggedIn = getLoginStatus();
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
    FirebaseDatabase firebaseInstance = FirebaseDatabase.instance;
    return firebaseInstance.ref('/userId').onValue;
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
}
