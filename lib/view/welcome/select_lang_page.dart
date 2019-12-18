import 'package:flutter/material.dart';
import 'package:housesolutions/util/all_translation.dart';
import 'package:housesolutions/util/session.dart';

class SelectLangPage extends StatefulWidget {
  @override
  _SelectLangPageState createState() => _SelectLangPageState();
}

class _SelectLangPageState extends State<SelectLangPage> {
  final _key = GlobalKey<ScaffoldState>();
  String lang;

  @override
  void initState() { 
    super.initState();
    initLang();
  }

  initLang() async {
    lang = await sessions.load("Lang");
    if (lang == null) lang = 'id';
    setState(() {});
  }

  Widget buttonLang(String code, String icon, String name) {
    return SizedBox( 
      height: 75,
      width: MediaQuery.of(context).size.width / 3,
      child: RaisedButton(
        elevation: (lang == code)?2:10,
        onPressed: () async {
          await allTranslations.setNewLanguage(code);
          sessions.save("lang", code);
          setState(() => lang = code);
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Image.asset(icon, width: 30, height: 30,),
              Text(name)
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(allTranslations.text("SELECT_LANG")),
                    SizedBox(height: MediaQuery.of(context).size.height /12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        buttonLang("en", "assets/Images/en.png", "English"),
                        buttonLang("id", "assets/Images/id.png", "Indonesia"),
                      ],
                    ),
                  ],
                ),
              ),
              RaisedButton(
                onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil("/welcome", (Route<dynamic> route) => false),
                child: SizedBox(
                  width: double.infinity,
                  child: Center(child: Text(allTranslations.text("NEXT")))
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}