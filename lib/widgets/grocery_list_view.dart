import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:tasks_app/config/styles.dart';
import 'package:tasks_app/database/db_helper.dart';
import 'package:tasks_app/models/grocery.dart';
import 'package:provider/provider.dart';
import 'package:tasks_app/models/grocery_provider.dart';

class GroceryListView extends StatefulWidget {
  @override
  _GroceryListViewState createState() => _GroceryListViewState();
}

class _GroceryListViewState extends State<GroceryListView> {
  final DateFormat formatter = DateFormat('dd MMMM yyyy');
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<GroceryProvider>(context, listen: false).groceries,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            if (snapshot.connectionState == ConnectionState.done) {
              return Consumer<GroceryProvider>(
                  child: Center(child: Text("No Groceries")),
                  builder: (context, groceryProvider, child) => groceryProvider
                              .groceriesCount <=
                          0
                      ? child
                      : ListView.separated(
                          padding: EdgeInsets.only(
                            bottom: 22,
                          ),
                          separatorBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: EdgeInsets.zero,
                              padding: EdgeInsets.zero,
                              height: 2.0,
                              width: MediaQuery.of(context).size.width * 0.8,
                              color: darkGreen,
                            );
                          },
                          itemBuilder: (context, index) {
                            if (index < snapshot.data.length) {
                              return Container(
                                  height: 50,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        snapshot.data[index].title,
                                        style: TextStyle(
                                          decoration:
                                              snapshot.data[index].isCompleted
                                                  ? TextDecoration.lineThrough
                                                  : null,
                                          color: darkGreen,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Theme(
                                          data: ThemeData(
                                              unselectedWidgetColor:
                                                  lightGreen),
                                          child: RoundCheckBox(
                                            checkedColor: darkGreen,
                                            uncheckedColor: backgroundPrimary,
                                            borderColor: darkGreen,
                                            size: 28,
                                            isChecked: snapshot
                                                .data[index].isCompleted,
                                            checkedWidget: Icon(
                                              Icons.check,
                                              size: 20,
                                              color: backgroundPrimary,
                                            ),
                                            onTap: (value) =>
                                                Provider.of<DBHelper>(context,
                                                        listen: false)
                                                    .completeGrocery(
                                                        snapshot.data[index]),
                                          )),
                                    ],
                                  ));
                            }
                            index -= 1;
                            return SizedBox(height: 35);
                          },
                          itemCount: snapshot.data.length + 1,
                        ));
            }
            return Container(
              width: 0.0,
              height: 0.0,
            );
          }
        });
  }
}
