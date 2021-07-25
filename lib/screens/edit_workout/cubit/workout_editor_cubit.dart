import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:workout_timer/common/workouts.dart';
import 'package:workout_timer/common/extensions.dart';

part 'workout_editor_state.dart';

class WorkoutEditorCubit extends Cubit<WorkoutEditorState> {
  WorkoutEditorCubit({Workout? workout})
      : super(WorkoutEditorState(workout: workout ?? Workout.empty()));

  void updateWorkout({String? name}) {
    emit(
      state.copyWith(
        workout: state.workout.copyWith(
          name: name,
        ),
      ),
    );
  }

  /// Add a WorkoutSequence at the specified index.
  void addSequenceAt(int index, {int repeatTimes = 1}) {
    emit(
      state.copyWith(
        activatedSequenceIndex: index,
        workout: state.workout.copyWith(
          sequences: state.workout.sequences.copyInsertAt(
            index,
            WorkoutSequence(
              repeatTimes: repeatTimes,
              blocks: [
                WorkoutBlock(
                  name: 'Workout',
                  type: WorkoutType.Workout,
                  duration: Duration(seconds: 30),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Removes a WorkoutSequence at the specified index
  void removeSequenceAt(int index) {
    emit(
      state.copyWith(
        activatedSequenceIndex: null,
        workout: state.workout.copyWith(
          sequences: state.workout.sequences.copyRemoveAt(index),
        ),
      ),
    );
  }

  void updateSequenceAt(
    int index,
    WorkoutSequence sequence,
  ) {
    emit(
      state.copyWith(
        workout: state.workout.copyWith(
          sequences: state.workout.sequences.copyUpdateAt(
            index,
            (element) => sequence,
          ),
        ),
      ),
    );
  }

  void addBlockAt({required int sequenceIndex, required int blockIndex}) {
    WorkoutSequence seq = state.workout.sequences[sequenceIndex];
    emit(
      state.copyWith(
        activatedSequenceIndex: sequenceIndex,
        workout: state.workout.copyWith(
          sequences: state.workout.sequences.copyInsertAt(
            sequenceIndex,
            seq.copyWith(
              blocks: seq.blocks.copyInsertAt(
                blockIndex,
                WorkoutBlock(
                  name: 'Workout',
                  type: WorkoutType.Workout,
                  duration: Duration(seconds: 30),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void removeBlockAt({required int sequenceIndex, required int blockIndex}) {
    WorkoutSequence seq = state.workout.sequences[sequenceIndex];

    // If removing a block would result in an empty sequence, then remove the sequence.
    List<WorkoutBlock> blocks = seq.blocks.copyRemoveAt(blockIndex);

    emit(
      state.copyWith(
        activatedSequenceIndex: null,
        workout: state.workout.copyWith(
          sequences: blocks.isEmpty
              ? state.workout.sequences.copyRemoveAt(sequenceIndex)
              : state.workout.sequences.copyUpdateAt(
                  sequenceIndex,
                  (_) => seq.copyWith(
                    blocks: blocks,
                  ),
                ),
        ),
      ),
    );
  }

  void updateBlockAt({
    required int sequenceIndex,
    required int blockIndex,
    required WorkoutBlock block,
  }) {
    emit(
      state.copyWith(
        activatedSequenceIndex: sequenceIndex,
        workout: state.workout.copyWith(
          sequences: state.workout.sequences.copyUpdateAt(
            sequenceIndex,
            (seq) => seq.copyWith(
              blocks: seq.blocks.copyUpdateAt(
                blockIndex,
                (_) => block,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void activateSequence(int sequenceIndex) {
    emit(
      state.copyWith(activatedSequenceIndex: sequenceIndex),
    );
  }

  void deactivateSequence() {
    emit(
      state.copyWith(activatedSequenceIndex: null),
    );
  }
}
