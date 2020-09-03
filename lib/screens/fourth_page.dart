import 'package:flutter/material.dart';

class FourthPage extends StatelessWidget {
  static const routeName = '/fourth';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Fourth Page'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
