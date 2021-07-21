import 'package:flutter/material.dart';
import 'package:tasks_app/config/enums.dart';

import 'package:tasks_app/widgets/header.dart';
import 'package:tasks_app/widgets/task_list_view.dart';
import 'package:tasks_app/config/styles.dart';

class TaskPage extends StatelessWidget {
  static const routeName = '/task';

  TaskPage();

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backgroundPrimary,
      body: Padding(
        padding: EdgeInsets.only(
            top: _height * 0.075, left: _width * 0.025, right: _width * 0.025),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Header(title: 'My Tasks'),
            Expanded(
              child: TaskListView(
                type: Type.incomplete,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
