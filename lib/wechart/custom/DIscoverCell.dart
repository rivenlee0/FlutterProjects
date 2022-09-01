import 'package:flutter/material.dart';
import 'package:flutter_sample/wechart/module/DiscoverItemModel.dart';


class DiscoverCell extends StatefulWidget {

  DiscoverItem item;
  DiscoverCell(this.item) : super();

  @override
  State<DiscoverCell> createState() => _DiscoverCellState();
}


class _DiscoverCellState extends State<DiscoverCell> {

  var _currentColor = Color(0xff191919);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentColor = Color(0xff191919);
        });
      },
      onTapDown: (detail) {
        setState(() {
          _currentColor = Colors.white12;
        });
      },
      onTapCancel: () {
        setState(() {
          _currentColor = Color(0xff191919);
        });
      },
      child: Container(
          height: 44,
          color: _currentColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(width: 12),
                  Image.asset(widget.item.iconName, width: 18, height: 18),
                  SizedBox(width: 15),
                  Text(widget.item.title, style: TextStyle(color: Colors.white70))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset("images/icon_arrow.png", width: 15, height: 15),
                  SizedBox(width: 8)
                ],
              )
            ],
          ),
        ),
    );
  }
  //Text(widget.item.title, style: TextStyle(
//           color: Colors.white70
//         ),
}
