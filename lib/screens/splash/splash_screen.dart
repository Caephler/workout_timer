import 'package:flutter/material.dart';
import 'package:workout_timer/common/storage/provider.dart';
import 'package:workout_timer/common/storage/storage.dart';
import 'package:workout_timer/screens/my_workouts/my_workouts_screen.dart';
import 'package:workout_timer/screens/splash/splash_content.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LocalStorageBuilder(
      builder: (isReady) {
        if (isReady) {
          return _SplashScreenContent();
        }
        return _PreSplashScreen();
      },
    );
  }
}

class _PreSplashScreen extends StatelessWidget {
  const _PreSplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashContent();
  }
}

class _SplashScreenContent extends StatefulWidget {
  const _SplashScreenContent({Key? key}) : super(key: key);

  @override
  _SplashScreenContentState createState() => _SplashScreenContentState();
}

class _SplashScreenContentState extends State<_SplashScreenContent> {
  bool shouldProceed = false;

  @override
  void initState() {
    super.initState();

    onStart().then((_) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => MyWorkoutsScreen(),
          ),
          (_) => false);
    });
  }

  Future<void> onStart() async {
    await StorageService.instance.init();
  }

  @override
  Widget build(BuildContext context) {
    return SplashContent();
  }
}
