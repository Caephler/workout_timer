import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:workout_timer/common/text.dart';
import 'package:workout_timer/common/workouts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_timer/screens/my_workouts/cubit/my_workouts_cubit.dart';

import 'workout_card.dart';

class WorkoutList extends StatelessWidget {
  const WorkoutList({
    required this.workouts,
    required this.onStartWorkout,
    required this.onEditWorkout,
    required this.onDeleteWorkout,
    required this.onReorderWorkout,
    required this.onAddWorkout,
  });
  final List<Workout> workouts;
  final void Function(Workout workout) onStartWorkout;
  final Future<void> Function(Workout workout, int index) onEditWorkout;
  final Future<void> Function(int index) onDeleteWorkout;
  final void Function(int oldIndex, int newIndex) onReorderWorkout;
  final VoidCallback onAddWorkout;

  void _expandIndex(BuildContext context, int? index) {
    context.read<MyWorkoutsCubit>().setExpandedIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    int? selectedIndex =
        context.select((MyWorkoutsCubit cubit) => cubit.state.expandedIndex);
    if (context
        .select((MyWorkoutsCubit cubit) => cubit.state.workouts.isEmpty)) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
        child: Center(
          child: Column(
            children: [
              Icon(
                LineIcons.dumbbell,
                size: 48,
                color: Colors.blue[300],
              ),
              SizedBox(height: 16.0),
              Text(
                'No workouts yet - why not create one now?',
                textAlign: TextAlign.center,
                style: AppTextStyles.body.getStyleFor(5, color: Colors.black45),
              ),
              SizedBox(height: 8.0),
              ElevatedButton.icon(
                  onPressed: onAddWorkout,
                  icon: Icon(LineIcons.plus),
                  label: Text('New Workout'))
            ],
          ),
        ),
      );
    }

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
        shrinkWrap: true,
        primary: false,
        itemBuilder: (context, index) {
          final Workout workout = workouts[index];
          return WorkoutCard(
            key: ObjectKey(workout.id),
            index: index,
            workout: workout,
            isExpanded: selectedIndex == index,
            onStartWorkout: onStartWorkout,
            onEditWorkout: (workout) => onEditWorkout(workout, index),
            onDeleteWorkout: () => onDeleteWorkout(index),
            onExpand: (isExpanded) {
              _expandIndex(context, isExpanded ? index : null);
            },
          );
        },
      ),
    );
  }
}
