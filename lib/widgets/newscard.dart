import 'package:benoit/misc/utilities.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        child: FutureBuilder<SharedPreferences>(
          future: SharedPreferences.getInstance(),
          builder: (context, sharedPreferencesSnapshot) {
            if (sharedPreferencesSnapshot.hasData) {
              SharedPreferences sharedPreferences =
                  sharedPreferencesSnapshot.data as SharedPreferences;

              return FutureBuilder<List<String>>(
                future: ScrapingUtilities.getInformationBody(sharedPreferences),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    String bodyContent = "";
                    String articleName = snapshot.data![1];

                    if ((snapshot.data![0]).isNotEmpty) {
                      bodyContent = (snapshot.data![0]);
                    } else {}

                    return ListView(
                      physics: const BouncingScrollPhysics(),
                      children: <Widget>[
                        FutureBuilder<String>(
                            builder: ((context, imageSnapshot) {
                              if (imageSnapshot.hasData &&
                                  imageSnapshot.data != null) {
                                return Image.network(
                                  imageSnapshot.data as String,
                                  height:
                                      MediaQuery.of(context).size.height * 0.35,
                                  fit: BoxFit.cover,
                                );
                              } else {
                                return Image.network(
                                  '$img',
                                  height:
                                      MediaQuery.of(context).size.height * 0.35,
                                  fit: BoxFit.cover,
                                );
                              }
                            }),
                            future: ScrapingUtilities.getImageFromArticle(
                                articleName)),
                        const Padding(
                          padding: EdgeInsets.only(
                            top: 30,
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: SelectableText(snapshot.data![1],
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 26,
                                ),
                                toolbarOptions:
                                    const ToolbarOptions(copy: true)),
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
                            onSelectionChanged: (selection, cause) {
                              // selection
                            },
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
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: MediaQuery.of(context).size.height * 0.25,
                        child: Image.asset(
                          "assets/gifs/loadingdots.gif",
                        ),
                      ),
                    );
                  }
                },
              );
            } else if (sharedPreferencesSnapshot.hasError) {
              print(sharedPreferencesSnapshot.error.toString());
              return Text(sharedPreferencesSnapshot.error.toString());
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
