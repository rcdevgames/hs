import 'dart:html';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:housesolutions/model/district.dart';
import 'package:housesolutions/model/province.dart';
import 'package:housesolutions/model/user_model.dart';
import 'package:housesolutions/provider/repository.dart';
import 'package:housesolutions/util/nav_service.dart';
import 'package:housesolutions/util/session.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc extends BlocBase {
  final _user = BehaviorSubject<User>();
  final _loading = BehaviorSubject<bool>();
  final _name = BehaviorSubject<String>();
  final _phone = BehaviorSubject<String>();
  final _address = BehaviorSubject<String>();
  final _provinces = BehaviorSubject<List<Province>>();
  final _districts = BehaviorSubject<List<District>>();
  final _province = BehaviorSubject<int>();
  final _district = BehaviorSubject<int>();
  final _password = BehaviorSubject<String>();
  final _password_conf = BehaviorSubject<String>();
  final _password_old = BehaviorSubject<String>();
  final _images = BehaviorSubject<File>();

  UserBloc() {
    fetchUser();
  }

  @override
  void dispose() { 
    super.dispose();
    _user.close();
    _loading.close();
    _name.close();
    _phone.close();
    _address.close();
    _provinces.close();
    _districts.close();
    _province.close();
    _district.close();
    _password.close();
    _password_conf.close();
    _password_old.close();
    _images.close();
  }

  //Getter
  Stream<User> get getUser => _user.stream;
  Stream<bool> get isLoading => _loading.stream;
  Stream<List<Province>> get getProvinces => _provinces.stream;
  Stream<List<District>> get getDistricts => _districts.stream;
  Stream<int> get getProvince => _province.stream;
  Stream<int> get getDistrict => _district.stream;
  Stream<File> get getImage => _images.stream;

  //Setter
  Function(String) get setName => _name.sink.add;
  Function(String) get setPhone => _phone.sink.add;
  Function(String) get setAddress => _address.sink.add;
  Function(int) get setProvince => _province.sink.add;
  Function(int) get setDistrict => _district.sink.add;
  Function(String) get setPassword => _password.sink.add;
  Function(String) get setPasswordConf => _password_conf.sink.add;
  Function(String) get setPasswordOld => _password_old.sink.add;
  Function(File) get setImage => _images.sink.add;
  Function(bool) get setLoading => _loading.sink.add;

  //Function
  Future fetchUser() async {
    try {
      _user.sink.add(await repo.getUser());
    } catch (e) {
      print("Get User Data : ${e.toString()}");
      _user.sink.addError(e.toString().replaceAll("Exception: ", ""));
    }
  }

  void logout() async {
    try {
      repo.logout();
    } catch (_) {}
    sessions.clear();
    await navService.navigateReplaceTo("/main");
    navService.navigateTo("/login");
  }

  void doChangePassword(GlobalKey<FormState> key) async {
    if (key.currentState.validate()) {
      key.currentState.save();
      setLoading(true);
      try {
        var result = await repo.changePassword(_password_old.value, _password.value);
        showAlert(
          context: key.currentContext,
          title: "Success",
          body: result,
          actions: [
            AlertAction(
              text: "Confirm",
              onPressed: navService.navigatePop
            )
          ]
        );
      } catch (e) {
        setLoading(false);
        print("Change Password : " + e.toString());
        showAlert(
          context: key.currentContext,
          title: "Ubah Kata Sandi Error",
          body: e.toString().replaceAll("Exception : ", "")
        );
      }
    }
  }

}