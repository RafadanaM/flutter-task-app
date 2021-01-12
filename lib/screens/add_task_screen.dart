import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasks_app/widgets/clickable_icon.dart';

class AddTaskScreen extends StatelessWidget {
  static const routeName = '/add';

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    String _title;
    String _description;
    return Scaffold(
      backgroundColor: Color(0xFF064B41),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
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
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 20, top: 30, bottom: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back,
                            size: 40,
                          ),
                        ),
                        TextField(
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 34.0),
                          cursorColor: Colors.grey,
                          autofocus: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Title',
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 34.0),
                          ),
                          onChanged: (String newTitle) {
                            _title = newTitle;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextField(
                        minLines: 2,
                        maxLines: 6,
                        style: TextStyle(
                            color: Color(0xFF73A99C),
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                        cursorColor: Colors.grey,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          // enabledBorder: OutlineInputBorder(
                          //   borderSide: BorderSide(
                          //       color: Color(0xFF73A99C), width: 1.0),
                          //   borderRadius: BorderRadius.circular(5),
                          // ),
                          // focusedBorder: OutlineInputBorder(
                          //   borderSide: BorderSide(
                          //       color: Color(0xFF73A99C), width: 1.0),
                          //   borderRadius: BorderRadius.circular(5),
                          // ),

                          hintText: 'Description',
                          hintStyle: TextStyle(
                              color: Color(0xFF73A99C),
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                        onChanged: (String newDescription) {
                          _description = newDescription;
                        },
                      ),
                      // SizedBox(
                      //   height: _height * 0.025,
                      // ),

                      ClickableIcon(
                        direction: Axis.horizontal,
                        iconData: Icons.calendar_today,
                        iconSize: 40,
                        title: 'Due Date',
                        titleSize: 18.0,
                        itemSpacing: 20.0,
                      ),
                      // SizedBox(
                      //   height: _height * 0.05,
                      // ),
                      ClickableIcon(
                        direction: Axis.horizontal,
                        iconData: Icons.notifications,
                        iconSize: 40,
                        title: 'Reminder',
                        titleSize: 18.0,
                        itemSpacing: 20.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: RaisedButton(
              color: Color(0xFFFF844C),
              textColor: Colors.white,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onPressed: () {},
              child: Text('Save'),
            ),
          )
        ],
      ),
    );
  }
}
