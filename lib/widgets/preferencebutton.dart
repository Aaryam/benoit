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
        height: (MediaQuery.of(context).size.width * 1 / 2) - 8,
        width: (MediaQuery.of(context).size.width * 1 / 2) - 8,
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
          child: Align(alignment: Alignment.bottomLeft, child: Text(
            text,
            style: const TextStyle(
              fontFamily: 'Poppins',
              color: Colors.black,
              fontSize: 12,
            ),
          ),)
        ),
      ),
    );
  }
}
