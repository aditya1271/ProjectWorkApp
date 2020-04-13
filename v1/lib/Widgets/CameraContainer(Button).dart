import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class CameraContainer extends StatefulWidget {
  final double h;
  final double w;

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
    if(timer!=null)
      timer.cancel();
    timer=Timer(Duration(seconds: 1),(){
      setState(() {
        taped=false;
      });
    });

    final img = await ImagePicker.pickImage(
      source: ImageSource.camera,
    );
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
        ),
        margin: EdgeInsets.symmetric(horizontal: 10),
        height: widget.h,
        width: widget.w,
      ),
    );
  }
}