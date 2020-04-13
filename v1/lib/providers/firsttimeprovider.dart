import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstTimeProvider extends ChangeNotifier {
  bool _temp=false;
  bool get  temp
  {
    return _temp;
}

Future<void> f1() async {
    final pref = await SharedPreferences.getInstance();

    pref.setString("id", "ready");

    notifyListeners();
  }
Future<void> f2()async{
    final pref = await SharedPreferences.getInstance();
    if(pref.containsKey("id"))
      _temp=true;

    else
      _temp=false;

  }


}
