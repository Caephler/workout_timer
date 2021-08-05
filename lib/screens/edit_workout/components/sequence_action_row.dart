import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class SequenceActionRow extends StatelessWidget {
  const SequenceActionRow({
    required this.insertExercise,
    required this.insertLoop,
  });

  final void Function() insertExercise;
  final void Function() insertLoop;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton.icon(
          onPressed: insertExercise,
          icon: Icon(LineIcons.dumbbell),
          label: Text('Add Exercise'),
        ),
        TextButton.icon(
          onPressed: insertLoop,
          icon: Icon(LineIcons.infinity),
          label: Text('Add Set'),
        ),
      ],
    );
  }
}
