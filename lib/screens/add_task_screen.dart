import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks_app/config/enums.dart';
import 'package:tasks_app/config/reminder.dart';
import 'package:tasks_app/config/styles.dart';
import 'package:tasks_app/models/task.dart';
import 'package:tasks_app/models/task_provider.dart';
import 'package:tasks_app/widgets/CustomSnackBar.dart';
import 'package:tasks_app/widgets/ErrorDialog.dart';
import 'package:tasks_app/widgets/clickable_icon.dart';
import 'package:intl/intl.dart';
import 'package:tasks_app/main.dart';

import 'package:tasks_app/widgets/confirm_dialog.dart';
import 'package:tasks_app/widgets/reminder_picker.dart';

class AddTaskScreen extends StatefulWidget {
  static const routeName = '/add';

  final Task task;
  const AddTaskScreen(this.task);

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  static const itemExtent = 30.0;
  DateTime _inputDateTime;
  DateTime _pickedDateTime;
  DateTime _reminder;
  int _reminderValue = 0;
  double _height;
  double _width;
  ReminderType _reminderType = ReminderType.minute;
  bool _isAllowed = false;
  bool _isAddMode;
  bool _isReadOnly = true;

  final DateFormat formatter = DateFormat('MMM dd, HH:mm');
  FixedExtentScrollController _controllerReminderValue;
  FixedExtentScrollController _controllerReminderType;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    //final Task task = ModalRoute.of(context).settings.arguments;
    super.initState();

    _isAddMode = widget.task == null;
    _pickedDateTime = _isAddMode ? null : widget.task.date;
    titleController.text = _isAddMode ? "" : widget.task.title;
    descriptionController.text = _isAddMode ? "" : widget.task.description;
    _reminder = _isAddMode ? null : widget.task.reminder;
    _reminderValue = _isAddMode || widget.task.reminderAsText == null
        ? 0
        : int.parse(widget.task.reminderAsText.split(" ")[0]);

