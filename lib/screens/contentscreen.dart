import 'package:benoit/misc/utilities.dart';
import 'package:benoit/screens/homescreen.dart';
import 'package:benoit/screens/preferencescreen.dart';
import 'package:benoit/widgets/newscard.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as DOM;
import 'package:flutter/services.dart';

class ContentScreen extends StatefulWidget {
  const ContentScreen({super.key, required this.articleTitle, required this.imageSrc});

  final String articleTitle;
  final String imageSrc;

  @override
  State<ContentScreen> createState() => ContentScreenState();
}

class ContentScreenState extends State<ContentScreen>
    with SingleTickerProviderStateMixin {
  PageController controller = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.thumb_up), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.thumb_down), label: ''),
        ],
        onTap: (int index) {
          if (index == 0) {
            Navigator.pop(context);
          } else if (index == 1) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(
                    title: 'Benoit',
                  ),
                ),
                (Route<dynamic> route) => false);
          } else {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const PreferencesScreen(
                    title: 'Benoit',
                  ),
                ),
                (Route<dynamic> route) => false);
          }
        },
      ),
      body: FutureBuilder<DOM.Document?>(
        future: ScrapingUtilities.getArticleDocument(widget.articleTitle),
        builder: (context, contentSnapshot) {

          if (contentSnapshot.hasData) {
            return NewsCard(
              articleTitle: widget.articleTitle,
              document: contentSnapshot.data as DOM.Document,
              imageSrc: widget.imageSrc,
            );
          } else if (contentSnapshot.hasError) {
            return Text(contentSnapshot.error.toString());
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
      floatingActionButton: FloatingActionButton(
        focusElevation: 0,
        hoverElevation: 0,
        disabledElevation: 0,
        highlightElevation: 0,
        backgroundColor: BenoitColors.jungleGreen,
        tooltip: 'Context Search: Copy text and click the button!',
        onPressed: () async {
          ClipboardData copyText =
              await Clipboard.getData('text/plain') as ClipboardData;

          showModalBottomSheet(
              context: context,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              builder: (context) {
                return Padding(
                    padding: const EdgeInsets.only(
                        top: 40.0, left: 40.0, right: 40.0, bottom: 0),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: FutureBuilder<String>(
                        future: ScrapingUtilities.getArticleBrief(
                            copyText.text!.replaceAll(" ", "_")),
                        builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.data != null) {
                            String finalContextText = snapshot.data as String;

                            return ListBody(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20.0),
                                  child: Center(
                                    child: Text(
                                      finalContextText != ''
                                          ? (copyText.text as String)
                                              .replaceAll('_', ' ')
                                          : 'Non-existant Article',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Poppins',
                                        fontSize: 24,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  finalContextText != ''
                                      ? finalContextText
                                      : 'Copy text exactly as how it should be searched, and click the button to use Context Search.',
                                  style: const TextStyle(
                                      fontFamily: 'Poppins', fontSize: 14),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 20.0),
                                ),
                              ],
                            );
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
                      ),
                    ));
              });
        },
        elevation: 0,
        foregroundColor: Colors.white,
        child: const Icon(Icons.search),
      ),
    );
  }
}
