import 'package:flutter/material.dart';
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

  void functanlity() async {
    setState(() {
      taped = true;
    });
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