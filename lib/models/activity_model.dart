

class ActivityModel {
  final String id;
  String name;
  int counter;

  ActivityModel({required this.id, required this.name, this.counter = 0});

  ActivityModel copyWith({String? id, String? name, int? counter}) {
    return ActivityModel(
      id: id ?? this.id,
      name: name ?? this.name,
      counter: counter ?? this.counter,
    );
  }
}
