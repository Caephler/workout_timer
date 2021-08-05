part of 'exercise_selector_cubit.dart';

@immutable
class ExerciseSelectorState {
  ExerciseSelectorState({
    required this.name,
    required this.categories,
  });

  final String name;
  final Set<ExerciseType> categories;

  ExerciseSelectorState copyWith(
      {String? name, Set<ExerciseType>? categories}) {
    return ExerciseSelectorState(
      name: name ?? this.name,
      categories: categories ?? this.categories,
    );
  }
}
