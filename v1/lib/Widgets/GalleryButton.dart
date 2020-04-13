import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class GalleryContainer extends StatefulWidget {
  final double h;
  final double w;

  // final Function f;

  GalleryContainer(this.h, this.w);

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
    if(timer!=null)
      timer.cancel();
    timer=Timer(Duration(seconds: 1),(){
      setState(() {
        taped=false;
      });
    });

    final img = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );

  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        functanlity();
      },
      child: Container(
        child:
            Icon(Icons.attach_file, color: taped ? Colors.white : Colors.black),
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
