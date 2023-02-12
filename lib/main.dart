import 'package:benoit/misc/utilities.dart';
import 'package:benoit/screens/homescreen.dart';
import 'package:flutter/material.dart';

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
        primarySwatch: Colors.cyan,
      ),
      home: const HomeScreen(title: 'Benoit'),
    );
  }
}
