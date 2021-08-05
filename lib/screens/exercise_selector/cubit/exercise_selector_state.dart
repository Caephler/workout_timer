part of 'exercise_selector_cubit.dart';

@immutable
class ExerciseSelectorState {
  ExerciseSelectorState({
    required this.name,
    required this.categories,
    required this.error,
  });

  final String name;
  final Set<ExerciseType> categories;
  final String error;

  ExerciseSelectorState copyWith({
    String? name,
    Set<ExerciseType>? categories,
    String? error,
  }) {
    return ExerciseSelectorState(
      name: name ?? this.name,
      categories: categories ?? this.categories,
      error: error ?? this.error,
    );
  }
}
