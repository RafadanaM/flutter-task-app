import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasks_app/models/task_data.dart';
import 'package:tasks_app/screens/task_detail_screen.dart';
import 'package:tasks_app/widgets/task_list_tile.dart';
import 'package:provider/provider.dart';
import 'package:tasks_app/models/task.dart';

class TaskListView extends StatefulWidget {
  @override
  _TaskListViewState createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  final DateFormat formatter = DateFormat('dd MMMM yyyy');
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return ListView.separated(
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 20.0,
            );
          },
          itemBuilder: (context, index) {
            return Container(
              height: 85,
              decoration: BoxDecoration(
                color: Color(0xFF064B41),
                borderRadius: BorderRadius.all(
                  Radius.circular(15.0),
                ),
              ),
              child: Center(
                child: TaskListTile(
                  taskTitle: taskData.tasks[index].title,
                  taskDescription: taskData.tasks[index].description,
                  date: formatter.format(taskData.tasks[index].date),
                  isChecked: taskData.tasks[index].isCompleted,
                  onChanged: (bool newVal) {
                    setState(() {
                      taskData.tasks[index].toggleCompleted();
                    });
                  },
                  onTap: () {
                    Navigator.pushNamed(context, TaskDetailScreen.routeName,
                        arguments: taskData.tasks[index]);
                  },
                ),
              ),
            );
          },
          itemCount: taskData.tasks.length,
        );
      },
    );
  }
}
