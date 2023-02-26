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
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: currentNavIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ''),
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
                  builder: (context) => const HomeScreen(
                    title: 'Benoit',
                  ),
                ),
                (Route<dynamic> route) => false);
          } else {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(
                    title: 'Benoit',
                  ),
                ),
                (Route<dynamic> route) => false);
          }
        },
      ),
      body: RefreshIndicator(
          onRefresh: () async {
            setState(() {});
          },
          child: FutureBuilder(
            future: SharedPreferences.getInstance(),
            builder: (context, sharedPreferencesSnapshot) {
              if (sharedPreferencesSnapshot.hasData) {
                SharedPreferences sharedPreferences =
                    sharedPreferencesSnapshot.data as SharedPreferences;

                return ListView.builder(
                  addAutomaticKeepAlives: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 4.0),
                      child: ContentCard(
                        sharedPreferences: sharedPreferences,
                      ),
                    );
                  },
                  itemCount: 25,
                );
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
