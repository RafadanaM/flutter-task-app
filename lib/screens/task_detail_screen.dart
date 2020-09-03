import 'package:flutter/material.dart';
import 'package:tasks_app/models/task.dart';
import 'package:tasks_app/widgets/clickable_icon.dart';

class TaskDetailScreen extends StatelessWidget {
  static const routeName = '/details';

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    final Task task = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Color(0xFF064B41),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Color(0xFF064B41),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ClickableIcon(
                iconData: Icons.edit,
                iconSize: 35,
                title: 'Edit',
                onTap: () {
                  print('Edit is pressed');
                },
              ),
              ClickableIcon(
                iconData: Icons.delete,
                iconSize: 35,
                title: 'Delete',
                onTap: () {
                  print('Delete is pressed');
                },
              ),
            ],
          ),
        ),
      ),
      body: Stack(children: <Widget>[
        Container(
          width: _width,
          height: _height * 0.225,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 20, top: 15, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    size: 40.0,
                  ),
                ),
                SizedBox(
                  height: _height * (0.225 / 4),
                ),
                Text(
                  task.title,
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: _height * 0.05,
                ),
                Text(
                  task.description,
                  style: TextStyle(color: Color(0xFFEFF6F4), fontSize: 18.0),
                ),
                SizedBox(
                  height: _height * 0.05,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.calendar_today,
                      size: 40.0,
                      color: Color(0xFF73A99C),
                    ),
                    SizedBox(
                      width: _width * 0.05,
                    ),
                    Text(
                      task.date,
                      style: TextStyle(
                        color: Color(0xFF73A99C),
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: _height * 0.025,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.notifications,
                      size: 40.0,
                      color: Color(0xFF73A99C),
                    ),
                    SizedBox(
                      width: _width * 0.05,
                    ),
                    Text(
                      'Sept 6, 8:30 pm',
                      style: TextStyle(
                        color: Color(0xFF73A99C),
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
