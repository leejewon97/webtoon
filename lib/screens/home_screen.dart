import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
        elevation: 3, // 적용이 안 되는 듯. 왜??
        shadowColor: Colors.black,
        backgroundColor: Colors.greenAccent[400],
        foregroundColor: Colors.white,
      ),
    );
  }
}
