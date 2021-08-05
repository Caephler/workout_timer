import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:workout_timer/common/dialog/input_dialog.dart';
import 'package:workout_timer/common/dialog/workout_counter_dialog.dart';
import 'package:workout_timer/common/format.dart';
import 'package:workout_timer/common/inkwell_button.dart';
import 'package:workout_timer/common/optional.dart';
import 'package:workout_timer/common/text.dart';
import 'package:workout_timer/common/validators.dart';
import 'package:workout_timer/common/workouts.dart';
import 'package:workout_timer/screens/exercise_selector/exercise_selector_screen.dart';

class SingleExerciseEditor extends StatefulWidget {
  const SingleExerciseEditor({
    Key? key,
    required this.block,
    required this.isEditing,
    required this.updateBlock,
    this.removeBlock,
    this.color = Colors.white,
    this.hasDrag = false,
    this.index = 0,
  }) : super(key: key);

  final WorkoutBlock block;
  final bool isEditing;
  final void Function(WorkoutBlock block) updateBlock;
  final VoidCallback? removeBlock;
  final Color color;
  final bool hasDrag;
  final int index;

  @override
  _SingleExerciseEditorState createState() => _SingleExerciseEditorState();
}

class _SingleExerciseEditorState extends State<SingleExerciseEditor>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  String _getCounterText() {
    return widget.block.type == WorkoutType.Time
        ? formatWorkoutDuration(widget.block.duration)
        : '${widget.block.reps} reps';
  }

  Widget _buildViewWidget() {
    return Container(
      padding: widget.hasDrag ? EdgeInsets.symmetric(horizontal: 40.0) : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.block.name,
                style: AppTextStyles.body.getStyleFor(5).copyWith(
                      color: Colors.black54,
                    ),
              ),
            ),
          ),
          SizedBox(width: 32.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(_getCounterText(),
                style:
                    AppTextStyles.body.getStyleFor(5, color: Colors.black54)),
          ),
        ],
      ),
    );
  }

  Widget _buildEditingWidget() {
    return Container(
      padding: widget.hasDrag ? EdgeInsets.symmetric(horizontal: 16.0) : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ShowIfAnimated(
            shouldShow: widget.hasDrag,
            child: ReorderableDragStartListener(
              index: widget.index,
              child: Icon(
                LineIcons.gripLines,
                size: 24,
                color: Colors.black45,
              ),
            ),
          ),
          Expanded(
            child: InkwellButton(
              hasBorder: true,
              onTap: () async {
                String? name = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) {
                      return ExerciseSelectorScreen(block: widget.block);
                    },
                  ),
                );

                if (name == null) {
                  return;
                }

                widget.updateBlock(
                  widget.block.copyWith(name: name),
                );
              },
              child: Text(
                widget.block.name,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.body.getStyleFor(5),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          SizedBox(width: 32.0),
          SizedBox(
            width: 96.0,
            child: InkwellButton(
              hasBorder: true,
              onTap: () {
                showWorkoutCounterDialog(context,
                    title: 'Exercise Details',
                    initialValue: widget.block, onOk: (newValue) {
                  widget.updateBlock(newValue);
                }, validators: [
                  (WorkoutBlock block) {
                    bool isValid = block.type == WorkoutType.Reps ||
                        block.duration > Duration();
                    return ValidatorResult(
                      isValid,
                      isValid ? [] : ['Duration must be at least 1 second.'],
                    );
                  },
                ]);
              },
              child: Text(
                _getCounterText(),
                textAlign: TextAlign.right,
                style: AppTextStyles.body.getStyleFor(5),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.removeBlock != null) {
      return Dismissible(
        key: ObjectKey(widget.block.id),
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
              )
            ],
          ),
        ),
        onDismissed: (direction) {
          widget.removeBlock?.call();
        },
        child: SizedBox(
          height: 48.0,
          child: Container(
            decoration: BoxDecoration(
              color: widget.color,
            ),
            child:
                widget.isEditing ? _buildEditingWidget() : _buildViewWidget(),
          ),
        ),
      );
    }
    return SizedBox(
      height: 48.0,
      child: Container(
        decoration: BoxDecoration(
          color: widget.color,
        ),
        child: widget.isEditing ? _buildEditingWidget() : _buildViewWidget(),
      ),
    );
  }
}
