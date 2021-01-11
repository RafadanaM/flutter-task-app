import 'package:flutter/material.dart';

class ClickableIcon extends StatelessWidget {
  final IconData iconData;
  final double iconSize;
  final double titleSize;
  final double itemSpacing;
  final String title;
  final Function onTap;
  final Axis direction;

  ClickableIcon(
      {@required this.direction,
      this.iconData,
      this.title,
      this.titleSize,
      this.iconSize,
      this.onTap,
      this.itemSpacing});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Flex(
        direction: direction,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            iconData,
            size: iconSize,
            color: Color(0xFF73A99C),
          ),
          SizedBox(
            width: direction == Axis.horizontal ? itemSpacing : null,
            height: direction == Axis.vertical ? itemSpacing : null,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: titleSize,
              color: Color(0xFF73A99C),
            ),
          ),
        ],
      ),
    );
  }
}
