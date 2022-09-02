import 'package:flutter/material.dart';
import 'package:flutter_sample/wechart/custom/FriendsCell.dart';
import 'package:flutter_sample/wechart/custom/IndexWidget.dart';
import 'package:flutter_sample/wechart/module/FriendsPageModel.dart';
import 'package:grouped_list/grouped_list.dart';

class FriendsPage extends StatefulWidget {
  const FriendsPage({Key? key}) : super(key: key);

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  var _dataMap;
  var _keys;

  var _controller = ScrollController();

  var jumpOffset = 0.0;
  var friendsDataList = [];

  @override
  void initState() {
    super.initState();
    //定义排序规则
    int i = 0;
    friendsTopDatas.forEach((element) {
      element.sort = i++;
    });
    friendsDataList.addAll(friendsTopDatas);
    friendsDataList.addAll(friendsDatas);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text("通讯录", style: TextStyle(color: Colors.white70, fontSize: 15)),
        centerTitle: true,
        bottomOpacity: 0.0,
        //透明度
        automaticallyImplyLeading: false,
        //不显示返回键
        toolbarHeight: 50,
        backgroundColor: Colors.black,
        brightness: Brightness.dark, //状态栏字体颜色
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.black,
            child: _createGroupedListView(),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            right: 0,
            child: IndexWidget(indexChanged: (keyStr) {
              print("indexString == $keyStr");
              print("jumpOffset == $jumpOffset");
              ///😭T😭T😭///
              _controller.jumpTo(jumpOffset);
              jumpOffset += 0.5;
              // var keys = getKeys();
              // var index = keys.indexOf(indexString);
              // _controller.jumpTo(index);
              // var a = _controller.position;
            }),
          ),
        ],
      ),
    );
  }

  GroupedListView _createGroupedListView() {
    return GroupedListView(
      controller: _controller,
      physics: BouncingScrollPhysics(),
      elements: friendsDataList,
      groupBy: (element) => element.indexLetter,
      groupComparator: (value1, value2) => value2.compareTo(value1),
      itemComparator: (item1, item2) {
        if (item1.sort == null && item2.sort == null) {
          return -(item1.name.compareTo(item2.name));
        } else {
          return -(item1.sort.compareTo(item2.sort));
        }
      },
      order: GroupedListOrder.DESC,
      useStickyGroupSeparators: false,
      // stickyHeaderBackgroundColor: Colors.black,
      groupHeaderBuilder: (element) {
        if (element.indexLetter == "*") {
          return SizedBox();
        }
        return Padding(
          padding: EdgeInsets.all(10),
          child: Text(element.indexLetter,
              style: TextStyle(fontSize: 12, color: Colors.white70)),
        );
      },
      // groupSeparatorBuilder: (value) {
      //   return Padding(
      //     padding: EdgeInsets.all(10),
      //     child: Text(value,
      //         style: TextStyle(fontSize: 12, color: Colors.white70)),
      //   );
      // },
      indexedItemBuilder: (context, element, index) {
        return FriendsCell(element.name, element.assetPath, element.imageUrl);
      },
      separator: SizedBox(height: 0.5),
    );
  }

  @deprecated
  Map<String, List<Friends>> getMapFrom(List<Friends> sender) {
    var map = Map<String, List<Friends>>();
    sender.forEach((model) {
      var tempArr = map[model.indexLetter];
      if (null == tempArr) {
        tempArr = [];
      }
      tempArr.add(model);
      map[model.indexLetter ?? ""] = tempArr;
    });
    return map;
  }

  @deprecated
  Map<String, List<Friends>> getDataMap() {
    if (null == _dataMap) {
      _dataMap = getMapFrom(friendsDatas);
    }
    return _dataMap;
  }

  @deprecated
  List<String> getKeys() {
    if (null == _keys) {
      _keys = getDataMap().keys.toList();
      _keys.sort((a, b) => a.compareTo(b));
    }
    return _keys;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
