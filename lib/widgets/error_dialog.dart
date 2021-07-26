import 'package:flutter/material.dart';
import 'package:tasks_app/config/styles.dart';

class ErrorDialog extends StatelessWidget {
  final String errorType;
  final String errorMsg;

  ErrorDialog({@required this.errorType, @required this.errorMsg});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Invalid $errorType",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: backgroundPrimary
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      backgroundColor: darkerGreen,
      content: SingleChildScrollView(
        child: Text(
          errorMsg,
          style: TextStyle(color: backgroundPrimary),
          ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'OK',
            style: TextStyle(color: orange),
          ),
        ),
      ],
    );
  }
}
