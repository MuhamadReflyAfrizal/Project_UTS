import '../data/activity_data.dart';
import '../models/activity_model.dart';

class ActivityRepository {
  final ActivityData _data = ActivityData();

  List<ActivityModel> getAll() => _data.activities;

  void add(ActivityModel activity) => _data.addActivity(activity);

  void update(ActivityModel activity) => _data.updateActivity(activity);

  void delete(String id) => _data.deleteActivity(id);
}
