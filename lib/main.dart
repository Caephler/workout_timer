import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workout_timer/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  runApp(WorkoutTimerApp());
}
