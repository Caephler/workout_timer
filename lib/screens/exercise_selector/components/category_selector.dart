import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:workout_timer/common/exercises.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_timer/screens/exercise_selector/components/exercise_chip.dart';
import 'package:workout_timer/screens/exercise_selector/cubit/exercise_selector_cubit.dart';

class CategorySelector extends StatelessWidget {
  const CategorySelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Set<ExerciseType> categories =
        context.select((ExerciseSelectorCubit cubit) => cubit.state.categories);

    return ListView(
      padding: const EdgeInsets.only(top: 16.0),
      scrollDirection: Axis.horizontal,
      children: [
        ExerciseChip(type: ExerciseType.Core),
        ExerciseChip(type: ExerciseType.Leg),
        ExerciseChip(type: ExerciseType.Arm),
        ExerciseChip(type: ExerciseType.Yoga),
      ],
    );
  }
}
