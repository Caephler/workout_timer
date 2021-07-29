import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class SettingsHero extends StatelessWidget {
  const SettingsHero({Key? key, required this.isActive}) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'settings',
      child: Icon(LineIcons.cog,
          color: isActive ? Colors.blue[400] : Colors.black45),
    );
  }
}
