import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:housesolutions/bloc/user_bloc.dart';
import 'package:housesolutions/util/all_translation.dart';
import 'package:housesolutions/widget/error_page.dart';
import 'package:housesolutions/widget/loading.dart';

class UserAgreementPage extends StatefulWidget {
  @override
  _UserAgreementPageState createState() => _UserAgreementPageState();
}

class _UserAgreementPageState extends State<UserAgreementPage> {
  final _key = GlobalKey<ScaffoldState>();
  final _refreshKey = GlobalKey<RefreshIndicatorState>();
  final bloc = BlocProvider.getBloc<UserBloc>();

  @override
  void initState() { 
    super.initState();
    bloc.fetchTNC();
  }

  @override
  void dispose() {
    bloc.setTNC(null);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text(allTranslations.text("AGREEMENT_BUTTON")),
        brightness: Platform.isIOS ? Brightness.light:Brightness.dark,
      ),
      body: StreamBuilder<String>(
        stream: bloc.getTNC,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return RefreshIndicator(
              key: _refreshKey,
              onRefresh: () => null,
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Html(data: snapshot.data),
                ),
              ),
            );
          } else if(snapshot.hasError) {
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
          } return LoadingBlock();
        }
      ),
    );
  }
}