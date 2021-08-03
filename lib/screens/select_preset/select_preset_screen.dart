import 'package:flutter/material.dart';
import 'package:workout_timer/common/colors.dart';
import 'package:workout_timer/common/muted_label.dart';
import 'package:workout_timer/common/preset_workouts.dart';
import 'package:workout_timer/common/text.dart';

import 'components/preset_workout_card.dart';

class SelectPresetScreen extends StatefulWidget {
  const SelectPresetScreen({Key? key}) : super(key: key);

  @override
  State<SelectPresetScreen> createState() => _SelectPresetScreenState();
}

class _SelectPresetScreenState extends State<SelectPresetScreen> {
  String? expandedKey;

  void _expandWorkout(String id, bool isExpanded) {
    setState(() {
      if (isExpanded) {
        expandedKey = id;
      } else {
        expandedKey = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MutedLabel('Select Preset'),
                  SizedBox(height: 8.0),
                  Text(
                    'Select from one of our presets for your base workout.',
                    style: AppTextStyles.body
                        .getStyleFor(5, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              key: PageStorageKey('preset_list'),
              children: presetWorkouts
                  .map(
                    (workout) => PresetWorkoutCard(
                      workout: workout,
                      onSelect: () {
                        Navigator.of(context).pop(workout);
                      },
                      isExpanded: workout.id == expandedKey,
                      onExpand: (isExpanded) {
                        _expandWorkout(workout.id, isExpanded);
                      },
                    ),
                  )
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
