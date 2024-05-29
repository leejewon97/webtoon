import 'package:flutter/material.dart';
import 'package:webtoon/screens/home_screen.dart';
// import 'package:webtoon/services/api_service.dart';

void main() {
  // ApiService().getTodayToons().then((value) {
  //   for (var element in value) {
  //     print(element.title);
  //   }
  // });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
