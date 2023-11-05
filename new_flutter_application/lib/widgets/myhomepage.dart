import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsList extends StatefulWidget {
  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  List<News> news = [];

  @override
  void initState() {
    super.initState();
    getNewsData();
  }

  Future<void> getNewsData() async {
    final apiKey = 'caf6a6763b1d40d58d871aab5e03a33c';
    final apiUrl =
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['articles'] != null) {
        final newsData = data['articles'] as List<dynamic>;
        setState(() {
          news = newsData.map((article) => News.fromJson(article)).toList();
        });
      } else {
        print('NO_RESULTADOS');
      }
    } else {
      print('ERROR DE OBTENCIÓN DE DATOS: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Noticias Populares'),
      ),
      body: ListView.builder(
        itemCount: news.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(news[index].title),
            subtitle: Text(news[index].description),
            leading: news[index].urlToImage != null
                ? Image.network(news[index].urlToImage!)
                : null,
          );
        },
      ),
    );
  }
}

class News {
  final String title;
  final String description;
  final String? urlToImage;

  News({required this.title, required this.description, this.urlToImage});

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      title: json['title'],
      description: json['description'],
      urlToImage: json['urlToImage'],
    );
  }
}
