import 'package:flutter/material.dart';
import 'package:hackernews_api/hackernews_api.dart';
import 'package:flutter_hw1/additional_screen.dart';

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
  final ThemeData _customLightTheme = ThemeData(
    primaryColor: Colors.purple,
    scaffoldBackgroundColor: Colors.white,
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: Colors.black),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.purple,
      foregroundColor: Colors.white,
    ),
    tabBarTheme: const TabBarTheme(
      labelColor: Colors.red,
      unselectedLabelColor: Colors.orange,
    ),
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pocket News',
      theme: _customLightTheme,
      darkTheme: ThemeData.dark(),
      themeMode: _isDarkTheme ? ThemeMode.dark : ThemeMode.light,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          bottomNavigationBar: _buildThemeSwitcher(context),
          appBar: AppBar(
            title: const Text('Pocket News'),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'New Stories'),
                Tab(text: 'Top Stories'),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              _NewsTab(newsType: NewsType.newStories),
              _NewsTab(newsType: NewsType.topStories),
            ],
          ),
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

class _NewsTab extends StatelessWidget {
  final NewsType newsType;

  const _NewsTab({required this.newsType});

  @override
  Widget build(BuildContext context) {
    final HackerNews news = HackerNews(newsType: newsType);

    return FutureBuilder<List<Story>>(
      future: news.getStories(),
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
    );
  }
}
