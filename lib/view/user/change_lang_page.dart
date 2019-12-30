import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:housesolutions/util/all_translation.dart';
import 'package:housesolutions/util/session.dart';

class ChangeLanguagePage extends StatefulWidget {
  @override
  _ChangeLanguagePageState createState() => _ChangeLanguagePageState();
}

class _ChangeLanguagePageState extends State<ChangeLanguagePage> {
  final _key = GlobalKey<ScaffoldState>();

  void do_change(String code) {
    showAlert(
      context: context,
      title: allTranslations.text("CHANGE_LANG"),
      body: allTranslations.text("PROMT_CHANGE_LANG"),
      actions: [
        AlertAction(
          text: "Confirm",
          onPressed: () async {
            await allTranslations.setNewLanguage(code);
            setState(() {});
            sessions.save("lang", code);
          }
        ),
        AlertAction(
          text: "Cancel",
          onPressed: () => null
        ),
      ]
    );
  }

  Widget buttonLanguage({@required String title, bool selected, void Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.all(0),
        shape: BeveledRectangleBorder(),
        child: SizedBox(
          height: 50,
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 70,
                child: selected ? Icon(FontAwesomeIcons.check, size: 18, color: Colors.green):null,
              ),
              Text(title)
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        brightness: Platform.isIOS ? Brightness.light:Brightness.dark,
        title: Text(allTranslations.text("CHANGE_LANG")),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ListView(
          children: <Widget>[
            buttonLanguage(
              title: "English (EN)",
              selected: allTranslations.currentLanguage == 'en' ? true:false,
              onTap: allTranslations.currentLanguage == 'en' ? null:() => do_change('en')
            ),
            buttonLanguage(
              title: "Bahasa Indonesia (ID)",
              selected: allTranslations.currentLanguage == 'id' ? true:false,
              onTap: allTranslations.currentLanguage == 'id' ? null:() => do_change('id')
            ),
          ],
        ),
      ),
    );
  }
}