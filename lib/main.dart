import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() => runApp(new Main());

class Main extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StatefulTabBar(),
    );
  }
}

class StatefulTabBar extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return TabBarState();
  }

}

class TabBarState extends State<StatefulTabBar> {
  int mIndex = 0;
  static const List<Widget> _widgetOptions = [
    Icon(Icons.archive),
    Icon(Icons.search),
    Icon(Icons.person),
  ];

  void onItemTapped(int index) {
    setState(() {
      mIndex = index;
    });
    testHttp(index);
  }

  void testHttp(int index) async {
    try {
      Response response = await Dio().get("http://zhangshaoru.pythonanywhere.com/?format=json");
      print(response);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sinfo'),
        ),
        body: Center(
          child: _widgetOptions.elementAt(mIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.archive), title: Text('Info')),
            BottomNavigationBarItem(icon: Icon(Icons.search), title: Text('Discover')),
            BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('User')),
          ],
          onTap: onItemTapped,
          currentIndex: mIndex,
        ));
  }

}
