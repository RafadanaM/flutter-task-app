import 'package:flutter/material.dart';

class ClickableIcon extends StatelessWidget {
  final IconData iconData;
  final double iconSize;
  final String title;
  final Function onTap;

  ClickableIcon({this.iconData, this.title, this.iconSize, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            iconData,
            size: iconSize,
            color: Color(0xFF73A99C),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF73A99C),
            ),
          ),
        ],
      ),
    );
  }
}
