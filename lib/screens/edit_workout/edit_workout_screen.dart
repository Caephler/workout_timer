import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:workout_timer/common/button.dart';
import 'package:workout_timer/common/colors.dart';
import 'package:workout_timer/common/dialog/confirm_dialog.dart';
import 'package:workout_timer/common/extensions.dart';
import 'package:workout_timer/common/format.dart';
import 'package:workout_timer/common/muted_label.dart';
import 'package:workout_timer/common/text.dart';
import 'package:workout_timer/common/workouts.dart';
import 'package:workout_timer/screens/edit_workout/components/sequence_action_row.dart';
import 'package:workout_timer/screens/edit_workout/components/workout_name_editor.dart';
import 'package:workout_timer/screens/edit_workout/components/workout_sequence_editor.dart';
import 'package:workout_timer/screens/select_preset/select_preset_screen.dart';

import 'cubit/workout_editor_cubit.dart';

class EditWorkoutScreen extends StatelessWidget {
  EditWorkoutScreen({required this.workout, required this.onSave});

  final Workout workout;
  final void Function(Workout workout) onSave;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WorkoutEditorCubit(workout: workout),
      child: Builder(builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            if (!context.read<WorkoutEditorCubit>().state.isDirty) {
              return true;
            }
            return await showConfirmDialog(
                  context,
                  title: 'Exit',
                  description:
                      'Are you sure you want to exit without saving? Your changes will not be saved.',
                  okLabel: 'Yes',
                  okType: ButtonType.text,
                  cancelLabel: 'No',
                  cancelType: ButtonType.text,
                ) ??
                false;
          },
          child: WorkoutScreenContent(onSave: onSave),
        );
      }),
    );
  }
}

class WorkoutScreenContent extends StatelessWidget {
  const WorkoutScreenContent({Key? key, required this.onSave})
      : super(key: key);
  final void Function(Workout workout) onSave;

  Widget _buildTopBar(BuildContext context, Workout workout) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: MutedLabel(
                'Edit Workout',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: WorkoutNameEditor()),
                SizedBox(width: 16.0),
                ElevatedButton.icon(
                  onPressed: () {
                    onSave(workout);
                    Navigator.pop(context, workout);
                  },
                  icon: Icon(LineIcons.save),
                  label: Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar(Workout workout) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Icon(LineIcons.hourglassHalf, color: Colors.black54),
          SizedBox(width: 4.0),
          Text(
            '${formatWorkoutDuration(workout.totalDuration)}',
            style: AppTextStyles.body.getStyleFor(5, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  Future<void> _selectPreset(BuildContext context) async {
    Workout? selectedWorkout = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SelectPresetScreen(),
      ),
    );

    if (selectedWorkout != null) {
      WorkoutEditorCubit cubit = context.read<WorkoutEditorCubit>();
      cubit.updateWorkout(
        cubit.state.workout.copyFromPreset(selectedWorkout),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Workout workout =
        context.select((WorkoutEditorCubit cubit) => cubit.state.workout);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTopBar(context, workout),
            SizedBox(height: 16.0),
            Expanded(
              child: Container(
                color: AppColors.background,
                child: BlocBuilder<WorkoutEditorCubit, WorkoutEditorState>(
                  builder: (context, state) {
                    if (state.workout.sequences.isEmpty) {
                      return SingleChildScrollView(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24.0,
                            vertical: 16.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                LineIcons.box,
                                size: 100,
                                color: Colors.blue,
                              ),
                              SizedBox(height: 16.0),
                              Text(
                                'No exercises in this workout routine yet. Why not select a preset to work from?',
                                textAlign: TextAlign.center,
                                style: AppTextStyles.body
                                    .getStyleFor(5, color: Colors.black45),
                              ),
                              ElevatedButton(
                                  onPressed: () => _selectPreset(context),
                                  child: Text('Select Preset',
                                      style:
                                          AppTextStyles.body.getStyleFor(5))),
                              SizedBox(height: 16.0),
                              Text(
                                'Or you can create your own from scratch:',
                                textAlign: TextAlign.center,
                                style: AppTextStyles.body
                                    .getStyleFor(5, color: Colors.black45),
                              ),
                              SequenceActionRow(
                                insertExercise: () {
                                  context
                                      .read<WorkoutEditorCubit>()
                                      .addSequenceAt(
                                        0,
                                        WorkoutSequence.only(
                                          WorkoutBlock.simple(),
                                        ),
                                      );
                                },
                                insertLoop: () {
                                  context
                                      .read<WorkoutEditorCubit>()
                                      .addSequenceAt(
                                        0,
                                        WorkoutSequence(
                                          blocks: [
                                            WorkoutBlock.simple(),
                                          ],
                                          repeatTimes: 2,
                                        ),
                                      );
                                },
                              )
                            ],
                          ),
                        ),
                      );
                    }
                    return Theme(
                      data: ThemeData(
                        canvasColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      child: ReorderableListView.builder(
                        itemCount: workout.sequences.length,
                        physics: BouncingScrollPhysics(),
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
                            index: index,
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
            _buildBottomBar(workout),
          ],
        ),
      ),
    );
  }
}
