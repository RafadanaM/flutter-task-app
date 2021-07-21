import 'package:tasks_app/config/enums.dart';

//
// class Reminder {
//   static var reminderList = <String, List<Widget>>{
//     'minutes': <Widget>[for (var i = 0; i < 3; i += 1) Text(i.toString())],
//     'hours': <Widget>[for (var i = 0; i < 3; i += 1) Text(i.toString())],
//     'days': <Widget>[for (var i = 0; i < 3; i += 1) Text(i.toString())]
//   };
// }

Map<ReminderType, List<int>> reminderList = <ReminderType, List<int>>{
  ReminderType.minute: <int>[for (var i = 0; i < 60; i += 1) i],
  ReminderType.hour: <int>[for (var i = 0; i < 24; i += 1) i],
  ReminderType.day: <int>[for (var i = 0; i < 365; i += 1) i],
};
