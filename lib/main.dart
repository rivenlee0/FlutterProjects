//导入MaterialUI组件库

import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';

import 'package:flutter/cupertino.dart';

import 'package:english_words/english_words.dart';
import 'package:flutter_sample/base_component.dart';


// main函数使用了(=>)符号，这是 Dart 中单行函数或方法的简写。
void main() => runApp(ComponentApp());
// void main() {
//   runApp(MyApp());
// }

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //应用名称
      title: 'Flutter Demo',
      theme: ThemeData(
        //蓝色主题
          primarySwatch: Colors.cyan,
          primaryColor: Colors.green,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent
      ),
      //应用首页路由
      // home: MyHomePage(title: 'Home Page'),
      routes: {
        "new_page": (context) => NewRoute(),
        "router_test_route2": (context) => RouterTestRoute2(),
        "tip_page": (context) => TipRoute(text: ModalRoute.of(context)?.settings.arguments as String?),
        // "/":(context) => GetStateObjectRoute(),
        "/": (context) => MyHomePage(title: "Home Page")
      },
      // home: GetStateObjectRoute(),
    );
  }

  @override
  StatelessElement createElement() => StatelessElement(this);
}


//StatefulWidget有状态的组件
//StatefulWidget - 1.Stateful widget 2.State
class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;//用于记录按钮点击的总次数

  void _incrementCounter() {
    setState(() {
      _counter++;
    });

    // setState(() => _counter++);
  }

  @override
  Widget build(BuildContext context) {
    //Scaffold页面脚手架
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      //Center可以将其子组件树对其到屏幕中心
      // body: CounterWidget(),
      body: Container(
        //Column将其所有子组件沿屏幕垂直方向一次排列
        color: Colors.red,
        width: 200,
        height: 200,
        child: Column(
          children: <Widget>[
            Text(
              'You have pushed the button this many times:'
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            RandomWordWidget(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}


class Echo extends StatelessWidget {
  const Echo({
    Key? key,
    required this.text,
    this.backgroundColor = Colors.grey
  }):super(key: key);

  final String text;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: backgroundColor,
        child: Text(text,
            style: Theme.of(context).textTheme.headline4),
      ),
    );
  }

}

class ContextRouter extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var textWidget = Text("声明Widget");
    return Scaffold(
      appBar: AppBar(
        title: textWidget
      ),
      body: Container(
        child: Builder(builder: (context) {
          // var scaffold = context.findAncestorWidgetOfExactType<Scaffold>()!;
          // return (scaffold.appBar as AppBar).title!;
          return textWidget;
        }),
      ),
    );
  }

}

class CounterWidget extends StatefulWidget {

  const CounterWidget({Key? key, this.initValue = 0});
  final int initValue;

  @override
  State<StatefulWidget> createState() => _CounterWidgetState();

}

class _CounterWidgetState extends State<CounterWidget> {

  int _counter = 0;

