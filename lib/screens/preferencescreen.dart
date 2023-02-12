import 'package:benoit/misc/tempvarstore.dart';
import 'package:benoit/misc/utilities.dart';
import 'package:benoit/screens/homescreen.dart';
import 'package:benoit/widgets/newscard.dart';
import 'package:benoit/widgets/preferencebutton.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({super.key, required this.title});

  final String title;

  @override
  State<PreferencesScreen> createState() => PreferencesScreenState();
}

class PreferencesScreenState extends State<PreferencesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation selectPreferenceAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    selectPreferenceAnimation = ColorTween(
            begin: const Color.fromARGB(255, 233, 233, 233),
            end: BenoitColors.jungleGreen[900])
        .animate(animationController);
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
          padding: const EdgeInsets.all(15),
          child: FutureBuilder<SharedPreferences>(
            future: SharedPreferences.getInstance(),
            builder: (context, sharedPreferencesSnapshot) {
              if (sharedPreferencesSnapshot.hasData) {
                SharedPreferences sharedPreferences = sharedPreferencesSnapshot.data as SharedPreferences;
                return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Wrap(
                spacing: 5,
                runSpacing: 5,
                children: <Widget>[
                  PreferenceButton(
                    text: 'Fictional Characters',
                    sharedPreferences: sharedPreferences,
                    promptDescription: 'a character in popular fictional books',
                  ),
                  PreferenceButton(
                    text: 'Historical Events',
                    sharedPreferences: sharedPreferences,
                    promptDescription: 'a historical event. Include factual details of the event such as dates, and important people in that event',
                  ),
                  PreferenceButton(
                    text: 'Celebrities',
                    sharedPreferences: sharedPreferences,
                    promptDescription: 'a popular celebrity in United States media. Celebrities include politicians, actors, directors, etc. Include the history and childhood of the person',
                  ),
                  PreferenceButton(
                    text: 'Country Musicians',
                    sharedPreferences: sharedPreferences,
                    promptDescription: 'a popular Country Musician. Include the history and childhood of the person',
                  ),
                  PreferenceButton(
                    text: 'Gaming Creators',
                    sharedPreferences: sharedPreferences,
                    promptDescription: 'a popular Gaming YouTuber or Twitch streamer. Include the history and childhood of the person',
                  ),
                  PreferenceButton(
                    text: 'R&B Musicians',
                    sharedPreferences: sharedPreferences,
                    promptDescription: 'a popular R&B Musician. Include the history and childhood of the person',
                  ),
                  PreferenceButton(
                    text: 'Architectural Feats',
                    sharedPreferences: sharedPreferences,
                    promptDescription: 'one example of architecture design. Include the history and the people behind the project.',
                  ),
                  PreferenceButton(
                    text: 'Advertising Campaigns',
                    sharedPreferences: sharedPreferences,
                    promptDescription: 'one example of an advertisement campaign that affected the world. Include the history and the people behind the project.',
                  ),
                  PreferenceButton(
                    text: 'Ballet Icons',
                    sharedPreferences: sharedPreferences,
                    promptDescription: 'a popular Ballet Dancer. Include the history and childhood of the person',
                  ),
                  PreferenceButton(
                    text: 'Mysteries',
                    sharedPreferences: sharedPreferences,
                    promptDescription: 'a popular serial killer. Include the history and childhood of the person, and the crimes committed',
                  ),
                  PreferenceButton(
                    text: 'Global Foods',
                    sharedPreferences: sharedPreferences,
                    promptDescription: 'one example of a food found in obscure places in the world. Include the ingredients and the taste profile',
                  ),
                  PreferenceButton(
                    text: 'Comic Book Characters',
                    sharedPreferences: sharedPreferences,
                    promptDescription: 'a character from the Marvel Comics or DC Comics. Include the character backstory, and powers and abilities of the character',
                  ),
                  PreferenceButton(
                    text: 'Popular Filmmakers',
                    sharedPreferences: sharedPreferences,
                    promptDescription: 'a popular Filmmaker. Include the childhood, and filmmaking influences of the person, but do not mention recent releases',
                  ),
                  PreferenceButton(
                    text: 'Historical Figures',
                    sharedPreferences: sharedPreferences,
                    promptDescription: 'a historical figure. Include the childhood and backstory of the person',
                  ),
                  PreferenceButton(
                    text: 'Companies',
                    sharedPreferences: sharedPreferences,
                    promptDescription: 'a company or businessman. Include the backstory of the company',
                  ),
                  PreferenceButton(
                    text: 'Abnormal Laws',
                    sharedPreferences: sharedPreferences,
                    promptDescription: 'a funny legal law that was or still is being followed somewhere in the world. Include the backstory of the law, and some convictions of the law in the past.',
                  ),
                ],
              ),
            ],
          );
              }
              else if (sharedPreferencesSnapshot.hasError) {
                return Text(sharedPreferencesSnapshot.error.toString());
              }
              else {
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
