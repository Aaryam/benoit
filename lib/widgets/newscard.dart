import 'dart:convert';

import 'package:benoit/misc/utilities.dart';
import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  final title;
  final img;

  const NewsCard({Key? key, this.title, this.img}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: FutureBuilder<String>(
          // Write a wikipedia article of 300 words, with at least 3 paragraphs on the history and the life of only one specific interesting historical figure (such as a entrepreneur or serial killer) or historical event that might seem interesting (such as a war) and mention the name of the topic at the start. Make the writing thematic, with at least 3 paragraphs. Do not reference this prompt whatsoever, write as if it is a wikipedia article.
          future: AIUtilities.requestResponse(
              'Write a wikipedia article with at least 300 words, 3 paragraphs with a for a historical figure, event, business, etc. Make the writing clear and concise, with no references to this prompt.'),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              String bodyContent =
                  jsonDecode(snapshot.data as String)['choices'][0]['text'].toString().trim();

              return ListView(
                physics: const BouncingScrollPhysics(),
                children: <Widget>[
                  Image.network(
                    '$img',
                    height: MediaQuery.of(context).size.height * 0.35,
                    fit: BoxFit.cover,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 30,
                    ),
                  ),
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: SelectableText(
                                "Untitled",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 26,
                                ),
                              ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: SelectableText(
                      bodyContent,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Text('$snapshot.error');
            } else {
              return Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.height * 0.15,
                  child: CircularProgressIndicator(
                    color: BenoitColors.jungleGreen,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
