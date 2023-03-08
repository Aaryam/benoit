import 'package:benoit/misc/utilities.dart';
import 'package:benoit/screens/homescreen.dart';
import 'package:benoit/widgets/imagebox.dart';
import 'package:benoit/widgets/scrollprogressbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsCard extends StatelessWidget {
  const NewsCard(
      {Key? key,
      required this.articleTitle,
      required this.bodyContent,
      required this.sectionHeadline, required this.imageSrc})
      : super(key: key);

  final String articleTitle;
  final String bodyContent;
  final String sectionHeadline;
  final String imageSrc;

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
              child: ScrollProgressBar(scrollController: scrollController),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.99 - 56, // 56px is the height of bottom nav bar
              child: ListView(
              controller: scrollController,
              physics: const BouncingScrollPhysics(),
              children: <Widget>[
                SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                imageSrc,
                fit: BoxFit.cover,
              ),
              ),
            ),
            ),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 30,
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: SelectableText(articleTitle.replaceAll("_", " "),
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontSize: 26,
                        ),
                        toolbarOptions: const ToolbarOptions(copy: true)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 8, bottom: 8, left: 20, right: 20),
                  child: Center(
                    child: SelectableText(
                      sectionHeadline.replaceAll("_", " ").contains("[edit]")
                          ? sectionHeadline
                              .replaceAll("_", " ")
                              .split("[edit]")[0]
                          : sectionHeadline.replaceAll("_", " "),
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
            ),
            ),
          ],
        ),
    );
  }
}
