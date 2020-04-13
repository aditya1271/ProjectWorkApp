import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v1/firsttimeinstalling.dart';
import 'package:v1/providers/firsttimeprovider.dart';
import 'package:v1/screen/imageinputscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: FirstTimeProvider()),
      ],
      child: MaterialApp(
        home: HomeApp(),
        theme: ThemeData(
          primaryColor: Color.fromRGBO(14, 196, 169, 1),
          accentColor: Color.fromRGBO(7, 218, 230, 1),
          canvasColor: Color.fromRGBO(25, 26, 26, 1)
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
    return Scaffold(
      appBar: AppBar(
        title: Text("2"),
      ),
      body: Consumer<FirstTimeProvider>(
        builder: (context, val, _) => FutureBuilder(
          builder: (context, snapshot) =>
              val.temp ? ImageInputScreen() : Firsttime(),
          future: val.f2(),
        ),
      ),
    );
  }
}
