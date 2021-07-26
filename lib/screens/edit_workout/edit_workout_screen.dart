import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_timer/common/button.dart';
import 'package:workout_timer/common/dialog/confirm_dialog.dart';
import 'package:workout_timer/common/extensions.dart';
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
          return await showConfirmDialog(
                context,
                title: 'Exit',
                description: 'Are you sure you want to discard your changes?',
                okLabel: 'Discard',
                okType: ButtonType.danger,
                cancelLabel: 'No',
                cancelType: ButtonType.text,
              ) ??
              false;
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
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
              ),
              Expanded(
                child: BlocBuilder<WorkoutEditorCubit, WorkoutEditorState>(
                  builder: (context, state) {
                    return Theme(
                      data: ThemeData(
                        canvasColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      child: ReorderableListView.builder(
                        padding: const EdgeInsets.all(16.0),
                        itemCount: workout.sequences.length,
                        onReorder: (oldIndex, newIndex) {
                          if (oldIndex < newIndex) {
                            newIndex -= 1;
                          }
                          List<WorkoutSequence> seqs = workout.sequences;
                          final WorkoutSequence seq = seqs[oldIndex];
                          List<WorkoutSequence> newSeqs = seqs
                              .copyRemoveAt(oldIndex)
                              .copyInsertAt(newIndex, seq);
                          context.read<WorkoutEditorCubit>()
                            ..updateWorkout(
                              workout.copyWith(
                                sequences: newSeqs,
                              ),
                            )
                            ..deactivateSequence();
                        },
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
                            insertExerciseAfter: () {
                              context
                                  .read<WorkoutEditorCubit>()
                                  .addSequenceAt(index + 1);
                            },
                            insertLoopAfter: () {
                              context
                                  .read<WorkoutEditorCubit>()
                                  .addSequenceAt(index + 1, repeatTimes: 2);
                            },
                          );
                        },
                      ),
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
