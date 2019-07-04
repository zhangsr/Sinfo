import 'package:flutter/material.dart';
import 'dart:convert';
import 'info.dart';
import 'info_list.dart';
import 'db.dart';
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
    var db = new DB();
    List<Info> infos = await db.infos(date : getTodayDate());
    if (infos.length > 0) {
      print('[Sinfo] load from db');
      return new InfoList(infoList: infos);
    } else {
      print('[Sinfo] load from network');
      final response = await http.get("http://zhangshaoru.pythonanywhere.com/sinfos/?format=json");
      print('[Sinfo] response : ' + response.body);
      // find out decoder problem
      Utf8Decoder utf8decoder = new Utf8Decoder();
      var infoList = InfoList.fromJson(jsonDecode(utf8decoder.convert(response.bodyBytes)));
      for (int i = 0; i < infoList.infoList.length; i++) {
        db.insertInfo(infoList.infoList[i]);
      }
      return infoList;
    }
  }

  String getTodayDate() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyyMMdd');
    return formatter.format(now);
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
            BottomNavigationBarItem(icon: Icon(Icons.view_list), title: Text('订阅')),
            BottomNavigationBarItem(icon: Icon(Icons.search), title: Text('发现')),
            BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('我的')),
          ],
          onTap: onItemTapped,
          currentIndex: mIndex,
        ));
  }

}
