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

class ShowIfAnimated extends StatefulWidget {
  const ShowIfAnimated(
      {Key? key, required this.child, required this.shouldShow})
      : super(key: key);

  final Widget child;
  final bool shouldShow;

  @override
  _ShowIfAnimatedState createState() => _ShowIfAnimatedState();
}

class _ShowIfAnimatedState extends State<ShowIfAnimated> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: Duration(milliseconds: 150),
      curve: Curves.easeIn,
      child: widget.shouldShow ? widget.child : SizedBox.shrink(),
    );
  }
}
