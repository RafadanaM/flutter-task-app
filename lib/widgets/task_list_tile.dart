import 'package:roundcheckbox/roundcheckbox.dart';
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
        padding: type == Type.incomplete
            ? const EdgeInsets.only(top: 5.0)
            : const EdgeInsets.symmetric(vertical: 5.0),
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
      subtitle: type == Type.incomplete
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Text(
                date,
                style: TextStyle(
                  color: lightGreen,
                  fontSize: 13.0,
                  decoration: isChecked ? TextDecoration.lineThrough : null,
                ),
              ),
            )
          : null,
      isThreeLine: type == Type.incomplete,
      onTap: onTap,
      trailing: Theme(
        data: ThemeData(
            unselectedWidgetColor: Color(0xFF73A99C),
            materialTapTargetSize: MaterialTapTargetSize.padded),
        child: RoundCheckBox(
          checkedColor: Color(0xFF73A99C),
          checkedWidget: Icon(
            Icons.check,
            size: 18,
            color: Color(0xFF1F6355),
          ),
          uncheckedColor: Color(0xFF1F6355),
          size: 24,
          isChecked: isChecked,
          onTap: onChanged,
        ),
      ),
    );
  }
}

// Checkbox(
// value: isChecked,
// onChanged: onChanged,
// ),
