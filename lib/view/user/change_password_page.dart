import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:housesolutions/bloc/user_bloc.dart';
import 'package:housesolutions/util/all_translation.dart';
import 'package:housesolutions/util/validator.dart';
import 'package:housesolutions/widget/input.dart';
import 'package:housesolutions/widget/loading.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> with ValidationMixin {
  final _key = GlobalKey<ScaffoldState>();
  final _form = GlobalKey<FormState>();
  final bloc = BlocProvider.getBloc<UserBloc>();

  final TextEditingController _old_ctrl = new TextEditingController();
  final TextEditingController _new_ctrl = new TextEditingController();
  final TextEditingController _conf_ctrl = new TextEditingController();

  final FocusNode _old_password = new FocusNode();
  final FocusNode _password = new FocusNode();
  final FocusNode _password_conf = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          key: _key,
          appBar: AppBar(
            brightness: Platform.isIOS ? Brightness.light:Brightness.dark,
            title: Text(allTranslations.text("CHANGE_PASSWORD")),
          ),
          body: Form(
            key: _form,
            child: StreamBuilder<bool>(
              initialData: false,
              stream: bloc.getHint,
              builder: (context, snapshot) {
                return SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      InputText(
                        controller: _old_ctrl,
                        focusNode: _old_password,
                        validator: validatePassword,
                        label: allTranslations.text("OLD_PASSWORD"),
                        textInputAction: TextInputAction.next,
                        onSaved: bloc.setPasswordOld,
                        onFieldSubmitted: (i) => FocusScope.of(context).requestFocus(_password),
                        hintTap: () => bloc.setHint(!snapshot.data),
                        isPassword: true,
                        obscureText: !snapshot.data
                      ),
                      InputText(
                        controller: _new_ctrl,
                        focusNode: _password,
                        validator: validatePassword,
                        label: allTranslations.text("PASSWORD"),
                        textInputAction: TextInputAction.next,
                        onSaved: bloc.setPassword,
                        onFieldSubmitted: (i) => FocusScope.of(context).requestFocus(_password_conf),
                        hintTap: () => bloc.setHint(!snapshot.data),
                        isPassword: true,
                        obscureText: !snapshot.data
                      ),
                      InputText(
                        controller: _conf_ctrl,
                        focusNode: _password_conf,
                        validator: validatePassword,
                        label: allTranslations.text("CONFIRMATION_PASSWORD"),
                        onSaved: bloc.setPasswordConf,
                        hintTap: () => bloc.setHint(!snapshot.data),
                        isPassword: true,
                        obscureText: !snapshot.data
                      ),
                      Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: RaisedButton(
                        color: Theme.of(context).primaryColor,
                        elevation: 0,
                        onPressed: () => bloc.doChangePassword(_form),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Center(child: Text(allTranslations.text("SAVE"), style: TextStyle(color: Colors.white)))
                        ),
                      ),
                    )
                    ],
                  ),
                );
              }
            ),
          ),
        ),
        StreamBuilder<bool>(
          stream: bloc.isLoading,
          builder: (context, snapshot) {
            return Loading(snapshot.data);
          }
        )
      ],
    );
  }
}