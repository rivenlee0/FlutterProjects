import 'package:flutter/material.dart';
import 'package:flutter_sample/wechart/module/MenuPageModel.dart';
import 'package:flutter_sample/wechart/pages/FindPage.dart';
import 'package:flutter_sample/wechart/pages/MessagePage.dart';
import 'package:flutter_sample/wechart/pages/MinePage.dart';

import 'pages/BottomMenuPage.dart';
import 'pages/FriendsPage.dart';


///仿微信主页面
class WeChartMainWidget extends StatefulWidget {

  const WeChartMainWidget({Key? key}) : super(key: key);

  @override
  State<WeChartMainWidget> createState() => _WeChartMainWidgetState();
}

var _menuPages = [
  MenuPageModel("微信", Icon(Icons.android_rounded), MessagePage()),
  MenuPageModel("通讯录", Icon(Icons.account_circle_rounded), FriendsPage()),
  MenuPageModel("发现", Icon(Icons.ad_units_rounded), FindPage()),
  MenuPageModel("我", Icon(Icons.person_rounded), MinePage()),
];

class _WeChartMainWidgetState extends State<WeChartMainWidget> {

  @override
  Widget build(BuildContext context) {
    return BottomMenuPage(pages: _menuPages);
  }

}
