import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_timer/common/text.dart';
import 'package:workout_timer/common/workouts.dart';
import 'package:workout_timer/screens/edit_workout/components/workout_name_editor.dart';
import 'package:workout_timer/screens/edit_workout/components/workout_sequence_editor.dart';
import 'cubit/workout_editor_cubit.dart';

class EditWorkoutScreen extends StatelessWidget {
  EditWorkoutScreen({required this.workout});

  final Workout workout;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WorkoutEditorCubit(workout: workout),
      child: WillPopScope(
        onWillPop: () async {
          // TODO: Change this to ask user if they want to save or discard
          return true;
        },
        child: WorkoutScreenContent(),
      ),
    );
  }
}

class WorkoutScreenContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Workout workout =
        context.select((WorkoutEditorCubit cubit) => cubit.state.workout);

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: WorkoutNameEditor()),
                  SizedBox(width: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, workout);
                    },
                    child: Text('Save'),
                  ),
                ],
              ),
              Expanded(
                child: BlocBuilder<WorkoutEditorCubit, WorkoutEditorState>(
                  builder: (context, state) {
                    return ListView.builder(
                      itemCount: workout.sequences.length,
                      itemBuilder: (_, index) {
                        WorkoutSequence sequence = workout.sequences[index];
                        return WorkoutSequenceEditor(
                          key: ObjectKey(sequence.id),
                          sequence: sequence,
                          isActivated: state.activatedSequenceIndex == index,
                          onUpdateSequence: ({required sequence}) {
                            context
                                .read<WorkoutEditorCubit>()
                                .updateSequenceAt(index, sequence);
                          },
                          onUpdateBlock: ({
                            required WorkoutBlock block,
                            required int blockIndex,
                          }) {
                            context.read<WorkoutEditorCubit>().updateBlockAt(
                                  sequenceIndex: index,
                                  blockIndex: blockIndex,
                                  block: block,
                                );
                          },
                          removeBlockAt: (blockIndex) {
                            context.read<WorkoutEditorCubit>().removeBlockAt(
                                  sequenceIndex: index,
                                  blockIndex: blockIndex,
                                );
                          },
                          removeSelf: () {
                            context
                                .read<WorkoutEditorCubit>()
                                .removeSequenceAt(index);
                          },
                          onActivate: () {
                            context
                                .read<WorkoutEditorCubit>()
                                .activateSequence(index);
                          },
                          insertExerciseBefore: () {
                            context
                                .read<WorkoutEditorCubit>()
                                .addSequenceAt(index);
                          },
                          insertExerciseAfter: () {
                            context
                                .read<WorkoutEditorCubit>()
                                .addSequenceAt(index + 1);
                          },
                          insertLoopBefore: () {
                            context
                                .read<WorkoutEditorCubit>()
                                .addSequenceAt(index, repeatTimes: 2);
                          },
                          insertLoopAfter: () {
                            context
                                .read<WorkoutEditorCubit>()
                                .addSequenceAt(index + 1, repeatTimes: 2);
                          },
                        );
                      },
                    );
                  },
                ),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     ElevatedButton.icon(
              //       icon: Icon(Icons.add),
              //       label: Text('New Exercise'),
              //       onPressed: () {
              //         print('Create new Exercise');
              //       },
              //     ),
              //     ElevatedButton.icon(
              //       icon: Icon(Icons.add),
              //       label: Text('New Loop'),
              //       onPressed: () {
              //         print('Create new Exercise');
              //       },
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
