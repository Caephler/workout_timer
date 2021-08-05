import 'package:flutter/material.dart';
import 'package:workout_timer/common/button.dart';
import 'package:workout_timer/common/text.dart';

Widget _getButtonWith({
  required Widget child,
  VoidCallback? onPressed,
  required ButtonType type,
}) {
  if (type != ButtonType.text) {
    return ElevatedButton(
      onPressed: onPressed,
      child: child,
      style: ElevatedButton.styleFrom(
        primary: type == ButtonType.primary
            ? Colors.blue
            : type == ButtonType.warning
                ? Colors.amber
                : type == ButtonType.danger
                    ? Colors.red
                    : Colors.blue,
      ),
    );
  }
  return TextButton(onPressed: onPressed, child: child);
}

Future<bool?> showConfirmDialog(
  BuildContext context, {
  String title = 'Confirm',
  String description = '',
  VoidCallback? onOk,
  VoidCallback? onCancel,
  ButtonType okType = ButtonType.text,
  ButtonType cancelType = ButtonType.text,
  String okLabel = 'OK',
  String cancelLabel = 'Cancel',
}) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (context) => new AlertDialog(
      title: Text(title,
          style:
              AppTextStyles.display.getStyleFor(4, weight: TextWeight.Medium)),
      content: Text(description),
      actionsPadding:
          const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 12.0),
      actions: [
        _getButtonWith(
          onPressed: () {
            Navigator.pop(context, false);
            onCancel?.call();
          },
          child: Text(cancelLabel),
          type: cancelType,
        ),
        _getButtonWith(
          onPressed: () {
            Navigator.pop(context, true);
            onOk?.call();
          },
          child: Text(okLabel),
          type: okType,
        ),
      ],
    ),
  );
}
