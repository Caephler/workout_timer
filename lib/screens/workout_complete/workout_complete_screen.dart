import 'package:flutter/material.dart';
import 'package:workout_timer/common/text.dart';
import 'package:workout_timer/screens/my_workouts/my_workouts_screen.dart';

class WorkoutCompleteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Yay!',
                style: AppTextStyles.display.getStyleFor(1).copyWith(
                      fontWeight: FontWeight.w900,
                      color: Colors.blue,
                    ),
              ),
              Text(
                "You've completed your workout! You deserve a pat on the back :)",
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyWorkoutsScreen(),
                    ),
                    (route) => false,
                  );
                },
                child: Text('To My Workouts'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
