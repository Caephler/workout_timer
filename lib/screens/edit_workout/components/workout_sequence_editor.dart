import 'package:flutter/material.dart';
import 'package:workout_timer/common/dialog/number_dialog.dart';
import 'package:workout_timer/common/optional.dart';
import 'package:workout_timer/common/text.dart';
import 'package:workout_timer/common/workouts.dart';
import 'package:workout_timer/screens/edit_workout/components/single_exercise_editor.dart';

class WorkoutSequenceEditor extends StatelessWidget {
  const WorkoutSequenceEditor({
    Key? key,
    required this.sequence,
    required this.onUpdateBlock,
    required this.onUpdateSequence,
    required this.isActivated,
    required this.onActivate,
    required this.insertExerciseBefore,
    required this.insertExerciseAfter,
    required this.insertLoopBefore,
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
  final void Function() insertExerciseBefore;
  final void Function() insertExerciseAfter;
  final void Function() insertLoopBefore;
  final void Function() insertLoopAfter;

  Widget _renderSingleBlock(int index) {
    assert(index < sequence.blocks.length);

    WorkoutBlock block = sequence.blocks[index];
    return Dismissible(
      key: ObjectKey(block.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        removeBlockAt(index);
      },
      child: SingleExerciseEditor(
        isEditing: isActivated,
        block: block,
        updateBlock: (newBlock) {
          onUpdateBlock(
            blockIndex: index,
            block: newBlock,
          );
        },
      ),
    );
  }

  Widget _renderMultiSequence(BuildContext context) {
    return Dismissible(
      key: ObjectKey(sequence.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        removeSelf();
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: Colors.blue.withAlpha(125),
            width: 2.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: InkWell(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0),
                ),
                onTap: () {
                  showNumberDialog(
                    context,
                    title: 'Repeat Times',
                    initialValue: sequence.repeatTimes,
                    onOk: (value) {
                      onUpdateSequence(
                        sequence: sequence.copyWith(
                          repeatTimes: value,
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 4.0,
                    horizontal: 8.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    'x${sequence.repeatTimes}',
                    style: AppTextStyles.display.getStyleFor(5).copyWith(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(children: [
                ShowIf(
                  shouldShow: isActivated,
                  child: TextButton.icon(
                    onPressed: () {
                      onUpdateSequence(
                        sequence: sequence.copyWith(
                          blocks: [
                            WorkoutBlock(
                              name: 'Workout',
                              type: WorkoutType.Workout,
                              duration: Duration(seconds: 60),
                            ),
                            ...sequence.blocks
                          ],
                        ),
                      );
                    },
                    icon: Icon(Icons.add),
                    label: Text('Add Exercise'),
                  ),
                ),
                ...List.generate(sequence.blocks.length, (i) => i)
                    .map(
                      (index) => _renderSingleBlock(index),
                    )
                    .toList(),
                ShowIf(
                  shouldShow: isActivated,
                  child: TextButton.icon(
                    onPressed: () {
                      onUpdateSequence(
                        sequence: sequence.copyWith(
                          blocks: [
                            ...sequence.blocks,
                            WorkoutBlock(
                              name: 'Workout',
                              type: WorkoutType.Workout,
                              duration: Duration(seconds: 60),
                            ),
                          ],
                        ),
                      );
                    },
                    icon: Icon(Icons.add),
                    label: Text('Add Exercise'),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isActivated
            ? SequenceActionRow(
                insertExercise: insertExerciseBefore,
                insertLoop: insertLoopBefore,
              )
            : SizedBox.shrink(),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onActivate,
          child: sequence.isSingleLoopAndBlock
              ? _renderSingleBlock(0)
              : _renderMultiSequence(context),
        ),
        isActivated
            ? SequenceActionRow(
                insertExercise: insertExerciseAfter,
                insertLoop: insertLoopAfter,
              )
            : SizedBox.shrink(),
      ],
    );
  }
}

class SequenceActionRow extends StatelessWidget {
  const SequenceActionRow(
      {required this.insertExercise, required this.insertLoop});

  final void Function() insertExercise;
  final void Function() insertLoop;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton.icon(
          onPressed: insertExercise,
          icon: Icon(Icons.add),
          label: Text('Add Exercise'),
        ),
        TextButton.icon(
          onPressed: insertLoop,
          icon: Icon(Icons.add),
          label: Text('Add Loop'),
        ),
      ],
    );
  }
}
