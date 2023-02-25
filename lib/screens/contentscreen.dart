import 'package:benoit/misc/newutilities.dart';
import 'package:benoit/misc/utilities.dart';
import 'package:benoit/screens/homescreen.dart';
import 'package:benoit/widgets/contextbox.dart';
import 'package:benoit/widgets/newscard.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

class ContentScreen extends StatefulWidget {
  const ContentScreen({super.key, required this.articleTitle});

  final String articleTitle;

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
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
        ],
        onTap: (int index) {
          if (index == 0) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(
                    title: 'Benoit',
                  ),
                ),
                (Route<dynamic> route) => false);
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
                  builder: (context) => const HomeScreen(
                    title: 'Benoit',
                  ),
                ),
                (Route<dynamic> route) => false);
          }
        },
      ),
      body: FutureBuilder<List<String>>(
        future: NewScrapingUtilities.getArticleBody(widget.articleTitle),
        builder: (context, contentSnapshot) {
          if (contentSnapshot.hasData) {
            List<String> content = contentSnapshot.data as List<String>;

            return NewsCard(
              articleTitle: widget.articleTitle,
              bodyContent: content[0],
              sectionHeadline: content[1],
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
        onPressed: () async {
          ClipboardData copyText =
              await Clipboard.getData('text/plain') as ClipboardData;

          showDialog(
              context: context,
              builder: (context) {
                return ContextBox(contextText: copyText.text as String);
              });
        },
        elevation: 0,
        foregroundColor: Colors.white,
        child: const Icon(Icons.search),
      ),
    );
  }
}
