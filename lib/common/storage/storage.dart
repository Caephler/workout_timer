import 'package:localstorage/localstorage.dart';
import 'package:workout_timer/common/storage/workout_data.dart';
import 'package:workout_timer/common/workouts.dart';

class StorageService {
  StorageService._() : _storage = LocalStorage(_workoutsKey);

  static StorageService instance = StorageService._();
  static String _workoutsKey = 'workouts.json';
  static String _workoutDataKey = 'workouts';

  final LocalStorage _storage;

  Future<void> init() async {
    dynamic json = _storage.getItem(_workoutDataKey);
    try {
      WorkoutData.fromJson(json);
    } catch (e) {
      print('Error in init: $e');
      // Error parsing data, create data from scratch
      return _storage.setItem(
        _workoutDataKey,
        WorkoutData(
          version: 1,
          data: WorkoutDataV1(workouts: []).toJson(),
        ).toJson(),
      );
    }
  }

  Future<bool> get ready {
    return _storage.ready;
  }

  List<Workout> getWorkouts() {
    try {
      dynamic json = _storage.getItem(_workoutDataKey);
      WorkoutData data = WorkoutData.fromJson(json);
      if (data.version != 1) {
        throw new Error();
      }
      WorkoutDataV1 v1data = data.getDataV1();
      return v1data.workouts;
    } catch (e) {
      print('Error when getting workouts: $e');
      return [];
    }
  }

  void setWorkouts(List<Workout> workouts) {
    WorkoutDataV1 v1data = WorkoutDataV1(workouts: workouts);
    WorkoutData data = WorkoutData(version: 1, data: v1data.toJson());
    _storage.setItem(
      _workoutDataKey,
      data.toJson(),
    );
  }
}
