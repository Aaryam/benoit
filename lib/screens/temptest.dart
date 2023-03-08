import 'package:benoit/misc/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TempTestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<String> x(String file) async {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      String loadedTextFile = await rootBundle.loadString(file);

      for (int i = 0; i < loadedTextFile.split("\n").length; i++) {
        var title = loadedTextFile.split("\n")[i];

        String image = await ScrapingUtilities.getImageFromArticle(title);

        if (image ==
            'https://static.vecteezy.com/system/resources/previews/004/141/669/non_2x/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg') {
          print(title);
          print(i);
        }
      }

      return 'x';
    }

    return Scaffold(
      body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.green,
              child: TextButton(
                onPressed: () async {
                  await x('assets/misc/content/historical_events.txt');
                },
                child: Text('x'),
              ),
            ),
    );
  }
}
