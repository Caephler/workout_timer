import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_timer/common/colors.dart';
import 'package:workout_timer/common/workouts.dart';
import 'package:workout_timer/screens/exercise_selector/components/exercise_list_view.dart';
import 'package:workout_timer/screens/exercise_selector/components/exercise_search_bar.dart';
import 'package:workout_timer/screens/exercise_selector/cubit/exercise_selector_cubit.dart';

class ExerciseSelectorScreen extends StatelessWidget {
  final WorkoutBlock block;
  const ExerciseSelectorScreen({Key? key, required this.block})
      : super(key: key);

  void onSave(BuildContext context) {
    String name = context.read<ExerciseSelectorCubit>().state.name;

    Navigator.pop(context, name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocProvider(
        create: (context) => ExerciseSelectorCubit(block.name),
        child: Column(
          children: [
            ExerciseSearchBar(
              onSave: onSave,
            ),
            Expanded(
              child: ExerciseListView(
                onSave: onSave,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
