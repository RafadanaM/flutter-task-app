import 'package:flutter/material.dart';

class CustomSnackBar extends SnackBar {
  final String text;
  CustomSnackBar({@required this.text});

  Widget build(BuildContext context) {
    return SnackBar(
      content: Text(text),
      width: 280,
      padding: const EdgeInsets.all(8),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
    );
  }
}
