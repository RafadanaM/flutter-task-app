import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasks_app/config/enums.dart';

import 'package:tasks_app/database/db_helper.dart';
import 'package:tasks_app/models/task.dart';
import 'package:tasks_app/screens/add_task_screen.dart';
import 'package:tasks_app/widgets/task_list_tile.dart';
import 'package:provider/provider.dart';

class TaskListView extends StatelessWidget {
  final Type type;
  final GlobalKey<AnimatedListState> listKey;

  TaskListView({@required this.type, @required this.listKey});

  @override
  Widget build(BuildContext context) {
    return Consumer<DBHelper>(
      builder: (context, taskData, child) {
        return FutureBuilder<List<Task>>(
            future: type == Type.incomplete
                ? taskData.getIncompleteTasks()
                : taskData.getCompletedTasks(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.length == 0) {
                  return Center(
                    child: Text("No Tasks"),
                  );
                }
                return AnimatedList(
                  padding: EdgeInsets.symmetric(vertical: 22),
                  key: listKey,
                  itemBuilder: (BuildContext context, int index,
                      Animation<double> animation) {
                    Task task = snapshot.data[index];
                    return TaskListTile(
                      task: task,
                      animation: animation,
                      type: type,
                      onChanged: type == Type.incomplete
                          ? (bool newVal) => _removeTask(index, task, context)
                          : (bool newVal) {},
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AddTaskScreen.routeName,
                          arguments: {'task': task, 'listKey': listKey},
                        );
                      },
                    );
                  },
                  initialItemCount: snapshot.data.length,
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            });
      },
    );
  }

  _removeTask(int index, Task task, BuildContext context) async {
    await Provider.of<DBHelper>(context, listen: false).completeTask(task);
    listKey.currentState.removeItem(index,
        (context, animation) => _removeItemBuilder(task, context, animation),
        duration: Duration(milliseconds: 600));
  }

  Widget _removeItemBuilder(
      Task task, BuildContext context, Animation<double> animation) {
    print(task.title);
    return TaskListTile(
      animation: animation,
      type: type,
      onChanged: (bool newVal) {},
      onTap: () {},
    );
  }
}
