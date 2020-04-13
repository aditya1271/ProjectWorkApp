import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:v1/providers/firsttimeprovider.dart';

class Firsttime extends StatefulWidget {
  @override
  _FirsttimeState createState() => _FirsttimeState();
}

class _FirsttimeState extends State<Firsttime> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.add),
      onPressed: () {
        Provider.of<firsttimeprovider>(context, listen: false).f1();
      },
    );
  }
}
