import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:housesolutions/bloc/auth_bloc.dart';
import 'package:housesolutions/util/all_translation.dart';
import 'package:housesolutions/util/validator.dart';
import 'package:housesolutions/widget/loading.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> with ValidationMixin {
  final GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _form = new GlobalKey<FormState>();
  final bloc = BlocProvider.getBloc<AuthBloc>();

  @override
  void dispose() {
    super.dispose();
    bloc.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          key: _key,
          appBar: AppBar(
            brightness: Platform.isIOS ? Brightness.light:Brightness.dark,
            iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                Text("${allTranslations.text('FORGOT_PASSWORD')} ?", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600, color: Theme.of(context).primaryColor)),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                  child: Form(
                    key: _form,
                    child: TextFormField(
                      validator: validateEmail,
                      onSaved: bloc.setEmail,
                      decoration: InputDecoration(
                        hintText: "Email",
                        contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    elevation: 0,
                    onPressed: () => bloc.doForgotPassword(_form),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Center(child: Text("Submit", style: TextStyle(color: Colors.white)))
                    ),
                  ),
                ),
              ],
            ),
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