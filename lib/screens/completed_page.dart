import 'package:flutter/material.dart';
import 'package:tasks_app/config/styles.dart';
import 'package:tasks_app/widgets/task_list_view.dart';
import 'package:tasks_app/config/enums.dart';

class ThirdPage extends StatelessWidget {
  static const routeName = '/completed';

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
            Text(
              'Completed',
              style: TextStyle(
                fontSize: 36.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: TaskListView(
                type: Type.complete,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
