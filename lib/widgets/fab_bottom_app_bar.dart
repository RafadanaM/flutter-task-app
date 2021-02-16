import 'package:flutter/material.dart';
import 'package:tasks_app/screens/add_task_screen.dart';

//items class for FABBottomBar
//can turn it back to Icon class since it only needs IconData
class FABBottomAppBarItem {
  IconData iconData;
  FABBottomAppBarItem({this.iconData});
}

class FABBottomAppBar extends StatefulWidget {
  FABBottomAppBar({
    this.isSecond,
    this.items,
    this.height: 70.0,
    this.iconSize: 24.0,
    this.selectedIconSize: 24.0,
    this.backgroundColor,
    this.color,
    this.selectedColor,
    this.notchedShape,
    this.onTabSelected,
  }) {
    //can only be 2 or 4 items in the bottom navbar
    assert(this.items.length == 2 || this.items.length == 4);
  }
  final List<FABBottomAppBarItem> items;
  final bool isSecond;
  final double height;
  final double iconSize;
  final double selectedIconSize;
  final Color backgroundColor;
  final Color color;
  final Color selectedColor;
  final NotchedShape notchedShape;
  final ValueChanged<int> onTabSelected;
  @override
  _FABBottomAppBarState createState() => _FABBottomAppBarState();
}

class _FABBottomAppBarState extends State<FABBottomAppBar> {
  int _selectedIndex = 0;

  /*
  This method will build item of navbar
  @param FABBottomAppBarItem item : item of navbar
  @param int index : index of the item in navbar
  @param ValueChanged<int> onPressed : callback function for each item
  @return Expanded widget that can be pressed due to InkWell
   */
  Widget _buildTabItem(
      {FABBottomAppBarItem item, int index, ValueChanged<int> onPressed}) {
    /*
    changing the colour and size if the the current item is selected
    -better implementation might be needed since the code below will always be checked even if we don't implement selectedColor and selectedIconSize(unnecessary comparison)
     */
    Color color = _selectedIndex == index ? widget.selectedColor : widget.color;
    double size =
        _selectedIndex == index ? widget.selectedIconSize : widget.iconSize;

    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () => onPressed(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  item.iconData,
                  color: color,
                  size: size,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /*
  This method will build the middle tab so that the spacing of navbar is correct
  @return an empty SizedBox with the same height as the other navbar items
   */
  Widget _buildMiddleTabItem() {
    return widget.isSecond
        ? RawMaterialButton(
            onPressed: () {
              Navigator.pushNamed(context, AddTaskScreen.routeName);
            },
            elevation: 2.0,
            fillColor: Color(0xFFFF844C),
            child: Icon(
              Icons.add,
              size: 45.0,
              color: Colors.white,
            ),
            padding: EdgeInsets.all(4.0),
            shape: CircleBorder(),
          )
        : Expanded(
            child: SizedBox(
              height: widget.height,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: widget.iconSize,
                  )
                ],
              ),
            ),
          );
  }

  // SizedBox(
  // height: widget.height,
  // child: Column(
  // mainAxisSize: MainAxisSize.min,
  // mainAxisAlignment: MainAxisAlignment.center,
  // children: <Widget>[
  // SizedBox(
  // height: widget.iconSize,
  // )
  // ],
  // ),
  // ),

  /*
  This method will update the current selected index
  @param int index : the index value of the pressed item
   */
  _updateIndex(int index) {
    widget.onTabSelected(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //generate list of navbar items
    List<Widget> items = List.generate(widget.items.length, (int index) {
      return _buildTabItem(
        item: widget.items[index],
        index: index,
        onPressed: _updateIndex,
      );
    });
    //insert the middle empty item
    items.insert(items.length >> 1, _buildMiddleTabItem());
    return BottomAppBar(
      notchMargin: 7.5,
      shape: widget.notchedShape,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      ),
      color: widget.backgroundColor,
    );
  }
}
