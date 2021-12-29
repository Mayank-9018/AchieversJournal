import 'package:intl/intl.dart';

class Goal {
  final int id;
  String name;
  String? description;
  int? icon;
  List<dynamic> history;
  int? position;
  String? unit;
  int? currentGoal;
  bool hasToday = true;
  bool isTimeBased = false;
  String? reminderTime;
  Goal(this.id, this.name, {this.description, this.history = const []});

  Goal.fromMap(Map<dynamic, dynamic> map, this.position)
      : id = map['id'],
        name = map['name'],
        description = map['description'],
        icon = map['icon'],
        history = List.from(map['history'] ?? []),
        unit = map['unit'],
        currentGoal = map['currentGoal'],
        isTimeBased = map['isTimeBased'] ?? false,
        reminderTime = map['reminderTime'] {
    if (history.isEmpty ||
        !_isSameDate(DateTime.parse(history.first['date']))) {
      hasToday = false;
      history.insert(
        0,
        {
          "achieved": 0,
          "goal": currentGoal,
          "date": DateFormat('yyyy-MM-dd').format(
            DateTime.now(),
          )
        },
      );
    }
  }

  bool _isSameDate(DateTime date) {
    DateTime todayDate = DateTime.now();
    return (todayDate.day == date.day &&
        todayDate.month == date.month &&
        todayDate.year == date.year);
  }
}
