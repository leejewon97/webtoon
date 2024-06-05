import 'package:flutter/material.dart';
import 'package:webtoon/models/webtoon_model.dart';
import 'package:webtoon/screens/detail_screen.dart';

class Webtoon extends StatelessWidget {
  final WebtoonModel webtoon;

  const Webtoon({
    super.key,
    required this.webtoon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(webtoon: webtoon),
            // fullscreenDialog: true, 뒤로가기 대신 닫기 버튼이 생김
          ),
        );
      },
      child: Column(
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
      ),
    );
  }
}
