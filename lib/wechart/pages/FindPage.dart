import 'package:flutter/material.dart';
import 'package:flutter_sample/wechart/custom/DIscoverCell.dart';
import 'package:flutter_sample/wechart/module/DiscoverItemModel.dart';

class FindPage extends StatefulWidget {
  const FindPage({Key? key}) : super(key: key);

  @override
  State<FindPage> createState() => _FindPageState();
}

class _FindPageState extends State<FindPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("发现", style: TextStyle(color: Colors.white70, fontSize: 15)),
        centerTitle: true,
        //透明度
        bottomOpacity: 0.0,
        //不显示返回键
        automaticallyImplyLeading: false,
        toolbarHeight: 50,
        backgroundColor: Colors.black,
        //状态栏字体颜色
        brightness: Brightness.dark,
      ),
      body: Container(
        color: Colors.black,
        child: ListView.builder(
            itemCount: k_discoverItems.length,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              var item = k_discoverItems[index];
              if (item == null) {
                return SizedBox(height: 5);
              } else {
                return DiscoverCell(item);
              }
            }),
      ),
    );
  }
}