  /// StateWidget插入到widget树时首先 @initState方法会被调用
  /// initState -> didChangeDependencies -> build
  @override
  void initState(){
    // 注意：在继承StatefulWidget重写其方法时，对于包含@mustCallSuper标注的父类方法，都要在子类方法中调用父类方法。
    super.initState();
    _counter = widget.initValue;
    print("initState");
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      body: Center(
        child: TextButton(
          child: Text("$_counter"),
          onPressed: () => setState(
              () => ++_counter,
          )
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(covariant CounterWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget");
  }

  /// widget树中移除对应组件， 在热重新，
  /// reassemble -> deactivate -> dispose
  @override
  void deactivate() {
    super.deactivate();
    print("deactivate");
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }

  /// 热重载 时 initState 和didChangeDependencies都没有被调用；
  /// reassemble -> didUpdateWidget -> build
  @override
  void reassemble() {
    super.reassemble();
    print("reassemble");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies");
  }

}


class GetStateObjectRoute extends StatefulWidget {
  const GetStateObjectRoute({Key? key}) : super(key: key);

  @override
  State<GetStateObjectRoute> createState() => _GetStateObjectRouteState();
}

class _GetStateObjectRouteState extends State<GetStateObjectRoute> {

  //通过GlobalKey获取State对象
  static GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text("子树中获取State对象")
      ),
      body: Center(
        child: Column(
          children: [
            Builder(builder: (context) {
              return ElevatedButton(onPressed: (){
                var _state = context.findAncestorStateOfType<ScaffoldState>()!;
                _state.openDrawer();
              },
                  child: Text("打开抽屉菜单1"));
            }),
            Builder(builder: (context) {
              return ElevatedButton(onPressed: (){
                // 直接通过of静态方法来获取ScaffoldState
                ScaffoldState _state = Scaffold.of(context);
                _state.openDrawer();
              },
                  child: Text("打开抽屉菜单2"));
            }),
            Builder(builder: (context) {
              return ElevatedButton(onPressed: (){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("我是SnackBar")));
              },
                  child: Text("显示SnackBar"));
            }),
            Builder(builder: (context) {
              return ElevatedButton(onPressed: (){
                _globalKey.currentState?.openDrawer();
              },
                  child: Text("打开抽屉开关3"));
            }),
            TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    //MaterialPageRoute 构造函数
                    // builder 是一个WidgetBuilder类型的回调函数，它的作用是构建路由页面的具体内容，返回值是一个widget。我们通常要实现此回调，返回新路由的实例。
                    // settings 包含路由的配置信息，如路由名称、是否初始路由（首页）。
                    // maintainState：默认情况下，当入栈一个新路由时，原来的路由仍然会被保存在内存中，如果想在路由没用的时候释放其所占用的所有资源，可以设置maintainState为 false。
                    // fullscreenDialog表示新的路由页面是否是一个全屏的模态对话框，在 iOS 中，如果fullscreenDialog为true，新页面将会从屏幕底部滑入（而不是水平方向）。
                    return NewRoute();
                    //通过路由命名方式启动
                    Navigator.pushNamed(context, "new_page");
                  }));
                },
                child: Text("open new route")),
            TextButton(
                onPressed: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //   return RouterTestRoute2();
                  // }));
                  //通过路由命名方式启动
                  // Navigator.pushNamed(context, "router_test_route2");
                  Navigator.of(context).pushNamed("router_test_route2", arguments: "This is a AppBar");
                  // Navigator.pushNamed(context, "tip_page");
                },
                child: Text("open new route with params")),
          ],
        ),
      ),
      drawer: Drawer(),
    );
  }

}

/// StatelessWidget 和 StatefulWidget 都是用于组合其它组件的，它们本身没有对应的 RenderObject。Flutter
/// 组件库中的很多基础组件都不是通过StatelessWidget 和 StatefulWidget 来实现的，比如 Text 、Column、Align等
/// ，就好比搭积木，StatelessWidget 和 StatefulWidget 可以将积木搭成不同的样子，但前提是得有积木，而这些积木
/// 都是通过自定义 RenderObject 来实现的。实际上Flutter 最原始的定义组件的方式就是通过定义RenderObject 来实现，
/// 而StatelessWidget 和 StatefulWidget 只是提供的两个帮助类。
///
/// 很简单，就是帮 widget 实现了createElement 方法，它会为组件创建一个 类型为 LeafRenderObjectElement 的 Element对象。
/// 如果自定义的 widget 可以包含子组件，则可以根据子组件的数量来选择继承SingleChildRenderObjectWidget 或 MultiChildRenderObjectWidget
/// ，它们也实现了createElement() 方法，返回不同类型的 Element 对象。
class CustomWidget extends LeafRenderObjectWidget {

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderCustomObject();
  }

  @override
  void updateRenderObject(BuildContext context, covariant RenderObject renderObject) {
    // 更新RenderObject
    super.updateRenderObject(context, renderObject);
  }

}

class RenderCustomObject extends RenderBox {

  @override
  void performLayout() {
    // 实现布局逻辑
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    // 实现绘制
  }

}
/// 状态管理
/// TapBoxA管理自身状态
class TapBoxA extends StatefulWidget {

  @override
  State<TapBoxA> createState() => _TapBoxAState();
}

class _TapBoxAState extends State<TapBoxA> {
  bool _active = false;

