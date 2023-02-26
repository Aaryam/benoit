import 'package:benoit/misc/newutilities.dart';
import 'package:benoit/misc/utilities.dart';
import 'package:benoit/screens/contentscreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContentCard extends StatelessWidget {
  const ContentCard({super.key, required this.sharedPreferences});

  final SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: NewScrapingUtilities.getArticleTitle(sharedPreferences),
        builder: (context, titleSnapshot) {
          if (titleSnapshot.hasData) {
            String articleTitle = titleSnapshot.data as String;

            return GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContentScreen(
                        articleTitle: articleTitle,
                      ),
                    ),
                    (Route<dynamic> route) => false);
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width * 0.8,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(articleTitle.replaceAll("_", " "),
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            color: Colors.black87,
                          )),
                    ],
                  ),
                ),
              ),
            );
          } else if (titleSnapshot.hasError) {
            print(titleSnapshot.error.toString());
            return Container(
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width,
              color: const Color.fromARGB(255, 234, 234, 234),
              child: Text(titleSnapshot.error.toString()),
            );
          } else {
            return Container(
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width,
              color: const Color.fromARGB(255, 234, 234, 234),
            );
          }
        });
  }
}
