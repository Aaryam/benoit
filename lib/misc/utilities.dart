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
  static Future<List<String>> getArticleData(article) async {
    Response response = await Client().get(
        Uri.parse('https://en.wikipedia.org/wiki/' + article),
        headers: {'Charset': 'utf-8'});
    String finalResponse = "";
    String documentData = "";
    bool isBefore = false;

    const DOCUMENT_LENGTH = 30;

    if (response.statusCode == 200) {
      var document = parser.parse(response.body);
      List<DOM.Element> pTags = document.getElementsByTagName('p');
      List<DOM.Element> imgTags = document.getElementsByTagName('img');
      List<DOM.Element> h2Tags = document.getElementsByTagName('h2');
      List<DOM.Element> mwHeadlines = document.querySelectorAll('h2 > .mw-headline');

      int randomNumber = Random().nextInt(mwHeadlines.length);
      DOM.Element sectionHeader = mwHeadlines[randomNumber].parent as DOM.Element;

      for (DOM.Element element in document.getElementsByTagName('*')) {
        if (sectionHeader == element && !isBefore) {
          isBefore = true;
        }

        if ((pTags.contains(element) || imgTags.contains(element) || h2Tags.contains(element)) &&
            isBefore) {
          if (pTags.contains(element)) {
            documentData +=
                '${element.text.replaceAll(RegExp(r"\[.*?\]"), '')}\n';
          } else if (imgTags.contains(element)) {
            // print(element);
          }
          else if (h2Tags.contains(element) && element != sectionHeader) {
            break;
          }
        } else {}
      }
      
      return documentData.split(" ").length > DOCUMENT_LENGTH ? [documentData, article + "#" + sectionHeader.text] : await getArticleData(article);
    }

    return [finalResponse, article + "#"];
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

  static Future<String> getTextFileData(textFile) async {
    String text = await rootBundle.loadString('$textFile');
    int randomNumber = Random().nextInt(text.split("\n").length);

    return text.split("\n")[randomNumber];
  }

  static String selectTheme(SharedPreferences sharedPreferences) {
    List<String> themes =
        LocalStorageUtilities.getPreferences(sharedPreferences);
    int randomNumber = Random().nextInt(themes.length);

    return themes[randomNumber];
  }

  static Future<List<String>> getInformationBody(
      SharedPreferences sharedPreferences) async {
    String topicName = ScrapingUtilities.selectTheme(sharedPreferences);

    return ScrapingUtilities.getArticleData(
        await ScrapingUtilities.getTextFileData(
            LocalStorageUtilities.getPreferenceTextFile(topicName)));
  }
}

class LocalStorageUtilities {
  
  // PREFERENCES:
  // "preferenceName•textfile|preferenceName1•textfile1"

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
