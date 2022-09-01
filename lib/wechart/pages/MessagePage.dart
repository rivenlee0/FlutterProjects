import 'package:flutter/material.dart';
import 'package:flutter_sample/wechart/custom/MessageCell.dart';
import 'package:flutter_sample/wechart/module/MessageModel.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              Text("微信", style: TextStyle(color: Colors.white70, fontSize: 15)),
          centerTitle: true,
          bottomOpacity: 0.0,
          //透明度
          automaticallyImplyLeading: false,
          //不显示返回键
          toolbarHeight: 50,
          backgroundColor: Colors.black,
          brightness: Brightness.dark,
          //状态栏字体颜色
          actions: [_popupMenuButton(context)],
        ),
        body: Container(
          color: Color(0xff191919),
          child: ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                //最后一行没分割线， 所以搞个歪招；
                if (index < messageArray.length) {
                  var item = messageArray[index];
                  return MessageCell(item);
                } else {
                  return SizedBox();
                }
              },
              separatorBuilder: (context, index) {
                return Divider(
                  height: 0.5,
                  indent: 65,
                  color: Colors.white10,
                );
              },
              itemCount: messageArray.length + 1),
        ));
  }

  var _popupMenuItemMap = {
    "发起群聊": Icons.people_rounded,
    "添加朋友": Icons.add_to_photos_rounded,
    "扫一扫": Icons.waves_rounded,
    "收付款": Icons.widgets_rounded,
  };

  var _popupMenuBtnColor = 0xff494949;

  PopupMenuButton _popupMenuButton(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(Icons.search_rounded, color: Colors.white70),
      iconSize: 22,
      color: Color(_popupMenuBtnColor),
      offset: Offset(30, 40),
      elevation: 0,
      onSelected: _popupMenuItemRouterPage,
      itemBuilder: (BuildContext context) {
        List<PopupMenuItem> popupMenuItemList = [];
        _popupMenuItemMap.entries.forEach((element) {
          popupMenuItemList.add(PopupMenuItem(
              value: element.key,
              child: _popupMenuItemCell(element.key, element.value),
              height: 30,
              padding: EdgeInsets.zero));
        });
        return popupMenuItemList;
      },
    );
  }

  Container _popupMenuItemCell(String text, IconData iconData) {
    return Container(
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(width: 15),
                Icon(iconData, color: Colors.white70, size: 18),
                SizedBox(width: 5),
                Text(text, style: TextStyle(fontSize: 14, color: Colors.white70))
              ],
            ),
            Divider(
              thickness: 1,
              indent: 38,
              color: Colors.white10,
            )
          ],
    ));
  }

  void _popupMenuItemRouterPage(dynamic d) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(d),
        ),
      );
    }));
  }
}
