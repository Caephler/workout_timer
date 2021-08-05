import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:workout_timer/common/format.dart';
import 'package:workout_timer/common/muted_label.dart';
import 'package:workout_timer/common/text.dart';
import 'package:workout_timer/common/workouts.dart';
import 'package:workout_timer/screens/my_workouts/components/workout_details_list.dart';
import 'package:workout_timer/screens/my_workouts/my_workouts_screen.dart';

class WorkoutCompleteScreen extends StatelessWidget {
  WorkoutCompleteScreen({
    required this.workout,
    required this.timeElapsed,
  });

  final Workout workout;
  final Duration timeElapsed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(LineIcons.dumbbell, color: Colors.black45),
                    SizedBox(width: 8.0),
                    Text(
                      'Workout Summary',
                      style: AppTextStyles.display
                          .getStyleFor(3, color: Colors.black54),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    Text(
                      'Good job on completing your workout!',
                      style: AppTextStyles.body.getStyleFor(
                        5,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Total Workout Duration',
                            style: AppTextStyles.body
                                .getStyleFor(5, color: Colors.teal[50]),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            formatWorkoutDuration(timeElapsed),
                            style: AppTextStyles.display
                                .getStyleFor(1, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyWorkoutsScreen(),
                          ),
                          (route) => false,
                        );
                      },
                      icon: Icon(LineIcons.angleLeft),
                      label: Text('Back to My Workouts',
                          style: AppTextStyles.body.getStyleFor(5)),
                    ),
                    SizedBox(height: 32.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: MutedLabel('Workout Items'),
                    ),
                    WorkoutDetailsList(workout: workout),
                    SizedBox(height: 32.0),
                    TextButton.icon(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyWorkoutsScreen(),
                          ),
                          (route) => false,
                        );
                      },
                      icon: Icon(LineIcons.angleLeft),
                      label: Text('Back to My Workouts',
                          style: AppTextStyles.body.getStyleFor(5)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
