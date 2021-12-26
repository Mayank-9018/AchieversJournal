class Goal {
  final String id;
  String name;
  String? description;
  int? icon;
  List<dynamic>? history;
  int? position;
  String? unit;
  Goal(this.id, this.name, {this.description, this.history});

  Goal.fromMap(Map<dynamic, dynamic> map, this.position)
      : id = map['id'],
        name = map['name'],
        description = map['description'],
        icon = map['icon'],
        history = map['history'],
        unit = map['unit'];
}
