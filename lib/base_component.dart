import 'package:flutter/material.dart';
import 'package:flutter_sample/wechart/WeCharMain.dart';

class ComponentApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //应用名称
      title: 'Flutter Demo',
      theme: ThemeData(
          //蓝色主题
          primarySwatch: Colors.cyan,
          splashColor: Color.fromRGBO(1, 0, 0, 0.0),
          highlightColor: Color.fromRGBO(1, 0, 0, 0.0)),
      routes: {
        "CommonWidget": (context) => CommonWidget(
            type: ModalRoute.of(context)?.settings.arguments as int),
        "WeChart": (context) => WeChartMainWidget(),
        "/":(context) => Component()
      },
      // home: Component(),
    );
  }
}

class Component extends StatefulWidget {
  @override
  State<Component> createState() => _ComponentState();
}

class _ComponentState extends State<Component> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("BaseComponent"),
        ),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            //iOS回弹效果
            physics: BouncingScrollPhysics(),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "CommonWidget", arguments: 1);
                    },
                    child: Text("文本按钮图片")),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "CommonWidget", arguments: 2);
                    },
                    child: Text("单选开关与复选框")),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "CommonWidget", arguments: 3);
                    },
                    child: Text("输入框及表格")),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "WeChart");
                    },
                    child: Text("仿微信"))
            ])));
  }
}

class CommonWidget extends StatelessWidget {
  const CommonWidget({Key? key, required this.type}) : super(key: key);
  final int type;

  @override
  Widget build(BuildContext context) {
    var typeMap = {1: "文本按钮图片", 2: "单选开关与复选框", 3: "输入框及表单"};
    return Scaffold(
        appBar: AppBar(
          title: Text(typeMap[type]!),
        ),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            //iOS回弹效果
            physics: BouncingScrollPhysics(),
            child: Column(children: [
              if (type == 1)
                TextBtnImgTestRoute()
              else if (type == 2)
                SwitchAndCheckBoxTestRoute()
              else if (type == 3)
                TextFieldAndFromTestRoute(),
            ])));
  }
}

class TextFieldAndFromTestRoute extends StatefulWidget {
  @override
  State<TextFieldAndFromTestRoute> createState() =>
      _TextFieldAndFromTestRouteState();
}

class _TextFieldAndFromTestRouteState extends State<TextFieldAndFromTestRoute> {
  var _unameController = TextEditingController();
  var _passwordController = TextEditingController();

  var focusNode1 = FocusNode();
  var focusNode2 = FocusNode();

  @override
  void initState() {
    super.initState();
    //监听文本变化
    _unameController.addListener(() {
      print("_unameController.addListener == ${_unameController.text}");
    });
    _passwordController.addListener(() {
      print("_passwordController.addListener == ${_passwordController.text}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //输入框
        TextField(
          autofocus: true,
          focusNode: focusNode1,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              labelText: "用户名",
              hintText: "用户名或邮箱",
              prefixIcon: Icon(Icons.person)),
          controller: _unameController,
          onChanged: (value) {
            print("onChanged == $value");
          },
          onSubmitted: (value) {
            print("controller == " + _unameController.text);
            print("onSubmitted == " + value);
          },
        ),
        TextField(
          focusNode: focusNode2,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
              labelText: "密码",
              hintText: "您的登陆密码",
              prefixIcon: Icon(Icons.lock)),
          obscureText: true,
          controller: _passwordController,
          onChanged: (value) {
            print("onChanged == $value");
          },
          onSubmitted: (value) {
            print("controller == " + _passwordController.text);
            print("onSubmitted == " + value);
          },
        ),
        Builder(builder: (context) {
          return Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    FocusScope.of(context).requestFocus(focusNode2);
                  },
                  child: Text("移动焦点")),
              ElevatedButton(
                  onPressed: () {
                    // 当所有编辑框都失去焦点时键盘就会收起
                    focusNode1.unfocus();
                    focusNode2.unfocus();
                  },
                  child: Text("关闭软键盘"))
            ],
          );
        })
      ],
    );
  }
}

