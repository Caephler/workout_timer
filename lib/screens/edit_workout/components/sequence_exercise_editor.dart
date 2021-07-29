import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:workout_timer/common/dialog/number_dialog.dart';
import 'package:workout_timer/common/optional.dart';
import 'package:workout_timer/common/extensions.dart';
import 'package:workout_timer/common/text.dart';
import 'package:workout_timer/common/workouts.dart';
import 'single_exercise_editor.dart';

class SequenceExerciseEditor extends StatelessWidget {
  const SequenceExerciseEditor({
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

  Widget _buildRepeatTimesBadge(BuildContext context) {
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
        removeSelf();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
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
                      children: List.generate(sequence.blocks.length, (i) => i)
                          .map(
                            (index) => Row(
                              key: ObjectKey(sequence.blocks[index].id),
                              children: [
                                Expanded(
                                  child: SingleExerciseEditor(
                                    key: ObjectKey(sequence.blocks[index].id),
                                    isEditing: isEditing,
                                    block: sequence.blocks[index],
                                    removeBlock: () {
                                      removeBlockAt(index);
                                    },
                                    updateBlock: (block) {
                                      onUpdateBlock(
                                          block: block, blockIndex: index);
                                    },
                                    hasDrag: true,
                                    index: index,
                                  ),
                                ),
                              ],
                            ),
                          )
                          .toList(),
                      onReorder: (oldIndex, newIndex) {
                        if (oldIndex < newIndex) {
                          newIndex -= 1;
                        }
                        final WorkoutBlock block = sequence.blocks[oldIndex];
                        List<WorkoutBlock> newBlocks = sequence.blocks
                            .copyRemoveAt(oldIndex)
                            .copyInsertAt(newIndex, block);

                        onUpdateSequence(
                            sequence: sequence.copyWith(blocks: newBlocks));
                      },
                    ),
                    ShowIfAnimated(
                      shouldShow: isEditing,
                      child: TextButton.icon(
                        onPressed: () {
                          onUpdateSequence(
                            sequence: sequence.copyWith(
                              blocks: [
                                ...sequence.blocks,
                                WorkoutBlock.simple(),
                              ],
                            ),
                          );
                        },
                        icon: Icon(Icons.add),
                        label: Text('Add Exercise'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
