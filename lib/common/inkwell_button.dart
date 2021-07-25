import 'package:flutter/material.dart';

class InkwellButton extends StatelessWidget {
  const InkwellButton({Key? key, this.onTap, this.child}) : super(key: key);

  final void Function()? onTap;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      splashColor: Colors.blue[50],
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: child,
      ),
    );
  }
}
