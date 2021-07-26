import 'package:flutter/material.dart';
import 'package:workout_timer/common/optional.dart';
import 'package:workout_timer/common/workouts.dart';
import 'package:workout_timer/screens/edit_workout/components/sequence_exercise_editor.dart';

import 'sequence_action_row.dart';
import 'single_exercise_editor.dart';

class WorkoutSequenceEditor extends StatelessWidget {
  const WorkoutSequenceEditor({
    Key? key,
    required this.sequence,
    required this.onUpdateBlock,
    required this.onUpdateSequence,
    required this.isActivated,
    required this.onActivate,
    required this.insertExerciseAfter,
    required this.insertLoopAfter,
    required this.removeBlockAt,
    required this.removeSelf,
  }) : super(key: key);

  final WorkoutSequence sequence;
  final void Function({
    required int blockIndex,
    required WorkoutBlock block,
  }) onUpdateBlock;
  final void Function({
    required WorkoutSequence sequence,
  }) onUpdateSequence;
  final void Function(int number) removeBlockAt;
  final void Function() removeSelf;

  final bool isActivated;
  final void Function() onActivate;
  final void Function() insertExerciseAfter;
  final void Function() insertLoopAfter;

  Widget _renderSingleBlock(int index) {
    assert(index < sequence.blocks.length);

    WorkoutBlock block = sequence.blocks[index];
    return SingleExerciseEditor(
      isEditing: isActivated,
      block: block,
      removeBlock: () {
        removeBlockAt(index);
      },
      updateBlock: (newBlock) {
        onUpdateBlock(
          blockIndex: index,
          block: newBlock,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onActivate,
          child: sequence.isSingleLoopAndBlock
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: _renderSingleBlock(0),
                )
              : SequenceExerciseEditor(
                  sequence: sequence,
                  removeSelf: removeSelf,
                  isEditing: isActivated,
                  removeBlockAt: removeBlockAt,
                  onUpdateSequence: onUpdateSequence,
                  onUpdateBlock: onUpdateBlock,
                ),
        ),
        ShowIfAnimated(
          shouldShow: isActivated,
          child: SequenceActionRow(
            insertExercise: insertExerciseAfter,
            insertLoop: insertLoopAfter,
          ),
        ),
      ],
    );
  }
}
