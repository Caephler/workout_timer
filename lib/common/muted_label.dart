import 'package:flutter/material.dart';
import 'package:workout_timer/common/text.dart';

class MutedLabel extends StatelessWidget {
  const MutedLabel(this.text, {Key? key}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: AppTextStyles.body.getStyleFor(6, color: Colors.black54).copyWith(
            letterSpacing: 0.8,
            fontWeight: FontWeight.w500,
          ),
    );
  }
}
