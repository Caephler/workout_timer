import 'package:flutter/material.dart';
import 'package:workout_timer/common/colors.dart';
import 'package:workout_timer/common/text.dart';
import 'package:workout_timer/screens/my_workouts/components/settings_hero.dart';
import 'package:workout_timer/screens/settings/components/beep_setting.dart';
import 'package:workout_timer/screens/settings/components/tts_setting.dart';
import 'package:workout_timer/screens/settings/components/version_details.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  Widget _buildTopBar() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          height: 48.0,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              SettingsHero(isActive: false),
              SizedBox(width: 8.0),
              Text(
                'Settings',
                style:
                    AppTextStyles.display.getStyleFor(4, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _buildTopBar(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(24.0),
              children: [
                TTSSetting(),
                SizedBox(height: 16.0),
                BeepSetting(),
                SizedBox(height: 48.0),
                VersionDetails(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
