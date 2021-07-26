import 'package:flutter/material.dart';
import 'package:tasks_app/config/styles.dart';

SnackBar undoSnackBar(Function onPressed, BuildContext context) {
  return SnackBar(
    content: Container(
      width: MediaQuery.of(context).size.width * 0.85,
      child: Text("Task has been completed"),
    ),
    action: SnackBarAction(
      label: 'Undo',
      textColor: orange,
      onPressed: onPressed,
    ),
    padding: const EdgeInsets.only(
      left: 12,
    ),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5.0),
    ),
    backgroundColor: grey.withOpacity(0.9),
  );
}

SnackBar reminderSnackBar(BuildContext context) {
  return SnackBar(
    content: Container(
      width: MediaQuery.of(context).size.width * 0.85,
      child: Text("Reminder is set before current time. No notification will be shown"),
    ),
    padding: const EdgeInsets.symmetric(
      horizontal: 12,
    ),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5.0),
    ),
    backgroundColor: grey.withOpacity(0.9),
  );
}
