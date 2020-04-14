import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:v1/Widgets/ImagePreview.dart';
import '../Widgets/CameraContainer(Button).dart';
import '../Widgets/GalleryButton.dart';

class ImageInputScreen extends StatelessWidget {
  static  Function f;
  static Image img;
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
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  //color: Theme.of(context).primaryColor,
                ),
                child: ImagePreview(),
                height: contraints.maxHeight * 0.4,
                width: contraints.maxWidth * 0.8,
              ),
              SizedBox(
                height: contraints.maxHeight * 0.1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: CameraContainer(contraints.maxHeight * 0.1,
                        contraints.maxWidth * 1 / 2),
                  ),
                  Flexible(
                    flex: 1,
                    child: GalleryContainer(contraints.maxHeight * 0.1,
                        contraints.maxWidth * 1 / 2),
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
