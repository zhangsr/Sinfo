import 'info.dart';

class InfoList {
  final List<Info> infoList;

  InfoList({
    this.infoList,
  });

  factory InfoList.fromJson(List<dynamic> parsedJson) {

    List<Info> infoList = new List<Info>();
    infoList = parsedJson.map((i)=>Info.fromJson(i)).toList();

    return new InfoList(
      infoList: infoList,
    );
  }
}