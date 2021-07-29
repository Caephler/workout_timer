import 'package:flutter/material.dart';

class ControlledExpansionTile extends StatelessWidget {
  const ControlledExpansionTile({
    Key? key,
    required this.title,
    required this.onExpand,
    required this.isExpanded,
    required this.children,
  }) : super(key: key);

  final Widget title;
  final bool isExpanded;
  final void Function(bool isExpanded) onExpand;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GestureDetector(
          onTap: () {
            onExpand(!isExpanded);
          },
          child: title,
        ),
        AnimatedSize(
          duration: Duration(milliseconds: 250),
          child: Column(
            children: isExpanded ? children : [],
          ),
        ),
      ],
    );
  }
}
