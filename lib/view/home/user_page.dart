import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:housesolutions/bloc/user_bloc.dart';
import 'package:housesolutions/model/user_model.dart';
import 'package:housesolutions/util/all_translation.dart';
import 'package:housesolutions/util/nav_service.dart';
import 'package:housesolutions/widget/error_page.dart';
import 'package:housesolutions/widget/loading.dart';
import 'package:responsive_screen/responsive_screen.dart';

class UserPage extends StatelessWidget {
  final _refreshKey = GlobalKey<RefreshIndicatorState>();

  Widget profileData(context, {String key, String value}) {
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
                    Text(key),
                    Text(":")
                  ],
                ),
              ),
              SizedBox(width: 10),
              Expanded(flex:2, child: Text(value??"-")),
            ],
          ),
        ),
        Divider(color: Theme.of(context).primaryColor)
      ],
    );
  }

  String initialName(String data) {
    var split_name = data.split(" ");
    if (split_name != null && split_name.length > 0) {
      return "${split_name[0][0].toUpperCase()}${split_name.length > 1 ? split_name[1][0].toUpperCase():''}";
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = Screen(context).wp;
    final Function hp = Screen(context).hp;
    final bloc = BlocProvider.getBloc<UserBloc>();

    return StreamBuilder<User>(
      stream: bloc.getUser,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return RefreshIndicator(
            key: _refreshKey,
            onRefresh: () => null,
            child: ListView(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: hp(35),
                  color: Theme.of(context).primaryColor,
                  child: StreamBuilder<File>(
                    stream: bloc.getImage,
                    builder: (context, image) {
                      if (image.hasData) {
                        return Image.file(image.data, fit: BoxFit.cover, alignment: Alignment.topCenter);
                      }

                      if (snapshot.data.customerImage == null) {
                        return CachedNetworkImage(
                          imageUrl: snapshot.data.customerImage,
                          fit: BoxFit.cover, alignment: Alignment.topCenter
                        );
                      }

                      return Center(
                        child: Text(initialName(snapshot.data.customerName), textAlign: TextAlign.center, style: TextStyle(fontSize: wp(30), color: Colors.white, fontWeight: FontWeight.bold)),
                      );
                    }
                  ),
                ),
                Container(
                  height: 10,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorDark
                  ),
                ),
                Column(
                  children: <Widget>[
                    SizedBox(height: 10),
                    profileData(context, key: allTranslations.text("FULL_NAME"), value: snapshot.data.customerName),
                    profileData(context, key: "Email", value: snapshot.data.customerEmail),
                    profileData(context, key: allTranslations.text("HANDPHONE"), value: snapshot.data.customerHandphone),
                    profileData(context, key: allTranslations.text("ADDRESS"), value: snapshot.data.customerAddress),
                    profileData(context, key: allTranslations.text("CITY"), value: snapshot.data.districtName),
                    profileData(context, key: allTranslations.text("PROVINCE"), value: snapshot.data.provinceName),
                    InkWell(
                      // onTap: () => print(snapshot.data.toJson()),
                      onTap: () => navService.navigateTo("/user-edit", snapshot.data),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        width: double.infinity,
                        child: Text(allTranslations.text("CHANGE_PROFILE"), style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w800), textAlign: TextAlign.center)
                      ),
                    ),
                    Divider(color: Theme.of(context).primaryColor),
                    InkWell(
                      onTap: () => navService.navigateTo("/settings"),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        width: double.infinity,
                        child: Text("Settings", style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w800), textAlign: TextAlign.center)
                      ),
                    ),
                    Divider(color: Theme.of(context).primaryColor),
                    InkWell(
                      onTap: () => showAlert(
                        context: context,
                        title: "Logout",
                        body: allTranslations.text("LOGOUT_NOTICE"),
                        actions: [
                          AlertAction(
                            text: "Cancel",
                            onPressed: () => null
                          ),
                          AlertAction(
                            text: "Confirm",
                            onPressed: bloc.logout
                          )
                        ]
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        width: double.infinity,
                        child: Text("Logout", style: TextStyle(color: Colors.red, fontWeight: FontWeight.w800), textAlign: TextAlign.center)
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                )
              ],  
            ),
          );
        }else if(snapshot.hasError) {
          return Center(
            child: ErrorPage(
              message: snapshot.error,
              buttonText: "ulangi",
              onPressed: () {
                bloc.setUser(null);
                bloc.fetchUser();
              },
            ),
          );
        } return LoadingBlock();
      }
    );
  }
}