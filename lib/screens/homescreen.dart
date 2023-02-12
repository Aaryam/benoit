import 'package:benoit/misc/tempvarstore.dart';
import 'package:benoit/misc/utilities.dart';
import 'package:benoit/widgets/newscard.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  PageController controller = PageController();
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
          return const NewsCard(
            title: 'Untitled',
            img: 'https://cdn.vox-cdn.com/thumbor/201jHY6gZb68viG_DhitZzp1OCw=/0x0:2040x1360/2000x1333/filters:focal(1020x680:1021x681)/cdn.vox-cdn.com/uploads/chorus_asset/file/22977156/acastro_211101_1777_meta_0002.jpg',
          );
        }),
        itemCount: 100,
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

              ClipboardData data = await Clipboard.getData('text/plain') as ClipboardData;

              print(data.text);
            },
            elevation: 0,
            foregroundColor: Colors.white,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(0),
              child: const Icon(Icons.share),
            ),
          );
        }),
      ),
    );
  }
}
