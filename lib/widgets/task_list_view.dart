import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasks_app/models/task_data.dart';
import 'package:tasks_app/screens/task_detail_screen.dart';
import 'package:tasks_app/widgets/task_list_tile.dart';
import 'package:provider/provider.dart';

class TaskListView extends StatelessWidget {
  final DateFormat formatter = DateFormat('dd MMMM yyyy');
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return ListView.separated(
          padding: EdgeInsets.symmetric(vertical: 22),
          separatorBuilder: (BuildContext context, int index) {
            return (taskData.tasks[index].isCompleted)
                ? Container()
                : SizedBox(
                    height: 10.0,
                  );
          },
          itemBuilder: (context, index) {
            return (taskData.tasks[index].isCompleted)
                ? Container()
                : Container(
                    height: 85,
                    decoration: BoxDecoration(
                      color: Color(0xFF1F6355),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                    ),
                    child: Center(
                      child: TaskListTile(
                        taskTitle: taskData.tasks[index].title,
                        taskDescription: taskData.tasks[index].description,
                        date: formatter.format(taskData.tasks[index].date),
                        isChecked: taskData.tasks[index].isChecked,
                        onChanged: (bool newVal) {
                          taskData.updateTask(taskData.tasks[index]);
                        },
                        onTap: () {
                          Navigator.pushNamed(
                              context, TaskDetailScreen.routeName,
                              arguments: taskData.tasks[index]);
                        },
                      ),
                    ),
                  );
          },
          itemCount: taskData.taskCount,
        );
      },
    );
  }
}
