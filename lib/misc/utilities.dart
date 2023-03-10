import 'dart:math';
import 'package:html/dom.dart' as DOM;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:html/parser.dart' as parser;
import 'package:shared_preferences/shared_preferences.dart';

class BenoitColors {
  static MaterialColor jungleGreen =
      const MaterialColor(0xFF4BA58D, <int, Color>{
    900: Color.fromARGB(255, 75, 165, 141),
    800: Color.fromARGB(245, 75, 165, 141),
    700: Color.fromARGB(235, 75, 165, 141),
    600: Color.fromARGB(225, 75, 165, 141),
    500: Color.fromARGB(215, 75, 165, 141),
    400: Color.fromARGB(205, 75, 165, 141),
    300: Color.fromARGB(195, 75, 165, 141),
    200: Color.fromARGB(185, 75, 165, 141),
    100: Color.fromARGB(175, 75, 165, 141),
    50: Color.fromARGB(170, 75, 165, 141),
  });
}

class AIUtilities {
  static const API_KEY = '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';

  static Future<String> requestResponse(prompt) async {
    final reqUrl = Uri.parse('https://api.openai.com/v1/completions');
    final reqHeaders = {
      'Accept': 'text/event-stream',
      'Authorization': 'Bearer $API_KEY',
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8'
    };
    Map<String, dynamic> reqBody = {
      "prompt": prompt,
      "model": "text-davinci-003",
      "max_tokens": 800,
      "temperature": 0.4,
      "n": 1,
    };

    final encoding = Encoding.getByName('utf-8');

    Response response = await post(
      reqUrl,
      headers: reqHeaders,
      body: json.encode(reqBody),
      encoding: encoding,
    );

    String responseBody = response.body;

    return responseBody;
  }
}

class ScrapingUtilities {
  static Future<String> getArticleTitle(
      SharedPreferences sharedPreferences) async {
    List<String> preferences =
        LocalStorageUtilities.getPreferences(sharedPreferences);

    int preferenceChoiceIndex = Random().nextInt(preferences.length);
    String selectedPreference = preferences[preferenceChoiceIndex];

    String preferenceName =
        LocalStorageUtilities.getPreferenceName(selectedPreference);
    String textFile =
        LocalStorageUtilities.getPreferenceTextFile(selectedPreference);

    String loadedTextFile = await rootBundle.loadString(textFile);
    int selectedArticleIndex =
        Random().nextInt(loadedTextFile.split("\n").length);
    String articleTitle = loadedTextFile.split("\n")[selectedArticleIndex];

    return articleTitle;
  }

  static Future<DOM.Document?> getArticleDocument(String article) async {
    Response response = await Client().get(
        Uri.parse('https://en.wikipedia.org/wiki/$article'),
        headers: {'Charset': 'utf-8'});

    if (response.statusCode == 200) {
      return parser.parse(response.body);
    } else {
      return null;
    }
  }

  static List<String> getArticleBody(String article, DOM.Document? document) {

    String finalResponse = "";
    String documentData = "";
    bool isBefore = false;

    const DOCUMENT_LENGTH = 30;

    if (document != null) {

      List<DOM.Element> pTags = document.getElementsByTagName('p');
      List<DOM.Element> imgTags = document.getElementsByTagName('img');
      List<DOM.Element> h2Tags = document.getElementsByTagName('h2');
      List<DOM.Element> mwHeadlines = document.querySelectorAll('h2 > .mw-headline');

      int randomNumber = Random().nextInt(mwHeadlines.length);
      DOM.Element sectionHeader =
          mwHeadlines[randomNumber].parent as DOM.Element;

      for (DOM.Element element in document.getElementsByTagName('*')) {
        if (sectionHeader == element && !isBefore) {
          isBefore = true;
        }

        if ((pTags.contains(element) ||
                imgTags.contains(element) ||
                h2Tags.contains(element)) &&
            isBefore) {
          if (pTags.contains(element)) {
            documentData +=
                '${element.text.replaceAll(RegExp(r"\[.*?\]"), '')}\n';
          } else if (imgTags.contains(element)) {
            // print(element);
          } else if (h2Tags.contains(element) && element != sectionHeader) {
            break;
          }
        } else {}
      }

      return documentData.split(" ").length > DOCUMENT_LENGTH ? [documentData, sectionHeader.text] : getArticleBody(article, document);
    }

    return [finalResponse, article + "#"];
  }

  static Future<List<List<String>>> getMultipleStrings(
      int max, SharedPreferences sharedPreferences) async {
    List<List<String>> multipleStrings = [];

    for (int i = 0; i < max; i++) {
      String articleName = await getArticleTitle(sharedPreferences);
      List<String> articleBody = getArticleBody(articleName, await getArticleDocument(articleName));
      multipleStrings.add([articleName, articleBody[0], articleBody[1]]);
    }

    return multipleStrings;
  }

