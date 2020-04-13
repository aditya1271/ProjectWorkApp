import 'package:flutter/material.dart';

class ImageInputScreen extends StatefulWidget {
  @override
  _ImageInputScreenState createState() => _ImageInputScreenState();
}

class _ImageInputScreenState extends State<ImageInputScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(),
        Material(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
          color: Theme.of(context).accentColor,
          child: InkWell(
            onTap: () {},
            splashColor: Theme.of(context).primaryColor,
            child: Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              height: 40,
              child: Text(
                "Go",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
                textAlign: TextAlign.center,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
