import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_timer/common/colors.dart';
import 'package:workout_timer/common/text.dart';
import 'package:workout_timer/screens/workout_main/cubit/workout_progress_cubit.dart';

class TopMainSection extends StatelessWidget {
  const TopMainSection({Key? key}) : super(key: key);

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
    return Container(
      height: 300,
      color: AppColors.background,
      padding: const EdgeInsets.all(16.0),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            BlocBuilder<WorkoutProgressCubit, WorkoutProgressState>(
              builder: (context, state) {
                return Hero(
                  tag: 'workout_${state.workout.id}',
                  flightShuttleBuilder: _flightShuttleBuilder,
                  child: Text(
                    state.workout.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.display.getStyleFor(
                      4,
                      color: Colors.black45,
                    ),
                  ),
                );
              },
            ),
            BlocBuilder<WorkoutProgressCubit, WorkoutProgressState>(
              builder: (context, state) {
                return Text(
                  state.currentWorkoutBlock.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.display.getStyleFor(2).copyWith(
                        color: Colors.blue,
                      ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
