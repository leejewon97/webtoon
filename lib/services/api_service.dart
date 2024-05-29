import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:webtoon/models/webtoon_model.dart';

class ApiService {
  final String baseUrl = 'https://webtoon-crawler.nomadcoders.workers.dev';
  final String today = 'today';

  Future<List<WebtoonModel>> getTodayToons() async {
    final url = Uri.parse('$baseUrl/$today');
    final response = await http.get(url);
    final List<WebtoonModel> webtoons = [];

    if (response.statusCode == 200) {
      jsonDecode(response.body).forEach((webtoon) {
        webtoons.add(WebtoonModel.fromJson(webtoon));
      });
      return webtoons;
    }
    throw Exception('Failed to load data');
  }
}
