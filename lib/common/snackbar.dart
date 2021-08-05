import 'package:flutter/material.dart';

void showUndoSnackbar(BuildContext context, String text, VoidCallback onUndo) {
  final snackBar = SnackBar(
    content: Text(text),
    action: SnackBarAction(
      label: 'Undo',
      onPressed: () {
        onUndo();
      },
    ),
  );
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showMessageSnackbar(BuildContext context, String text) {
  final snackBar = SnackBar(
    content: Text(text),
  );

  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
