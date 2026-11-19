import '../repositories/activity_repository.dart';
import '../models/activity_model.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ActivityViewModel extends ChangeNotifier {
  final ActivityRepository _repo = ActivityRepository();

  List<ActivityModel> get activities => _repo.getAll();

  ActivityModel? getById(String id) {
    try {
      return activities.firstWhere((a) => a.id == id);
    } catch (_) {
      return null;
    }
  }

  void addActivity(String name) {
    final id = const Uuid().v4();
    final activity = ActivityModel(id: id, name: name);
    _repo.add(activity);
    notifyListeners();
  }

  void updateName(String id, String newName) {
    final activity = getById(id);
    if (activity != null) {
      final updated = activity.copyWith(name: newName);
      _repo.update(updated);
      notifyListeners();
    }
  }

  void deleteActivity(String id) {
    _repo.delete(id);
    notifyListeners();
  }

  void incrementCounter(String id) {
    final activity = getById(id);
    if (activity != null) {
      final updated = activity.copyWith(counter: activity.counter + 1);
      _repo.update(updated);
      notifyListeners();
    }
  }

  void decrementCounter(String id) {
    final activity = getById(id);
    if (activity != null && activity.counter > 0) {
      final updated = activity.copyWith(counter: activity.counter - 1);
      _repo.update(updated);
      notifyListeners();
    }
  }

  void resetCounter(String id) {
    final activity = getById(id);
    if (activity != null) {
      final updated = activity.copyWith(counter: 0);
      _repo.update(updated);
      notifyListeners();
    }
  }
}
