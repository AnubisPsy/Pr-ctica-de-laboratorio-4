import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'widgets/myhomepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Noticias Populares',
      home: NewsList(),
    );
  }
}
