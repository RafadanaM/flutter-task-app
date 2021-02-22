import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks_app/config/styles.dart';
import 'package:tasks_app/database/db_helper.dart';
import 'package:tasks_app/models/grocery.dart';
import 'package:tasks_app/widgets/grocery_list_view.dart';

class SecondPage extends StatefulWidget {
  static const routeName = '/second';

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  double _bottomPaddingKeyboard = 80;
  bool _isAllowed = false;
  TextEditingController groceryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // KeyboardVisibilityNotification().addNewListener(
    //   onChange: (bool visible) {
    //     if (visible) {
    //       setState(() {
    //         _bottomPaddingKeyboard = 0;
    //       });
    //     } else {
    //       _bottomPaddingKeyboard = 80;
    //     }
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backgroundPrimary,
      body: Padding(
        padding: EdgeInsets.only(
          top: _height * 0.075,
          left: _width * 0.025,
          right: _width * 0.025,
          bottom: _bottomPaddingKeyboard,
        ),
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
            // FlatButton(
            //   child: Container(
            //     height: 75.0,
            //     width: 75.0,
            //     color: darkGreen,
            //   ),
            //   onPressed: () {
            //     Provider.of<DBHelper>(context, listen: false)
            //         .insertGrocery(Grocery(
            //       title: 'Balls',
            //     ));
            //   },
            // ),
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
                              // validator: _checkTitle(groceryController.text),
                              controller: groceryController,
                              maxLines: 1,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'insert item..',
                                hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                            ),
                          ),
                          Container(
                            height: 30,
                            width: 30,
                            child: OutlineButton(
                              color: Colors.transparent,
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              onPressed: () {
                                _submit();
                              },
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 2,
                              ),
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
            // SizedBox(
            //   height: 80,
            // ),
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

      await Provider.of<DBHelper>(context, listen: false)
          .insertGrocery(newGrocery);

      groceryController.clear();
    }
  }

  _checkKeyboard() {
    if (MediaQuery.of(context).viewInsets.bottom == 0) {
      setState(() {
        _bottomPaddingKeyboard = 80;
      });
    } else {
      setState(() {
        _bottomPaddingKeyboard = 0;
      });
    }
  }
}
