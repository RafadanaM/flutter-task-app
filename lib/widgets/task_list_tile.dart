import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasks_app/config/styles.dart';

class TaskListTile extends StatelessWidget {
  final String taskTitle;
  final String taskDescription;
  final String date;
  final Function onChanged;
  final Function onTap;
  final bool isChecked;

  TaskListTile(
      {this.taskTitle,
      this.taskDescription,
      this.date,
      this.isChecked,
      this.onChanged,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Text(
          taskTitle,
          style: TextStyle(
            decoration: isChecked ? TextDecoration.lineThrough : null,
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      subtitle: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.0),
        child: Text(
          date,
          style: TextStyle(
            color: lightGreen,
            fontSize: 13.0,
            decoration: isChecked ? TextDecoration.lineThrough : null,
          ),
        ),
      ),
      isThreeLine: true,
      onTap: onTap,
      trailing: Theme(
        data: ThemeData(unselectedWidgetColor: lightGreen),
        child: Checkbox(
          value: isChecked,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
