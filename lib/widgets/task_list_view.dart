import 'package:flutter/material.dart';
import 'package:tasks_app/config/enums.dart';
import 'package:tasks_app/config/styles.dart';
import 'package:tasks_app/models/task.dart';
import 'package:tasks_app/models/task_provider.dart';
import 'package:tasks_app/screens/add_task_screen.dart';
import 'package:tasks_app/widgets/custom_snack_bar.dart';
import 'package:tasks_app/widgets/task_list_tile.dart';
import 'package:provider/provider.dart';

class TaskListView extends StatelessWidget {
  final Type type;

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  TaskListView({@required this.type});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: type == Type.incomplete
            ? Provider.of<TaskProvider>(context, listen: false).tasksIncomplete
            : Provider.of<TaskProvider>(context, listen: false).tasksComplete,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            if (snapshot.connectionState == ConnectionState.done) {
              return Consumer<TaskProvider>(
                child: Center(
                  child: Text(
                    "No tasks added yet.",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: lightGreen,
                    ),
                  )
                ),
                builder: (context, taskProvider, child) =>
                    type == Type.complete &&
                                taskProvider.taskCompletedCount <= 0 ||
                            type == Type.incomplete &&
                                taskProvider.taskIncompleteCount <= 0
                        ? child
                        : AnimatedList(
                            key: _listKey,
                            padding: EdgeInsets.symmetric(vertical: 22),
                            itemBuilder: (BuildContext context, int index,
                                Animation<double> animation) {
                              Task task = snapshot.data[index];
                              print(task.title);
                              return TaskListTile(
                                task: task,
                                animation: animation,
                                type: type,
                                onChanged: type == Type.incomplete
                                    ? (bool newVal) =>
                                        _completeTask(index, task, context)
                                    : (bool newVal) {},
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AddTaskScreen.routeName,
                                    arguments: task,
                                  );
                                },
                              );
                            },
                            initialItemCount: snapshot.data.length,
                          ),
              );
            }
          }
          return Container(
            width: 0.0,
            height: 0.0,
          );
        });
  }

  _completeTask(int index, Task task, BuildContext context) {
    task.toggleCompleted();
    Provider.of<TaskProvider>(context, listen: false).completeTask(task);
    _listKey.currentState.removeItem(index,
        (context, animation) => _removeItemBuilder(task, context, animation),
        duration: Duration(milliseconds: 500));

    ScaffoldMessenger.of(context).showSnackBar(undoSnackBar(
      () {
        task.toggleCompleted();
        Provider.of<TaskProvider>(context, listen: false)
            .undoCompleteTask(task);
        _listKey.currentState
            .insertItem(index, duration: Duration(milliseconds: 500));
      }, context
    ));
  }

  Widget _removeItemBuilder(
      Task task, BuildContext context, Animation<double> animation) {
    return TaskListTile(
      animation: animation,
      task: task,
      type: type,
      onChanged: (bool newVal) {},
      onTap: () {},
    );
  }
}
