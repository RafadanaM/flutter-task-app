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
import 'package:tasks_app/widgets/custom_checkbox.dart';

class GroceryListView extends StatefulWidget {
  @override
  _GroceryListViewState createState() => _GroceryListViewState();
}

class _GroceryListViewState extends State<GroceryListView> {
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
                  child: Center(
                    child: Text(
                      "No groceries added yet.",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: lightGreen,
                      ),
                    )
                  ),
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
                                    horizontal: 8.0,
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
                                          decorationThickness: 3.0,
                                          color: snapshot.data[index].isCompleted
                                                  ? lightGreen
                                                  : darkGreen,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      CustomCheckbox(
                                            checkColor: backgroundPrimary,
                                            activeColor: darkGreen,
                                            borderColor: darkGreen,
                                            value: snapshot
                                                .data[index].isCompleted,
                                            onChanged: (value) =>
                                                Provider.of<GroceryProvider>(
                                                        context,
                                                        listen: false)
                                                    .completeGrocery(
                                                        snapshot.data[index]),
                                          ),
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
