import 'package:benoit/misc/utilities.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceButton extends StatelessWidget {
  final String text;
  final String textFile;
  final SharedPreferences sharedPreferences;

  const PreferenceButton({super.key, 
    required this.text,
    required this.sharedPreferences,
    required this.textFile,
  });
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.5, vertical: 4.5),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
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
              color: Colors.black,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
