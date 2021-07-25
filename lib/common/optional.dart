import 'package:flutter/material.dart';

class ShowIf extends StatelessWidget {
  const ShowIf({required this.child, required this.shouldShow});

  final Widget child;
  final bool shouldShow;

  @override
  Widget build(BuildContext context) {
    return shouldShow ? child : SizedBox.shrink();
  }
}
