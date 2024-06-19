import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:webtoon/models/webtoon_detail_model.dart';
import 'package:webtoon/models/webtoon_episode_model.dart';
import 'package:webtoon/models/webtoon_model.dart';

class ApiService {
  static const String baseUrl =
      'https://webtoon-crawler.nomadcoders.workers.dev';
  static const String today = 'today';

  static Future<List<WebtoonModel>> getTodayToons() async {
    final url = Uri.parse('$baseUrl/$today');
    final response = await http.get(url);
    final List<WebtoonModel> webtoons = [];

    if (response.statusCode == 200) {
      jsonDecode(response.body).forEach((webtoon) {
        webtoons.add(WebtoonModel.fromJson(webtoon));
      });
      return webtoons;
    }
    throw Exception('Failed to load today toons');
  }

  static Future<WebtoonDetailModel> getWebtoonDetail(String id) async {
    final url = Uri.parse('$baseUrl/$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return WebtoonDetailModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('Failed to load webtoon($id) detail');
  }

  static Future<List<WebtoonEpisodeModel>> getLatestWebtoonEpisodes(
      String id) async {
    final url = Uri.parse('$baseUrl/$id/episodes');
    final response = await http.get(url);
    final List<WebtoonEpisodeModel> episodes = [];

    if (response.statusCode == 200) {
      jsonDecode(response.body).forEach((episode) {
        if (episodes.length < 10) {
          episodes.add(WebtoonEpisodeModel.fromJson(episode));
        }
      });
      return episodes;
    }
    throw Exception('Failed to load webtoon($id) episodes');
  }
}
