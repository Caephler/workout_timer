import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_timer/common/dialog/input_dialog.dart';
import 'package:workout_timer/common/inkwell_button.dart';
import 'package:workout_timer/common/text.dart';
import 'package:workout_timer/common/validators.dart';
import 'package:workout_timer/common/workouts.dart';
import 'package:workout_timer/screens/edit_workout/cubit/workout_editor_cubit.dart';

class WorkoutNameEditor extends StatelessWidget {
  Widget _flightShuttleBuilder(
    BuildContext flightContext,
    Animation<double> animation,
    HeroFlightDirection flightDirection,
    BuildContext fromHeroContext,
    BuildContext toHeroContext,
  ) {
    return DefaultTextStyle(
      style: DefaultTextStyle.of(toHeroContext).style,
      child: toHeroContext.widget,
    );
  }

  @override
  Widget build(BuildContext context) {
    Workout workout =
        context.select((WorkoutEditorCubit cubit) => cubit.state.workout);
    return InkwellButton(
      hasBorder: true,
      onTap: () {
        WorkoutEditorCubit cubit = context.read<WorkoutEditorCubit>();
        showInputDialog(
          context,
          title: 'Workout Name',
          defaultValue: cubit.state.workout.name,
          onOk: (newName) {
            cubit.updateWorkout(
              cubit.state.workout.copyWith(name: newName),
            );
          },
          validators: [
            createLengthValidator(
                1, 40, 'Your workout name must have at most 40 characters.'),
          ],
        );
      },
      child: Hero(
        tag: 'workout_${workout.id}',
        flightShuttleBuilder: _flightShuttleBuilder,
        child: Text(
          workout.name,
          style: AppTextStyles.display.getStyleFor(4),
          maxLines: 2,
        ),
      ),
    );
  }
}
