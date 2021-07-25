// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkoutData _$WorkoutDataFromJson(Map<String, dynamic> json) => WorkoutData(
      version: json['version'] as int,
      data: json['data'],
    );

Map<String, dynamic> _$WorkoutDataToJson(WorkoutData instance) =>
    <String, dynamic>{
      'version': instance.version,
      'data': instance.data,
    };

WorkoutDataV1 _$WorkoutDataV1FromJson(Map<String, dynamic> json) =>
    WorkoutDataV1(
      workouts: (json['workouts'] as List<dynamic>)
          .map((e) => Workout.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WorkoutDataV1ToJson(WorkoutDataV1 instance) =>
    <String, dynamic>{
      'workouts': instance.workouts.map((e) => e.toJson()).toList(),
    };
