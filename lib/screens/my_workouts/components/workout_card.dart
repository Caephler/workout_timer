import 'package:flutter/material.dart';
import 'package:workout_timer/common/dialog/choice_dialog.dart';
import 'package:workout_timer/common/format.dart';
import 'package:workout_timer/common/text.dart';
import 'package:workout_timer/common/workouts.dart';
import 'workout_preview.dart';

class WorkoutCard extends StatelessWidget {
  const WorkoutCard({
    required this.workout,
    required this.onStartWorkout,
    required this.onEditWorkout,
    required this.onDeleteWorkout,
  });

  final Workout workout;
  final void Function(Workout workout) onStartWorkout;
  final void Function(Workout workout) onEditWorkout;
  final void Function() onDeleteWorkout;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0),
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          workout.name,
                          style: AppTextStyles.display.getStyleFor(4).copyWith(
                                fontWeight: FontWeight.w600,
                                color: Colors.blue,
                              ),
                          maxLines: 3,
                        ),
                        Text(
                          formatDuration(workout.totalDuration),
                          style: AppTextStyles.body.getStyleFor(5),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 32.0),
                  ElevatedButtonTheme(
                    data: ElevatedButtonThemeData(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size(36, 36),
                      ),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        onStartWorkout(workout);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                      ),
                      child: Icon(Icons.play_arrow),
                    ),
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
