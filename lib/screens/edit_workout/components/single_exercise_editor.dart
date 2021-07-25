import 'package:flutter/material.dart';
import 'package:workout_timer/common/dialog/duration_dialog.dart';
import 'package:workout_timer/common/dialog/input_dialog.dart';
import 'package:workout_timer/common/format.dart';
import 'package:workout_timer/common/inkwell_button.dart';
import 'package:workout_timer/common/text.dart';
import 'package:workout_timer/common/workouts.dart';

class SingleExerciseEditor extends StatefulWidget {
  const SingleExerciseEditor({
    Key? key,
    required this.block,
    required this.isEditing,
    required this.updateBlock,
  }) : super(key: key);

  final WorkoutBlock block;
  final bool isEditing;
  final void Function(WorkoutBlock block) updateBlock;

  @override
  _SingleExerciseEditorState createState() => _SingleExerciseEditorState();
}

class _SingleExerciseEditorState extends State<SingleExerciseEditor> {
  @override
  void initState() {
    super.initState();
  }

  Widget _buildViewWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.block.name,
              style: AppTextStyles.body.getStyleFor(5).copyWith(
                    color: Colors.black87,
                  ),
            ),
          ),
        ),
        SizedBox(width: 32.0),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(formatDuration(widget.block.duration)),
        ),
      ],
    );
  }

  Widget _buildEditingWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: InkwellButton(
            onTap: () {
              showInputDialog(
                context,
                title: 'Exercise Name',
                defaultValue: widget.block.name,
                onOk: (newValue) {
                  widget.updateBlock(
                    widget.block.copyWith(name: newValue),
                  );
                },
              );
            },
            child: Text(
              widget.block.name,
              style: AppTextStyles.body.getStyleFor(5).copyWith(
                    color: Colors.blue,
                  ),
              textAlign: TextAlign.left,
            ),
          ),
        ),
        SizedBox(width: 32.0),
        TextButton(
          onPressed: () {
            showDurationDialog(
              context,
              title: 'Workout Duration',
              initialValue: widget.block.duration,
              onOk: (newValue) {
                widget.updateBlock(
                  widget.block.copyWith(duration: newValue),
                );
              },
            );
          },
          child: Text(
            formatDuration(widget.block.duration),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 48.0,
      ),
      child: widget.isEditing ? _buildEditingWidget() : _buildViewWidget(),
    );
  }
}
