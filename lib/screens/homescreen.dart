import 'package:benoit/misc/utilities.dart';
import 'package:benoit/widgets/contextbox.dart';
import 'package:benoit/widgets/newscard.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  PageController controller = PageController(keepPage: true);
  late AnimationController animationController;
  late Animation likeBtnTween;
  late TextSelectionControls bodySelectionControl;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    likeBtnTween = ColorTween(
            begin: BenoitColors.jungleGreen, end: BenoitColors.jungleGreen[900])
        .animate(animationController);

    bodySelectionControl = MaterialTextSelectionControls();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemBuilder: ((context, index) {
          return const NewsCard();
        }),
      ),
      floatingActionButton: AnimatedBuilder(
        animation: likeBtnTween,
        builder: ((context, child) {
          return FloatingActionButton(
            focusElevation: 0,
            hoverElevation: 0,
            disabledElevation: 0,
            highlightElevation: 0,
            backgroundColor: likeBtnTween.value,
            onPressed: () async {
              if (animationController.status == AnimationStatus.completed) {
                animationController.reverse();
              } else {
                animationController.forward();
              }

              ClipboardData copyText = await Clipboard.getData('text/plain') as ClipboardData;

              showDialog(context: context, builder: (context) {
                return ContextBox(contextText: copyText.text as String);
              });
            },
            elevation: 0,
            foregroundColor: Colors.white,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(0),
              child: const Icon(Icons.search),
            ),
          );
        }),
      ),
    );
  }
}
