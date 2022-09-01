import 'package:flutter/material.dart';

class MineHeaderView extends StatefulWidget {
  const MineHeaderView({Key? key}) : super(key: key);

  @override
  State<MineHeaderView> createState() => _MineHeaderViewState();
}

class _MineHeaderViewState extends State<MineHeaderView> {
  
  final double _iconSize = 54;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      padding: EdgeInsets.only(left: 18, right: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: _iconSize,
            height: _iconSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(image: AssetImage("images/icon_chart_group.png")),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("爱吃大蒜😋", style: TextStyle(color: Colors.white70, fontSize: 18)),
                Text("rivenlee0@gmail.com", style: TextStyle(color: Colors.white30, fontSize: 12))
              ],
            ),
          )
        ],
      ),
    );
  }
}
