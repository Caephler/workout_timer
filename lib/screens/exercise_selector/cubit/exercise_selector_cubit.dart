import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:workout_timer/common/exercises.dart';
import 'package:workout_timer/common/extensions.dart';

part 'exercise_selector_state.dart';

class ExerciseSelectorCubit extends Cubit<ExerciseSelectorState> {
  ExerciseSelectorCubit(String name)
      : super(
          ExerciseSelectorState(
            name: name,
            categories: Set.from(
              [
                ExerciseType.Core,
                ExerciseType.Arm,
                ExerciseType.Leg,
                ExerciseType.Yoga,
              ],
            ),
          ),
        );

  void updateName(String name) {
    emit(state.copyWith(name: name));
  }

  void selectCategory(ExerciseType category) {
    emit(
      state.copyWith(
        categories: state.categories.copyInsert(category),
      ),
    );
  }

  void unselectCategory(ExerciseType category) {
    emit(
      state.copyWith(
        categories: state.categories.copyRemove(category),
      ),
    );
  }

  void toggleCategory(ExerciseType category) {
    bool shouldRemove = state.categories.contains(category);
    if (shouldRemove) {
      unselectCategory(category);
    } else {
      selectCategory(category);
    }
  }

  void selectCategories(Set<ExerciseType> categories) {
    emit(
      state.copyWith(
        categories: categories,
      ),
    );
  }
}
