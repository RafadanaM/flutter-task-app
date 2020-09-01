import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasks_app/screens/task_page.dart';
import 'package:tasks_app/screens/fourth_page.dart';
import 'package:tasks_app/screens/second_page.dart';
import 'package:tasks_app/screens/third_page.dart';
import 'widgets/fab_bottom_app_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  List<StatelessWidget> _pages = [
    TaskPage(),
    SecondPage(),
    ThirdPage(),
    FourthPage()
  ];

  void _selectedPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE5E5E5),
      body: _pages[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFFF844C),
        onPressed: () {},
        child: Icon(
          Icons.add,
          size: 50.0,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: FABBottomAppBar(
        iconSize: 27.0,
        selectedIconSize: 35.0,
        backgroundColor: Color(0xFF064B41),
        color: Color(0xFF73A99C),
        selectedColor: Colors.white,
        notchedShape: AutomaticNotchedShape(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          CircleBorder(),
        ),
        onTabSelected: _selectedPage,
        items: [
          FABBottomAppBarItem(iconData: Icons.home),
          FABBottomAppBarItem(iconData: Icons.local_grocery_store),
          FABBottomAppBarItem(iconData: Icons.check_box),
          FABBottomAppBarItem(iconData: Icons.settings),
        ],
      ),
    );
  }
}

// BottomAppBar(
// color: Color(0xFF064B41),
// clipBehavior: Clip.antiAlias,
// shape: AutomaticNotchedShape(
// RoundedRectangleBorder(
// borderRadius: BorderRadius.only(
// topLeft: Radius.circular(20),
// topRight: Radius.circular(20),
// ),
// ),
// CircleBorder(),
// ),
// notchMargin: 5.0,
// child: BottomNavigationBar(
// type: BottomNavigationBarType.fixed,
// selectedItemColor: Colors.white,
// unselectedItemColor: Color(0xFF73A99C),
// backgroundColor: Colors.transparent,
// selectedIconTheme: IconThemeData(size: 40.0),
// unselectedIconTheme: IconThemeData(size: 30.0),
// currentIndex: _selectedIndex,
// onTap: (int index) {
// setState(() {
// _selectedIndex = index;
// });
// },
// showSelectedLabels: false,
// showUnselectedLabels: false,
// items: [
// BottomNavigationBarItem(
// icon: Icon(Icons.home), title: Text('Home')),
// BottomNavigationBarItem(
// icon: Icon(Icons.local_grocery_store),
// title: Text('Groceries')),
// BottomNavigationBarItem(
// icon: Icon(Icons.check_box), title: Text('Completed')),
// BottomNavigationBarItem(
// icon: Icon(Icons.settings), title: Text('Setting')),
// ],
// ),
// ),
