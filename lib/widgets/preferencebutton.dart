import 'package:benoit/misc/utilities.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceButton extends StatelessWidget {
  final String text;
  final String textFile;
  final SharedPreferences sharedPreferences;

  const PreferenceButton({
    required this.text,
    required this.sharedPreferences,
    required this.textFile,
  });
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          color: BenoitColors.jungleGreen,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextButton(
          onPressed: () async {
            await LocalStorageUtilities.addPreference(
                text, textFile, sharedPreferences);
          },
          onLongPress: () async {
            await LocalStorageUtilities.clearPreferences(sharedPreferences);
          },
          child: Text(
            text,
            style: const TextStyle(
              fontFamily: 'Poppins',
              color: Color.fromARGB(255, 0, 0, 0),
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
