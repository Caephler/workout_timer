import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:workout_timer/common/text.dart';
import 'package:workout_timer/common/validators.dart';
import 'package:workout_timer/common/workouts.dart';
import 'dialog.dart';

Future<void> showWorkoutCounterDialog(
  BuildContext context, {
  required WorkoutBlock initialValue,
  String title = 'WorkoutBlock Input',
  String? helpText,
  void Function(WorkoutBlock value)? onOk,
  void Function()? onCancel,
  Iterable<Validator<WorkoutBlock>>? validators,
}) {
  return showDialogOf<WorkoutBlock>(
    context,
    title: title,
    defaultValue: initialValue,
    validators: validators,
    onCancel: onCancel,
    onOk: onOk,
    helpText: helpText,
    buildContent: (state, commitChange) {
      WorkoutBlock block = state.value ?? WorkoutBlock.simple();
      WorkoutType type = block.type;
      int reps = block.reps;
      Duration duration = block.duration;
      int mins = duration.inMinutes;
      int seconds = duration.inSeconds.remainder(60);

      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ToggleButtons(
            renderBorder: true,
            borderRadius: BorderRadius.circular(16.0),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Time'),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Reps'),
              ),
            ],
            isSelected: [
              type == WorkoutType.Time,
              type == WorkoutType.Reps,
            ],
            onPressed: (index) {
              if (index == 0) {
                state.didChange(
                  block.copyWith(
                    type: WorkoutType.Time,
                    duration: Duration(seconds: 60),
                  ),
                );
              } else if (index == 1) {
                state.didChange(
                  block.copyWith(
                    type: WorkoutType.Reps,
                    reps: 10,
                  ),
                );
              }
            },
          ),
          type == WorkoutType.Time
              ? (Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    NumberPicker(
                      value: mins,
                      minValue: 0,
                      maxValue: 180,
                      textMapper: (value) => value + ' m',
                      onChanged: (value) => state.didChange(
                        block.copyWith(
                          duration: Duration(
                            minutes: value,
                            seconds: seconds,
                          ),
                        ),
                      ),
                    ),
                    NumberPicker(
                      value: seconds,
                      minValue: 0,
                      maxValue: 59,
                      textMapper: (value) => value + ' s',
                      onChanged: (value) => state.didChange(
                        block.copyWith(
                          duration: Duration(
                            minutes: mins,
                            seconds: value,
                          ),
                        ),
                      ),
                    ),
                  ],
                ))
              : NumberPicker(
                  minValue: 0,
                  maxValue: 100,
                  value: reps,
                  onChanged: (value) => state.didChange(
                        block.copyWith(reps: value),
                      )),
          state.hasError
              ? Text(
                  state.errorText ?? 'Error',
                  style: AppTextStyles.body.getStyleFor(5, color: Colors.red),
                )
              : SizedBox.shrink(),
        ],
      );
    },
  );
}
