import 'package:flutter/material.dart';
import 'package:tasks_app/config/enums.dart';
import 'package:tasks_app/config/styles.dart';
//
// class Reminder {
//   static var reminderList = <String, List<Widget>>{
//     'minutes': <Widget>[for (var i = 0; i < 3; i += 1) Text(i.toString())],
//     'hours': <Widget>[for (var i = 0; i < 3; i += 1) Text(i.toString())],
//     'days': <Widget>[for (var i = 0; i < 3; i += 1) Text(i.toString())]
//   };
// }

Map<ReminderType, List<Widget>> reminderList = <ReminderType, List<Widget>>{
  ReminderType.minute: <Widget>[
    for (var i = 0; i < 60; i += 1)
      Text(
        i.toString(),
        style: TextStyle(
            color: darkGreen, fontSize: 14, fontWeight: FontWeight.bold),
      )
  ],
  ReminderType.hour: <Widget>[
    for (var i = 0; i < 24; i += 1)
      Text(
        i.toString(),
        style: TextStyle(
            color: darkGreen, fontSize: 14, fontWeight: FontWeight.bold),
      )
  ],
  ReminderType.day: <Widget>[
    for (var i = 0; i < 366; i += 1)
      Text(
        i.toString(),
        style: TextStyle(
            color: darkGreen, fontSize: 14, fontWeight: FontWeight.bold),
      )
  ]
};
