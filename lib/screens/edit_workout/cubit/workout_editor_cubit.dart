import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:workout_timer/common/workouts.dart';
import 'package:workout_timer/common/extensions.dart';

part 'workout_editor_state.dart';

class WorkoutEditorCubit extends Cubit<WorkoutEditorState> {
  WorkoutEditorCubit({Workout? workout})
      : super(WorkoutEditorState(workout: workout ?? Workout.empty()));

  void updateWorkout(Workout workout) {
    emit(
      WorkoutEditorState(
        workout: workout,
        activatedSequenceIndex: state.activatedSequenceIndex,
      ),
    );
  }

  /// Add a WorkoutSequence at the specified index.
  void addSequenceAt(int index, {int repeatTimes = 1}) {
    emit(
      WorkoutEditorState(
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
                  duration: Duration(seconds: 60),
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
      WorkoutEditorState(
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
      WorkoutEditorState(
        activatedSequenceIndex: state.activatedSequenceIndex,
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
      WorkoutEditorState(
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
      WorkoutEditorState(
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
      WorkoutEditorState(
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
      WorkoutEditorState(
        activatedSequenceIndex: sequenceIndex,
        workout: state.workout,
      ),
    );
  }

  void deactivateSequence() {
    emit(
      WorkoutEditorState(
        activatedSequenceIndex: null,
        workout: state.workout,
      ),
    );
  }
}
