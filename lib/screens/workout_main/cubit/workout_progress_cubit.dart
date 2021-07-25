import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:workout_timer/common/workouts.dart';

part 'workout_progress_state.dart';

class WorkoutProgressCubit extends Cubit<WorkoutProgressState> {
  WorkoutProgressCubit({required Workout workout})
      : super(WorkoutProgressState(
          workout: workout,
          sequenceNumber: 0,
          blockNumber: 0,
          loopNumber: 0,
          isFinished: false,
        ));

  void gotoNextWorkoutBlock() {
    if (state.isFinished) {
      return;
    }

    Workout workout = state.workout;
    WorkoutSequence currentSequence = workout.sequences[state.sequenceNumber];

    int numBlocks = currentSequence.blocks.length;

    // Proceed to next block
    if (state.blockNumber + 1 < numBlocks) {
      emit(state.copyWith(blockNumber: state.blockNumber + 1));
      return;
    }

    // Proceed to next loop
    if (state.loopNumber + 1 < currentSequence.repeatTimes) {
      emit(state.copyWith(blockNumber: 0, loopNumber: state.loopNumber + 1));
      return;
    }

    // Proceed to next sequence
    if (state.sequenceNumber + 1 < workout.sequences.length) {
      emit(
        state.copyWith(
            blockNumber: 0,
            loopNumber: 0,
            sequenceNumber: state.sequenceNumber + 1),
      );
      return;
    }

    // Workout is finished
    emit(state.copyWith(
      blockNumber: 0,
      loopNumber: 0,
      sequenceNumber: 0,
      isFinished: true,
    ));
  }
}
