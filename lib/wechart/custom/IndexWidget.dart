import 'package:flutter/material.dart';

class IndexWidget extends StatefulWidget {

  final Function(String keyStr) indexChanged;

  const IndexWidget({Key? key, required this.indexChanged}) : super(key: key);

  @override
  State<IndexWidget> createState() => _IndexWidgetState();
}

class _IndexWidgetState extends State<IndexWidget> {
  final double _itemHeight = 15.0;
  var _showQiPao = false;
  var _indexBackgroundColor = Color.fromRGBO(0, 0, 0, 0.0);
  var _textColor = Colors.black;
  var _qiPaoText = "";
  var _alignmentY = 0.0;
  //start -1.05 end 1.05
  final double ido = 2.1 /(indexStringArr.length - 1);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          height: _itemHeight * indexStringArr.length,
          color: Colors.red,
              child: Row(
                children: [
                  _showQiPao ? _loadLeftQiPao() : SizedBox(),
                  GestureDetector(
                      onVerticalDragDown: (detail) {
                        print("localPosition.dy == ${detail.localPosition.dy}   globalPosition.dy == ${detail.globalPosition.dy}");
                        _drag(detail.localPosition.dy, detail.globalPosition.dy);
                      },
                      onVerticalDragUpdate: (detail) {
                        print("onVerticalDragUpdate");
                        setState(() {
                          _showQiPao = true;
                        });
                        _drag(detail.localPosition.dy, detail.globalPosition.dy);
                      },
                      onVerticalDragEnd: (detail) {
                        print("onVerticalDragEnd");
                        setState(() {
                          _showQiPao = false;
                        });
                      },
                      child: Container(
                          // color: _indexBackgroundColor,
                          color: Colors.green,
                          child: Column(
                            children: _loadIndexWidget(),
                          )
                      )
                  )
                ],
            ),
      ));
  }

  List<Widget> _loadIndexWidget() {
    List<Widget> _itemWidgetList = [];
    indexStringArr.forEach((element) {
      _itemWidgetList.add(Container(
        height: _itemHeight,
        child: Text(element, style: TextStyle(color: _textColor, fontSize: 12)),
      ));
    });
    return _itemWidgetList;
  }

  Widget _loadLeftQiPao() {
    var widget = Container(
      color: Colors.blue,
      margin: EdgeInsets.only(right: 16),
      width: 54,
      child: Align(
        alignment: Alignment(0.0, _alignmentY),
        child: Container(
            height: 30,
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("images/qipao.png"))),
            child: Align(
              alignment: Alignment(-0.12, 0.0),
              child: Text(_qiPaoText),
            )),
      ),
    );
    return widget;
  }

  void _drag(double localY, double globalY) {
    var index = _getIndexFrom(localY);
    index = index.clamp(0, indexStringArr.length - 1);
    setState(() {
      _qiPaoText = indexStringArr[index];
      //start -1.05 end 1.05
      _alignmentY = -1.05 + index * ido;
    });
    widget.indexChanged(_qiPaoText);
  }

  /// 根据手势获取下标
  int _getIndexFrom(double y) {
    double height = _itemHeight;
    return y ~/ height;
  }
}

const List<String> indexStringArr = [
  '↑',
  '☆',
  'A',
  'B',
  'C',
  'D',
  'E',
  'F',
  'G',
  'H',
  'I',
  'J',
  'K',
  'L',
  'M',
  'N',
  'O',
  'P',
  'Q',
  'R',
  'S',
  'T',
  'U',
  'V',
  'W',
  'X',
  'Y',
  'Z'
];
