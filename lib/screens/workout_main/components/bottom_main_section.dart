import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_timer/common/format.dart';
import 'package:workout_timer/common/text.dart';
import 'package:workout_timer/common/workouts.dart';
import 'package:workout_timer/screens/workout_main/bloc/count_up/count_up.dart';
import 'package:workout_timer/screens/workout_main/bloc/timer/timer.dart';
import 'package:workout_timer/screens/workout_main/components/skip_exercise_button.dart';
import 'package:workout_timer/screens/workout_main/components/start_pause_button.dart';
import 'package:workout_timer/screens/workout_main/cubit/workout_progress_cubit.dart';

class BottomMainSection extends StatelessWidget {
  const BottomMainSection({Key? key, required this.onSkipExercise})
      : super(key: key);

  final VoidCallback onSkipExercise;

  String _formatTimeLeftDuration(Duration timeLeft) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String result = '';
    int minutes = timeLeft.inMinutes;
    result += '${twoDigits(minutes)}:';

    String twoDigitSeconds = twoDigits(timeLeft.inSeconds.remainder(60));

    result += twoDigitSeconds;
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.white,
      child: Column(
        children: [
          BlocBuilder<WorkoutProgressCubit, WorkoutProgressState>(
            builder: (context, state) {
              WorkoutBlock block = state.currentWorkoutBlock;
              return BlocBuilder<TimerBloc, TimerState>(
                builder: (context, state) {
                  return Text(
                    block.type == WorkoutType.Time
                        ? _formatTimeLeftDuration(state.duration)
                        : '${block.reps} reps',
                    style: AppTextStyles.display.getStyleFor(
                      0,
                      color: Colors.blue[900],
                    ),
                  );
                },
              );
            },
          ),
          SizedBox(height: 16.0),
          BlocBuilder<WorkoutProgressCubit, WorkoutProgressState>(
            builder: (context, state) {
              return state.currentWorkoutBlock.type == WorkoutType.Time
                  ? TimerActionSection(onSkipExercise: onSkipExercise)
                  : RepsActionSection(onSkipExercise: onSkipExercise);
            },
          ),
          SizedBox(height: 32.0),
          Text(
            'Time Elapsed',
            style: AppTextStyles.body.getStyleFor(5).copyWith(
                  color: Colors.black54,
                ),
          ),
          BlocBuilder<CountUpBloc, CountUpState>(
            builder: (context, state) {
              return Text(
                formatWorkoutDuration(state.duration),
                style: AppTextStyles.body.getStyleFor(4).copyWith(
                      color: Colors.black87,
                    ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class RepsActionSection extends StatelessWidget {
  const RepsActionSection({Key? key, required this.onSkipExercise})
      : super(key: key);

  final VoidCallback onSkipExercise;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SkipExerciseButton(onSkip: onSkipExercise),
      ],
    );
  }
}

class TimerActionSection extends StatelessWidget {
  const TimerActionSection({Key? key, required this.onSkipExercise})
      : super(key: key);

  final VoidCallback onSkipExercise;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StartPauseTimerButton(),
        SizedBox(width: 32.0),
        SkipExerciseButton(onSkip: onSkipExercise),
      ],
    );
  }
}
