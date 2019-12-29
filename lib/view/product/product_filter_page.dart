import 'dart:io';

import 'package:flutter/material.dart';

class ProductFilterPage extends StatelessWidget {
  final _key = GlobalKey<ScaffoldState>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text("Filter Data"),
        brightness: Platform.isIOS ? Brightness.light:Brightness.dark,
      ),
      body: null,
    );
  }
}