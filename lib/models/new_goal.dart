class NewGoal {
  String? title;
  String? description;
  int? iconData;
  bool isTimeBased = false;
  String? unit;
  int currentGoal = 0;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "name": title,
      "description": description,
      "icon": iconData,
      "currentGoal": currentGoal,
      "id": 069,
      "isTimeBased": isTimeBased,
      "unit": unit,
    };
  }
}
