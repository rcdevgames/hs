import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:housesolutions/bloc/auth_bloc.dart';
import 'package:housesolutions/model/district.dart';
import 'package:housesolutions/model/province.dart';
import 'package:housesolutions/util/all_translation.dart';
import 'package:housesolutions/util/validator.dart';
import 'package:housesolutions/widget/input.dart';
import 'package:housesolutions/widget/loading.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with ValidationMixin {
  final _key = GlobalKey<ScaffoldState>();
  final _form = GlobalKey<FormState>();
  final bloc = BlocProvider.getBloc<AuthBloc>();

  final FocusNode _email = new FocusNode();
  final FocusNode _password = new FocusNode();
  final FocusNode _password_conf = new FocusNode();
  final FocusNode _phone = new FocusNode();
  final FocusNode _address = new FocusNode();

  @override
  void initState() { 
    super.initState();
    bloc.fetchProvince();
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
          body: Form(
            key: _form,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: <Widget>[
                    InputText(
                      validator: validateRequired,
                      label: allTranslations.text("FULL_NAME"),
                      textInputAction: TextInputAction.next,
                      onSaved: bloc.setName,
                      onFieldSubmitted: (i) => FocusScope.of(context).requestFocus(_email),
                    ),
                    InputText(
                      focusNode: _email,
                      validator: validateEmail,
                      label: "Email",
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      onSaved: bloc.setEmail,
                      onFieldSubmitted: (i) => FocusScope.of(context).requestFocus(_password),
                    ),
                    StreamBuilder(
                      initialData: false,
                      stream: bloc.getHint,
                      builder: (context, snapshot) {
                        return InputText(
                          focusNode: _password,
                          validator: validatePassword,
                          label: allTranslations.text("PASSWORD"),
                          textInputAction: TextInputAction.next,
                          onSaved: bloc.setPassword,
                          onFieldSubmitted: (i) => FocusScope.of(context).requestFocus(_password_conf),
                          hintTap: () => bloc.setHint(!snapshot.data),
                          isPassword: true,
                          obscureText: !snapshot.data
                        );
                      }
                    ),
                    StreamBuilder(
                      initialData: false,
                      stream: bloc.getHint,
                      builder: (context, snapshot) {
                        return InputText(
                          focusNode: _password_conf,
                          validator: validatePassword,
                          label: allTranslations.text("CONFIRMATION_PASSWORD"),
                          textInputAction: TextInputAction.next,
                          onSaved: bloc.setPassword,
                          onFieldSubmitted: (i) => FocusScope.of(context).requestFocus(_phone),
                          hintTap: () => bloc.setHint(!snapshot.data),
                          isPassword: true,
                          obscureText: !snapshot.data
                        );
                      }
                    ),
                    InputText(
                      focusNode: _phone,
                      validator: validateRequiredNumber,
                      label: allTranslations.text("PHONE"),
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      onSaved: bloc.setPhone,
                      onFieldSubmitted: (i) => FocusScope.of(context).requestFocus(_address),
                    ),
                    InputText(
                      focusNode: _address,
                      validator: validateRequired,
                      label: allTranslations.text("ADDRESS"),
                      textInputAction: TextInputAction.newline,
                      maxLines: 3,
                      onSaved: bloc.setAddress,
                    ),
                    StreamBuilder<List<Province>>(
                      stream: bloc.getProvinces,
                      builder: (context, snapshot) {
                        return StreamBuilder<int>(
                          stream: bloc.getProvince,
                          builder: (context, province) {
                            return DropdownButtonFormField<int>(
                              validator: validateRequiredInteger,
                              value: province.data,
                              onChanged: (int i) {
                                bloc.setProvince(i);
                                bloc.fetchDistrict(i);
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                labelText: allTranslations.text("PROVINCE")
                              ),
                              items: snapshot.hasData ? snapshot.data.map((province) {
                                return DropdownMenuItem(
                                  value: province.idProvince,
                                  child: Text(province.provinceName),
                                );
                              }).toList():<DropdownMenuItem<int>>[],
                            );
                          }
                        );
                      }
                    ),
                    StreamBuilder<List<District>>(
                      stream: bloc.getDistricts,
                      builder: (context, snapshot) {
                        return StreamBuilder<int>(
                          stream: bloc.getDistrict,
                          builder: (context, district) {
                            return DropdownButtonFormField<int>(
                              validator: validateRequiredInteger,
                              value: district.data,
                              onChanged: bloc.setDistrict,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                labelText: allTranslations.text("CITY")
                              ),
                              items: snapshot.hasData ? snapshot.data.map((district) {
                                return DropdownMenuItem(
                                  value: district.idDistrict,
                                  child: Text(district.districtName),
                                );
                              }).toList():<DropdownMenuItem<int>>[],
                            );
                          }
                        );
                      }
                    ),
                    SizedBox(height: 30),
                    Row(
                      children: <Widget>[
                        StreamBuilder<bool>(
                          initialData: false,
                          stream: bloc.getAgreement,
                          builder: (context, snapshot) {
                            return Checkbox(
                              value: snapshot.data,
                              onChanged: (i) => bloc.openAgreement(i),
                              activeColor: Theme.of(context).primaryColor,
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            );
                          }
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 5),
                          child: Text(allTranslations.text("AGREEMENT")),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Text(allTranslations.text("AGREEMENT_BUTTON"), style: TextStyle(color: Theme.of(context).primaryColor)),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    StreamBuilder<bool>(
                      initialData: false,
                      stream: bloc.getAgreement,
                      builder: (context, snapshot) {
                        return RaisedButton(
                          color: Theme.of(context).primaryColor,
                          elevation: 0,
                          onPressed: snapshot.data ? null : () => bloc.doRegister(_form),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Center(child: Text(allTranslations.text("SIGN_UP"), style: TextStyle(color: Colors.white)))
                          ),
                        );
                      }
                    ),
                  ],
                ),
              ),
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