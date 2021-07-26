import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:workout_timer/common/circle_elevated_button.dart';
import 'package:workout_timer/common/dialog/choice_dialog.dart';
import 'package:workout_timer/common/format.dart';
import 'package:workout_timer/common/text.dart';
import 'package:workout_timer/common/workouts.dart';
import 'workout_preview.dart';

class WorkoutCard extends StatelessWidget {
  const WorkoutCard({
    Key? key,
    required this.workout,
    required this.onStartWorkout,
    required this.onEditWorkout,
    required this.onDeleteWorkout,
    required this.index,
  }) : super(key: key);

  final Workout workout;
  final void Function(Workout workout) onStartWorkout;
  final void Function(Workout workout) onEditWorkout;
  final void Function() onDeleteWorkout;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: GestureDetector(
        onLongPress: () {
          showChoiceDialog(
            context,
            actions: [
              ChoiceAction('Edit', () => onEditWorkout(workout)),
              ChoiceAction('Delete', () => onDeleteWorkout()),
            ],
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(16.0),
          ),
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReorderableDragStartListener(
                    child: Icon(LineIcons.gripLines),
                    index: index,
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          workout.name,
                          style: AppTextStyles.display
                              .getStyleFor(4, weight: TextWeight.Bold)
                              .copyWith(
                                color: Colors.blue,
                              ),
                          maxLines: 3,
                        ),
                        Text(
                          formatWorkoutDuration(workout.totalDuration),
                          style: AppTextStyles.body.getStyleFor(5).copyWith(
                                color: Colors.black54,
                              ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 32.0),
                  CircleElevatedButton(
                    onPressed: () {
                      onStartWorkout(workout);
                    },
                    child: Icon(Icons.play_arrow),
                  )
                ],
              ),
              WorkoutPreview(
                workout: workout,
                onEditWorkout: onEditWorkout,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
