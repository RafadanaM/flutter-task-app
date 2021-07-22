import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String errorType;
  final String errorMsg;

  ErrorDialog({@required this.errorType, @required this.errorMsg});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Invalid $errorType"),
      content: SingleChildScrollView(
        child: Text(errorMsg),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
