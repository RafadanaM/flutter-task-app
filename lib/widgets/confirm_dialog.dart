import 'package:flutter/material.dart';
import 'package:tasks_app/config/styles.dart';

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
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: backgroundPrimary
        ),
      ),
      content: SingleChildScrollView(
        child: Text(
          content,
          style: TextStyle(color: backgroundPrimary),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      backgroundColor: darkerGreen,
      actions: <Widget>[
        TextButton(
          onPressed: () => onPressedCancel,
          //Navigator.pop(context)
          child: Text(
            cancelText,
            style: TextStyle(color: backgroundPrimary),
          ),
        ),
        TextButton(
          onPressed: onPressedConfirm,
          child: Text(
            confirmText,
            style: TextStyle(color: orange),
          ),
        ),
      ],
      actionsPadding: EdgeInsets.only(right: 8),
    );
  }
}
