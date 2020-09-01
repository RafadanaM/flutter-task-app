import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            top: _height * 0.075, left: _width * 0.05, right: _width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'My Tasks',
              style: TextStyle(
                fontSize: 36.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: _height * 0.025,
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 10.0,
                  );
                },
                itemBuilder: (context, index) {
                  return Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: Color(0xFF064B41),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                    ),
                    child: Center(
                      child: ListTile(
                        title: Text(
                          'Task Name',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          child: Text(
                            '6 September 1969',
                            style: TextStyle(
                                color: Color(0xFF73A99C), fontSize: 13.0),
                          ),
                        ),
                        isThreeLine: true,
                        trailing: Theme(
                          data: ThemeData(
                              unselectedWidgetColor: Color(0xFF73A99C)),
                          child: Checkbox(
                            value: false,
                            onChanged: (bool value) {},
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
