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
                    Center(
                      child: Wrap(
                        spacing: 5,
                        runSpacing: 5,
                        children: <Widget>[
                          PreferenceButton(
                            text: 'Political Figures',
                            sharedPreferences: sharedPreferences,
                            textFile:
                                'assets/misc/content/political_figures.txt',
                          ),
                          PreferenceButton(
                            text: 'Historical Events',
                            sharedPreferences: sharedPreferences,
                            textFile:
                                'assets/misc/content/historical_events.txt',
                          ),
                          PreferenceButton(
                            text: 'Celebrities',
                            sharedPreferences: sharedPreferences,
                            textFile: 'assets/misc/content/celebrities.txt',
                          ),
                          PreferenceButton(
                            text: 'Country Musicians',
                            sharedPreferences: sharedPreferences,
                            textFile:
                                'assets/misc/content/country_musicians.txt',
                          ),
                          PreferenceButton(
                            text: 'Influencers',
                            sharedPreferences: sharedPreferences,
                            textFile: 'assets/misc/content/celebrities.txt',
                          ),
                          PreferenceButton(
                            text: 'R&B Musicians',
                            sharedPreferences: sharedPreferences,
                            textFile: 'assets/misc/content/celebrities.txt',
                          ),
                          PreferenceButton(
                            text: 'Architectural Feats',
                            sharedPreferences: sharedPreferences,
                            textFile:
                                'assets/misc/content/historical_figures.txt',
                          ),
                          PreferenceButton(
                            text: 'Advertising Campaigns',
                            sharedPreferences: sharedPreferences,
                            textFile:
                                'assets/misc/content/historical_figures.txt',
                          ),
                          PreferenceButton(
                            text: 'Ballet Icons',
                            sharedPreferences: sharedPreferences,
                            textFile:
                                'assets/misc/content/historical_figures.txt',
                          ),
                          PreferenceButton(
                            text: 'Mysteries',
                            sharedPreferences: sharedPreferences,
                            textFile:
                                'assets/misc/content/historical_figures.txt',
                          ),
                          PreferenceButton(
                            text: 'Global Foods',
                            sharedPreferences: sharedPreferences,
                            textFile: 'assets/misc/content/global_foods.txt',
                          ),
                          PreferenceButton(
                            text: 'Comic Book Characters',
                            sharedPreferences: sharedPreferences,
                            textFile:
                                'assets/misc/content/comic_characters.txt',
                          ),
                          PreferenceButton(
                            text: 'Popular Filmmakers',
                            sharedPreferences: sharedPreferences,
                            textFile: 'assets/misc/content/filmmakers.txt',
                          ),
                          PreferenceButton(
                            text: 'Historical Figures',
                            sharedPreferences: sharedPreferences,
                            textFile:
                                'assets/misc/content/historical_figures.txt',
                          ),
                          PreferenceButton(
                            text: 'Companies',
                            sharedPreferences: sharedPreferences,
                            textFile: 'assets/misc/content/entrepreneurs.txt',
                          ),
                          PreferenceButton(
                            text: 'Abnormal Laws',
                            sharedPreferences: sharedPreferences,
                            textFile: 'assets/misc/content/entrepreneurs.txt',
                          ),
                        ],
                      ),
                    ),
                  ],
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
