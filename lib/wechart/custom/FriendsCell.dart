import 'package:flutter/material.dart';

class FriendsCell extends StatefulWidget {
  final String name;
  final String? assetPath;
  final String? imageUrl;

  const FriendsCell(this.name, this.assetPath, this.imageUrl) : super();

  @override
  State<FriendsCell> createState() => _FriendsCellState();
}

class _FriendsCellState extends State<FriendsCell> {
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
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    image: null == widget.imageUrl
                        ? DecorationImage(image: AssetImage(widget.assetPath!))
                        : DecorationImage(
                            image: NetworkImage(widget.imageUrl!))),
              ),
              SizedBox(width: 15),
              Text(widget.name,
                  style: TextStyle(fontSize: 12, color: Colors.white70))
            ],
          ),
        ),
        onTap: _handleTap,
        onTapDown: _handleTapDown,
        onTapCancel: _handleTap);
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
