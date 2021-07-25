import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:workout_timer/common/workouts.dart';

part 'workout_data.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class WorkoutData {
  WorkoutData({required this.version, this.data});

  final int version;
  final dynamic data;

  WorkoutDataV1 getDataV1() {
    assert(version == 1);

    return WorkoutDataV1.fromJson(data);
  }

  factory WorkoutData.fromJson(Map<String, dynamic> json) =>
      _$WorkoutDataFromJson(json);
  Map<String, dynamic> toJson() => _$WorkoutDataToJson(this);
}

@immutable
@JsonSerializable(explicitToJson: true)
class WorkoutDataV1 {
  final List<Workout> workouts;

  WorkoutDataV1({required this.workouts});

  factory WorkoutDataV1.fromJson(Map<String, dynamic> json) =>
      _$WorkoutDataV1FromJson(json);
  Map<String, dynamic> toJson() => _$WorkoutDataV1ToJson(this);
}
