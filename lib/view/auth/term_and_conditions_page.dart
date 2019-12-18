import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:housesolutions/bloc/auth_bloc.dart';
import 'package:housesolutions/util/nav_service.dart';
import 'package:housesolutions/widget/error_page.dart';
import 'package:housesolutions/widget/loading.dart';

class TermsAndConditionPage extends StatefulWidget {
  @override
  _TermsAndConditionPageState createState() => _TermsAndConditionPageState();
}

class _TermsAndConditionPageState extends State<TermsAndConditionPage> {
  final _key = GlobalKey<ScaffoldState>();
  final _refreshKey = GlobalKey<RefreshIndicatorState>();
  final bloc = BlocProvider.getBloc<AuthBloc>();

  @override
  void initState() { 
    super.initState();
    bloc.fetchTNC();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          key: _key,
          appBar: AppBar(
            brightness: Platform.isIOS ? Brightness.light:Brightness.dark,
            title: Text("Syarat dan Ketentuan"),
          ),
          body: StreamBuilder<String>(
            stream: bloc.getTNC,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return RefreshIndicator(
                  key: _refreshKey,
                  onRefresh: bloc.fetchTNC,
                  child: ListView(
                    children: <Widget>[
                      Html(data: snapshot.data),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          RaisedButton(
                            onPressed: () {
                              bloc.setAgreement(false);
                              navService.navigatePop();
                            },
                            color: Colors.red,
                            child: Text("Tidak Setuju", style: TextStyle(color: Colors.white)),
                          ),
                          RaisedButton(
                            onPressed: () {
                              bloc.setAgreement(true);
                              navService.navigatePop();
                            },
                            color: Colors.green,
                            child: Text("Setuju", style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              }else if(snapshot.error) {
                return Center(
                  child: ErrorPage(
                    message: snapshot.error,
                    buttonText: "ulangi",
                    onPressed: () {
                      bloc.setTNC(null);
                      bloc.fetchTNC();
                    },
                  ),
                );
              }return LoadingBlock();
            }
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