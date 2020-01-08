import 'dart:io';

import 'package:flutter/material.dart';
import 'package:housesolutions/util/all_translation.dart';

class OrderDetailPage extends StatefulWidget {
  

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        brightness: Platform.isIOS ? Brightness.light:Brightness.dark,
        title: Text(allTranslations.text("DETAIL_TRANSACTION")),
      ),
    );
  }
}