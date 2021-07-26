import 'package:flutter/material.dart';

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
          icon: Icon(Icons.add),
          label: Text('Add Exercise'),
        ),
        TextButton.icon(
          onPressed: insertLoop,
          icon: Icon(Icons.add),
          label: Text('Add Loop'),
        ),
      ],
    );
  }
}
