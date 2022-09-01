import 'package:flutter/material.dart';
import 'package:flutter_sample/wechart/module/MessageModel.dart';

class MessageCell extends StatefulWidget {
  MessageItem item;
  MessageCell(this.item);

  @override
  State<MessageCell> createState() => _MessageCellState();
}

class _MessageCellState extends State<MessageCell> {
  var _iconSize = 40.0;
  var _currentColor = Color(0xff191919);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        color: _currentColor,
        padding: EdgeInsets.fromLTRB(15, 10, 10, 10),
        child: Row(
          children: [
            Container(
              width: _iconSize,
              height: _iconSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                image: DecorationImage(
                    image: AssetImage(widget.item.ava.isEmpty?"images/icon_chart_group.png": widget.item.ava)),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
                child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.item.name,
                          style: TextStyle(fontSize: 14, color: Colors.white70),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                      SizedBox(height: 4),
                      Text(widget.item.msg,
                          style: TextStyle(fontSize: 12, color: Colors.white30),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis)
                    ],
            )),
            Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(widget.item.time,
                      style: TextStyle(fontSize: 11, color: Colors.white30),
                      textAlign: TextAlign.end),
                  SizedBox(height: 10),
                  Offstage(
                    offstage: widget.item.offstage,
                    child: Icon(Icons.visibility_off_outlined, size: 14, color: Colors.white30,),
                  )
                ],
              ),
          ],
        ),
      ),
      onTap: _handleTap,
      onTapDown: _handleTapDown,
      onTapCancel: _handleTap,
    );
  }

  void _handleTap() {
    setState(() {
      _currentColor = Color(0xff191919);
    });
  }

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _currentColor = Colors.white12;
    });
  }

}
