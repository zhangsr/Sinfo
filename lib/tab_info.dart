import 'package:flutter/material.dart';
import 'info_list.dart';
import 'package:url_launcher/url_launcher.dart';

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
          }),
    );
  }

  _getListData(AsyncSnapshot<InfoList> snapshot) {
    List<Widget> widgets = [];
    for (int i = 0; i < snapshot.data.infoList.length; i++) {
      widgets.add(
        Padding(
            padding: EdgeInsets.all(10.0),
            child: ListTile(
              title: Text(
                (i + 1).toString() +
                    '. ' +
                    snapshot.data.infoList.elementAt(i).title,
                style: TextStyle(fontSize: 18),
              ),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                _launchURL(snapshot.data.infoList.elementAt(i).url);
              },
            )),
      );
    }
    return widgets;
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
