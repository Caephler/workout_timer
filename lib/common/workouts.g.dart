// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workouts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Workout _$WorkoutFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Workout',
      json,
      ($checkedConvert) {
        final val = Workout(
          id: $checkedConvert('id', (v) => v as String?),
          name: $checkedConvert('name', (v) => v as String),
          sequences: $checkedConvert(
              'sequences',
              (v) => (v as List<dynamic>)
                  .map((e) =>
                      WorkoutSequence.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$WorkoutToJson(Workout instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'sequences': instance.sequences.map((e) => e.toJson()).toList(),
    };

WorkoutSequence _$WorkoutSequenceFromJson(Map<String, dynamic> json) =>
    WorkoutSequence(
      id: json['id'] as String?,
      repeatTimes: json['repeatTimes'] as int? ?? 1,
      blocks: (json['blocks'] as List<dynamic>)
          .map((e) => WorkoutBlock.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WorkoutSequenceToJson(WorkoutSequence instance) =>
    <String, dynamic>{
      'id': instance.id,
      'repeatTimes': instance.repeatTimes,
      'blocks': instance.blocks.map((e) => e.toJson()).toList(),
    };

WorkoutBlock _$WorkoutBlockFromJson(Map<String, dynamic> json) => WorkoutBlock(
      name: json['name'] as String,
      type: _$enumDecode(_$WorkoutTypeEnumMap, json['type']),
      duration:
          Duration(microseconds: json['duration'] as int) ?? const Duration(),
      reps: json['reps'] as int? ?? 0,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$WorkoutBlockToJson(WorkoutBlock instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$WorkoutTypeEnumMap[instance.type],
      'duration': instance.duration.inMicroseconds,
      'reps': instance.reps,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$WorkoutTypeEnumMap = {
  WorkoutType.Time: 'Time',
  WorkoutType.Reps: 'Reps',
};
