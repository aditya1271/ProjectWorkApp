import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:v1/Widgets/ImagePreview.dart';
import '../Widgets/CameraContainer(Button).dart';
import '../Widgets/GalleryButton.dart';

Route createpage() {
  //const routename = 'ImageInputScreen';
  return PageRouteBuilder(
      transitionDuration: Duration(seconds: 2),
      pageBuilder: (context, animation, secondaryanimation) =>
          ImageInputScreen(),
      transitionsBuilder: (context, animation, secondaryanimation, child) {
        var tween = Tween(
          begin: 0.0,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeIn));
        var fadeanimation = animation.drive(tween);
        return FadeTransition(
          opacity: fadeanimation,
          child: child,
        );
      });
}

class ImageInputScreen extends StatelessWidget {
  static Function f;
  static Image img;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(""),),
      body: LayoutBuilder(builder: (context, contraints) {
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
                      child: GalleryContainer(h: contraints.maxHeight * 0.1,
                          w: contraints.maxWidth * 1 / 2),
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
                onTap: () {
                  // Navigator.of(context).pop();
                },
                splashColor: Theme.of(context).primaryColor,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: Text(
                    "Go",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.height >= 1000.0
                            ? 50
                            : 25),
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
      }),
    );
  }
}
