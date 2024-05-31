import 'package:flutter/material.dart';
import 'package:webtoon/models/webtoon_model.dart';
import 'package:webtoon/services/api_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final Future<List<WebtoonModel>> webtoons = ApiService().getTodayToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'webtoon',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 3,
        shadowColor: Colors.black,
        backgroundColor: Colors.greenAccent[400],
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: webtoons,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return makeList(snapshot);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      padding: const EdgeInsets.all(20),
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length, // overflow 방지
      itemBuilder: (context, index) {
        var webtoon = snapshot.data![index];
        return Column(
          children: [
            Container(
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
              child: Image.network(webtoon.thumb),
            ),
            const SizedBox(height: 20),
            Text(
              webtoon.title,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(width: 20);
      },
    );
  }
}
