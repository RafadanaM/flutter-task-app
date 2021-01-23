import 'package:flutter/material.dart';
import 'package:tasks_app/models/grocery_data.dart';
import 'package:provider/provider.dart';

class GroceryListView extends StatefulWidget {
  @override
  _GroceryListViewState createState() => _GroceryListViewState();
}

class _GroceryListViewState extends State<GroceryListView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GroceryData>(
      builder: (context, taskData, child) {
        return ListView.separated(
          padding: EdgeInsets.symmetric(vertical: 10),
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 2.0,
              width: MediaQuery.of(context).size.width * 0.85,
            );
          },
          // itemBuilder: (context, index) {
          //   return Container(
          //     height: 50,
          //     child: Center(
          //       child: ListTile(
          //         title: Text(
          //           taskTitle,
          //           style: TextStyle(
          //             color: Colors.white,
          //             fontSize: 24,
          //             fontWeight: FontWeight.bold,
          //           ),
          //         ),
          //         subtitle: Padding(
          //           padding: EdgeInsets.symmetric(vertical: 5.0),
          //           child: Text(
          //             date,
          //             style:
          //                 TextStyle(color: Color(0xFF73A99C), fontSize: 13.0),
          //           ),
          //         ),
          //         isThreeLine: true,
          //         onTap: onTap,
          //         trailing: Theme(
          //           data: ThemeData(unselectedWidgetColor: Color(0xFF73A99C)),
          //           child: Checkbox(
          //             value: isChecked,
          //             onChanged: onChanged,
          //           ),
          //         ),
          //       ),
          //     ),
          //   );
          itemBuilder: (context, index) {
            return Container(
              height: 50,
              child: Center(
                child: ListTile(
                  title: Text(
                    taskTitle,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  isThreeLine: true,
                  onTap: onTap,
                  trailing: Theme(
                    data: ThemeData(unselectedWidgetColor: Color(0xFF73A99C)),
                    child: Checkbox(
                      value: isChecked,
                      onChanged: onChanged,
                    ),
                  ),
                ),
              ),
            );
          },
          // itemCount: taskData.tasks.length,
        );
      },
    );
  }
}
