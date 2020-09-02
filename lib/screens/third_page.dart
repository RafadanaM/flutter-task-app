import 'package:flutter/material.dart';

class ThirdPage extends StatelessWidget {
  static const routeName = '/third';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Third Page'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
