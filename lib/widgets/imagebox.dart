import 'package:flutter/material.dart';

class ImageBox extends StatelessWidget {

  final String imageSrc;

  const ImageBox({super.key, required this.imageSrc});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.3,
        child: Image.network(imageSrc, fit: BoxFit.cover,),
      ),
    );
  }
}