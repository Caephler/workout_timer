import 'package:flutter/material.dart';
import 'package:workout_timer/common/text.dart';
import 'package:workout_timer/screens/my_workouts/my_workouts_screen.dart';

class WorkoutCompleteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 300,
                child: Image.asset('images/yay.png'),
              ),
              Text(
                'Yay!',
                style: AppTextStyles.display.getStyleFor(1, color: Colors.blue),
              ),
              SizedBox(height: 16.0),
              Text(
                "You've completed your workout! You deserve a pat on the back :)",
                style: AppTextStyles.body.getStyleFor(5, color: Colors.black87),
              ),
              SizedBox(height: 16.0),
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
                child: Text('To My Workouts',
                    style: AppTextStyles.body.getStyleFor(5)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
