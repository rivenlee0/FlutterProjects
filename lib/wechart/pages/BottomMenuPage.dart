import 'package:flutter/material.dart';
import 'package:flutter_sample/wechart/module/MenuPageModel.dart';

class BottomMenuPage extends StatefulWidget {
  final List<MenuPageModel> pages;

  const BottomMenuPage({Key? key, required this.pages}) : super(key: key);

  @override
  State<BottomMenuPage> createState() => _BottomMenuPageState();
}

class _BottomMenuPageState extends State<BottomMenuPage> {
  List<BottomNavigationBarItem> bottomNavItems = [];
  List<Widget> bottomNavPages = [];
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    if (bottomNavItems.isEmpty) {
      widget.pages.forEach((element) {
        bottomNavItems.add(
            BottomNavigationBarItem(label: element.title, icon: element.icon));
        bottomNavPages.add(element.widget);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return buildBottomTabScaffold();
  }

  Widget buildBottomTabScaffold() {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavItems,
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: _changePage,
        selectedFontSize: 10.0,
        unselectedFontSize: 10.0,
        selectedItemColor: Colors.green[600],
        unselectedItemColor: Colors.white70,
        backgroundColor: Color(0xff191919),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: bottomNavPages,
      ),
    );
  }

  void _changePage(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }
}
