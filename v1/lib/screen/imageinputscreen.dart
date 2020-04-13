import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageInputScreen extends StatefulWidget {
  @override
  _ImageInputScreenState createState() => _ImageInputScreenState();
}

class _ImageInputScreenState extends State<ImageInputScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, contraints) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Text(
                  "sdf",
                  style: TextStyle(color: Colors.black),
                ),
                color: Colors.white,
                height: contraints.maxHeight * 0.3,
                width: contraints.maxWidth * 0.5,
              ),
              SizedBox(
                height: contraints.maxHeight * 0.1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Icon(Icons.camera_alt),
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        height: contraints.maxHeight * 0.1,
                        width: contraints.maxWidth * 1 / 2,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: GestureDetector(
                      child: Container(
                        child: Icon(Icons.attach_file),
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        height: contraints.maxHeight * 0.1,
                        width: contraints.maxWidth * 1 / 2,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
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
    });
  }
}

