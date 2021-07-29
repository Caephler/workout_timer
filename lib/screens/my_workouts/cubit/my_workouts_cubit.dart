import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:workout_timer/common/workouts.dart';

part 'my_workouts_state.dart';

class MyWorkoutsCubit extends Cubit<MyWorkoutsState> {
  MyWorkoutsCubit(List<Workout> workouts)
      : super(MyWorkoutsState(workouts: workouts, expandedIndex: null));

  void setWorkouts(List<Workout> workouts) {
    emit(
      MyWorkoutsState(workouts: workouts, expandedIndex: null),
    );
  }

  void setExpandedIndex(int? expandedIndex) {
    emit(
      MyWorkoutsState(workouts: state.workouts, expandedIndex: expandedIndex),
    );
  }
}
