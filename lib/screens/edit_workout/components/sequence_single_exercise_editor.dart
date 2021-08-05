import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:workout_timer/common/snackbar.dart';
import 'package:workout_timer/common/workouts.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_timer/screens/edit_workout/cubit/workout_editor_cubit.dart';
import 'single_exercise_editor.dart';

class SequenceSingleExerciseEditor extends StatelessWidget {
  const SequenceSingleExerciseEditor({
    Key? key,
    required this.sequence,
    required this.index,
  }) : super(key: key);

  final WorkoutSequence sequence;
  final int index;

  @override
  Widget build(BuildContext context) {
    WorkoutBlock block = sequence.blocks.first;
    return Dismissible(
      key: ObjectKey(sequence.id),
      onDismissed: (_) {
        WorkoutEditorCubit cubit = context.read<WorkoutEditorCubit>();
        WorkoutEditorState previousState = cubit.state;
        cubit.removeBlockAt(sequenceIndex: index, blockIndex: 0);
        showUndoSnackbar(context, 'Deleted exercise: ${block.name}', () {
          cubit.replaceState(previousState);
        });
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
        child: BlocBuilder<WorkoutEditorCubit, WorkoutEditorState>(
          builder: (context, state) {
            bool isEditing = state.activatedSequenceIndex == index;
            return Container(
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
                        updateBlock: (newBlock) {
                          context.read<WorkoutEditorCubit>().updateBlockAt(
                              sequenceIndex: index,
                              blockIndex: 0,
                              block: newBlock);
                        },
                        isEditing: isEditing,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
