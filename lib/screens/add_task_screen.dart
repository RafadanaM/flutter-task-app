import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks_app/config/enums.dart';
import 'package:tasks_app/config/reminder.dart';
import 'package:tasks_app/config/styles.dart';
import 'package:tasks_app/database/db_helper.dart';
import 'package:tasks_app/models/task.dart';
import 'package:tasks_app/widgets/clickable_icon.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:intl/intl.dart';
import 'package:tasks_app/main.dart';

class AddTaskScreen extends StatefulWidget {
  static const routeName = '/add';

  final Task task;
  const AddTaskScreen(this.task);

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  DateTime _inputDateTime;
  DateTime _pickedDateTime;
  DateTime _reminder;
  String _reminderText;
  double _height;
  double _width;
  ReminderType _reminderType = ReminderType.minute;
  bool _isAllowed = false;
  bool _isAddMode;
  bool _isReadOnly = true;
  List<String> _minutes;
  final DateFormat formatter = DateFormat('MMM dd, HH:mm');
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    //final Task task = ModalRoute.of(context).settings.arguments;
    // print(widget.task.title);
    super.initState();
    _minutes = <String>[
      '5 Minutes before',
      '10 Minutes before',
      '15 Minutes before',
      '20 Minutes before',
      '25 Minutes before',
      '30 Minutes before',
    ];
    _isAddMode = widget.task ?? true;
    // print(Reminder.reminderList);
    _pickedDateTime = _isAddMode ? null : widget.task.date;
    titleController.text = _isAddMode ? "" : widget.task.title;
    descriptionController.text = _isAddMode ? "" : widget.task.description;
    _reminder = _isAddMode ? null : widget.task.reminder;
    _reminderText = _isAddMode || (_reminder ?? true)
        ? "Reminder"
        : '${widget.task.date.difference(widget.task.reminder).inMinutes.toString()} Minutes before';
    _inputDateTime = _isAddMode ? DateTime.now() : widget.task.date;
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFF064B41),
      bottomNavigationBar: _isAddMode
          ? BottomAppBar()
          : BottomAppBar(
              elevation: 0,
              color: Color(0xFF064B41),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    if (!widget.task.isCompleted)
                      ClickableIcon(
                        direction: Axis.vertical,
                        iconData: _isReadOnly ? Icons.edit : Icons.clear,
                        iconSize: 35,
                        title: _isReadOnly ? 'Edit' : 'Cancel',
                        itemSpacing: 5.0,
                        onTap: () {
                          _toggleEdit();
                        },
                      ),
                    ClickableIcon(
                      direction: Axis.vertical,
                      iconData: _isReadOnly ? Icons.delete : Icons.check,
                      iconSize: 35,
                      title: _isReadOnly ? 'Delete' : 'Save',
                      itemSpacing: 5.0,
                      onTap: () async {
                        _isReadOnly ? await _showAlertDialog() : _submit();
                      },
                    ),
                  ],
                ),
              ),
            ),
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
                        TextFormField(
                          validator: _checkTitle(titleController.text),
                          readOnly: _isReadOnly && !_isAddMode,
                          controller: titleController,
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
                        readOnly: _isReadOnly && !_isAddMode,
                        controller: descriptionController,
                        minLines: 2,
                        maxLines: 6,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                        cursorColor: Colors.grey,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: _isAddMode || !_isReadOnly
                              ? 'Description'
                              : "No description",
                          hintStyle: TextStyle(
                              color: Color(0xFF73A99C),
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
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
                          if (!_isReadOnly || _isAddMode) {
                            FocusScope.of(context).unfocus();
                            _pickDateTime();
                          }
                        },
                      ),
                      // SizedBox(
                      //   height: _height * 0.05,
                      // ),
                      ExpansionTile(
                        iconColor: lightGreen,
                        collapsedIconColor: lightGreen,
                        tilePadding: EdgeInsets.only(left: 0),
                        expandedAlignment: Alignment.center,
                        title: ClickableIcon(
                          direction: Axis.horizontal,
                          iconData: Icons.notifications,
                          iconSize: 40,
                          title: _reminderText == null
                              ? 'Reminder'
                              : _reminderText,
                          titleSize: 18.0,
                          itemSpacing: 20.0,
                          onTap: () {
                            if (!_isReadOnly || _isAddMode) {
                              FocusScope.of(context).unfocus();
                              _dropDown();
                            }
                          },
                        ),
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: lightGreen,
                                borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(10))),
                            height: 125,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: ListWheelScrollView(
                                      overAndUnderCenterOpacity: 0.6,
                                      diameterRatio: 0.8,
                                      useMagnifier: true,
                                      magnification: 1.5,
                                      itemExtent: 30,
                                      children: reminderList[_reminderType]),
                                ),
                                Expanded(
                                  child: ListWheelScrollView(
                                      overAndUnderCenterOpacity: 0.6,
                                      diameterRatio: 0.8,
                                      useMagnifier: true,
                                      magnification: 1.5,
                                      itemExtent: 30,
                                      children: reminderList.keys
                                          .map((e) => Text(
                                                describeEnum(e),
                                                style: TextStyle(
                                                    color: darkGreen,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ))
                                          .toList()),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          widget.task == null
              ? Container(
                  margin: EdgeInsets.all(20),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: ButtonTheme(
                      minWidth: 70,
                      height: 41,
                      child: RaisedButton(
                        color: Color(0xFFFF844C),
                        disabledColor: Colors.grey[400],
                        textColor: Colors.white,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onPressed: _isAllowed
                            ? () {
                                _submit();
                              }
                            : null,
                        child: Text('Save'),
                      ),
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  _toggleEdit() {
    setState(() {
      _isReadOnly = !_isReadOnly;
      if (_isReadOnly) {
        Task task = widget.task;
        titleController.text = task.title;
        descriptionController.text = task.description;
        _inputDateTime = task.date;
        _reminder = task.reminder;
      }
    });
  }

  _checkTitle(String title) {
    print(title);
    if (title.isNotEmpty) {
      setState(() {
        _isAllowed = true;
      });
    } else {
      setState(() {
        _isAllowed = false;
      });
    }
  }

  _pickDateTime() async {
    DateTime date = await showDatePicker(
      context: context,
      initialDate: _isAddMode ? DateTime.now() : _pickedDateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    if (date != null) {
      TimeOfDay time = await showTimePicker(
        context: context,
        initialTime: _isAddMode
            ? TimeOfDay.now()
            : TimeOfDay(
                hour: _pickedDateTime.hour, minute: _pickedDateTime.minute),
      );
      DateTime currentDateTime = DateTime.now();
      if (time != null) {
        DateTime selectedDateTime =
            DateTime(date.year, date.month, date.day, time.hour, time.minute);
        setState(() {
          _inputDateTime = selectedDateTime;
        });
      }
    }
  }

  _dropDown() {
    return showMaterialScrollPicker(
        context: context,
        title: "Reminder",
        items: _minutes,
        maxLongSide: 400,
        maxShortSide: 300,
        selectedItem: _reminderText,
        onChanged: (value) {
          print(value);
          List<String> split = value.split(" ");
          int time = int.parse(split[0]);
          if (DateTime.now()
              .isBefore(_inputDateTime.subtract(Duration(minutes: time)))) {
            setState(() {
              _reminder = _inputDateTime.subtract(Duration(minutes: time));
              _reminderText = value;
            });
          } else {
            setState(() {
              _reminder = null;
              _reminderText = "Reminder";
            });
          }
        });
  }

  Future<void> _showAlertDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Delete Confirmation"),
        content: const SingleChildScrollView(
          child: Text("Are you sure you want to delete this task?"),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await Provider.of<DBHelper>(context, listen: false)
                  .deleteTask(widget.task.id)
                  .then((value) => Navigator.pop(context));
            },
            child: const Text('DELETE'),
          ),
        ],
      ),
    );
  }

  // _calcReminder() {
  //   DateTime reminder = _inputDateTime.subtract(Duration(minutes: _reminder));
  //   return formatter.format(reminder);
  // }

  // TODO make sure that Title exists and check for input time against current time
  _submit() async {
    Task newTask = Task(
        id: widget.task == null ? null : widget.task.id,
        title: titleController.text,
        description: descriptionController.text,
        date: _inputDateTime,
        reminder: _reminder);

    widget.task == null
        ? await Provider.of<DBHelper>(context, listen: false)
            .insertTask(newTask)
            .then((value) {
            Navigator.pop(context);
            Navigator.popAndPushNamed(context, HomePage.routeName);
          })
        : await Provider.of<DBHelper>(context, listen: false)
            .updateTask(newTask)
            .then((value) {
            Navigator.pop(context);
          });

    // Navigator.pop(context);
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
