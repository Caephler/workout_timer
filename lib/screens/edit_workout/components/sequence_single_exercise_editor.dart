import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:workout_timer/common/workouts.dart';
import 'package:workout_timer/screens/edit_workout/components/single_exercise_editor.dart';

class SequenceSingleExerciseEditor extends StatelessWidget {
  const SequenceSingleExerciseEditor({
    Key? key,
    required this.sequence,
    required this.removeSelf,
    required this.isEditing,
    required this.onUpdateSequence,
    required this.onUpdateBlock,
    required this.removeBlockAt,
    required this.index,
  }) : super(key: key);

  final WorkoutSequence sequence;
  final VoidCallback removeSelf;
  final bool isEditing;
  final void Function({required WorkoutSequence sequence}) onUpdateSequence;
  final void Function({
    required int blockIndex,
    required WorkoutBlock block,
  }) onUpdateBlock;
  final void Function(int number) removeBlockAt;
  final int index;

  @override
  Widget build(BuildContext context) {
    WorkoutBlock block = sequence.blocks.first;
    return Dismissible(
      key: ObjectKey(sequence.id),
      onDismissed: (_) {
        removeBlockAt(0);
      },
      background: Container(
        color: Colors.red,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(LineIcons.alternateTrashAlt, color: Colors.white),
            Icon(LineIcons.alternateTrashAlt, color: Colors.white),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: isEditing ? kElevationToShadow[2] : null,
            border: isEditing
                ? Border.all(width: 2.0, color: Colors.blue)
                : Border.all(width: 2.0, color: Colors.black.withAlpha(20)),
            color: Colors.white,
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                ReorderableDragStartListener(
                  index: index,
                  child: Icon(
                    LineIcons.gripLines,
                    size: 24,
                    color: Colors.black45,
                  ),
                ),
                Expanded(
                  child: SingleExerciseEditor(
                    block: block,
                    color: Colors.transparent,
                    updateBlock: (newBlock) =>
                        onUpdateBlock(blockIndex: 0, block: newBlock),
                    isEditing: isEditing,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
