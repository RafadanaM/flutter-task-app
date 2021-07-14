import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:tasks_app/config/styles.dart';
import 'package:tasks_app/database/db_helper.dart';
import 'package:tasks_app/models/grocery.dart';
import 'package:provider/provider.dart';

class GroceryListView extends StatefulWidget {
  @override
  _GroceryListViewState createState() => _GroceryListViewState();
}

class _GroceryListViewState extends State<GroceryListView> {
  final DateFormat formatter = DateFormat('dd MMMM yyyy');
  @override
  Widget build(BuildContext context) {
    return Consumer<DBHelper>(
      builder: (context, groceryData, child) {
        return FutureBuilder<List<Grocery>>(
            future: groceryData.groceries(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.length == 0) {
                  return Center(
                    child: Text("No Groceries"),
                  );
                }
                return ListView.separated(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              snapshot.data[index].title,
                              style: TextStyle(
                                decoration: snapshot.data[index].isCompleted
                                    ? TextDecoration.lineThrough
                                    : null,
                                color: darkGreen,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Theme(
                                data:
                                    ThemeData(unselectedWidgetColor: lightGreen),
                                child: RoundCheckBox(
                                  checkedColor: darkGreen,
                                  uncheckedColor: backgroundPrimary,
                                  borderColor: darkGreen,
                                  size: 28,
                                  isChecked: snapshot.data[index].isCompleted,
                                  checkedWidget: Icon(
                                    Icons.check,
                                    size: 20,
                                    color: backgroundPrimary,
                                  ),
                                  onTap: (value) => Provider.of<DBHelper>(
                                          context,
                                          listen: false)
                                      .completeGrocery(snapshot.data[index]),
                                )),
                          ],
                        ));
                    }
                    index -= 1;
                    return SizedBox(height: 35);
                  },
                  itemCount: snapshot.data.length + 1,
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            });
      },
    );
  }
}
