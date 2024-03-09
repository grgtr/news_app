import 'package:flutter/material.dart';
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:hackernews_api/model/story.dart';
import 'package:url_launcher/url_launcher_string.dart';

class NewsScreen extends StatelessWidget {
  final Story story;

  const NewsScreen({Key? key, required this.story}) : super(key: key);

  Future<String?> _fetchImage(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == HttpStatus.ok) {
      final document = parse(response.body);
      final imageSrc = document.querySelector('img')?.attributes['src'];
      return imageSrc;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(story.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FutureBuilder<String?>(
              future: _fetchImage(story.url),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
                  return const SizedBox(height: 0);
                }

                return ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: FractionallySizedBox(
                    widthFactor: 0.6,
                    child: Image.network(
                      snapshot.data!,
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const CircularProgressIndicator();
                      },
                      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                        return const SizedBox(height: 0);
                      },
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16.0),
            Text(
              story.title,
              style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            Text('by ${story.by}'),
            const SizedBox(height: 8.0),
            Text('${story.descendants} comments'),
            const SizedBox(height: 8.0),
            Text('${story.score} points'),
            const SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                launchURL(story.url);
              },
              child: const Text('Read more'),
            ),
          ],
        ),
      ),
    );
  }
}



Future<void> launchURL(String url) async {
  if (await canLaunchUrlString(url)) {
    await launchUrlString(url);
  } else {
    throw 'Could not launch $url';
  }
}