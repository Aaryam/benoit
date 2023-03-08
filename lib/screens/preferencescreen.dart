import 'package:benoit/misc/utilities.dart';
import 'package:benoit/screens/homescreen.dart';
import 'package:benoit/widgets/preferencebutton.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({super.key, required this.title});

  final String title;

  @override
  State<PreferencesScreen> createState() => PreferencesScreenState();
}

class PreferencesScreenState extends State<PreferencesScreen> {
  List<Widget> preferenceButtons = [];

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
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.grey[600],
              ),
              label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                color: BenoitColors.jungleGreen,
              ),
              label: ''),
        ],
        onTap: (int index) {
          if (index == 0) {
            Navigator.pop(context);
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
                  builder: (context) => const PreferencesScreen(
                    title: 'Benoit',
                  ),
                ),
                (Route<dynamic> route) => false);
          }
        },
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: FutureBuilder<SharedPreferences>(
            future: SharedPreferences.getInstance(),
            builder: (context, sharedPreferencesSnapshot) {
              if (sharedPreferencesSnapshot.hasData) {
                SharedPreferences sharedPreferences =
                    sharedPreferencesSnapshot.data as SharedPreferences;

                for (int i = 0;
                    i < LocalStorageUtilities.preferencesMap.keys.length;
                    i++) {
                  String preferenceName =
                      LocalStorageUtilities.preferencesMap.keys.elementAt(i);
                  String preferenceTextFile = LocalStorageUtilities
                      .preferencesMap[preferenceName] as String;

                  preferenceButtons.add(PreferenceButton(
                      text: preferenceName,
                      sharedPreferences: sharedPreferences,
                      textFile: preferenceTextFile));
                }

                return Wrap(
                  children: preferenceButtons,
                );
              } else if (sharedPreferencesSnapshot.hasError) {
                return Text(sharedPreferencesSnapshot.error.toString());
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
      floatingActionButton: Container(
        height: 50,
        decoration: BoxDecoration(
          color: BenoitColors.jungleGreen,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(
                  title: 'Benoit',
                ),
              ),
            );
          },
          child: const Text(
            'Proceed to content!',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
