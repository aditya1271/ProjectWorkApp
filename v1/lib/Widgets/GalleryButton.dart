import 'dart:async';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart' as path;

import 'package:v1/providers/imageprovider.dart';

class GalleryContainer extends StatefulWidget {
  final double h;
  final double w;
  final AnimationController controller;

  // final Function f;

  GalleryContainer({this.h, this.w, this.controller});

  @override
  _GalleryContainerState createState() => _GalleryContainerState();
}

class _GalleryContainerState extends State<GalleryContainer> {
  bool taped = false;
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
    try {
      final img = await ImagePicker.pickImage(
        source: ImageSource.gallery,
      );

      Provider.of<Image_Provider>(context, listen: false)
          .functionhelpingchangereview(Image.file(img));
      final path1 = await path_provider.getApplicationDocumentsDirectory();
      final path2 = path.basename(img.path);

      final copiedpath=img.copy(path.join(path1.path,path2));
    } catch (error) {
      print(error);
    }







  }
  //Users/bharatgupta/Library/Developer/CoreSimulator/Devices/9F0D36CD-B945-49F7-807F-B01206C7D645/data/Containers/Data/Application/DD7451DC-748D-4EE5-9842-364A4CC468B1/Documents

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        functanlity();
      },
      child: Container(
        child: Icon(
          Icons.attach_file,
          color: taped ? Colors.white : Colors.black,
          size: MediaQuery.of(context).size.height > 800 ? 30 : 25,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        margin: EdgeInsets.symmetric(horizontal: 10),
        height: widget.h,
        width: widget.w,
      ),
    );
  }
}
