import 'package:flutter/material.dart';

SnackBar undoSnackBar(Function onPressed) {
  return SnackBar(
    content: Text("Task has been completed"),
    action: SnackBarAction(
      label: 'Undo',
      onPressed: onPressed,
    ),
    width: 280,
    padding: const EdgeInsets.all(8),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5.0),
    ),
  );
}

SnackBar reminderSnackBar() {
  return SnackBar(
    content: Text(
        "Reminder is set before current time. No notification will be shown"),
    width: 280,
    padding: const EdgeInsets.all(8),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5.0),
    ),
  );
}