  void _handleTop() {
    setState(() {
      _active = !_active;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTop,
      child: Container(
        child: Center(
          child: Text(
            _active? "Active": "Inactive",
            style: TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: _active? Colors.lightGreen[700]: Colors.grey[600]
        ),
      ),
    );
  }
}

///TapBoxB 类:
/// 继承StatelessWidget类，因为所有状态都由其父组件处理。
/// 当检测到点击时，它会通知父组件。
///
class ParentWidget extends StatefulWidget {

  @override
  State<ParentWidget> createState() => _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget> {
  bool _active = false;

  void _handleTopBoxChanged(bool _active) {
    setState(() {
      this._active = _active;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TapBoxB(active: _active, onChanged: _handleTopBoxChanged);
  }
}

class TapBoxB extends StatelessWidget {

  const TapBoxB({Key? key, this.active: false , required this.onChanged}) : super(key: key);

  final bool active;
  final ValueChanged<bool> onChanged;

  void _handleTop() {
    onChanged(!active);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTop,
      child: Container(
        child: Center(
          child: Text(
            active? "Active": "Inactive",
            style: TextStyle(fontSize: 32.0, color: Colors.white)
          ),
        ),
        width: 200,
        height: 200,
        decoration: BoxDecoration(
            color: active? Colors.lightGreen[700]: Colors.grey[600]
        ),
      ),
    );
  }
}

///混合状态管理
class ParentWidgetC extends StatefulWidget {

  @override
  State<ParentWidgetC> createState() => _ParentWidgetCState();
}

class _ParentWidgetCState extends State<ParentWidgetC> {
  bool _active = false;

  void _handleTapBoxChanged(bool _active){
    setState(() {
      this._active = _active;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TapBoxC(active: _active, onChanged: _handleTapBoxChanged);
  }

}

class TapBoxC extends StatefulWidget {
  const TapBoxC({Key? key, this.active = false, required this.onChanged}) : super(key: key);
  final bool active;
  final ValueChanged<bool> onChanged;

  @override
  State<TapBoxC> createState() => _TapBoxCState();
}

class _TapBoxCState extends State<TapBoxC> {
  bool _highlight = false;

  void _handleTapDown(TapDownDetails details){
    setState(() {
      _highlight = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTapCancel() {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTap() {
    widget.onChanged(!widget.active);
  }
  @override
  Widget build(BuildContext context) {
    //在按下时添加绿色边框，当抬起时，取消高亮
    return GestureDetector(
      onTapDown: _handleTapDown, //处理按下事件
      onTapUp: _handleTapUp, //处理抬起事件
      onTap: _handleTap,
      onTapCancel: _handleTapCancel,
      child: Container(
        child: Center(
          child: Text(
            widget.active? "C Active": "C Inactive",
            style: TextStyle(fontSize: 32.0, color: Colors.white)
          ),
        ),
        width: 200.0,
        height: 200.0,
        decoration: BoxDecoration(
          color: widget.active? Colors.lightGreen[700]: Colors.grey[600],
          border: _highlight? Border.all(color:  Colors.teal, width: 10,): null
        ),
      ),

    );
  }
}

class NewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Route"),
      ),
      body: Center(
        child: Text("This is new route"),
      ),
    );
  }
}

/// 路由管理
class TipRoute extends StatelessWidget {

  const TipRoute({Key? key, required this.text}) : super(key: key);

  final String? text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("提示"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              Text(text??"flutter 空默认"),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, "return params");
                  },
                  child: Text("返回"))
            ],
          ),
        ),
      ),
    );
  }
}

class RouterTestRoute extends StatelessWidget {
  const RouterTestRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ElevatedButton(
        onPressed: () async {
          // 打开 TipRoute，并等待返回结果
          var result = await Navigator.push(context,
              MaterialPageRoute(builder: (context) {
            return TipRoute(text: "我是传递参数");
          }));
          print("我是传递参数 $result");
        },
        child: Text("打开提示页"),
      ),
    ));
  }
}

class RouterTestRoute2 extends StatefulWidget {

  const RouterTestRoute2({Key? key}) : super(key: key);

  @override
  State<RouterTestRoute2> createState() => _RouterTestRoute2State();
}

class _RouterTestRoute2State extends State<RouterTestRoute2> {
  var result;
  void _handleResult(dynamic result){
    setState(() {
      this.result = result;
    });
  }

  @override
  Widget build(BuildContext context) {

    var args = ModalRoute.of(context)?.settings.arguments as String?;

    return Scaffold(
      appBar: AppBar(
        title: Text(args??""),
      ),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              // 打开 TipRoute，并等待返回结果
              result = await Navigator.of(context).pushNamed("tip_page", arguments: "我是传递参数");
              // result = await Navigator.push(context,
              //     MaterialPageRoute(builder: (context) {
              //       return TipRoute(text: "我是传递参数");
              //     }));
              print("我是传递参数 $result");
              _handleResult(result);
            },
            child: Text("打开提示页${result??""}"),
          ),
        ));
  }
}

/// 使用english_words包来生成随机字符串。
class RandomWordWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var wordPair = WordPair.random();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(wordPair.toString()),
    );
  }
}


