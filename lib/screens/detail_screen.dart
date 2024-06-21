import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webtoon/models/webtoon_detail_model.dart';
import 'package:webtoon/models/webtoon_episode_model.dart';
import 'package:webtoon/models/webtoon_model.dart';
import 'package:webtoon/services/api_service.dart';
import 'package:webtoon/widgets/episode_widget.dart';

class DetailScreen extends StatefulWidget {
  final WebtoonModel webtoon;

  const DetailScreen({
    super.key,
    required this.webtoon,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<WebtoonDetailModel> webtoonDetail;
  late Future<List<WebtoonEpisodeModel>> episodes;
  late SharedPreferences prefs;
  bool isLiked = false;

  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(widget.webtoon.id)) {
      await prefs.setBool(widget.webtoon.id, isLiked);
    }
    setState(() {
      isLiked = prefs.getBool(widget.webtoon.id)!;
    });
  }

  @override
  void initState() {
    super.initState();
    webtoonDetail = ApiService.getWebtoonDetail(widget.webtoon.id);
    episodes = ApiService.getLatestWebtoonEpisodes(widget.webtoon.id);
    initPrefs();
  }

  onLikePressed() async {
    setState(() {
      isLiked = !isLiked;
    });
    await prefs.setBool(widget.webtoon.id, isLiked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.webtoon.title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: isLiked
                ? const Icon(Icons.favorite_outlined)
                : const Icon(Icons.favorite_outline_sharp),
            onPressed: onLikePressed,
          ),
        ],
        elevation: 3,
        shadowColor: Colors.black,
        backgroundColor: Colors.greenAccent[400],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 48,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: widget.webtoon.id,
                    child: Container(
                      width: 200,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.75),
                            blurRadius: 10,
                            offset: const Offset(5, 5),
                          ),
                        ],
                      ),
                      child: Image.network(widget.webtoon.thumb),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              FutureBuilder(
                future: webtoonDetail,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Text(
                          '${snapshot.data!.genre} / ${snapshot.data!.age}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          snapshot.data!.about,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    );
                  }
                  return const Text('...');
                },
              ),
              const SizedBox(height: 20),
              FutureBuilder(
                future: episodes,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        for (var episode in snapshot.data!)
                          Episode(
                            episode: episode,
                            webtoon: widget.webtoon,
                          ),
                      ],
                    );
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
