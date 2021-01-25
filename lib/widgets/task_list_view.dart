import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasks_app/database/db_helper.dart';
import 'package:tasks_app/models/task.dart';
import 'package:tasks_app/screens/task_detail_screen.dart';
import 'package:tasks_app/widgets/task_list_tile.dart';
import 'package:provider/provider.dart';
import 'package:tasks_app/config/type.dart';

class TaskListView extends StatelessWidget {
  final DateFormat formatter = DateFormat('dd MMMM yyyy');
  final Type type;

  TaskListView({@required this.type});

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
                return ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: 22),
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 10.0,
                    );
                  },
                  itemBuilder: (context, index) {
                    return Container(
                      height: type == Type.incomplete ? 85 : 60,
                      decoration: BoxDecoration(
                        color: Color(0xFF1F6355),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                      ),
                      child: Center(
                        child: TaskListTile(
                          type: type,
                          taskTitle: snapshot.data[index].title,
                          taskDescription: snapshot.data[index].description,
                          date: formatter.format(snapshot.data[index].date),
                          isChecked: snapshot.data[index].isChecked,
                          onChanged: type == Type.incomplete
                              ? (bool newVal) {
                                  Provider.of<DBHelper>(context, listen: false)
                                      .completeTask(snapshot.data[index]);
                                }
                              : (bool newVal) {},
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
