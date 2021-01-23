import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:tasks_app/database/db_helper.dart';
import 'package:tasks_app/models/task.dart';

import 'package:tasks_app/models/task_data.dart';
import 'package:tasks_app/screens/task_detail_screen.dart';
import 'package:tasks_app/widgets/task_list_tile.dart';
import 'package:provider/provider.dart';

class TaskListView extends StatelessWidget {
  final DateFormat formatter = DateFormat('dd MMMM yyyy');
  @override
  Widget build(BuildContext context) {
    return Consumer<DBHelper>(
      builder: (context, taskData, child) {
        return FutureBuilder<List<Task>>(
            future: taskData.tasks(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.length == 0) {
                  return Center(
                    child: Text("No Tasks"),
                  );
                }
                return ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: 22),
                  separatorBuilder: (BuildContext context, int index) {
                    return (snapshot.data[index].isCompleted)
                        ? Container()
                        : SizedBox(
                            height: 10.0,
                          );
                  },
                  itemBuilder: (context, index) {
                    return (snapshot.data[index].isCompleted)
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
                                taskTitle: snapshot.data[index].title,
                                taskDescription:
                                    snapshot.data[index].description,
                                date:
                                    formatter.format(snapshot.data[index].date),
                                isChecked: snapshot.data[index].isChecked,
                                onChanged: (bool newVal) {
                                  Provider.of<DBHelper>(context, listen: false)
                                      .completeTask(snapshot.data[index]);
                                },
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, TaskDetailScreen.routeName,
                                      arguments: snapshot.data[index]);
                                },
                              ),
                            ),
                          );
                  },
                  itemCount: snapshot.data.length,
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            });

      },
    );
  }
}
