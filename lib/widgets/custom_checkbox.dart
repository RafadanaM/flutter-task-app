import 'package:flutter/material.dart';
import 'package:tasks_app/config/styles.dart';

class CustomCheckbox extends StatelessWidget {
  final double scale;
  final Color borderColor;
  final Color activeColor;
  final Color checkColor;
  final bool value;
  final Function onChanged;
  

  CustomCheckbox({
    this.scale = 1.4,
    this.borderColor = lightGreen,
    this.activeColor = lightGreen,
    this.checkColor = darkGreen,
    @required this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {

    return Transform.scale(
      scale: scale,
      child: Checkbox(
        shape: CircleBorder(),
        side: BorderSide(color: borderColor),
        value: value,
        onChanged: onChanged,
        activeColor: activeColor,
        checkColor: checkColor,
      ),
    );
  }
}
