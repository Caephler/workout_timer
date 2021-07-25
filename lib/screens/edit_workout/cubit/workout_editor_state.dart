part of 'workout_editor_cubit.dart';

@immutable
class WorkoutEditorState {
  WorkoutEditorState({required this.workout, this.activatedSequenceIndex});

  final Workout workout;
  final int? activatedSequenceIndex;

  WorkoutEditorState copyWith({Workout? workout, int? activatedSequenceIndex}) {
    return WorkoutEditorState(
      workout: workout ?? this.workout,
      activatedSequenceIndex:
          activatedSequenceIndex ?? this.activatedSequenceIndex,
    );
  }
}
