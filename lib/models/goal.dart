class Goal {
  final String id;
  String name;
  String? description;
  int? icon;
  List<dynamic>? history;
  Goal(this.id, this.name, {this.description, this.history});

  Goal.fromMap(Map<dynamic, dynamic> map)
      : id = map['id'],
        name = map['name'],
        description = map['description'],
        icon = map['icon'],
        history = map['history'];
}
