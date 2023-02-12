import 'dart:math';
import 'package:html/dom.dart' as DOM;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:html/parser.dart' as parser;

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
      'Content-Type': 'application/json',
    };
    Map<String, dynamic> reqBody = {
      "prompt": prompt,
      "model": "text-davinci-002",
      "max_tokens": 800,
      "temperature": 0.8,
      "n": 1,
    };

    final encoding = Encoding.getByName('utf-8');

    Response response = await post(
      reqUrl,
      headers: reqHeaders,
      body: json.encode(reqBody),
      encoding: encoding,
    );

    int statusCode = response.statusCode;
    String responseBody = response.body;

    return responseBody;
  }
}

class ScrapingUtilities {
  static Future<String> getArticleData(article) async {
    Response response = await Client()
        .get(Uri.parse('https://en.wikipedia.org/wiki/' + article));
    String finalResponse = "";
    String documentData = "";

    if (response.statusCode == 200) {
      var document = parser.parse(response.body);
      List<DOM.Element> data = document.getElementsByTagName('p');

      for (DOM.Element element in data) {
        if (documentData.length < 2500) {
          documentData += "${element.text}";
        }
        else {
          break;
        }
      }

      documentData = documentData.toString().trim();
      print(documentData);

      finalResponse = await AIUtilities.requestResponse(
          "Summarize this content with less than 400 words, starting with a good intro paragraph, ending with a good conclusion paragraph, and removing wiki references: $documentData");
      return finalResponse;
    }

    return finalResponse;
  }

  static Future<String> selectTopic(textFile) async {
    String text = await rootBundle.loadString('$textFile');
    int randomNumber = Random().nextInt(text.split("\n").length);

    return text.split("\n")[randomNumber];
  }

  static String selectTheme() {
    List<String> themes = [
      "assets/misc/content/celebrities.txt",
      "assets/misc/content/comic_characters.txt",
      "assets/misc/content/entrepreneurs.txt",
      "assets/misc/content/filmmakers.txt",
      "assets/misc/content/global_foods.txt",
      "assets/misc/content/historical_events.txt",
      "assets/misc/content/historical_figures.txt",
      "assets/misc/content/marketing_campaigns.txt"
    ];
    int randomNumber = Random().nextInt(themes.length);

    return themes[randomNumber];
  }

  static Future<String> getInformationBody() async {
    return ScrapingUtilities.getArticleData(await ScrapingUtilities.selectTopic(ScrapingUtilities.selectTheme()));
  }
}
