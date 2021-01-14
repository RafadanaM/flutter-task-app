import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasks_app/widgets/clickable_icon.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:intl/intl.dart';

class AddTaskScreen extends StatefulWidget {
  static const routeName = '/add';

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  String stateText;
  DateTime _pickedDate;
  DateTime _inputDateTime;
  TimeOfDay _pickedTime;
  String _title;
  String _description;
  int _reminder;
  double _height;
  double _width;
  List<String> _minutes;
  final DateFormat formatter = DateFormat('MMM dd, HH:mm');

  @override
  void initState() {
    super.initState();
    _minutes = <String>[
      '5 Minutes',
      '10 Minutes',
      '15 Minutes',
      '20 Minutes',
      '25 Minutes',
      '30 Minutes',
    ];
    _pickedDate = DateTime.now();
    _pickedTime = TimeOfDay.now();
    _reminder = 0;
    _inputDateTime = DateTime(_pickedDate.year, _pickedDate.month,
        _pickedDate.day, _pickedTime.hour, _pickedTime.minute);
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
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 34.0),
                          cursorColor: Colors.grey,
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
                            color: Colors.white,
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
                        title: formatter.format(_inputDateTime),
                        titleSize: 18.0,
                        itemSpacing: 20.0,
                        onTap: () {
                          FocusScope.of(context).unfocus();
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
                        title: _reminder == 0 ? 'Reminder' : _calcReminder(),
                        titleSize: 18.0,
                        itemSpacing: 20.0,
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          _dropDown();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: Align(
              alignment: Alignment.bottomRight,
              child: ButtonTheme(
                minWidth: 70,
                height: 41,
                child: RaisedButton(
                  color: Color(0xFFFF844C),
                  textColor: Colors.white,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: () {
                    print("===================");
                    print(_title);
                    print(_description);
                    _submit();
                  },
                  child: Text('Save'),
                ),
              ),
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
        _inputDateTime = DateTime(_pickedDate.year, _pickedDate.month,
            _pickedDate.day, time.hour, time.minute);
        if (_inputDateTime.isAfter(currentDateTime))
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
    return showMaterialScrollPicker(
        context: context,
        title: "Reminder",
        items: _minutes,
        maxLongSide: 400,
        maxShortSide: 300,
        // selectedItem: selectedUsState,
        onChanged: (value) {
          List<String> split = value.split(" ");
          int time = int.parse(split[0]);
          if (DateTime.now()
              .isBefore(_inputDateTime.subtract(Duration(minutes: time))))
            setState(() {
              _reminder = time;
            });
        });
  }

  _calcReminder() {
    DateTime reminder = _inputDateTime.subtract(Duration(minutes: _reminder));
    return formatter.format(reminder);
  }

  // TODO make sure that Title exists and check for input time against current time
  _submit() {}
}
