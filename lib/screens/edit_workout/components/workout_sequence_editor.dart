import 'package:flutter/material.dart';
import 'package:workout_timer/common/optional.dart';
import 'package:workout_timer/common/workouts.dart';
import 'package:workout_timer/screens/edit_workout/cubit/workout_editor_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'sequence_exercise_editor.dart';
import 'sequence_single_exercise_editor.dart';

import 'sequence_action_row.dart';

class WorkoutSequenceEditor extends StatelessWidget {
  const WorkoutSequenceEditor({
    Key? key,
    required this.sequence,
    required this.index,
  }) : super(key: key);

  final WorkoutSequence sequence;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            context.read<WorkoutEditorCubit>().activateSequence(index);
          },
          child: sequence.isSingleLoopAndBlock
              ? SequenceSingleExerciseEditor(
                  index: index,
                  sequence: sequence,
                )
              : SequenceExerciseEditor(
                  index: index,
                  sequence: sequence,
                ),
        ),
        BlocBuilder<WorkoutEditorCubit, WorkoutEditorState>(
          builder: (context, state) {
            return ShowIfAnimated(
              shouldShow: state.activatedSequenceIndex == index,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SequenceActionRow(
                  insertExercise: () {
                    context.read<WorkoutEditorCubit>().addSequenceAt(
                          index + 1,
                          WorkoutSequence(
                            blocks: [
                              WorkoutBlock.simple(),
                            ],
                          ),
                        );
                  },
                  insertLoop: () {
                    context.read<WorkoutEditorCubit>().addSequenceAt(
                          index + 1,
                          WorkoutSequence(
                            blocks: [
                              WorkoutBlock.simple(),
                            ],
                            repeatTimes: 2,
                          ),
                        );
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
