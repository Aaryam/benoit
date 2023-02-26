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
      floatingActionButton: FloatingActionButton(
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
        elevation: 0,
        focusElevation: 0,
        child: const Icon(Icons.send),
      ),
    );
  }
}
