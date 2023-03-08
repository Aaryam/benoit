import 'package:benoit/misc/utilities.dart';
import 'package:benoit/screens/homescreen.dart';
import 'package:benoit/screens/preferencescreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Benoit',
      theme: ThemeData(
        primarySwatch: BenoitColors.jungleGreen,
      ),
      home: const StartScreen(),
    );
  }
}

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: ((context, snapshot) {

      if (snapshot.hasData) {
          SharedPreferences sharedPreferences = snapshot.data as SharedPreferences;

          print(sharedPreferences.getString('preferences'));

          if (sharedPreferences.getString('preferences') == "") {
            return const PreferencesScreen(title: 'Benoit');
          }
          else {
            return const HomeScreen(title: 'Benoit');
          }
      }
      else if (snapshot.hasError) {
        return Text(snapshot.error.toString());
      }
      else {
        return Container();
      }
    }));
  }

}
