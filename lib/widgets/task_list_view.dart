import 'package:flutter/material.dart';
import 'package:tasks_app/screens/task_detail_screen.dart';
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
              taskTitle: 'New Title',
              taskDescription: 'blablablabla',
              date: '6 September 1969',
              isChecked: false,
              onChanged: (bool newVal) {},
              onLongPress: () {},
            ),
          ),
        );
      },
      itemCount: 3,
    );
  }
}
