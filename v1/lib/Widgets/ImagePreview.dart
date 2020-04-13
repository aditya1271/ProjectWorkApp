import 'package:flutter/material.dart';

class ImagePreview extends StatefulWidget {
  @override
  _ImagePreviewState createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  Image img;

  void changeimage(Image temp) {
    setState(() {
      img = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: img == null
            ? Image.asset(
                'assets/images/no_image.png',
                fit: BoxFit.cover,
              )
            : img);
  }
}
