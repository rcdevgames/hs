import 'dart:io';

import 'package:flutter/material.dart';
import 'package:housesolutions/widget/loading.dart';

class LoadingPayment extends StatelessWidget {
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        brightness: Platform.isIOS ? Brightness.light:Brightness.dark,
        title: Text("Memproses Pesanan"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            LoadingBlock(),
            SizedBox(height: 10),
            Text("Sedang memproses pesanan anda.", style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 25, fontWeight: FontWeight.w700), textAlign: TextAlign.center),
            SizedBox(height: 5),
            Text("Jangan tutup atau keluarkan aplikasi, tunggu hingga proses selesai.", style: TextStyle(color: Colors.grey, fontSize: 16), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}