import 'package:benoit/misc/utilities.dart';
import 'package:flutter/material.dart';

class ContextBox extends StatelessWidget {
  final String contextText;

  const ContextBox({super.key, required this.contextText});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        contextText.replaceAll("_", " "),
        style: const TextStyle(fontFamily: 'Poppins'),
      ),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.25,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: FutureBuilder<String>(
            future: ScrapingUtilities.getArticleBrief(contextText),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                String finalContextText = snapshot.data as String;

                return ListBody(
                  children: <Widget>[
                    Text(
                      finalContextText,
                      style:
                          const TextStyle(fontFamily: 'Poppins', fontSize: 14),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.height * 0.25,
                    child: Image.asset(
                      "assets/gifs/loadingdots.gif",
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            'Close',
            style: TextStyle(
                fontFamily: 'Poppins', color: BenoitColors.jungleGreen),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
