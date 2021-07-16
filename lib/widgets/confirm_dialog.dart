import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String content;
  final Function onPressedCancel;
  final Function onPressedConfirm;
  final String confirmText;
  final String cancelText;

  ConfirmDialog(
      {@required this.title,
      @required this.content,
      @required this.onPressedCancel,
      @required this.onPressedConfirm,
      @required this.confirmText,
      @required this.cancelText});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: Text(content),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => onPressedCancel,
          //Navigator.pop(context)
          child: Text(cancelText),
        ),
        TextButton(
          onPressed: onPressedConfirm,
          child: Text(confirmText),
        ),
      ],
    );
  }
}
