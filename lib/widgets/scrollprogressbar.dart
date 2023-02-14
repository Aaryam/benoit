import 'package:benoit/misc/utilities.dart';
import 'package:flutter/material.dart';

class ScrollProgressBar extends StatefulWidget {
  final ScrollController scrollController;

  const ScrollProgressBar({super.key, required this.scrollController});

  @override
  ScrollProgressBarState createState() => ScrollProgressBarState();
}

class ScrollProgressBarState extends State<ScrollProgressBar> {
  double _progress = 0;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_updateProgress);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_updateProgress);
    super.dispose();
  }

  void _updateProgress() {
    final maxScroll = widget.scrollController.position.maxScrollExtent;
    final currentScroll = widget.scrollController.position.pixels;
    final newProgress = currentScroll / maxScroll;
    setState(() {
      _progress = newProgress.isNaN ? 0 : newProgress;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: _progress,
      backgroundColor: Colors.grey[300],
      minHeight: MediaQuery.of(context).size.height * 0.01,
      valueColor: AlwaysStoppedAnimation<Color>(BenoitColors.jungleGreen),
    );
  }
}
