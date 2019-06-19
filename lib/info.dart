class Info {
  final String date;
  final String title;
  final String url;

  Info(this.date, this.title, this.url);

  Info.fromJson(Map<String, dynamic> json)
      : date = json['date'],
        title = json['title'],
        url = json['url'];

  Map<String, dynamic> toJson() =>
      {
        'date': date,
        'title': title,
        'url': url,
      };
}