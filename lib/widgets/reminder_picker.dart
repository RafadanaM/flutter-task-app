import 'package:flutter/material.dart';
import 'package:tasks_app/config/styles.dart';

class ReminderPicker extends StatelessWidget {
  static const itemExtent = 30.0;
  final ScrollController numberController;
  final List<Widget> numberChildren;
  final Function numberOnSelectedItemChanged;
  final ScrollController typeController;
  final List<Widget> typeChildren;
  final Function typeOnSelectedItemChanged;

  ReminderPicker(
      {@required this.numberController,
      @required this.numberChildren,
      @required this.numberOnSelectedItemChanged,
      @required this.typeController,
      @required this.typeChildren,
      @required this.typeOnSelectedItemChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: lightGreen,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10))),
      height: 125,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ListWheelScrollView(
              controller: numberController,
              overAndUnderCenterOpacity: 0.6,
              diameterRatio: 0.8,
              useMagnifier: true,
              magnification: 1.5,
              itemExtent: itemExtent,
              physics: FixedExtentScrollPhysics(),
              children: numberChildren,
              //     .map((e) => Text(
              //   e.toString(),
              //   style: TextStyle(
              //       color: darkGreen,
              //       fontSize: 14,
              //       fontWeight:
              //       FontWeight.bold),
              // ))
              //     .toList(),
              onSelectedItemChanged: numberOnSelectedItemChanged,
              // onSelectedItemChanged: (value) {
              //   setState(() {
              //     _reminderValue =
              //     reminderList[_reminderType]
              //     [value];
              //   });
              // },
            ),
          ),
          Expanded(
            child: ListWheelScrollView(
              controller: typeController,
              overAndUnderCenterOpacity: 0.6,
              diameterRatio: 0.8,
              useMagnifier: true,
              magnification: 1.5,
              itemExtent: itemExtent,
              physics: FixedExtentScrollPhysics(),
              children: typeChildren,
              // children: reminderList.keys
              //     .map((e) => Text(
              //   describeEnum(e),
              //   style: TextStyle(
              //       color: darkGreen,
              //       fontSize: 14,
              //       fontWeight:
              //       FontWeight.bold),
              // ))
              //     .toList(),
              onSelectedItemChanged: typeOnSelectedItemChanged,
              // onSelectedItemChanged: (value) {
              //   int lastItem = reminderList[
              //   ReminderType.values[value]]
              //       .last;
              //   setState(() {
              //     _reminderType =
              //     ReminderType.values[value];
              //   });
              //   if (_reminderValue != null &&
              //       (_reminderValue > lastItem)) {
              //     setState(() {
              //       _reminderValue = lastItem;
              //     });
              //     _controllerReminderValue
              //         .jumpToItem(lastItem);
              //   }
              //   _controllerReminderValue.jumpTo(
              //       (itemExtent + 0.001) *
              //           _reminderValue);
              // },
            ),
          ),
        ],
      ),
    );
  }
}
