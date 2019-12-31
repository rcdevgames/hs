import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:housesolutions/bloc/user_bloc.dart';
import 'package:housesolutions/model/district.dart';
import 'package:housesolutions/model/province.dart';
import 'package:housesolutions/model/user_model.dart';
import 'package:housesolutions/util/all_translation.dart';
import 'package:housesolutions/util/nav_service.dart';
import 'package:housesolutions/util/validator.dart';
import 'package:housesolutions/widget/error_page.dart';
import 'package:housesolutions/widget/input.dart';
import 'package:responsive_screen/responsive_screen.dart';

class UpdateUserPage extends StatefulWidget {
  @override
  _UpdateUserPageState createState() => _UpdateUserPageState();
}

class _UpdateUserPageState extends State<UpdateUserPage> with ValidationMixin {
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
                        height: hp(35),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          image: snapshot.data?.customerImage == null ? null : DecorationImage(image: CachedNetworkImageProvider(snapshot.data?.customerImage), fit: BoxFit.cover)
                        ),
                        child: snapshot.data?.customerImage == null ? Center(
                          child: Text("RP", textAlign: TextAlign.center, style: TextStyle(fontSize: wp(20), fontWeight: FontWeight.bold, color: Colors.white)),
                        ) : null,
                      ),
                      GestureDetector(
                        onTap: () => bloc.showActionSheet(context),
                        child: Container(
                          height: hp(35),
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
                  InputText(
                    controller: emailCtrl,
                    validator: validateEmail,
                    label: "Email",
                    enabled: false,
                    onSaved: null,
                  ),
                  InputText(
                    controller: nameCtrl,
                    validator: validateRequired,
                    label: "Nama Lengkap",
                    enabled: true,
                    onSaved: bloc.setName,
                  ),
                  InputText(
                    controller: phoneCtrl,
                    validator: validateNumber,
                    label: "Nomor HP",
                    enabled: true,
                    onSaved: bloc.setPhone
                  ),
                  InputText(
                    controller: addressCtrl,
                    focusNode: _address,
                    validator: validateRequired,
                    label: "Alamat",
                    textInputAction: TextInputAction.newline,
                    maxLines: 3,
                    onSaved: bloc.setAddress,
                  ),
                  StreamBuilder<int>(
                    stream: bloc.getProvince,
                    builder: (context, snapshot) {
                      return StreamBuilder<List<Province>>(
                        stream: bloc.getProvinces,
                        builder: (context, list) {
                          return DropdownButtonFormField<int>(
                            value: snapshot.data,
                            onChanged: (int i) {
                              bloc.setProvince(i);
                              bloc.fetchDistrict(i);
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                              labelText: "Provinsi"
                            ),
                            items: list.hasData ? list.data.map((province) {
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
                  StreamBuilder<int>(
                    stream: bloc.getDistrict,
                    builder: (context, snapshot) {
                      return StreamBuilder<List<District>>(
                        stream: bloc.getDistricts,
                        builder: (context, list) {
                          return DropdownButtonFormField<int>(
                            value: snapshot.data,
                            onChanged: bloc.setDistrict,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                              labelText: "Kota/Kabupaten"
                            ),
                            items: list.hasData ? list.data.map((district) {
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
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      elevation: 0,
                      onPressed: () => bloc.doChangeProfile(_form),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Center(child: Text("Simpan", style: TextStyle(color: Colors.white)))
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}