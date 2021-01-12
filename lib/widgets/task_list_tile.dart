import 'package:flutter/material.dart';

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
      title: Text(
        taskTitle,
        style: TextStyle(
            color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
      ),
      subtitle: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.0),
        child: Text(
          date,
          style: TextStyle(color: Color(0xFF73A99C), fontSize: 13.0),
        ),
      ),
      isThreeLine: true,
      onTap: onTap,
      trailing: Theme(
        data: ThemeData(unselectedWidgetColor: Color(0xFF73A99C)),
        child: Checkbox(
          value: isChecked,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
