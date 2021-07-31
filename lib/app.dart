import 'package:flutter/material.dart';
import 'package:workout_timer/screens/splash/splash_screen.dart';

class WorkoutTimerApp extends StatelessWidget {
  const WorkoutTimerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      theme: ThemeData(
        fontFamily: 'Inter',
        primaryColor: Colors.blue,
        colorScheme: ColorScheme.light(
          primary: Colors.blue,
          secondary: Colors.lightBlue,
        ),
      ),
    );
  }
}
