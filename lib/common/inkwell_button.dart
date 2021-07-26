import 'package:flutter/material.dart';

class InkwellButton extends StatelessWidget {
  const InkwellButton({
    Key? key,
    this.onTap,
    this.child,
    this.hasBorder = false,
    this.borderRadius,
  }) : super(key: key);

  final void Function()? onTap;
  final Widget? child;
  final bool hasBorder;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      borderRadius: borderRadius,
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      splashColor: Colors.blue[50],
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0).copyWith(bottom: 0.0),
        child: Container(
          padding: const EdgeInsets.only(bottom: 8.0),
          decoration: hasBorder
              ? BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.blue,
                      width: 2,
                      style: BorderStyle.solid,
                    ),
                  ),
                )
              : null,
          child: child,
        ),
      ),
    );
  }
}
