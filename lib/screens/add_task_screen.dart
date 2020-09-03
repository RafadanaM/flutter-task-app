import 'package:flutter/material.dart';

class AddTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    String _title;
    String _description;
    return Container(
      child: Text('This is a bottom sheet.'),
    );
  }
}
