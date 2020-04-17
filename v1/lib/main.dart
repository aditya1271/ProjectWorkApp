import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v1/firsttimeinstalling.dart';
import 'package:v1/providers/firsttimeprovider.dart';
import 'package:v1/screen/imageinputscreen.dart';
import 'package:v1/providers/imageprovider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: FirstTimeProvider()),
        ChangeNotifierProvider.value(value: Image_Provider())
      ],
      child: MaterialApp(
        //builder: DevicePreview.appBuilder,
        home: HomeApp(),
        theme: ThemeData(
          primaryColor: Color.fromRGBO(14, 196, 169, 1),
          accentColor: Color.fromRGBO(7, 218, 230, 1),
          canvasColor: Color.fromRGBO(25, 26, 26, 1),
        ),

      ),
    );
  }
}

class HomeApp extends StatefulWidget {
  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FirstTimeProvider>(
        builder: (context, val, _) => FutureBuilder(
          builder: (context, snapshot) =>
              val.temp ? ImageInputScreen() : Firsttime(),
          future: val.f2(),
        ),

      );

  }
}
