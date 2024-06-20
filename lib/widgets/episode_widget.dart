import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:webtoon/models/webtoon_episode_model.dart';
import 'package:webtoon/models/webtoon_model.dart';

class Episode extends StatelessWidget {
  const Episode({
    super.key,
    required this.episode,
    required this.webtoon,
  });

  final WebtoonEpisodeModel episode;
  final WebtoonModel webtoon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await launchUrlString(
          "https://m.comic.naver.com/webtoon/detail?titleId=${webtoon.id}&no=${episode.id}",
          mode: LaunchMode.inAppWebView,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.greenAccent[400]!,
          ),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 5,
              offset: const Offset(5, 5),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        margin: const EdgeInsets.only(
          bottom: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              episode.title,
              style: TextStyle(
                fontSize: 16,
                color: Colors.greenAccent[400],
              ),
            ),
            Icon(
              Icons.keyboard_double_arrow_right_rounded,
              color: Colors.greenAccent[400],
            ),
          ],
        ),
      ),
    );
  }
}
