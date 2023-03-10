import 'package:benoit/misc/utilities.dart';
import 'package:flutter/material.dart';

class ImageBox extends StatelessWidget {
  final String articleName;

  const ImageBox({super.key, required this.articleName});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        builder: ((context, imageSnapshot) {
          if (imageSnapshot.hasData && imageSnapshot.data != null) {
            return SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    imageSnapshot.data as String,
                    height: MediaQuery.of(context).size.height * 0.35,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          } else {
            return Container(
              height: MediaQuery.of(context).size.height * 0.35,
              color: Colors.white,
            );
          }
        }),
        future:
            ScrapingUtilities.getImageFromArticle(articleName.split("#")[0]));
  }
}
