import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hackernews_api/hackernews_api.dart';
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher_string.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _ThemedAppState();
}

class _ThemedAppState extends State<App> {
  late bool _isDarkTheme = false;
  late HackerNews _news;

  @override
  void initState() {
    super.initState();
    _news = HackerNews(newsType: NewsType.newStories);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _isDarkTheme ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildThemeSwitcher(context),
            const SizedBox(height: 16),
            Expanded(
              child: FutureBuilder<List<Story>>(
                future: _news.getStories(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  if (!snapshot.hasData) {
                    return const Text('No Data');
                  }

                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final story = snapshot.data![index];
                      return ListTile(
                        title: Text(story.title),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewsScreen(
                                story: story,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeSwitcher(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _isDarkTheme ? 'Dark' : 'Light',
            style: const TextStyle(fontSize: 18),
          ),
          const Spacer(),
          const Icon(Icons.sunny),
          Switch(
            value: _isDarkTheme,
            onChanged: (bool value) {
              setState(() {
                _isDarkTheme = value;
              });
            },
          ),
          const Icon(Icons.nightlight),
        ],
      ),
    );
  }
}

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
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (!snapshot.hasData || snapshot.data == null) {
                  return const Text('No image found');
                }

                return ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: AspectRatio(
                    aspectRatio: 3 / 1,
                    child: Image.network(
                      snapshot.data!,
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const CircularProgressIndicator();
                      },
                      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                        return const Text('Error loading image');
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