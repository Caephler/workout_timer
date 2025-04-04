import 'package:flutter/material.dart';
import 'package:workout_timer/common/format.dart';
import 'package:workout_timer/common/text.dart';
import 'package:workout_timer/common/workouts.dart';

class WorkoutDetailsList extends StatelessWidget {
  const WorkoutDetailsList({required this.workout});

  final Workout workout;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: workout.sequences
          .map(
            (sequence) => WorkoutSequenceSection(workoutSequence: sequence),
          )
          .toList(),
    );
  }
}

class WorkoutSequenceSection extends StatelessWidget {
  const WorkoutSequenceSection({required this.workoutSequence});

  final WorkoutSequence workoutSequence;

  Widget _renderSingleBlock() {
    return WorkoutBlockSection(
      workoutBlock: this.workoutSequence.blocks.first,
      padHorizontal: true,
    );
  }

  Widget _renderSequence() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.blue,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 4.0,
                  horizontal: 8.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)).copyWith(
                    topLeft: Radius.zero,
                    topRight: Radius.zero,
                  ),
                  color: Colors.blue,
                ),
                child: Text(
                  'x${workoutSequence.repeatTimes}',
                  style:
                      AppTextStyles.display.getStyleFor(5, color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Column(
                children: workoutSequence.blocks
                    .map(
                      (block) => WorkoutBlockSection(workoutBlock: block),
                    )
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (workoutSequence.isSingleLoopAndBlock) {
      return _renderSingleBlock();
    } else {
      return _renderSequence();
    }
  }
}

class WorkoutBlockSection extends StatelessWidget {
  const WorkoutBlockSection({
    required this.workoutBlock,
    this.padHorizontal = false,
  });

  final WorkoutBlock workoutBlock;
  final bool padHorizontal;

  @override
  Widget build(BuildContext context) {
    Duration duration = workoutBlock.duration;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: padHorizontal ? 16.0 : 0.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              workoutBlock.name,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.body.getStyleFor(5),
              maxLines: 2,
            ),
          ),
          SizedBox(width: 32.0),
          Text(
            workoutBlock.type == WorkoutType.Time
                ? formatWorkoutDuration(duration)
                : '${workoutBlock.reps} reps',
            style: AppTextStyles.body.getStyleFor(5),
          ),
        ],
      ),
    );
  }
}
