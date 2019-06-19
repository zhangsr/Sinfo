import 'package:flutter/material.dart';
import 'info_list.dart';

class InfoTab extends StatelessWidget {
  final Future<InfoList> mInfoList;

  InfoTab({Key key, this.mInfoList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
            child: FutureBuilder(
                future: mInfoList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView(children: _getListData(snapshot));
                  } else if (snapshot.hasData) {
                    return Text("${snapshot.error}");
                  }
                  // By default, show a loading spinner
                  return CircularProgressIndicator();
                }));
  }

  _getListData(AsyncSnapshot<InfoList> snapshot) {
    List<Widget> widgets = [];
    for (int i = 0; i < snapshot.data.infoList.length; i++) {
      widgets.add(Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(snapshot.data.infoList.elementAt(i).title)));
    }
    return widgets;
  }
}
