import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:workout_timer/common/format.dart';
import 'package:workout_timer/common/preset_workouts.dart';
import 'package:workout_timer/common/text.dart';
import 'package:workout_timer/common/workouts.dart';

import 'preset_workout_preview.dart';

class PresetWorkoutCard extends StatelessWidget {
  const PresetWorkoutCard({
    Key? key,
    required this.presetWorkout,
    required this.onSelect,
    required this.isExpanded,
    required this.onExpand,
  }) : super(key: key);

  final PresetWorkout presetWorkout;
  final VoidCallback onSelect;
  final bool isExpanded;
  final void Function(bool) onExpand;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        presetWorkout.workout.name,
                        style: AppTextStyles.display.getStyleFor(4).copyWith(
                              color: Colors.blue,
                            ),
                        maxLines: 3,
                      ),
                      SizedBox(height: 4.0),
                      Row(
                        children: [
                          Icon(LineIcons.hourglassHalf, color: Colors.black45),
                          Text(
                            formatWorkoutDuration(
                                presetWorkout.workout.totalDuration),
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
                    onSelect();
                  },
                  child:
                      Text('Select', style: AppTextStyles.body.getStyleFor(5)),
                )
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              presetWorkout.description,
              style: AppTextStyles.body.getStyleFor(
                5,
                color: Colors.black54,
              ),
            ),
            WorkoutPreview(
              workout: presetWorkout.workout,
              isExpanded: isExpanded,
              onExpand: onExpand,
            ),
          ],
        ),
      ),
    );
  }
}
