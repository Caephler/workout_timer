import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wakelock/wakelock.dart';
import 'package:workout_timer/common/ads.dart';
import 'package:workout_timer/common/audio.dart';
import 'package:workout_timer/common/button.dart';
import 'package:workout_timer/common/dialog/confirm_dialog.dart';
import 'package:workout_timer/common/speech.dart';
import 'package:workout_timer/common/storage/shared_prefs.dart';
import 'package:workout_timer/common/workouts.dart';
import 'package:workout_timer/screens/workout_complete/workout_complete_screen.dart';
import 'package:workout_timer/screens/workout_main/bloc/count_up/bloc/count_up_bloc.dart';
import 'package:workout_timer/screens/workout_main/components/bottom_main_section.dart';
import 'package:workout_timer/screens/workout_main/components/top_main_section.dart';

import 'bloc/timer/timer.dart';
import 'cubit/workout_progress_cubit.dart';

class WorkoutMainScreen extends StatelessWidget {
  const WorkoutMainScreen({required this.workout});

  final Workout workout;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TimerBloc(duration: Duration())),
        BlocProvider(create: (context) => CountUpBloc()),
        BlocProvider(
            create: (context) => WorkoutProgressCubit(workout: workout)),
      ],
      child: WillPopScope(
        onWillPop: () async {
          return await showConfirmDialog(
                context,
                title: 'Exit',
                description: 'Are you sure you want to end the workout now?',
                onOk: () => Navigator.of(context).pop(true),
                okLabel: 'Yes',
                okType: ButtonType.danger,
              ) ??
              false;
        },
        child: WorkoutMainScreenContent(workout: workout),
      ),
    );
  }
}

class WorkoutMainScreenContent extends StatefulWidget {
  WorkoutMainScreenContent({required this.workout});

  final Workout workout;

  @override
  _WorkoutMainScreenContentState createState() =>
      _WorkoutMainScreenContentState();
}

class _WorkoutMainScreenContentState extends State<WorkoutMainScreenContent> {
  @override
  void initState() {
    super.initState();

    SharedPreferencesService.instance
        .getWakelockSetting()
        .then((needsWakelock) {
      if (needsWakelock) {
        Wakelock.enable();
      }
    });

    AdService.instance.preloadInterstitialAd();

    TimerBloc timer = context.read<TimerBloc>();
    WorkoutProgressCubit workoutProgress = context.read<WorkoutProgressCubit>();

    timer.stream.where((state) => state is TimerRunComplete).listen((state) {
      workoutProgress.gotoNextWorkoutBlock();
      _initializeTimer();
    });

    timer.stream.where((state) {
      int ms = state.duration.inMilliseconds;
      return state is TimerRunInProgress && ms % 1000 == 0 && ms / 1000 <= 3;
    }).listen((state) {
      AudioService.instance.playBlip();
    });

    workoutProgress.stream.where((state) => state.isFinished).listen((state) {
      // Finish workout
      timer.add(TimerReset());
      AudioService.instance.playFinishBlip();
      transitionToFinishScreen();
    });

    _initializeTimer();
    _initializeGlobalCountUp();
  }

  @override
  void dispose() {
    Wakelock.disable();
    super.dispose();
  }

  void _initializeGlobalCountUp() {
    CountUpBloc countUp = context.read<CountUpBloc>();
    countUp.add(CountUpStarted());
  }

  void _resumeGlobalCountUp() {
    CountUpBloc countUp = context.read<CountUpBloc>();
    countUp.add(CountUpResumed());
  }

  void _initializeTimer() {
    TimerBloc timer = context.read<TimerBloc>();
    WorkoutProgressCubit workoutProgress = context.read<WorkoutProgressCubit>();

    if (workoutProgress.state.isFinished) {
      return;
    }

    WorkoutBlock block = workoutProgress.state.currentWorkoutBlock;

    AudioService.instance.playFinishBlip();
    TtsService.instance.speak(block.name);

    if (block.type == WorkoutType.Time) {
      timer.add(
        TimerStarted(duration: block.duration),
      );
    } else {
      timer.add(TimerReset());
    }
  }

  void _skipCurrentExercise() {
    WorkoutProgressCubit workoutProgress = context.read<WorkoutProgressCubit>();

    workoutProgress.gotoNextWorkoutBlock();
    _initializeTimer();
    _resumeGlobalCountUp();
  }

  Future<void> transitionToFinishScreen() async {
    await AdService.instance.showInterstitialAd();
    WorkoutProgressCubit cubit = context.read<WorkoutProgressCubit>();
    CountUpBloc countUp = context.read<CountUpBloc>();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => WorkoutCompleteScreen(
          workout: cubit.state.workout,
          timeElapsed: countUp.state.duration,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TopMainSection(),
          Container(height: 2, color: Colors.blue.withAlpha(50)),
          Builder(builder: (context) {
            WorkoutBlock block = context.select((WorkoutProgressCubit cubit) =>
                cubit.state.currentWorkoutBlock);
            Duration currentCount =
                context.select((TimerBloc timer) => timer.state.duration);
            double progress = block.type == WorkoutType.Reps
                ? 0
                : 1 -
                    (currentCount.inMilliseconds /
                        block.duration.inMilliseconds);
            return LinearProgressIndicator(
              value: progress,
            );
          }),
          Expanded(
            child: BottomMainSection(
              onSkipExercise: _skipCurrentExercise,
            ),
          ),
        ],
      ),
    );
  }
}
