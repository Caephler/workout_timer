import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:workout_timer/common/controlled_expansion_tile.dart';
import 'package:workout_timer/common/text.dart';
import 'package:workout_timer/common/workouts.dart';

import 'preset_workout_details_list.dart';

class WorkoutPreview extends StatefulWidget {
  const WorkoutPreview({
    required this.workout,
    required this.isExpanded,
    required this.onExpand,
  });

  final Workout workout;
  final bool isExpanded;
  final void Function(bool isExpanded) onExpand;

  @override
  _WorkoutPreviewState createState() => _WorkoutPreviewState();
}

class _WorkoutPreviewState extends State<WorkoutPreview>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  Set<String> get uniqueWorkouts {
    Set<String> workoutNames = new Set();
    widget.workout.sequences.forEach((workoutSequence) {
      workoutSequence.blocks.forEach((workoutBlock) {
        workoutNames.add(workoutBlock.name);
      });
    });

    return workoutNames;
  }

  String get joinedWorkoutText {
    return uniqueWorkouts.join(', ');
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
      ),
      child: ControlledExpansionTile(
        key: PageStorageKey(widget.workout.id),
        isExpanded: widget.isExpanded,
        onExpand: widget.onExpand,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                widget.isExpanded
                    ? LineIcons.minusCircle
                    : LineIcons.plusCircle,
                color: Colors.black45,
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  joinedWorkoutText,
                  style: AppTextStyles.body.getStyleFor(5).copyWith(
                        color: Colors.black54,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: WorkoutDetailsList(workout: widget.workout),
          ),
        ],
      ),
    );
  }
}
