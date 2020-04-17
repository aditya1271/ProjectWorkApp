import 'package:flutter/material.dart';

class Image_Provider extends ChangeNotifier {
  Image _img;

  Image get img {
    return _img;
  }

  void functionhelpingchangereview(Image img) {
    _img = img;


    notifyListeners();
  }
}
