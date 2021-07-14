import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String title;

  Header({
    @required this.title
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 36.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
