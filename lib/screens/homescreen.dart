import 'package:benoit/misc/utilities.dart';
import 'package:benoit/screens/preferencescreen.dart';
import 'package:benoit/screens/temptest.dart';
import 'package:benoit/widgets/contentcard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  ScrollController scrollController = ScrollController();

  int itemCount = 10;
  int currentNavIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<List<String>> generateArticleTitles(
        int count, SharedPreferences sharedPreferences) async {
      List<String> titles = [];

      for (int i = 0; i < count; i++) {
        String title =
            await ScrapingUtilities.getArticleTitle(sharedPreferences);

        titles.add(title);
      }

      return titles;
    }

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: currentNavIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
        ],
        onTap: (int index) {
          if (index == 0 && currentNavIndex == 0) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(
                    title: 'Benoit',
                  ),
                ),
                (Route<dynamic> route) => false);
          } else if (index == 1) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => TempTestScreen(),
                ),
                (Route<dynamic> route) => false);
          } else {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const PreferencesScreen(
                    title: 'Benoit',
                  ),
                ),
                (Route<dynamic> route) => false);
          }
        },
      ),
      body: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              
            });
          },
          child: FutureBuilder(
            future: SharedPreferences.getInstance(),
            builder: (context, sharedPreferencesSnapshot) {
              if (sharedPreferencesSnapshot.hasData) {
                SharedPreferences sharedPreferences =
                    sharedPreferencesSnapshot.data as SharedPreferences;

                return FutureBuilder<List<String>>(
                  future: generateArticleTitles(25, sharedPreferences),
                  builder: (context, listSnapshot) {
                  if (listSnapshot.hasData) {

                    List<String> articleList = listSnapshot.data as List<String>;

                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6.0, horizontal: 0.0),
                          child: ContentCard(
                            sharedPreferences: sharedPreferences,
                            articleTitle: articleList[index],
                          ),
                        );
                      },
                      itemCount: 25,
                    );
                  } else if (listSnapshot.hasError) {
                    return Text(listSnapshot.error.toString());
                  } else {
                    return Container();
                  }
                });
              } else if (sharedPreferencesSnapshot.hasError) {
                return Text(sharedPreferencesSnapshot.error.toString());
              } else {
                return Container();
              }
            },
          )),
    );
  }
}
