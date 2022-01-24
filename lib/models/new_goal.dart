class NewGoal {
  late int id;
  String? title;
  String? description;
  int? iconData;
  bool isTimeBased = false;
  String? unit;
  int currentGoal = 0;

  NewGoal() : id = DateTime.now().hashCode;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': title,
      'description': description,
      'icon': iconData,
      'currentGoal': currentGoal,
      'id': id,
      'isTimeBased': isTimeBased,
      'unit': unit,
    };
  }
}
