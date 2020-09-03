import 'package:flutter/material.dart';
import 'package:tasks_app/screens/task_detail_screen.dart';
import 'file:///D:/Udemy/Flutter/Projects/tasks_app/lib/models/task.dart';
import 'package:tasks_app/widgets/task_list_tile.dart';

class TaskListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: 20.0,
        );
      },
      itemBuilder: (context, index) {
        final Task task = Task(
            title: "New Title",
            description: "bla bla bla",
            date: "6 September 1969");
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
              taskTitle: task.title,
              taskDescription: task.description,
              date: task.date,
              isChecked: task.isCompleted,
              onChanged: (bool newVal) {},
              onLongPress: () {
                Navigator.pushNamed(context, TaskDetailScreen.routeName,
                    arguments: task);
              },
            ),
          ),
        );
      },
      itemCount: 3,
    );
  }
}
