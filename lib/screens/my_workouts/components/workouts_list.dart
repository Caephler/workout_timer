import 'package:flutter/material.dart';
import 'package:workout_timer/common/workouts.dart';
import 'workout_card.dart';

class WorkoutList extends StatelessWidget {
  const WorkoutList({
    required this.workouts,
    required this.onStartWorkout,
    required this.onEditWorkout,
    required this.onDeleteWorkout,
    required this.onReorderWorkout,
  });
  final List<Workout> workouts;
  final void Function(Workout workout) onStartWorkout;
  final Future<void> Function(Workout workout, int index) onEditWorkout;
  final Future<void> Function(int index) onDeleteWorkout;
  final void Function(int oldIndex, int newIndex) onReorderWorkout;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        canvasColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      child: ReorderableListView.builder(
        padding: const EdgeInsets.all(16.0),
        key: PageStorageKey('workout_list'),
        onReorder: onReorderWorkout,
        itemCount: workouts.length,
        itemBuilder: (context, index) {
          final Workout workout = workouts[index];
          return WorkoutCard(
            key: ObjectKey(workout.id),
            index: index,
            workout: workout,
            onStartWorkout: onStartWorkout,
            onEditWorkout: (workout) => onEditWorkout(workout, index),
            onDeleteWorkout: () => onDeleteWorkout(index),
          );
        },
      ),
    );
  }
}
