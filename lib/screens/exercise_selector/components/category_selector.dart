import 'package:flutter/material.dart';
import 'package:workout_timer/common/exercises.dart';
import 'package:workout_timer/screens/exercise_selector/components/exercise_chip.dart';

class CategorySelector extends StatelessWidget {
  const CategorySelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 16.0),
      scrollDirection: Axis.horizontal,
      children: [
        ExerciseChip(type: ExerciseType.FullBody),
        ExerciseChip(type: ExerciseType.Core),
        ExerciseChip(type: ExerciseType.Leg),
        ExerciseChip(type: ExerciseType.Arm),
        ExerciseChip(type: ExerciseType.Yoga),
      ],
    );
  }
}
