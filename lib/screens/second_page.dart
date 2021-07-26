import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks_app/config/styles.dart';
import 'package:tasks_app/database/db_helper.dart';
import 'package:tasks_app/models/grocery.dart';
import 'package:tasks_app/models/grocery_provider.dart';
import 'package:tasks_app/widgets/grocery_list_view.dart';
import 'package:tasks_app/widgets/header.dart';

class SecondPage extends StatefulWidget {
  static const routeName = '/second';

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  bool _isAllowed = false;
  TextEditingController groceryController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('rendered');
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backgroundPrimary,
      body: Padding(
        padding: EdgeInsets.only(
          top: _height * 0.075,
          left: _width * 0.025,
          right: _width * 0.025,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Header(title: 'Groceries'),
                IconButton(
                  padding: EdgeInsets.only(top: 8),
                  alignment: Alignment.topCenter,
                  icon: const Icon(Icons.more_vert),
                  tooltip: 'Show options menu',
                  onPressed: () {
                    _showMenu();
                  },
                  iconSize: 28,
                ),
              ],
            ),
            Expanded(
              child: Stack(
                children: <Widget>[
                  GroceryListView(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 3,
                      ),
                      margin: EdgeInsets.only(
                        bottom: 10,
                      ),
                      decoration: BoxDecoration(
                        color: orange,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: TextFormField(
                              controller: groceryController,
                              maxLines: 1,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Insert grocery item..',
                                hintStyle: TextStyle(
                                  color: lightOrange,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 30,
                            width: 30,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                side: BorderSide(
                                  color: Colors.white,
                                  width: 2,
                                ),
                                padding: EdgeInsets.zero,
                              ),
                              onPressed: () {
                                _submit();
                              },
                              child: Icon(
                                Icons.add,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _checkTitle(String title) {
    print(title);
    if (title.isNotEmpty) {
      setState(() {
        _isAllowed = true;
      });
    } else {
      setState(() {
        _isAllowed = false;
      });
    }
  }

  _submit() async {
    _checkTitle(groceryController.text);
    if (_isAllowed) {
      Grocery newGrocery = Grocery(
        title: groceryController.text,
      );

      Provider.of<GroceryProvider>(context, listen: false)
          .addGrocery(newGrocery);

      groceryController.clear();
    }
  }

  _showMenu() {
    showModalBottomSheet<void>(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: 10,
                  left: 10,
                  right: 10,
                  bottom: 20,
                ),
                decoration: BoxDecoration(
                  color: darkerGreen,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                alignment: Alignment.topLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Align(
                      child: Container(
                        height: 4,
                        width: 25,
                        margin: EdgeInsets.only(bottom: 15),
                        decoration: BoxDecoration(
                            color: lightGreen,
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        bottom: 10,
                      ),
                      decoration: BoxDecoration(
                        color: darkestGreen,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          minimumSize: Size(double.infinity, 30),
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                        ),
                        child: Text(
                          'Clear all items',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        onPressed: () {
                          _deleteAll();
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        bottom: 10,
                      ),
                      decoration: BoxDecoration(
                        color: darkestGreen,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          minimumSize: Size(double.infinity, 30),
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                        ),
                        child: Text(
                          'Clear checklisted items',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        onPressed: () {
                          _deleteCompleted();
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        bottom: 10,
                      ),
                      decoration: BoxDecoration(
                        color: darkestGreen,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          minimumSize: Size(double.infinity, 30),
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                        ),
                        child: Text(
                          'Uncheck all items',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        onPressed: () {
                          _uncheckAll();
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }

  _deleteAll() {
    Provider.of<GroceryProvider>(context, listen: false).deleteAllGroceries();
  }

  _deleteCompleted() {
    Provider.of<GroceryProvider>(context, listen: false)
        .deleteAllCompletedGroceries();
  }

  _uncheckAll() {
    Provider.of<GroceryProvider>(context, listen: false).uncheckAllGroceries();
  }
}
