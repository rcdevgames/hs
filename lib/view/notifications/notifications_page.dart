import 'dart:io';

import 'package:flutter/material.dart';
import 'package:housesolutions/util/all_translation.dart';

class NotificationsPage extends StatelessWidget {
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text(allTranslations.text("NOTIFICATION")),
        brightness: Platform.isIOS ? Brightness.light:Brightness.dark,
      ),
      body: Center(
        child: Text("Tidak ada notifikasi"),
      ),
    );
  }
}