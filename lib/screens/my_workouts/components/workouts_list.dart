import 'package:flutter/material.dart';
import 'package:workout_timer/common/workouts.dart';
import 'workout_card.dart';

class WorkoutList extends StatelessWidget {
  const WorkoutList({
    required this.workouts,
    required this.onStartWorkout,
    required this.onEditWorkout,
    required this.onDeleteWorkout,
  });
  final List<Workout> workouts;
  final void Function(Workout workout) onStartWorkout;
  final Future<void> Function(Workout workout, int index) onEditWorkout;
  final Future<void> Function(int index) onDeleteWorkout;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      key: PageStorageKey('workout_list'),
      itemCount: workouts.length,
      itemBuilder: (context, index) {
        final Workout workout = workouts[index];
        return WorkoutCard(
          workout: workout,
          onStartWorkout: onStartWorkout,
          onEditWorkout: (workout) => onEditWorkout(workout, index),
          onDeleteWorkout: () => onDeleteWorkout(index),
        );
      },
    );
  }
}