  static Future<String> getArticleBrief(article) async {
    Response response = await Client().get(
        Uri.parse('https://en.wikipedia.org/wiki/' + article),
        headers: {'Charset': 'utf-8'});
    String finalResponse = "";
    String documentData = "";
    bool isBefore = true;

    if (response.statusCode == 200) {
      var document = parser.parse(response.body);
      List<DOM.Element> pTags = document.getElementsByTagName('p');
      List<DOM.Element> imgTags = document.getElementsByTagName('img');

      for (DOM.Element element in document.getElementsByTagName('*')) {
        if (element.className.contains('mw-headline') && isBefore) {
          isBefore = false;
        }

        if ((pTags.contains(element) || imgTags.contains(element)) &&
            isBefore) {
          if (pTags.contains(element) && pTags.indexOf(element) != 0) {
            documentData +=
                '${element.text.trim().replaceAll(RegExp(r"\[.*?\]"), '')}\n';
          }
        } else {}
      }

      return documentData.trim();
    }

    return finalResponse;
  }

  static Future<String> getImageFromArticle(String article) async {
    Response response = await Client().get(
        Uri.parse('https://en.wikipedia.org/wiki/' + article),
        headers: {'Charset': 'utf-8'});

    if (response.statusCode == 200) {
      var document = parser.parse(response.body);
      List<DOM.Element> imgTags = document.getElementsByTagName('img');

      for (int i = 0; i < imgTags.length; i++) {
        if (imgTags[i].parent!.className == "image") {
          return "https:${imgTags[i].attributes['src'] as String}";
        }
      }
    }

    return "https://static.vecteezy.com/system/resources/previews/004/141/669/non_2x/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg";
  }
}

class LocalStorageUtilities {
  // PREFERENCES:
  // "preferenceName•textfile|preferenceName1•textfile1"

  static Map<String, String> preferencesMap = {
    'Political Figures': 'assets/misc/content/political_figures.txt',
    'Historical Events': 'assets/misc/content/historical_events.txt',
    'Celebrities': 'assets/misc/content/celebrities.txt',
    'Country Musicians': 'assets/misc/content/country_musicians.txt',
    'Advertising': 'assets/misc/content/marketing_campaigns.txt',
    'Comic Characters': 'assets/misc/content/comic_characters.txt',
    'True Crime': 'assets/misc/content/crimes.txt',
    'Global Foods': 'assets/misc/content/global_foods.txt',
    'Popular Filmmakers': 'assets/misc/content/filmmakers.txt',
    'Historical Figures': 'assets/misc/content/historical_figures.txt',
    'Abnormal Laws': 'assets/misc/content/historical_figures.txt',
    'Companies': 'assets/misc/content/entrepreneurs.txt',
    'Software Applications': 'assets/misc/content/applications.txt',
    'Programming': 'assets/misc/content/programming.txt',
    'Interesting Topics': 'assets/misc/content/interesting_topics.txt',
  };

  static List<String> getPreferences(SharedPreferences sharedPreferences) {
    String preferences = sharedPreferences.getString('preferences') ?? '';

    List<String> preferenceList = preferences.split("|");

    return preferenceList;
  }

  static Future<bool> addPreference(String preferenceName, String textFile,
      SharedPreferences sharedPreferences) {
    String preferences = sharedPreferences.getString('preferences') ?? '';

    // print(preferences);

    preferences += preferences.isNotEmpty
        ? "|$preferenceName•$textFile"
        : "$preferenceName•$textFile";

    return sharedPreferences.setString('preferences', preferences);
  }

  static String getPreferenceName(String preference) {
    return preference.split("•")[0];
  }

  static String getPreferenceTextFile(String preference) {
    return preference.split("•")[1];
  }

  static Future<bool> clearPreferences(SharedPreferences sharedPreferences) {
    print("Cleared");

    return sharedPreferences.setString('preferences', '');
  }

  static Future<bool> removePreference(
      String preference, SharedPreferences sharedPreferences) {
    List<String> preferenceList = getPreferences(sharedPreferences);

    for (var p in preferenceList) {
      if (p == preference) {
        preferenceList.remove(p);
      }
    }

    return sharedPreferences.setString('preferences', preferenceList.join());
  }
}

class WidgetUtilities {
  static List<Widget> getWidgetsFromText(text) {
    List<Widget> widgets = [];

    return widgets;
  }
}

class MathUtilities {
  static int getRandomRange(int min, int max) {
    return Random().nextInt(max) + min;
  }
}
