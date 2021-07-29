part of 'workout_editor_cubit.dart';

@immutable
class WorkoutEditorState {
  WorkoutEditorState({
    required this.workout,
    this.activatedSequenceIndex,
    required this.isDirty,
  });

  final Workout workout;
  final bool isDirty;
  final int? activatedSequenceIndex;
}
