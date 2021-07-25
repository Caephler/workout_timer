import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_timer/common/audio.dart';
import 'package:workout_timer/common/speech.dart';
import 'package:workout_timer/common/text.dart';
import 'package:workout_timer/common/timer/timer.dart';
import 'package:workout_timer/common/workouts.dart';
import 'package:workout_timer/screens/workout_complete/workout_complete_screen.dart';

import 'components/next_exercise_card.dart';
import 'components/start_pause_button.dart';
import 'components/timer.dart';
import 'cubit/workout_progress_cubit.dart';

class WorkoutMainScreen extends StatelessWidget {
  const WorkoutMainScreen({required this.workout});

  final Workout workout;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TimerBloc(duration: Duration())),
        BlocProvider(
            create: (context) => WorkoutProgressCubit(workout: workout)),
      ],
      child: WillPopScope(
        onWillPop: () async {
          return await showDialog(
                context: context,
                builder: (context) => new AlertDialog(
                    title: Text('Are you sure?'),
                    content: Text('To exit the workout'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text('No'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: Text('Yes'),
                      ),
                    ]),
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

    TimerBloc timer = context.read<TimerBloc>();
    WorkoutProgressCubit workoutProgress = context.read<WorkoutProgressCubit>();

    timer.stream.where((state) => state is TimerRunComplete).listen((state) {
      workoutProgress.gotoNextWorkoutBlock();
      initializeTimer();
    });

    timer.stream.where((state) {
      int ms = state.duration.inMilliseconds;
      return state is TimerRunInProgress && ms % 1000 == 0 && ms / 1000 <= 3;
    }).listen((state) {
      AudioService.instance.playBlip();
    });

    timer.stream.where((state) => state is TimerRunComplete).listen((state) {
      AudioService.instance.playFinishBlip();
    });

    workoutProgress.stream.where((state) => state.isFinished).listen((state) {
      // Finish workout
      timer.add(TimerReset());
      AudioService.instance.playFinishBlip();
      transitionToFinishScreen();
    });

    initializeTimer();
  }

  void initializeTimer() {
    TimerBloc timer = context.read<TimerBloc>();
    WorkoutProgressCubit workoutProgress = context.read<WorkoutProgressCubit>();

    if (workoutProgress.state.isFinished) {
      return;
    }

    WorkoutBlock block = workoutProgress.state.currentWorkoutBlock;

    TtsService.instance.speak(block.name);
    timer.add(
      TimerStarted(duration: block.duration),
    );
  }

  void skipCurrentExercise() {
    WorkoutProgressCubit workoutProgress = context.read<WorkoutProgressCubit>();

    workoutProgress.gotoNextWorkoutBlock();
    initializeTimer();
  }

  void transitionToFinishScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => WorkoutCompleteScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SafeArea(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 300,
                    width: 300,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue[100],
                      ),
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            context.select((WorkoutProgressCubit progress) =>
                                progress.state.currentWorkoutBlock.name),
                            style:
                                AppTextStyles.display.getStyleFor(3).copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                            textAlign: TextAlign.center,
                          ),
                          TimerView(),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StartPauseTimerButton(),
                      ElevatedButton(
                        onPressed: () {
                          skipCurrentExercise();
                        },
                        child: Icon(Icons.skip_next),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: NextExerciseCard(
              workoutBlock: context.select((WorkoutProgressCubit progress) =>
                  progress.state.nextWorkoutBlock),
            ),
          )
        ],
      ),
    );
  }
}
