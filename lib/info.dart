class Info {
  final int id;
  final String date;
  final String title;
  final String url;

  Info(this.id, this.date, this.title, this.url);

  Info.fromJson(Map<String, dynamic> json):
        id = json['id'],
        date = json['date'],
        title = json['title'],
        url = json['url'];

  Map<String, dynamic> toJson() =>
      {
        'date': date,
        'title': title,
        'url': url,
      };
}