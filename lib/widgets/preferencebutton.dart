import 'package:benoit/misc/utilities.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceButton extends StatelessWidget {
  final String text;
  final String promptDescription;
  final SharedPreferences sharedPreferences;

  const PreferenceButton({
    required this.text,
    required this.sharedPreferences,
    required this.promptDescription,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = false;
    Color btnColor = BenoitColors.jungleGreen[900] as Color;

    return Container(
      decoration: BoxDecoration(
        color: btnColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            if (btnColor == BenoitColors.jungleGreen[900]) {
              String preferences =
                  sharedPreferences.getString('preferences') ?? "";
              preferences != ""
                  ? sharedPreferences.setString(
                      'preferences', "$preferences• $promptDescription")
                  : sharedPreferences.setString(
                      'preferences', promptDescription);

              String preferenceTitles =
                  sharedPreferences.getString('preferenceTitles') ?? "";
              preferenceTitles != ""
                  ? sharedPreferences.setString(
                      'preferenceTitles', "$preferenceTitles• $text")
                  : sharedPreferences.setString(
                      'preferenceTitles', text);

              print(preferenceTitles);
              print(preferences);

              btnColor = BenoitColors.jungleGreen[700] as Color;
            }
          },
          onLongPress: () {
            sharedPreferences.setString('preferences', "");
            String preferences =
                sharedPreferences.getString('preferences') ?? "";

             String preferenceTitles =
                  sharedPreferences.getString('preferenceTitles') ?? "";
              preferenceTitles != ""
                  ? sharedPreferences.setString(
                      'preferenceTitles', "")
                  : sharedPreferences.setString(
                      'preferenceTitles', "");

                            print(preferenceTitles);
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
