import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  static const routeName = '/second';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Second Page'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
