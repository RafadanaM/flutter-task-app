import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
import 'package:tasks_app/config/styles.dart';
import 'package:tasks_app/config/type.dart';

class TaskListTile extends StatelessWidget {
  final String taskTitle;
  final String taskDescription;
  final String date;
  final Function onChanged;
  final Function onTap;
  final bool isChecked;
  final Type type;

  TaskListTile({
    this.taskTitle,
    this.taskDescription,
    this.date,
    this.isChecked,
    this.onChanged,
    this.onTap,
    this.type,
  });

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
        child: type == Type.incomplete
            ? Text(
                date,
                style: TextStyle(
                  color: lightGreen,
                  fontSize: 13.0,
                  decoration: isChecked ? TextDecoration.lineThrough : null,
                ),
              )
            : null,
      ),
      isThreeLine: type == Type.incomplete,
      onTap: onTap,
      trailing: Theme(
          data: ThemeData(unselectedWidgetColor: Color(0xFF73A99C)),
          child: CircularCheckBox(
            checkColor: Color(0xFF1F6355),
            activeColor: Color(0xFF73A99C),
            value: isChecked,
            materialTapTargetSize: MaterialTapTargetSize.padded,
            onChanged: onChanged,
          )),
    );
  }
}

// Checkbox(
// value: isChecked,
// onChanged: onChanged,
// ),
