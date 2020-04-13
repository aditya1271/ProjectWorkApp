import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Widgets/CameraContainer(Button).dart';
import '../Widgets/GalleryButton.dart';

class ImageInputScreen extends StatefulWidget {
  @override
  _ImageInputScreenState createState() => _ImageInputScreenState();
}

class _ImageInputScreenState extends State<ImageInputScreen> {
  Image img;

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
                  color: Theme.of(context).primaryColor,
                ),
                child: img == null
                    ? ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: Image.asset(
                          'assets/images/no_image.png',
                          fit: BoxFit.cover,
                        ),
                      )
                    : Text("Asdf"),
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

