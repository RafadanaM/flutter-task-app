import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  DateTime _pickedDate;
  DateTime _inputDateTime;
  TimeOfDay _pickedTime;
  DateTime _reminder;
  double _height;
  double _width;
  bool _isAllowed = false;
  bool _isReadOnly;
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
      '5 Minutes',
      '10 Minutes',
      '15 Minutes',
      '20 Minutes',
      '25 Minutes',
      '30 Minutes',
    ];
    _isReadOnly = widget.task != null;
    _pickedDate = widget.task == null
        ? DateTime.now()
        : DateTime(widget.task.date.year, widget.task.date.month,
            widget.task.date.day);
    _pickedTime = widget.task == null
        ? TimeOfDay.now()
        : TimeOfDay(
            hour: widget.task.date.hour, minute: widget.task.date.minute);
    titleController.text = widget.task == null ? "" : widget.task.title;
    descriptionController.text =
        widget.task == null ? "" : widget.task.description;
    _reminder = widget.task == null ? null : widget.task.reminder;
    _inputDateTime = widget.task == null
        ? DateTime(_pickedDate.year, _pickedDate.month, _pickedDate.day,
            _pickedTime.hour, _pickedTime.minute)
        : widget.task.date;
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFF064B41),
      bottomNavigationBar: widget.task == null
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
                        _isReadOnly
                            ? await Provider.of<DBHelper>(context,
                                    listen: false)
                                .deleteTask(widget.task.id)
                                .then((value) => Navigator.pop(context))
                            : _submit();
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
                          readOnly: _isReadOnly,
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
                        readOnly: _isReadOnly,
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
                          hintText: widget.task == null || !_isReadOnly
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
                          if (!_isReadOnly) {
                            FocusScope.of(context).unfocus();
                            _pickDateTime();
                          }
                        },
                      ),
                      // SizedBox(
                      //   height: _height * 0.05,
                      // ),
                      ClickableIcon(
                        direction: Axis.horizontal,
                        iconData: Icons.notifications,
                        iconSize: 40,
                        title: _reminder == null
                            ? 'Reminder'
                            : formatter.format(_reminder),
                        titleSize: 18.0,
                        itemSpacing: 20.0,
                        onTap: () {
                          if (!_isReadOnly) {
                            FocusScope.of(context).unfocus();
                            _dropDown();
                          }
                        },
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
      initialDate: _pickedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    if (date != null) {
      setState(() {
        _pickedDate = date;
        print(date);
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
            _reminder = null;
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
        // selectedItem: selectedUsState,
        onChanged: (value) {
          List<String> split = value.split(" ");
          int time = int.parse(split[0]);
          if (DateTime.now()
              .isBefore(_inputDateTime.subtract(Duration(minutes: time)))) {
            setState(() {
              _reminder = _inputDateTime.subtract(Duration(minutes: time));
            });
          } else {
            setState(() {
              _reminder = null;
            });
          }
        });
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
        : await Provider.of<DBHelper>(context, listen: false)
            .updateTask(newTask);

    widget.task == null
        ? await Provider.of<DBHelper>(context, listen: false)
            .insertTask(newTask)
            .then((value) {
            Navigator.pop(context);
            Navigator.popAndPushNamed(context, HomePage.routeName);
          })
        : await Provider.of<DBHelper>(context, listen: false)
            .updateTask(newTask);

    // Navigator.pop(context);
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
