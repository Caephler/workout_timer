import 'package:flutter/material.dart';
import 'package:workout_timer/common/storage/provider.dart';
import 'package:workout_timer/common/storage/storage.dart';
import 'package:workout_timer/common/extensions.dart';
import 'package:workout_timer/common/text.dart';
import 'package:workout_timer/common/workouts.dart';
import 'package:workout_timer/screens/edit_workout/edit_workout_screen.dart';
import 'package:workout_timer/screens/my_workouts/components/workouts_list.dart';
import 'package:workout_timer/screens/workout_main/workout_main_screen.dart';

Workout createWorkout(String name) => Workout(
      name: name,
      sequences: [
        WorkoutSequence(
          blocks: [
            WorkoutBlock(
                name: 'Stretch',
                duration: Duration(seconds: 10),
                type: WorkoutType.Stretch),
          ],
        ),
        WorkoutSequence(
          blocks: [
            WorkoutBlock(
                name: 'Workout',
                type: WorkoutType.Workout,
                duration: Duration(seconds: 45)),
            WorkoutBlock(
                name: 'Rest',
                type: WorkoutType.Rest,
                duration: Duration(seconds: 15)),
          ],
          repeatTimes: 1,
        ),
        WorkoutSequence(
          blocks: [
            WorkoutBlock(
                name: 'Cool Down',
                type: WorkoutType.Stretch,
                duration: Duration(seconds: 60)),
          ],
        ),
      ],
    );

class MyWorkoutsScreen extends StatelessWidget {
  const MyWorkoutsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LocalStorageProvider(
      getter: (storage) => storage.getWorkouts(),
      builder: (isReady, List<Workout>? workouts) {
        if (isReady) {
          assert(workouts != null);
          return _MyWorkoutsScreenContent(workouts: workouts!);
        }
        return _MyWorkoutsScreenContent(workouts: []);
      },
    );
  }
}

class _MyWorkoutsScreenContent extends StatefulWidget {
  _MyWorkoutsScreenContent({Key? key, required this.workouts})
      : super(key: key);

  final List<Workout> workouts;

  @override
  _MyWorkoutsScreenContentState createState() =>
      _MyWorkoutsScreenContentState();
}

class _MyWorkoutsScreenContentState extends State<_MyWorkoutsScreenContent> {
  @override
  void initState() {
    super.initState();
    workouts = widget.workouts;
  }

  List<Workout> workouts = [];

  @override
  void didUpdateWidget(covariant _MyWorkoutsScreenContent oldWidget) {
    super.didUpdateWidget(oldWidget);

    setState(() {
      workouts = widget.workouts;
    });
  }

  void _onStartWorkout(BuildContext context, Workout workout) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return WorkoutMainScreen(workout: workout);
    }));
  }

  Future<void> _onEditWorkout(
      BuildContext context, Workout workout, int index) async {
    Workout? updatedWorkout = await Navigator.push<Workout>(
      context,
      MaterialPageRoute(
        builder: (context) {
          return EditWorkoutScreen(
            workout: workout,
          );
        },
      ),
    );

    if (updatedWorkout == null) {
      return;
    }

    List<Workout> updatedWorkouts = index < workouts.length
        ? workouts.copyUpdateAt(index, (_) => updatedWorkout)
        : workouts.copyInsertAt(index, updatedWorkout);
    StorageService.instance.setWorkouts(updatedWorkouts);
    setState(() {
      workouts = updatedWorkouts;
    });
  }

  Future<void> _onDeleteWorkout(BuildContext context, int index) async {
    List<Workout> updatedWorkouts = workouts.copyRemoveAt(index);
    StorageService.instance.setWorkouts(updatedWorkouts);
    setState(() {
      workouts = updatedWorkouts;
    });
  }

  void _onAddWorkout(BuildContext context) {
    _onEditWorkout(
        context,
        Workout(
          name: 'My Workout',
          sequences: [
            WorkoutSequence(
              repeatTimes: 1,
              blocks: [
                WorkoutBlock(
                    name: 'Workout',
                    type: WorkoutType.Workout,
                    duration: Duration(minutes: 1))
              ],
            ),
          ],
        ),
        workouts.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'My Workouts',
                      style: AppTextStyles.display
                          .getStyleFor(2)
                          .copyWith(fontWeight: FontWeight.w900),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _onAddWorkout(context);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(0),
                      ),
                      child: Icon(Icons.add),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: WorkoutList(
                  workouts: workouts,
                  onStartWorkout: (workout) =>
                      _onStartWorkout(context, workout),
                  onEditWorkout: (workout, index) =>
                      _onEditWorkout(context, workout, index),
                  onDeleteWorkout: (index) => _onDeleteWorkout(context, index),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
