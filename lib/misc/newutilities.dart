import 'dart:math';

import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utilities.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;

class NewScrapingUtilities {
  // 1. Get random article title
  // 2. Scrape body content
  // 3. Select article section
  // 4. Get article images
  // 5. Display on ContentCard()

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

  static Future<List<String>> getArticleBody(article) async {
    Response response = await Client().get(
        Uri.parse('https://en.wikipedia.org/wiki/' + article),
        headers: {'Charset': 'utf-8'});
    String finalResponse = "";
    String documentData = "";
    bool isBefore = false;

    const DOCUMENT_LENGTH = 30;

    if (response.statusCode == 200) {
      var document = parser.parse(response.body);
      List<dom.Element> pTags = document.getElementsByTagName('p');
      List<dom.Element> imgTags = document.getElementsByTagName('img');
      List<dom.Element> h2Tags = document.getElementsByTagName('h2');
      List<dom.Element> mwHeadlines = document.querySelectorAll('h2 > .mw-headline');

      int randomNumber = Random().nextInt(mwHeadlines.length);
      dom.Element sectionHeader = mwHeadlines[randomNumber].parent as dom.Element;

      for (dom.Element element in document.getElementsByTagName('*')) {
        if (sectionHeader == element && !isBefore) {
          isBefore = true;
        }

        if ((pTags.contains(element) || imgTags.contains(element) || h2Tags.contains(element)) &&
            isBefore) {
          if (pTags.contains(element)) {
            documentData += '${element.text.replaceAll(RegExp(r"\[.*?\]"), '')}\n';
          } else if (imgTags.contains(element)) {
            // print(element);
          }
          else if (h2Tags.contains(element) && element != sectionHeader) {
            break;
          }
        } else {}
      }
      
      return documentData.split(" ").length > DOCUMENT_LENGTH ? [documentData, sectionHeader.text] : await getArticleBody(article);
    }

    return [finalResponse, article + "#"];
  }

  static Future<List<List<String>>> getMultipleStrings(int max, SharedPreferences sharedPreferences) async {
    List<List<String>> multipleStrings = [];

    for (int i = 0; i < max; i++) {
      String articleName = await getArticleTitle(sharedPreferences);
      List<String> articleBody = await getArticleBody(articleName);
      multipleStrings.add([articleName, articleBody[0], articleBody[1]]);
    }

    return multipleStrings;
  }
}
