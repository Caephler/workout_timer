import 'package:flutter/material.dart';
import 'package:workout_timer/common/text.dart';
import 'package:workout_timer/common/format.dart';
import 'package:workout_timer/common/workouts.dart';

class NextExerciseCard extends StatelessWidget {
  NextExerciseCard({required this.workoutBlock});

  final WorkoutBlock? workoutBlock;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            )),
        child: Column(
          children: [
            Text(
              'Next Up',
              style: AppTextStyles.display.getStyleFor(4).copyWith(
                    color: Colors.black54,
                  ),
            ),
            Text(
              workoutBlock != null
                  ? '${workoutBlock!.name} (${formatDuration(workoutBlock!.duration)})'
                  : 'No more!',
              style: AppTextStyles.display.getStyleFor(2).copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
