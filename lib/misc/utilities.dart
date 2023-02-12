import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';

class BenoitColors {
  static MaterialColor jungleGreen = const MaterialColor(0xFF4BA58D, <int, Color> {
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
      "model": "text-davinci-001",
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
