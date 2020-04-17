import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:v1/providers/firsttimeprovider.dart';
import 'package:v1/screen/imageinputscreen.dart';

class Firsttime extends StatefulWidget {
  @override
  _FirsttimeState createState() => _FirsttimeState();
}

class _FirsttimeState extends State<Firsttime> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IconButton(
        icon: Icon(Icons.add),
        onPressed: () {
           Provider.of<FirstTimeProvider>(context, listen: false).f1();
          Navigator.of(context).pushReplacement(createpage());
        },
      ),
    );
  }
}
