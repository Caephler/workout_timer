part of 'workout_editor_cubit.dart';

@immutable
class WorkoutEditorState {
  WorkoutEditorState({required this.workout, this.activatedSequenceIndex});

  final Workout workout;
  final int? activatedSequenceIndex;
}
