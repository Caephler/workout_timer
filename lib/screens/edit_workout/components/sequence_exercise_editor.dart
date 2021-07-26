import 'package:flutter/material.dart';
import 'package:workout_timer/common/dialog/number_dialog.dart';
import 'package:workout_timer/common/optional.dart';
import 'package:workout_timer/common/text.dart';
import 'package:workout_timer/common/workouts.dart';
import 'package:workout_timer/screens/edit_workout/components/single_exercise_editor.dart';

class SequenceExerciseEditor extends StatelessWidget {
  const SequenceExerciseEditor({
    Key? key,
    required this.sequence,
    required this.removeSelf,
    required this.isEditing,
    required this.onUpdateSequence,
    required this.onUpdateBlock,
    required this.removeBlockAt,
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

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ObjectKey(sequence.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        removeSelf();
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8.0, top: 8.0),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
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
                onTap: isEditing
                    ? () {
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
                      }
                    : null,
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
                  child: Column(
                    children: [
                      Text(
                        'x${sequence.repeatTimes}',
                        style: AppTextStyles.display
                            .getStyleFor(5, weight: TextWeight.Bold)
                            .copyWith(
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
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(children: [
                ...List.generate(sequence.blocks.length, (i) => i)
                    .map(
                      (index) => SingleExerciseEditor(
                        isEditing: isEditing,
                        block: sequence.blocks[index],
                        removeBlock: () {
                          removeBlockAt(index);
                        },
                        updateBlock: (block) {
                          onUpdateBlock(block: block, blockIndex: index);
                        },
                      ),
                    )
                    .toList(),
                ShowIfAnimated(
                  shouldShow: isEditing,
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
}
