import 'package:flutter/foundation.dart';
import 'package:workout_timer/common/uuid.dart';
import 'package:json_annotation/json_annotation.dart';

import 'extensions.dart';
import 'format.dart';

part 'workouts.g.dart';

@immutable
@JsonSerializable(checked: true, explicitToJson: true)
class Workout {
  final String id;
  final String name;
  final List<WorkoutSequence> sequences;

  Workout({
    String? id,
    required this.name,
    required this.sequences,
  }) : this.id = id ?? UuidService.v4();

  static Workout empty({String name = 'My Workout'}) {
    return Workout(name: name, sequences: []);
  }

  Duration get totalDuration {
    return sequences.foldRight(
        (accumulator, element) => accumulator + element.totalDuration,
        Duration(seconds: 0));
  }

  Workout copyWith({
    String? id,
    String? name,
    List<WorkoutSequence>? sequences,
  }) {
    return Workout(
      name: name ?? this.name,
      sequences: sequences ?? this.sequences,
      id: id,
    );
  }

  factory Workout.fromJson(Map<String, dynamic> json) =>
      _$WorkoutFromJson(json);
  Map<String, dynamic> toJson() => _$WorkoutToJson(this);

  @override
  String toString() {
    return 'Workout { id $id, name $name, sequences [${sequences.map((s) => s.toString()).join(',\n')}] }';
  }
}

@immutable
@JsonSerializable(explicitToJson: true)
class WorkoutSequence {
  final String id;

  /// How many times this sequence should repeat
  final int repeatTimes;

  final List<WorkoutBlock> blocks;

  WorkoutSequence({
    String? id,
    this.repeatTimes = 1,
    required this.blocks,
  }) : this.id = id ?? UuidService.v4();

  Duration get totalDuration {
    return blocks.foldRight<Duration>(
            (accumulator, element) => accumulator + element.duration,
            Duration(seconds: 0)) *
        repeatTimes;
  }

  bool get isEmpty {
    return blocks.length == 0;
  }

  bool get isSingleLoopAndBlock {
    return repeatTimes == 1 && blocks.length == 1;
  }

  factory WorkoutSequence.fromJson(Map<String, dynamic> json) =>
      _$WorkoutSequenceFromJson(json);
  Map<String, dynamic> toJson() => _$WorkoutSequenceToJson(this);

  WorkoutSequence copyWith({
    String? id,
    int? repeatTimes,
    List<WorkoutBlock>? blocks,
  }) {
    return WorkoutSequence(
      id: id,
      repeatTimes: repeatTimes ?? this.repeatTimes,
      blocks: blocks ?? this.blocks,
    );
  }

  @override
  String toString() {
    return 'WorkoutSequence { id $id, repeatTimes $repeatTimes, blocks ${blocks.map((s) => s.toString()).join(',\n')}}';
  }
}

@immutable
@JsonSerializable(explicitToJson: true)
class WorkoutBlock {
  final String id;
  final String name;
  final WorkoutType type;
  final Duration duration;

  WorkoutBlock({
    required this.name,
    required this.type,
    required this.duration,
    String? id,
  }) : this.id = id ?? UuidService.v4();

  WorkoutBlock copyWith({
    String? id,
    String? name,
    WorkoutType? type,
    Duration? duration,
  }) {
    return WorkoutBlock(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      duration: duration ?? this.duration,
    );
  }

  factory WorkoutBlock.fromJson(Map<String, dynamic> json) =>
      _$WorkoutBlockFromJson(json);
  Map<String, dynamic> toJson() => _$WorkoutBlockToJson(this);

  @override
  String toString() {
    return 'Workout { id $id, name $name, duration ${formatDuration(duration)} }';
  }
}

enum WorkoutType {
  Stretch,
  Rest,
  Workout,
}
