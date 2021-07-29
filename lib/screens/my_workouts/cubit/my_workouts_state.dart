part of 'my_workouts_cubit.dart';

@immutable
class MyWorkoutsState {
  final List<Workout> workouts;
  final int? expandedIndex;

  MyWorkoutsState({required this.workouts, required this.expandedIndex});
}
