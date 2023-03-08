import 'package:benoit/misc/utilities.dart';
import 'package:benoit/screens/contentscreen.dart';
import 'package:benoit/widgets/imagebox.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContentCard extends StatelessWidget {
  const ContentCard(
      {super.key, required this.sharedPreferences, required this.articleTitle});

  final SharedPreferences sharedPreferences;
  final String articleTitle;

  @override
  Widget build(BuildContext context) {
    String renderedImage = "";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ContentScreen(
                  articleTitle: articleTitle,
                  imageSrc: renderedImage,
                ),
              ));
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FutureBuilder<String>(
                    builder: ((context, imageSnapshot) {
                      if (imageSnapshot.hasData && imageSnapshot.data != null) {
                        renderedImage = imageSnapshot.data as String;
                        return SizedBox(
                          width: (MediaQuery.of(context).size.width * 0.47) - 42,
                          height: MediaQuery.of(context).size.height * 0.2,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                            child: Image.network(
                              renderedImage,
                              height: MediaQuery.of(context).size.height * 0.2,
                              width: MediaQuery.of(context).size.width * 0.2,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      } else {
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          color: Colors.white,
                        );
                      }
                    }),
                    future: ScrapingUtilities.getImageFromArticle(
                        articleTitle.split("#")[0])),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 5.0,),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(articleTitle.replaceAll("_", " "),
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              color: Colors.black87,
                            )),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
