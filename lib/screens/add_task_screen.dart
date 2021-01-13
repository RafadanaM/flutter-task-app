import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasks_app/widgets/clickable_icon.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';

class AddTaskScreen extends StatefulWidget {
  static const routeName = '/add';

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  String stateText;
  DateTime _pickedDate;
  TimeOfDay _pickedTime;
  String _title;
  String _description;
  int _reminder;
  double _height;
  double _width;

  @override
  void initState() {
    super.initState();
    _pickedDate = DateTime.now();
    _pickedTime = TimeOfDay.now();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

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
                  padding: EdgeInsets.all(20),
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
                        title:
                            "${_pickedDate.day}/${_pickedDate.month}/${_pickedDate.year} ${_pickedTime.hour}:${_pickedTime.minute}",
                        titleSize: 18.0,
                        itemSpacing: 20.0,
                        onTap: () {
                          _pickDateTime();
                        },
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
                        onTap: () {
                          _dropDown();
                        },
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
              onPressed: () {
                print("===================");
                print(_title);
                print(_description);
              },
              child: Text('Save'),
            ),
          )
        ],
      ),
    );
  }

  _pickDateTime() async {
    DateTime date = await showDatePicker(
      context: context,
      initialDate: _pickedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    if (date != null) {
      setState(() {
        _pickedDate = date;
      });
      TimeOfDay time = await showTimePicker(
        context: context,
        initialTime: _pickedTime,
      );
      DateTime currentDateTime = DateTime.now();
      if (time != null) {
        DateTime inputDateTime = DateTime(_pickedDate.year, _pickedDate.month,
            _pickedDate.day, time.hour, time.minute);
        if (inputDateTime.isAfter(currentDateTime))
          setState(() {
            _pickedTime = time;
          });
      }
    }
  }

  // _pickTime() async {
  //   TimeOfDay time = await showTimePicker(
  //     context: context,
  //     initialTime: _pickedTime,
  //   );
  //   DateTime currentDateTime = DateTime.now();
  //   DateTime inputDateTime = date
  //   if (time != null) {
  //     if()
  //     setState(() {
  //       _pickedTime = time;
  //     });
  //   }
  // }

  _dropDown() {
    return showMaterialNumberPicker(
      context: context,
      title: "Pick a number",
      minNumber: 5,
      maxNumber: 30,
      step: 5,
      selectedNumber: _reminder,
      onChanged: (value) => setState(() => _reminder = value),
    );
  }
}
