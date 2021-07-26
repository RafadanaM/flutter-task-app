import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasks_app/config/styles.dart';
import 'package:tasks_app/config/enums.dart';
import 'package:tasks_app/models/task.dart';

import 'custom_checkbox.dart';

class TaskListTile extends StatelessWidget {
  final Task task;
  final Type type;
  final Animation<double> animation;
  final Function onTap;
  final Function onChanged;
  final DateFormat formatter = DateFormat('dd MMMM yyyy');

  TaskListTile(
      {@required this.task,
      @required this.onTap,
      @required this.onChanged,
      @required this.type,
      @required this.animation});

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      key: ValueKey(task.id),
      position: Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset(0, 0),
      ).animate(animation),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        height: type == Type.incomplete ? 85 : 60,
        decoration: BoxDecoration(
          color: Color(0xFF1F6355),
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        child: Center(
          child: ListTile(
            key: ValueKey(task.id),
            title: Padding(
              padding: type == Type.incomplete
                  ? const EdgeInsets.only(top: 5.0)
                  : const EdgeInsets.symmetric(vertical: 5.0),
              child: Text(
                task.title,
                key: ValueKey(task.id),
                style: TextStyle(
                  decoration:
                      task.isCompleted ? TextDecoration.lineThrough : null,
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
                      formatter.format(task.date),
                      key: ValueKey(task.id),
                      style: TextStyle(
                        color: lightGreen,
                        fontSize: 13.0,
                        decoration: task.isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                  )
                : null,
            isThreeLine: type == Type.incomplete,
            onTap: onTap,
            trailing: CustomCheckbox(
                value: task.isCompleted,
                onChanged: task.isCompleted ? (newValue) {} : onChanged,
            ),
          ),
        ),
      ),
    );
  }
}

// Checkbox(
// value: isChecked,
// onChanged: onChanged,
// ),

// RoundCheckBox(
// checkedColor: Color(0xFF73A99C),
// checkedWidget: Icon(
// Icons.check,
// size: 18,
// color: Color(0xFF1F6355),
// ),
// uncheckedColor: Color(0xFF1F6355),
// size: 24,
// isChecked: isChecked,
// onTap: type == Type.incomplete ? onChanged : null),
