class WebtoonModel {
  final String id, title, thum;

  WebtoonModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        thum = json['thumb'];
}
