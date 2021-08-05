import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_timer/common/exercises.dart';
import 'package:workout_timer/common/text.dart';
import 'package:workout_timer/screens/exercise_selector/cubit/exercise_selector_cubit.dart';

class ExerciseListView extends StatelessWidget {
  const ExerciseListView({Key? key, required this.onSave}) : super(key: key);

  final void Function(BuildContext context) onSave;

  @override
  Widget build(BuildContext context) {
    ExerciseSelectorState state =
        context.select((ExerciseSelectorCubit cubit) => cubit.state);
    List<String> exercises = ExerciseMaster.instance.getExercises(
      state.name,
      state.categories,
    );
    exercises.sort();
    return ListView.separated(
      padding: const EdgeInsets.all(0.0),
      separatorBuilder: (context, index) {
        return Divider();
      },
      itemCount: exercises.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            context.read<ExerciseSelectorCubit>().updateName(exercises[index]);
            onSave(context);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Text(
              exercises[index],
              style: AppTextStyles.body.getStyleFor(
                5,
              ),
            ),
          ),
        );
      },
    );
  }
}
