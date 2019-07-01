import 'package:flutter/material.dart';
import 'dart:convert';
import 'info_list.dart';
import 'tab_info.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

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
  List<Widget> _widgetOptions = [];

  TabBarState() {
    _widgetOptions.add(InfoTab(mInfoList: fetchInfo()));
    _widgetOptions.add(Icon(Icons.search));
    _widgetOptions.add(Icon(Icons.person));
  }

  void onItemTapped(int index) {
    setState(() {
      mIndex = index;
    });
  }

  Future<InfoList> fetchInfo() async {
    // mark not callback in Dio
//    final response = await Dio().get("http://zhangshaoru.pythonanywhere.com/sinfos/?format=json");

    final response = await http.get("http://zhangshaoru.pythonanywhere.com/sinfos/?format=json");
    print('[Sinfo] response : ' + response.body);
    // find out decoder problem
    Utf8Decoder utf8decoder = new Utf8Decoder();
    return InfoList.fromJson(jsonDecode(utf8decoder.convert(response.bodyBytes)));
  }

  @override
  Widget build(BuildContext context) {
    var now = new DateTime.now();
    var formatter = new DateFormat('M月dd日');
    String formatted = formatter.format(now);

    return Scaffold(
        appBar: AppBar(
          title: Text(formatted),
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
