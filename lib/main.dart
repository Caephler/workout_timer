import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workout_timer/app.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  MobileAds.instance.initialize();

  runApp(WorkoutTimerApp());
}
