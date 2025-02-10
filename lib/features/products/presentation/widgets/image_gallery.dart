import 'dart:io';

import 'package:flutter/material.dart';

class ImageGallery extends StatelessWidget {
  final List<String> images;
  const ImageGallery({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
      return ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: Image.asset('assets/images/no-image.jpg', fit: BoxFit.cover));
    }

    return PageView(
      scrollDirection: Axis.horizontal,
      controller: PageController(viewportFraction: 0.7),
      children: images.map((imagePath) {
        late ImageProvider imageProvider;
        if (imagePath.startsWith('http')) {
          imageProvider = NetworkImage(imagePath);
        } else {
          imageProvider = FileImage(File(imagePath));
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: FadeInImage(
              image: imageProvider,
              fit: BoxFit.cover,
              placeholder: const AssetImage('assets/loaders/bottle-loader.gif'),
            ),
          ),
        );
      }).toList(),
    );
  }
}
