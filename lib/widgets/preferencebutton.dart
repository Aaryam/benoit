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
      padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 3.0),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 62, 188, 131),
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
              // 75, 165, 141
              // 50, 110, 94
              // 32, 102, 83
              color: Colors.black,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