///继承自StatefulWidget，但它们本身不会保存当前选中状态，选中状态都是由父组件来管理的。
///当Switch或Checkbox被点击时，会触发它们的onChanged回调，我们可以在此回调中处理选中状态改变逻辑。
class SwitchAndCheckBoxTestRoute extends StatefulWidget {
  @override
  State<SwitchAndCheckBoxTestRoute> createState() =>
      _SwitchAndCheckBoxTestRouteState();
}

class _SwitchAndCheckBoxTestRouteState
    extends State<SwitchAndCheckBoxTestRoute> {
  bool _switchSelected = false;
  bool _checkboxSelected = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Switch(
            value: _switchSelected,
            activeColor: Colors.deepPurpleAccent,
            onChanged: (value) {
              setState(() {
                _switchSelected = value;
              });
            }),
        Checkbox(
            value: _checkboxSelected,
            activeColor: Colors.red,
            onChanged: (value) {
              setState(() {
                _checkboxSelected = value ?? false;
              });
            })
      ],
    );
  }
}

class TextBtnImgTestRoute extends StatelessWidget {
  //字体库选择
  // static const textStyle = const TextStyle(
  //   fontFamily: "Raleway",
  // );
  //
  // static const textStylePkg =
  // const TextStyle(fontFamily: "Raleway", package: "my_package" //指定包名
  // );
  //
  // var buttonStyle = const Text(
  //   "text",
  //   style: textStyle,
  // );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 文本及样式
        Text(
          "Hello World",
          textAlign: TextAlign.start,
        ),
        Text("Hello World ! I am rivenLee !" * 3,
            maxLines: 2, overflow: TextOverflow.ellipsis),
        Text(
          "Hello Word",
          textScaleFactor: 1.5,
        ),
        Text(
          "Hello Word",
          style: TextStyle(
              color: Colors.cyan,
              fontSize: 18,
              height: 1.2,
              fontFamily: "Courier",
              background: Paint()..color = Colors.yellow,
              decoration: TextDecoration.underline,
              decorationStyle: TextDecorationStyle.dashed),
        ),
        Text.rich(TextSpan(children: [
          TextSpan(text: "Home: "),
          TextSpan(
            text: "https://flutterchina.club",
            style: TextStyle(color: Colors.blue),
          )
        ])),
        Padding(
            padding: const EdgeInsets.only(
                left: 0.0, top: 20.0, right: 0, bottom: 0),
            child: DefaultTextStyle(
                style: TextStyle(color: Colors.red, fontSize: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("hello world"),
                    Text("i am jack"),
                    Text(
                      "i am lucy",
                      style: TextStyle(color: Colors.teal, fontSize: 15),
                    )
                  ],
                ))),

        ///ElevatedButton、TextButton、OutlineButton都有一个icon 构造函数，通过它可以轻松创建带图标的按钮
        //ElevatedButton即"漂浮"按钮，它默认带有阴影和灰色背景。按下后，阴影会变大
        ElevatedButton(onPressed: () {}, child: Text("ElevatedButton")),
        //TextButton即文本按钮，默认背景透明并不带阴影。按下后，会有背景色
        TextButton(onPressed: () {}, child: Text("TextButton")),
        //OutlineButton默认有一个边框，不带阴影且背景透明。按下后，边框颜色会变亮、同时出现背景和阴影(较弱)
        OutlineButton(onPressed: () {}, child: Text("OutlineButton")),
        //IconButton是一个可点击的Icon，不包括文字，默认没有背景，点击后会出现背景
        IconButton(onPressed: () {}, icon: Icon(Icons.thumb_up)),

        Image(image: AssetImage("images/img_15day.png")),

        Image(
          image: NetworkImage(
              "https://avatars2.githubusercontent.com/u/20411648?s=460&v=4"),
          width: 100.0,
        ),
        Image.network(
          "https://avatars2.githubusercontent.com/u/20411648?s=460&v=4",
          width: 100.0,
        )
      ],
    );
  }
}
