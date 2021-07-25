import 'package:flutter/material.dart';
import 'package:workout_timer/common/text.dart';
import 'package:workout_timer/common/workouts.dart';
import 'package:workout_timer/screens/my_workouts/components/workout_details_list.dart';

class WorkoutPreview extends StatefulWidget {
  const WorkoutPreview({
    required this.workout,
    required this.onEditWorkout,
  });

  final Workout workout;
  final void Function(Workout workout) onEditWorkout;

  @override
  _WorkoutPreviewState createState() => _WorkoutPreviewState();
}

class _WorkoutPreviewState extends State<WorkoutPreview>
    with AutomaticKeepAliveClientMixin {
  bool isExpanded = false;

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
      child: ExpansionTile(
        key: PageStorageKey(widget.workout.id),
        initiallyExpanded: isExpanded,
        tilePadding: EdgeInsets.zero,
        childrenPadding: EdgeInsets.zero,
        onExpansionChanged: (value) {
          setState(() {
            isExpanded = value;
          });
        },
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              isExpanded
                  ? Icons.remove_circle_outline
                  : Icons.add_circle_outline,
              color: Colors.black54,
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
        trailing: SizedBox.shrink(),
        children: [
          WorkoutDetailsList(workout: widget.workout),
        ],
      ),
    );
  }
}
