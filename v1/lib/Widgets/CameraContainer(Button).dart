import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../providers/imageprovider.dart';
import 'package:provider/provider.dart';

class CameraContainer extends StatefulWidget {
  final double h;
  final double w;
  AnimationController controller;

  // final Function f;

  CameraContainer(this.h, this.w);

  @override
  _CameraContainerState createState() => _CameraContainerState();
}

class _CameraContainerState extends State<CameraContainer> {
  bool taped = false;
  Image img;
  Timer timer;


  void functanlity() async {
    setState(() {
      taped = true;
    });
    if (timer != null) timer.cancel();
    timer = Timer(Duration(seconds: 1), () {
      setState(() {
        taped = false;
      });
    });
     try{
       final img = await ImagePicker.pickImage(
         source: ImageSource.camera,
       );

       Provider.of<Image_Provider>(context,listen: false)
           .functionhelpingchangereview(Image.file(img));
     } catch(error)
    {
      print(error);
    }


  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        functanlity();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Icon(
          Icons.camera_alt,
          color: taped ? Colors.white : Colors.black,
          size: MediaQuery.of(context).size.height > 800 ? 30 : 25,
        ),
        margin: EdgeInsets.symmetric(horizontal: 10),
        height: widget.h,
        width: widget.w,
      ),
    );
  }
}
