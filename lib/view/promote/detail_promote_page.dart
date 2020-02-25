import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:housesolutions/model/promote.dart';
import 'package:responsive_screen/responsive_screen.dart';

class PromoteDetailPage extends StatelessWidget {
  Promote data;
  PromoteDetailPage(this.data);

  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final Function wp = Screen(context).wp;
    final Function hp = Screen(context).hp;

    return Scaffold(
      key: _key,
      appBar: AppBar(
        brightness: Platform.isIOS ? Brightness.light:Brightness.dark,
        title: Text(data.promoteTitle),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: hp(35),
              child: CachedNetworkImage(
                imageUrl: data.promoteBanner,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Icon(Icons.person),
                  Text(data.promoteCreated, style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Html(data: data.promoteContent),
            )
          ],
        ),
      ),
    );
  }
}