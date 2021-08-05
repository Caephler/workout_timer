import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:workout_timer/common/dialog/number_dialog.dart';
import 'package:workout_timer/common/extensions.dart';
import 'package:workout_timer/common/optional.dart';
import 'package:workout_timer/common/snackbar.dart';
import 'package:workout_timer/common/text.dart';
import 'package:workout_timer/common/workouts.dart';
import 'package:workout_timer/screens/edit_workout/cubit/workout_editor_cubit.dart';

import 'single_exercise_editor.dart';

class SequenceExerciseEditor extends StatelessWidget {
  const SequenceExerciseEditor({
    Key? key,
    required this.sequence,
    required this.index,
  }) : super(key: key);

  final WorkoutSequence sequence;
  final int index;

  Widget _buildRepeatTimesBadge(BuildContext context) {
    return BlocBuilder<WorkoutEditorCubit, WorkoutEditorState>(
      builder: (context, state) {
        bool isEditing = state.activatedSequenceIndex == index;
        return Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: InkWell(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0),
            ),
            onTap: isEditing
                ? () {
                    showNumberDialog(
                      context,
                      title: 'Repeat Times',
                      initialValue: sequence.repeatTimes,
                      min: 1,
                      max: 99,
                      onOk: (value) {
                        context.read<WorkoutEditorCubit>().updateSequenceAt(
                              index,
                              sequence.copyWith(
                                repeatTimes: value,
                              ),
                            );
                      },
                    );
                  }
                : null,
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 4.0,
                horizontal: 8.0,
              ),
              decoration: BoxDecoration(
                color: isEditing ? Colors.blue : Colors.blue.withAlpha(175),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'x${sequence.repeatTimes}',
                    style: AppTextStyles.display.getStyleFor(5).copyWith(
                          color: Colors.white,
                        ),
                  ),
                  ShowIf(
                    shouldShow: isEditing,
                    child: Container(
                      width: 24.0,
                      height: 2.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(
        color: Colors.red,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              LineIcons.alternateTrashAlt,
              color: Colors.white,
            ),
            Icon(
              LineIcons.alternateTrashAlt,
              color: Colors.white,
            ),
          ],
        ),
      ),
      key: ObjectKey(sequence.id),
      onDismissed: (direction) {
        WorkoutEditorCubit cubit = context.read<WorkoutEditorCubit>();
        WorkoutEditorState previousState = cubit.state;
        cubit.removeSequenceAt(index);
        showUndoSnackbar(context, 'Deleted exercise set', () {
          cubit.replaceState(previousState);
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WorkoutEditorCubit, WorkoutEditorState>(
          builder: (context, state) {
            bool isEditing = state.activatedSequenceIndex == index;
            return Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: isEditing ? kElevationToShadow[2] : null,
                border: isEditing
                    ? Border.all(color: Colors.blue, width: 2)
                    : Border.all(
                        width: 2.0,
                        color: Colors.black.withAlpha(20),
                      ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        isEditing
                            ? SizedBox(width: 24)
                            : ReorderableDragStartListener(
                                index: index,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Icon(LineIcons.gripLines,
                                      size: 24, color: Colors.black45),
                                ),
                              ),
                        _buildRepeatTimesBadge(context),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ReorderableListView(
                          shrinkWrap: true,
                          primary: false,
                          children:
                              List.generate(sequence.blocks.length, (i) => i)
                                  .map(
                            (blockIndex) {
                              WorkoutBlock block = sequence.blocks[blockIndex];
                              return Row(
                                key: ObjectKey(block.id),
                                children: [
                                  Expanded(
                                    child: SingleExerciseEditor(
                                      key: ObjectKey(
                                          sequence.blocks[blockIndex].id),
                                      isEditing: isEditing,
                                      block: sequence.blocks[blockIndex],
                                      removeBlock: () {
                                        WorkoutEditorCubit cubit =
                                            context.read<WorkoutEditorCubit>();
                                        WorkoutEditorState previousState =
                                            cubit.state;
                                        cubit.removeBlockAt(
                                            sequenceIndex: index,
                                            blockIndex: blockIndex);

                                        showUndoSnackbar(context,
                                            'Deleted workout: ${block.name}',
                                            () {
                                          cubit.replaceState(previousState);
                                        });
                                      },
                                      updateBlock: (block) {
                                        WorkoutEditorCubit cubit =
                                            context.read<WorkoutEditorCubit>();
                                        cubit.updateBlockAt(
                                            sequenceIndex: index,
                                            blockIndex: blockIndex,
                                            block: block);
                                      },
                                      hasDrag: true,
                                      index: blockIndex,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ).toList(),
                          onReorder: (oldIndex, newIndex) {
                            if (oldIndex < newIndex) {
                              newIndex -= 1;
                            }
                            final WorkoutBlock block =
                                sequence.blocks[oldIndex];
                            List<WorkoutBlock> newBlocks = sequence.blocks
                                .copyRemoveAt(oldIndex)
                                .copyInsertAt(newIndex, block);

                            WorkoutEditorCubit cubit =
                                context.read<WorkoutEditorCubit>();
                            Workout workout = cubit.state.workout;
                            cubit.updateWorkout(
                              workout.copyWith(
                                sequences: workout.sequences.copyUpdateAt(
                                  index,
                                  (element) => sequence.copyWith(
                                    blocks: newBlocks,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        ShowIfAnimated(
                          shouldShow: isEditing,
                          child: TextButton.icon(
                            onPressed: () {
                              WorkoutEditorCubit cubit =
                                  context.read<WorkoutEditorCubit>();
                              cubit.addBlockAt(
                                  sequenceIndex: index,
                                  blockIndex: sequence.blocks.length);
                            },
                            icon: Icon(LineIcons.dumbbell),
                            label: Text('Add Exercise'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
