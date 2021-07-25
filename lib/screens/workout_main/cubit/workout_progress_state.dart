part of 'workout_progress_cubit.dart';

@immutable
class WorkoutProgressState {
  final Workout workout;

  final int sequenceNumber;
  final int blockNumber;
  final int loopNumber;
  final bool isFinished;

  WorkoutProgressState({
    required this.workout,
    required this.sequenceNumber,
    required this.blockNumber,
    required this.loopNumber,
    required this.isFinished,
  });

  WorkoutProgressState copyWith({
    int? sequenceNumber,
    int? blockNumber,
    int? loopNumber,
    bool? isFinished,
  }) =>
      WorkoutProgressState(
        workout: workout,
        sequenceNumber: sequenceNumber ?? this.sequenceNumber,
        blockNumber: blockNumber ?? this.blockNumber,
        loopNumber: loopNumber ?? this.loopNumber,
        isFinished: isFinished ?? this.isFinished,
      );

  WorkoutBlock get currentWorkoutBlock {
    return workout.sequences[sequenceNumber].blocks[blockNumber];
  }

  WorkoutBlock? get nextWorkoutBlock {
    WorkoutSequence currentSequence = workout.sequences[sequenceNumber];
    if (isFinished) {
      return null;
    }

    if (blockNumber + 1 < currentSequence.blocks.length) {
      return currentSequence.blocks[blockNumber + 1];
    }

    if (loopNumber + 1 < currentSequence.repeatTimes) {
      return currentSequence.blocks.first;
    }

    if (sequenceNumber + 1 < workout.sequences.length) {
      return workout.sequences[sequenceNumber + 1].blocks.first;
    }

    return null;
  }
}
