import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:housesolutions/bloc/user_bloc.dart';
import 'package:housesolutions/model/user_model.dart';
import 'package:housesolutions/util/all_translation.dart';
import 'package:housesolutions/util/nav_service.dart';
import 'package:housesolutions/widget/error_page.dart';
import 'package:responsive_screen/responsive_screen.dart';

class UpdateUserPage extends StatefulWidget {
  @override
  _UpdateUserPageState createState() => _UpdateUserPageState();
}

class _UpdateUserPageState extends State<UpdateUserPage> {
  final _key = GlobalKey<ScaffoldState>();
  final _form = GlobalKey<FormState>();
  final bloc = BlocProvider.getBloc<UserBloc>();

  final TextEditingController nameCtrl = new TextEditingController();
  final TextEditingController emailCtrl = new TextEditingController();
  final TextEditingController phoneCtrl = new TextEditingController();
  final TextEditingController addressCtrl = new TextEditingController();

  final FocusNode _email = new FocusNode();
  final FocusNode _phone = new FocusNode();
  final FocusNode _handphone = new FocusNode();
  final FocusNode _address = new FocusNode();

  @override
  void dispose() { 
    nameCtrl.dispose();
    emailCtrl.dispose();
    phoneCtrl.dispose();
    addressCtrl.dispose();
    super.dispose();
  }

  Future loadUser(User user) async {
    // print(user?.toJson());
    await bloc.fetchProvince();
    nameCtrl.text = user.customerName;
    emailCtrl.text = user.customerEmail;
    phoneCtrl.text = user.customerHandphone;
    addressCtrl.text = user.customerAddress;
    bloc.setProvince(user.idProvince);
    await bloc.fetchDistrict(user.idProvince);
    bloc.setDistrict(user.idDistrict);
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = Screen(context).wp;
    final Function hp = Screen(context).hp;

    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text(allTranslations.text("CHANGE_PROFILE")),
        brightness: Platform.isIOS ? Brightness.light:Brightness.dark,
      ),
      body: StreamBuilder<User>(
        stream: bloc.getUser,
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.hasError) {
            return Center(
              child: ErrorPage(
                message: "Tidak dapat mengubah data.",
                buttonText: "kembali",
                onPressed: () => navService.navigatePop(),
              ),
            );
          }
          loadUser(snapshot.data);
          return Form(
            key: _form,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        height: hp(33),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          image: snapshot.data?.customerImage == null ? null : DecorationImage(image: CachedNetworkImageProvider(snapshot.data?.customerImage))
                        ),
                        child: snapshot.data?.customerImage == null ? Center(
                          child: Text("RP", textAlign: TextAlign.center, style: TextStyle(fontSize: wp(20), fontWeight: FontWeight.bold, color: Colors.white)),
                        ) : null,
                      ),
                      GestureDetector(
                        onTap: () => bloc.showActionSheet(context),
                        child: Container(
                          height: hp(40),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.black26
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.camera_alt, color: Colors.white60, size: wp(20)),
                              Text("Tap to Change Avatar", style: TextStyle(color: Colors.white60, fontSize: 20, fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),

                ],
              ),
            ),
          );
        }
      ),
    );
  }
}