import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v1/Widgets/GalleryButton.dart';
import '../providers/imageprovider.dart';

class ImagePreview extends StatefulWidget {
  @override
  _ImagePreviewState createState() => _ImagePreviewState();
}


class _ImagePreviewState extends State<ImagePreview>
    with TickerProviderStateMixin {
  Image img;

  AnimationController _controller;
  Animation<double> _animation;


  @override
  void didChangeDependencies() {
   // print("67");
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    _animation = Tween<double>(end: 1, begin: 0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn),
    );
   // setState(() {});
    _controller.forward();


    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    img = Provider.of<Image_Provider>(context).img;

    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      child: img == null
          ? Image.asset(
              'assets/images/no_image.png',
              fit: BoxFit.fill,
            )
          : FittedBox(
            child: FadeTransition(opacity: _animation,child: img),
            fit: BoxFit.fill,
          ),
    );
  }
}
