import 'package:uuid/uuid.dart';
import '../models/activity_model.dart';




class ActivityData {
  // Initial in-memory list of activities
  final List<ActivityModel> _activities = [
    ActivityModel(id: const Uuid().v4(), name: 'Membaca Buku (Halaman)', counter: 15),
    ActivityModel(id: const Uuid().v4(), name: 'Olahraga Push Up', counter: 30),
    ActivityModel(id: const Uuid().v4(), name: 'Latihan Coding Flutter', counter: 4),
  ];

  List<ActivityModel> get activities => List.unmodifiable(_activities);

  void addActivity(ActivityModel activity) {
    _activities.add(activity);
  }

  void updateActivity(ActivityModel updated) {
    final index = _activities.indexWhere((a) => a.id == updated.id);
    if (index != -1) {
      _activities[index] = updated;
    }
  }

  void deleteActivity(String id) {
    _activities.removeWhere((a) => a.id == id);
  }
}
