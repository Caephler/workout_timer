import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_timer/common/button.dart';
import 'package:workout_timer/common/colors.dart';
import 'package:workout_timer/common/dialog/confirm_dialog.dart';
import 'package:workout_timer/common/extensions.dart';
import 'package:workout_timer/common/inkwell_button.dart';
import 'package:workout_timer/common/storage/provider.dart';
import 'package:workout_timer/common/storage/shared_prefs.dart';
import 'package:workout_timer/common/storage/storage.dart';
import 'package:workout_timer/common/text.dart';
import 'package:workout_timer/common/workouts.dart';
import 'package:workout_timer/screens/edit_workout/edit_workout_screen.dart';
import 'package:workout_timer/screens/my_workouts/components/iap_status_badge.dart';
import 'package:workout_timer/screens/my_workouts/components/settings_hero.dart';
import 'package:workout_timer/screens/my_workouts/components/workouts_list.dart';
import 'package:workout_timer/screens/my_workouts/cubit/my_workouts_cubit.dart';
import 'package:workout_timer/screens/settings/settings_screen.dart';
import 'package:workout_timer/screens/workout_main/workout_main_screen.dart';

import 'package:wakelock/wakelock.dart';

class MyWorkoutsScreen extends StatelessWidget {
  const MyWorkoutsScreen({Key? key}) : super(key: key);

  Widget _buildView(bool isReady, List<Workout>? workouts) {
    return _MyWorkoutsScreenContent();
  }

  @override
  Widget build(BuildContext context) {
    return LocalStorageProvider(
      getter: (storage) => storage.getWorkouts(),
      builder: (isReady, List<Workout>? workouts) {
        if (!isReady) {
          return Container();
        }
        return BlocProvider(
          create: (_) => MyWorkoutsCubit(workouts!),
          child: _buildView(isReady, workouts),
        );
      },
    );
  }
}

class _MyWorkoutsScreenContent extends StatefulWidget {
  _MyWorkoutsScreenContent({Key? key}) : super(key: key);

  @override
  _MyWorkoutsScreenContentState createState() =>
      _MyWorkoutsScreenContentState();
}

class _MyWorkoutsScreenContentState extends State<_MyWorkoutsScreenContent> {
  @override
  void initState() {
    SharedPreferencesService.instance
        .getWakelockSetting()
        .then((needsWakelock) {
      if (needsWakelock) {
        Wakelock.enable();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    Wakelock.disable();
    super.dispose();
  }

  void _onStartWorkout(BuildContext context, Workout workout) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return WorkoutMainScreen(workout: workout);
    }));
  }

  MyWorkoutsCubit _getCubit() {
    return context.read<MyWorkoutsCubit>();
  }

  Future<void> _onDuplicateWorkout(
      BuildContext context, Workout workout, int index) async {
    MyWorkoutsCubit cubit = _getCubit();
    List<Workout> workouts = cubit.state.workouts;
    List<Workout> updatedWorkouts =
        workouts.copyInsertAt(workouts.length, workouts[index].duplicate());
    StorageService.instance.setWorkouts(updatedWorkouts);
    _getCubit().setWorkouts(updatedWorkouts);
  }

  Future<void> _onEditWorkout(
      BuildContext context, Workout workout, int index) async {
    await Navigator.push<Workout>(
      context,
      MaterialPageRoute(
        builder: (context) {
          return EditWorkoutScreen(
            workout: workout,
            onSave: (workout) {
              MyWorkoutsCubit cubit = _getCubit();
              List<Workout> workouts = cubit.state.workouts;

              List<Workout> updatedWorkouts = index < workouts.length
                  ? workouts.copyUpdateAt(index, (_) => workout)
                  : workouts.copyInsertAt(index, workout);
              StorageService.instance.setWorkouts(updatedWorkouts);
              cubit.setWorkouts(updatedWorkouts);
            },
          );
        },
      ),
    );
  }

  Future<void> _onDeleteWorkout(BuildContext context, int index) async {
    MyWorkoutsCubit cubit = _getCubit();
    List<Workout> workouts = cubit.state.workouts;
    showConfirmDialog(
      context,
      onOk: () {
        List<Workout> updatedWorkouts = workouts.copyRemoveAt(index);
        StorageService.instance.setWorkouts(updatedWorkouts);
        _getCubit().setWorkouts(updatedWorkouts);
      },
      title: 'Confirm Delete',
      description: 'Once deleted, this item will be gone forever. Continue?',
      okType: ButtonType.danger,
    );
  }

  void _onAddWorkout(BuildContext context) {
    MyWorkoutsCubit cubit = context.read<MyWorkoutsCubit>();
    List<Workout> workouts = cubit.state.workouts;
    _onEditWorkout(
      context,
      Workout.empty(),
      workouts.length,
    );
  }

  void _onReorderWorkout(int oldIndex, int newIndex) {
    MyWorkoutsCubit cubit = _getCubit();
    List<Workout> workouts = cubit.state.workouts;
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final Workout workout = workouts[oldIndex];
    List<Workout> newWorkouts =
        workouts.copyRemoveAt(oldIndex).copyInsertAt(newIndex, workout);

    StorageService.instance.setWorkouts(newWorkouts);
    cubit.setWorkouts(newWorkouts);
  }

  String _getGreeting() {
    int hour = DateTime.now().hour;
    if (hour < 3 || hour > 18) {
      return 'Good evening';
    } else if (hour < 12) {
      return 'Good morning';
    } else {
      return 'Good afternoon';
    }
  }

  Widget _buildTopBar() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 48,
              child: Row(
                children: [
                  InkwellButton(
                    child: SettingsHero(
                      isActive: false,
                    ),
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) {
                        return SettingsScreen();
                      }));
                    },
                  ),
                  IAPStatusBadge(),
                ],
              ),
            ),
            SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${_getGreeting()},',
                        style: AppTextStyles.display.getStyleFor(
                          5,
                          color: Colors.black45,
                        ),
                      ),
                      Text("Let's workout!",
                          style: AppTextStyles.display.getStyleFor(
                            3,
                            weight: TextWeight.Medium,
                            color: Colors.blue,
                          )),
                    ],
                  ),
                  TextButton(
                    style: AppButtonThemes.secondary,
                    onPressed: () {
                      _onAddWorkout(context);
                    },
                    child: Icon(Icons.add, color: Colors.blue),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _buildTopBar(),
          Expanded(
            child: Container(
              color: AppColors.background,
              child: WorkoutList(
                  workouts: context
                      .select((MyWorkoutsCubit cubit) => cubit.state.workouts),
                  onStartWorkout: (workout) =>
                      _onStartWorkout(context, workout),
                  onEditWorkout: (workout, index) =>
                      _onEditWorkout(context, workout, index),
                  onDeleteWorkout: (index) => _onDeleteWorkout(context, index),
                  onReorderWorkout: _onReorderWorkout,
                  onAddWorkout: () => _onAddWorkout(context),
                  onDuplicateWorkout: (workout, index) =>
                      _onDuplicateWorkout(context, workout, index)),
            ),
          ),
        ],
      ),
    );
  }
}
