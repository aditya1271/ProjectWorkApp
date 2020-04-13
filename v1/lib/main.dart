import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v1/firsttimeinstalling.dart';
import 'package:v1/providers/firsttimeprovider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: firsttimeprovider()),
      ],
      child: MaterialApp(
        home: HomeApp(),
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
      body: Consumer<firsttimeprovider>(
        builder: (context, val, _) => FutureBuilder(
          builder: (context, snapshot) => val.temp ? Text("yeh") : Firsttime(),
          future: val.f2(),
        ),
      ),
    );
  }
}