    _reminderType = _isAddMode || widget.task.reminderAsText == null
        ? ReminderType.minute
        : ReminderType.values.firstWhere(
            (element) =>
                describeEnum(element) ==
                widget.task.reminderAsText.split(" ")[1],
            orElse: () => ReminderType.minute);
    _controllerReminderType = FixedExtentScrollController(
        initialItem: ReminderType.values.indexOf(_reminderType));
    _controllerReminderValue =
        FixedExtentScrollController(initialItem: _reminderValue);
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
                      _isReadOnly && !_isAddMode
                          ? ClickableIcon(
                              direction: Axis.horizontal,
                              iconData: Icons.notifications,
                              iconSize: 40,
                              title: _reminder == null
                                  ? 'Reminder'
                                  : formatter.format(_reminder),
                              titleSize: 18.0,
                              itemSpacing: 20.0,
                              onTap: () {},
                            )
                          : ExpansionTile(
                              iconColor: lightGreen,
                              collapsedIconColor: lightGreen,
                              tilePadding: EdgeInsets.only(left: 0),
                              expandedAlignment: Alignment.center,
                              onExpansionChanged: (value) {
                                if (!value)
                                  _calculateReminder(
                                      _reminderType, _reminderValue);
                              },
                              title: ClickableIcon(
                                direction: Axis.horizontal,
                                iconData: Icons.notifications,
                                iconSize: 40,
                                title: _reminder == null
                                    ? 'Reminder'
                                    : formatter.format(_reminder),
                                titleSize: 18.0,
                                itemSpacing: 20.0,
                                onTap: () {},
                              ),
                              children: [
                                ReminderPicker(
                                  numberController: _controllerReminderValue,
                                  numberChildren: reminderList[_reminderType]
                                      .map((e) => Text(
                                            e.toString(),
                                            style: TextStyle(
                                                color: darkGreen,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ))
                                      .toList(),
                                  numberOnSelectedItemChanged: (value) {
                                    setState(() {
                                      _reminderValue =
                                          reminderList[_reminderType][value];
                                    });
                                  },
                                  typeController: _controllerReminderType,
                                  typeChildren: reminderList.keys
                                      .map((e) => Text(
                                            describeEnum(e),
                                            style: TextStyle(
                                                color: darkGreen,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ))
                                      .toList(),
                                  typeOnSelectedItemChanged: (value) {
                                    int lastItem =
                                        reminderList[ReminderType.values[value]]
                                            .last;
                                    setState(() {
                                      _reminderType =
                                          ReminderType.values[value];
                                    });
                                    if (_reminderValue != null &&
                                        (_reminderValue > lastItem)) {
                                      setState(() {
                                        _reminderValue = lastItem;
                                      });
                                      _controllerReminderValue
                                          .jumpToItem(lastItem);
                                    }
                                    _controllerReminderValue.jumpTo(
                                        (itemExtent + 0.001) * _reminderValue);
                                  },
                                )
                              ],
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _isAddMode
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
      if (time != null) {
        DateTime selectedDateTime =
            DateTime(date.year, date.month, date.day, time.hour, time.minute);
        setState(() {
          _inputDateTime = selectedDateTime;
        });
        _calculateReminder(_reminderType, _reminderValue);
      }
    }
  }

  _calculateReminder(ReminderType reminderType, int reminderValue) {
    if (reminderType != null || reminderValue != null) {
      if (reminderValue == 0) {
        setState(() {
          _reminder = null;
        });
        return;
      }
      var reminder;
      switch (reminderType) {
        case ReminderType.minute:
          reminder = _inputDateTime.subtract(Duration(minutes: reminderValue));
          break;
        case ReminderType.hour:
          reminder = _inputDateTime.subtract(Duration(hours: reminderValue));
          break;
        case ReminderType.day:
          reminder = _inputDateTime.subtract(Duration(days: reminderValue));
          break;
        default:
          return;
      }
      setState(() {
        _reminder = reminder;
      });
    }
  }

  Future<void> _showAlertDialog() async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) => ConfirmDialog(
              title: "Confirm Delete",
              content: "Are you sure you want to delete this task?",
              cancelText: "CANCEL",
              confirmText: "DELETE",
              onPressedCancel: () => Navigator.pop(context),
              onPressedConfirm: () {
                Navigator.pop(context);
                Provider.of<TaskProvider>(context, listen: false)
                    .deleteTask(widget.task.id);

                Navigator.pop(context);
              },
            ));
  }

  Future<void> _showErrorDialog(String errorType, String errorMsg) async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) =>
            ErrorDialog(errorType: errorType, errorMsg: errorMsg));
  }

  // TODO make sure that Title exists and check for input time against current time
  _submit() async {
    _calculateReminder(_reminderType, _reminderValue);

    if (titleController.text.isEmpty) {
      _showErrorDialog("Title", "Title cannot be empty");
      return;
    }

    if (_inputDateTime.isBefore(DateTime.now())) {
      _showErrorDialog("Due Date", "Due date cannot be before current time");
      return;
    }

    if (_reminder != null && _reminder.isBefore(DateTime.now())) {
      ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
          text:
              "Reminder is set before current time. No notification will be shown"));
    }

    Task newTask = Task(
        id: widget.task == null ? null : widget.task.id,
        title: titleController.text,
        description: descriptionController.text,
        date: _inputDateTime,
        reminderAsText: '$_reminderValue ${describeEnum(_reminderType)}',
        reminder: _reminder);

    if (_isAddMode) {
      Provider.of<TaskProvider>(context, listen: false).addTask(newTask);
      Navigator.pop(context);
      Navigator.popAndPushNamed(context, HomePage.routeName);
    } else {
      Provider.of<TaskProvider>(context, listen: false).editTask(newTask);
      Navigator.pop(context);
    }

    // Navigator.pop(context);
  }

  @override
  void dispose() {
    _controllerReminderType.dispose();
    _controllerReminderValue.dispose();
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
