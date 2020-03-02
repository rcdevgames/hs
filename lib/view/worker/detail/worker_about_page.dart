import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class WorkerAboutPage extends StatelessWidget {
  String data;
  WorkerAboutPage(this.data);

  final _key = GlobalKey<ScaffoldState>();

  Widget profileDataBig(context, {String key, String value}) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(key, style: TextStyle(fontWeight: FontWeight.w500)),
                    Text(":")
                  ],
                ),
              ),
              SizedBox(width: 10),
              Expanded(flex:2, child: Text("")),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
          child: value != null ? Html(data: value):Text(""),
        ),
        Divider(color: Theme.of(context).primaryColor)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text("Tentang Pekerja"),
      ),
      body: SingleChildScrollView(child: profileDataBig(context, key: "Tentang Pekerja", value: data)),
    );
  }
}