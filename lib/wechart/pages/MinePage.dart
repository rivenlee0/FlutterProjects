import 'package:flutter/material.dart';
import 'package:flutter_sample/wechart/custom/DIscoverCell.dart';
import 'package:flutter_sample/wechart/custom/MineHeaderView.dart';
import 'package:flutter_sample/wechart/module/DiscoverItemModel.dart';

class MinePage extends StatefulWidget {
  const MinePage({Key? key}) : super(key: key);

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, //不显示返回键
        toolbarHeight: 0,
        backgroundColor: Colors.black,
        brightness: Brightness.dark, //状态栏字体颜色
      ),
      body: Container(
          color: Colors.black,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: k_mineItems.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return MineHeaderView();
              } else {
                var item = k_mineItems[index - 1];
                if (item == null) {
                  return SizedBox(height: 5);
                } else {
                  return DiscoverCell(item);
                }
              }
          })),
    );
  }
}
