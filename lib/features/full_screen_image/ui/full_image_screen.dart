import 'dart:typed_data';
import 'package:flutter/material.dart';

class ImageFullScreen extends StatelessWidget {
  final Uint8List uint8list;
  final String heroTag;
  const ImageFullScreen({
    super.key,
    required this.uint8list,
    this.heroTag = 'hero_image',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: InteractiveViewer(
        child: Container(
          color: Colors.black,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Hero(
              tag: heroTag,
              child: Image.memory(uint8list),
            ),
          ),
        ),
      ),
    );
  }
}
