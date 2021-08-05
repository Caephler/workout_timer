import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:workout_timer/common/exercises.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_timer/common/text.dart';
import 'package:workout_timer/screens/exercise_selector/cubit/exercise_selector_cubit.dart';

final Map<ExerciseType, String> _typeMap = {
  ExerciseType.Core: 'Core',
  ExerciseType.Arm: 'Arm',
  ExerciseType.Leg: 'Leg',
  ExerciseType.Yoga: 'Yoga',
};

class ExerciseChip extends StatelessWidget {
  const ExerciseChip({Key? key, required this.type}) : super(key: key);

  final ExerciseType type;

  @override
  Widget build(BuildContext context) {
    Set<ExerciseType> categories =
        context.select((ExerciseSelectorCubit cubit) => cubit.state.categories);
    bool isSelected = categories.contains(type);

    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: GestureDetector(
        onTap: () {
          context.read<ExerciseSelectorCubit>().toggleCategory(type);
        },
        child: Chip(
          clipBehavior: Clip.antiAlias,
          backgroundColor: isSelected ? Colors.blue[50] : null,
          label: Text(
            _typeMap[type] ?? 'Unknown',
            style: AppTextStyles.body.getStyleFor(
              6,
              color: isSelected ? Colors.blue : null,
            ),
          ),
          avatar: isSelected
              ? Icon(LineIcons.check, size: 16.0, color: Colors.blue)
              : null,
        ),
      ),
    );
  }
}
