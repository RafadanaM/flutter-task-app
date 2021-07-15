import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks_app/config/styles.dart';
import 'package:tasks_app/screens/add_task_screen.dart';
import 'package:tasks_app/screens/task_detail_screen.dart';
import 'package:tasks_app/screens/task_page.dart';
import 'package:tasks_app/screens/fourth_page.dart';
import 'package:tasks_app/screens/second_page.dart';
import 'package:tasks_app/screens/completed_page.dart';
import 'database/db_helper.dart';
import 'widgets/fab_bottom_app_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DBHelper(),
      child: MaterialApp(
        title: 'Task App',

        initialRoute: HomePage.routeName,
        onGenerateRoute: (RouteSettings settings) {
          var routes = <String, WidgetBuilder>{
            HomePage.routeName: (context) => HomePage(),
            TaskDetailScreen.routeName: (context) => TaskDetailScreen(),
            AddTaskScreen.routeName: (context) =>
                AddTaskScreen(settings.arguments),
          };
          WidgetBuilder builder = routes[settings.name];
          return MaterialPageRoute(builder: (context) => builder(context));
        },
        // routes: {
        //   MyHomePage.routeName: (context) => MyHomePage(),
        //   TaskDetailScreen.routeName: (context) => TaskDetailScreen(),
        //   AddTaskScreen.routeName: (context) => AddTaskScreen(),
        // },
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  static const routeName = '/';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  PageController _pageController = PageController();

  int _selectedIndex = 0;
  List<StatelessWidget> _pages;

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _selectedPage(int index) {
    _pageController.jumpToPage(index);
  }

  @override
  void initState() {
    //final Task task = ModalRoute.of(context).settings.arguments;

    super.initState();
    _pages = [
      TaskPage(
        listKey: _listKey,
      ),
      SecondPage(),
      CompletedPage(),
      FourthPage()
    ];
  }

  @override
  Widget build(BuildContext context) {
    //final Size size = MediaQuery.of(context).size;

    return Scaffold(
      extendBody: false,
      backgroundColor: Color(0xFFEFF6F4),
      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      floatingActionButton: _selectedIndex == 1
          ? null
          : FloatingActionButton(
              backgroundColor: Color(0xFFFF844C),
              onPressed: () {
                Navigator.pushNamed(context, AddTaskScreen.routeName,
                    arguments: {'listKey': _listKey});
              },
              child: Icon(
                Icons.add,
                size: 50.0,
              ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: FABBottomAppBar(
        isSecond: _selectedIndex == 1,
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
// CustomPaint(
// size: Size(size.width, 80),
// painter: BNBCustomPainter(),
// ),

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;
    Path path = Path()..moveTo(0, 10);
    path.lineTo(size.width * 0.35, 10);
    // path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 10, size.width * 0.40, 10);
    path.arcToPoint(Offset(size.width * 0.60, 10),
        radius: Radius.elliptical(60, 100), clockwise: false);
    path.lineTo(size.width, 10);
    // path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    // path.quadraticBezierTo(size.width * 0.80, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
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
