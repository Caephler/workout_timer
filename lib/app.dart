import 'package:flutter/material.dart';
import 'package:workout_timer/screens/splash/splash_screen.dart';

class WorkoutTimerApp extends MaterialApp {
  WorkoutTimerApp({Key? key})
      : super(
          key: key,
          home: SplashScreen(),
          theme: ThemeData(
            applyElevationOverlayColor: false,
            fontFamily: 'Inter',
            primaryColor: Colors.blue,
            colorScheme: ColorScheme.light(
              primary: Colors.blue,
              secondary: Colors.lightBlue,
            ),
          ),
        );
}
