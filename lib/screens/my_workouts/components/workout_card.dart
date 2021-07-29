import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
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
    required this.isExpanded,
    required this.onExpand,
  }) : super(key: key);

  final Workout workout;
  final void Function(Workout workout) onStartWorkout;
  final void Function(Workout workout) onEditWorkout;
  final void Function() onDeleteWorkout;
  final int index;
  final bool isExpanded;
  final void Function(bool) onExpand;

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
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: Colors.black.withAlpha(20), width: 2.0),
          ),
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTapDown: (_) {
                      onExpand(false);
                    },
                    child: ReorderableDragStartListener(
                      child: Icon(LineIcons.gripLines, color: Colors.black45),
                      index: index,
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Hero(
                          tag: 'workout_${workout.id}',
                          child: Text(
                            workout.name,
                            style:
                                AppTextStyles.display.getStyleFor(4).copyWith(
                                      color: Colors.blue,
                                    ),
                            maxLines: 3,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Row(
                          children: [
                            Icon(LineIcons.hourglassHalf,
                                color: Colors.black45),
                            Text(
                              formatWorkoutDuration(workout.totalDuration),
                              style: AppTextStyles.body.getStyleFor(5).copyWith(
                                    color: Colors.black54,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 36.0),
                  ElevatedButton(
                    onPressed: () {
                      onStartWorkout(workout);
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size(36, 36),
                    ),
                    child: Icon(Icons.play_arrow),
                  )
                ],
              ),
              SizedBox(height: 16.0),
              WorkoutPreview(
                index: index,
                workout: workout,
                onEditWorkout: onEditWorkout,
                isExpanded: isExpanded,
                onExpand: onExpand,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
