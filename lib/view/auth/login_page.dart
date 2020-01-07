import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:housesolutions/bloc/auth_bloc.dart';
import 'package:housesolutions/r.dart';
import 'package:housesolutions/util/all_translation.dart';
import 'package:housesolutions/util/validator.dart';
import 'package:housesolutions/widget/loading.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with ValidationMixin{
  final _key = GlobalKey<ScaffoldState>();
  final _form = GlobalKey<FormState>();
  final _fcsPWD = FocusNode();
  ImageProvider logo, logo_text;

  @override
  void initState() { 
    super.initState();
    logo = AssetImage(R.assetsImagesIcon);
    logo_text = AssetImage(R.assetsImagesLogo);
  }

  @override
  void dispose() {
    super.dispose();
    BlocProvider.disposeBloc<AuthBloc>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(logo, context);
    precacheImage(logo_text, context);
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.getBloc<AuthBloc>();

    return Stack(
      children: <Widget>[
        Scaffold(
          key: _key,
          resizeToAvoidBottomPadding: true,
          appBar: AppBar(
            brightness: Platform.isIOS ? Brightness.light:Brightness.dark,
            iconTheme: IconThemeData(
              color: Theme.of(context).primaryColor
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: ListView(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height - 80,
                padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 10),
                child: Form(
                  key: _form,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Image(image: logo),
                      ),
                      Center(
                        child: Image(image: logo_text, width: MediaQuery.of(context).size.width / 1.8),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        onSaved: bloc.setEmail,
                        validator: validateEmail,
                        decoration: InputDecoration(
                          labelText: "Email",
                          contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0)
                        ),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (v) => FocusScope.of(context).requestFocus(_fcsPWD),
                      ),
                      StreamBuilder<bool>(
                        initialData: false,
                        stream: bloc.getHint,
                        builder: (context, snapshot) {
                          return TextFormField(
                            onSaved: bloc.setPassword,
                            focusNode: _fcsPWD,
                            validator: validatePassword,
                            obscureText: !snapshot.data,
                            decoration: InputDecoration(
                              labelText: allTranslations.text("PASSWORD"),
                              contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
                              suffix: InkWell(
                                onTap: () => bloc.setHint(!snapshot.data),
                                child: Icon(snapshot.data ? FontAwesomeIcons.eye:FontAwesomeIcons.eyeSlash),
                              )
                            ),
                          );
                        }
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            InkWell(
                              onTap: () => Navigator.of(context).pushNamed("/forgot-password"),
                              child: Text("${allTranslations.text('FORGOT_PASSWORD')}?", style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600)),
                            ),
                          ],
                        )
                      ),
                      RaisedButton(
                        color: Theme.of(context).primaryColor,
                        elevation: 0,
                        onPressed: () => bloc.doLogin(_form),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Center(child: Text(allTranslations.text("SIGN_IN"), style: TextStyle(color: Colors.white)))
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text(allTranslations.text("SOCMED_SPARATOR"), style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black26)),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: RaisedButton(
                              color: Colors.red,
                              elevation: 0,
                              onPressed: () => bloc.doLoginSocmed(context, Socmed.google),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Icon(FontAwesomeIcons.google, color: Colors.white,),
                                  Text("Google", style: TextStyle(color: Colors.white))
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: RaisedButton(
                              color: Colors.blue,
                              elevation: 0,
                              onPressed: () => bloc.doLoginSocmed(context, Socmed.facebbok),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Icon(FontAwesomeIcons.facebookF, color: Colors.white,),
                                  Text("Facebook", style: TextStyle(color: Colors.white))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(allTranslations.text("SIGN_UP_WORD")),
                                SizedBox(width: 10),
                                InkWell(
                                  onTap: () => Navigator.of(context).pushNamed("/register"),
                                  child: Text(allTranslations.text("SIGN_UP"), style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600)),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        StreamBuilder<bool>(
          initialData: false,
          stream: bloc.isLoading,
          builder: (context, snapshot) {
            return Loading(snapshot.data);
          }
        )
      ],
    );
  }
}