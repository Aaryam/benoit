import 'package:benoit/misc/utilities.dart';
import 'package:flutter/material.dart';

class ContextBox extends StatelessWidget {
  final contextText;

  const ContextBox({super.key, required this.contextText});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Alert',
        style: TextStyle(fontFamily: 'Poppins'),
      ),
      content: SingleChildScrollView(
        child: FutureBuilder<String>(
          future: AIUtilities.requestResponse('Summarize this text within 50 words: $contextText'),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {

              String finalContextText = snapshot.data as String;

              return ListBody(
                children: <Widget>[
                  Text(
                    finalContextText,
                    style: const TextStyle(fontFamily: 'Poppins', fontSize: 14),
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
