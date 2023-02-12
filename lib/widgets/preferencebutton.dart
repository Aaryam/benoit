import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceButton extends StatelessWidget {
  final String text;
  final String promptDescription;
  final SharedPreferences sharedPreferences;

  const PreferenceButton({
    required this.text, required this.sharedPreferences, required this.promptDescription,
  });

  @override
  Widget build(BuildContext context) {

    bool isSelected = false;

    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 197, 209, 232),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            String preferences = sharedPreferences.getString('preferences') ?? "";

            preferences != "" ? sharedPreferences.setString('preferences', "$preferences, $promptDescription") : sharedPreferences.setString('preferences', promptDescription);
            print(preferences);
          },
          onLongPress: () {
            sharedPreferences.setString('preferences', "");
            String preferences = sharedPreferences.getString('preferences') ?? "";
            print(preferences);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: 'Poppins',
                color: Colors.black,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }
}