import 'package:benoit/misc/utilities.dart';
import 'package:benoit/screens/homescreen.dart';
import 'package:benoit/widgets/imagebox.dart';
import 'package:benoit/widgets/scrollprogressbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        child: Column(
          children: <Widget>[
            ScrollProgressBar(scrollController: scrollController),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: FutureBuilder<SharedPreferences>(
                  future: SharedPreferences.getInstance(),
                  builder: (context, sharedPreferencesSnapshot) {
                    if (sharedPreferencesSnapshot.hasData) {
                      SharedPreferences sharedPreferences =
                          sharedPreferencesSnapshot.data as SharedPreferences;

                      return FutureBuilder<List<String>>(
                        future: ScrapingUtilities.getInformationBody(
                            sharedPreferences),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            String bodyContent = "";
                            String articleName = snapshot.data![1];

                            if ((snapshot.data![0]).isNotEmpty) {
                              bodyContent = (snapshot.data![0]);
                            } else {}

                            return ListView(
                              controller: scrollController,
                              physics: const BouncingScrollPhysics(),
                              children: <Widget>[
                                ImageBox(articleName: articleName),
                                const Padding(
                                  padding: EdgeInsets.only(
                                    top: 30,
                                  ),
                                ),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: SelectableText(
                                        snapshot.data![1]
                                            .replaceAll("_", " ")
                                            .split("#")[0],
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
                                  padding: const EdgeInsets.only(
                                      top: 8, bottom: 8, left: 20, right: 20),
                                  child: Center(
                                    child: SelectableText(
                                    snapshot.data![1]
                                            .replaceAll("_", " ")
                                            .split("#")[1]
                                            .contains("[edit]")
                                        ? snapshot.data![1]
                                            .replaceAll("_", " ")
                                            .split("#")[1]
                                            .split("[edit]")[0]
                                        : snapshot.data![1]
                                            .replaceAll("_", " ")
                                            .split("#")[1],
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                    onSelectionChanged: (selection, cause) {
                                      // selection
                                    },
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
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                                width:
                                    MediaQuery.of(context).size.height * 0.25,
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
            )
          ],
        ),
      ),
    );
  }
}
