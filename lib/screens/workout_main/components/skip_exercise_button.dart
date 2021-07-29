import 'package:flutter/material.dart';

class SkipExerciseButton extends StatelessWidget {
  const SkipExerciseButton({Key? key, required this.onSkip}) : super(key: key);

  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onSkip,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
        backgroundColor: Colors.blue[50],
      ),
      child: Icon(Icons.fast_forward, size: 48),
    );
  }
}
