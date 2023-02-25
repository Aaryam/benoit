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
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.25,
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: FutureBuilder(
                        future: ScrapingUtilities.getImageFromArticle(articleTitle),
                        builder: (context, imageSnapshot) {
                          if (imageSnapshot.hasData) {
                            String networkUrl = imageSnapshot.data as String;

                            return Image.network(
                              networkUrl,
                              fit: BoxFit.cover,
                            );
                          } else if (imageSnapshot.hasError) {
                            print(imageSnapshot.error.toString());
                            return Image.network(
                              'https://static.vecteezy.com/system/resources/previews/004/141/669/non_2x/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg',
                              fit: BoxFit.cover,
                            );
                          } else {
                            return Image.network(
                              'https://static.vecteezy.com/system/resources/previews/004/141/669/non_2x/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg',
                              fit: BoxFit.cover,
                            );
                          }
                        },
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Center(
                              child: Text(
                                articleTitle,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
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
