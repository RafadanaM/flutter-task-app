import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks_app/config/styles.dart';
import 'package:tasks_app/database/db_helper.dart';
import 'package:tasks_app/models/grocery.dart';
import 'package:tasks_app/widgets/grocery_list_view.dart';

class SecondPage extends StatelessWidget {
  static const routeName = '/second';
  @override
  Widget build(BuildContext context) {
    print('rendered');
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backgroundPrimary,
      body: Padding(
        padding: EdgeInsets.only(
            top: _height * 0.075, left: _width * 0.025, right: _width * 0.025),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Groceries',
              style: TextStyle(
                fontSize: 36.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            FlatButton(
              child: Container(
                height: 75.0,
                width: 75.0,
                color: darkGreen,
              ),
              onPressed: () {
                Provider.of<DBHelper>(context, listen: false)
                    .insertGrocery(Grocery(
                  title: 'Balls',
                ));
              },
            ),
            Expanded(
              child: GroceryListView(),
            ),
          ],
        ),
      ),
    );
  }
}
