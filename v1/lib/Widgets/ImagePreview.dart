import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/imageprovider.dart';

class ImagePreview extends StatefulWidget {
  @override
  _ImagePreviewState createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  @override
  Widget build(BuildContext context) {
    final img = Provider.of<Image_Provider>(context).img;

    return ClipRRect(

        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: img == null
            ? Image.asset(
                'assets/images/no_image.png',
                fit: BoxFit.cover,
              )
            : FittedBox(child: img,fit: BoxFit.fill,));
  }
}
