import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  State<App> createState() => _ThemedAppState();
}

class _ThemedAppState extends State<App> {
  late bool _isDarkTheme = false;

  late List<Map<String, dynamic>> _newsList;

  @override
  void initState() {
    super.initState();
    _newsList = [
      {
        'title': 'News 1',
        'imageUrl': 'https://via.placeholder.com/150',
        'content': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      },
      {
        'title': 'News 2',
        'imageUrl': 'https://via.placeholder.com/150',
        'content': 'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      },
      {
        'title': 'News 3',
        'imageUrl': 'https://via.placeholder.com/150',
        'content': 'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
      },
      {
        'title': 'News 4',
        'imageUrl': 'https://via.placeholder.com/150',
        'content': 'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
      },
      {
        'title': 'News 5',
        'imageUrl': 'https://via.placeholder.com/150',
        'content': 'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      },
      {
        'title': 'News 6',
        'imageUrl': 'https://via.placeholder.com/150',
        'content': 'Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.',
      },
      {
        'title': 'News 1',
        'imageUrl': 'https://via.placeholder.com/150',
        'content': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      },
      {
        'title': 'News 2',
        'imageUrl': 'https://via.placeholder.com/150',
        'content': 'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      },
      {
        'title': 'News 3',
        'imageUrl': 'https://via.placeholder.com/150',
        'content': 'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
      },
      {
        'title': 'News 4',
        'imageUrl': 'https://via.placeholder.com/150',
        'content': 'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
      },
      {
        'title': 'News 5',
        'imageUrl': 'https://via.placeholder.com/150',
        'content': 'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      },
      {
        'title': 'News 6',
        'imageUrl': 'https://via.placeholder.com/150',
        'content': 'Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.',
      },
      {
        'title': 'News 1',
        'imageUrl': 'https://via.placeholder.com/150',
        'content': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      },
      {
        'title': 'News 2',
        'imageUrl': 'https://via.placeholder.com/150',
        'content': 'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      },
      {
        'title': 'News 3',
        'imageUrl': 'https://via.placeholder.com/150',
        'content': 'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
      },
      {
        'title': 'News 4',
        'imageUrl': 'https://via.placeholder.com/150',
        'content': 'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
      },
      {
        'title': 'News 5',
        'imageUrl': 'https://via.placeholder.com/150',
        'content': 'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      },
      {
        'title': 'News 6',
        'imageUrl': 'https://via.placeholder.com/150',
        'content': 'Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.',
      },
      {
        'title': 'News 1',
        'imageUrl': 'https://via.placeholder.com/150',
        'content': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      },
      {
        'title': 'News 2',
        'imageUrl': 'https://via.placeholder.com/150',
        'content': 'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      },
      {
        'title': 'News 3',
        'imageUrl': 'https://via.placeholder.com/150',
        'content': 'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
      },
      {
        'title': 'News 4',
        'imageUrl': 'https://via.placeholder.com/150',
        'content': 'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
      },
      {
        'title': 'News 5',
        'imageUrl': 'https://via.placeholder.com/150',
        'content': 'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      },
      {
        'title': 'News 6',
        'imageUrl': 'https://via.placeholder.com/150',
        'content': 'Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.',
      },


      // Add more news items here
    ];
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
            const Icon(Icons.ice_skating),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _newsList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: Image.network(_newsList[index]['imageUrl']),
                    title: Text(_newsList[index]['title']),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewsScreen(
                            title: _newsList[index]['title'],
                            imageUrl: _newsList[index]['imageUrl'],
                            content: _newsList[index]['content'],
                          ),
                        ),
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
  final String title;
  final String imageUrl;
  final String content;

  const NewsScreen({
    required this.title,
    required this.imageUrl,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(imageUrl),
            const SizedBox(height: 16.0),
            Text(
              title,
              style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            Text(content),
          ],
        ),
      ),
    );
  }
}

const baseUrl = "https://hacker-news.firebaseio.com/v0/";

Future<List<int>> getTopStories() async {
  var resp = await get(Uri.parse("${baseUrl}topstories.json"));
  var array = resp.body.substring(1, resp.body.length - 1).split(',');
  List<int> newsID = [];
  for (int i = 0; i < array.length; ++i) {
    newsID.add(int.parse(array[i].substring(0, array[i].length - 1)));
  }
  return newsID;
}

class NewDTO {
  final int id;
  final bool? deleted;
  final String type;
  final String? by;
  final int? time;
  final String? text;
  final bool? dead;
  final int? parent;
  final int? poll;
  final List<int>? kids;
  final String? url;
  final int? score;
  final String? title;
  final List<int>? parts;
  final int? descendants;

  NewDTO({
    required this.id,
    required this.deleted,
    required this.type,
    required this.by,
    required this.time,
    required this.text,
    required this.dead,
    required this.parent,
    required this.poll,
    required this.kids,
    required this.url,
    required this.score,
    required this.title,
    required this.parts,
    required this.descendants,
  });

  factory NewDTO.fromJson(Map<String, dynamic> json) {
    return NewDTO(
      id: json['id'],
      deleted: json['deleted'],
      type: json['type'],
      by: json['by'],
      time: json['time'],
      text: json['text'],
      dead: json['dead'],
      parent: json['parent'],
      poll: json['poll'],
      kids: json['kids'] != null ? List<int>.from(json['kids']) : null,
      url: json['url'],
      score: json['score'],
      title: json['title'],
      parts: json['parts'] != null ? List<int>.from(json['parts']) : null,
      descendants: json['descendants'],
    );
  }

}

Future<NewDTO> getNew(int id) async {
  var resp = await get(Uri.parse("${baseUrl}item/$id.json"));
  Map<String, dynamic> jsonMap = json.decode(resp.body);
  return NewDTO.fromJson(jsonMap);
}
