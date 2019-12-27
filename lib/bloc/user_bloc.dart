import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cryptoutils/cryptoutils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:housesolutions/model/district.dart';
import 'package:housesolutions/model/province.dart';
import 'package:housesolutions/model/user_model.dart';
import 'package:housesolutions/provider/repository.dart';
import 'package:housesolutions/util/nav_service.dart';
import 'package:housesolutions/util/session.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc extends BlocBase {
  final _user = BehaviorSubject<User>();
  final _loading = BehaviorSubject<bool>.seeded(false);
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
  final _image64 = BehaviorSubject<String>();

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
    _image64.close();
  }

  void disposed() {
    _user.sink.add(null);
    _loading.sink.add(false);
    _name.sink.add(null);
    _phone.sink.add(null);
    _address.sink.add(null);
    _provinces.sink.add(null);
    _districts.sink.add(null);
    _province.sink.add(null);
    _district.sink.add(null);
    _password.sink.add(null);
    _password_conf.sink.add(null);
    _password_old.sink.add(null);
    _images.sink.add(null);
    _image64.sink.add(null);
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
  Function(User) get setUser => _user.sink.add;

  //Function
  Future fetchUser() async {
    try {
      _user.sink.add(await repo.getUser());
    } catch (e) {
      print("Get User Data : ${e.toString()}");
      if (e.toString().contains("Unauthorized")) {
        sessions.clear();
        return navService.navigateReplaceTo("/login", "unauthorized");
      }
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
        setLoading(false);
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
        if (e.toString().contains("Unauthorized")) {
          sessions.clear();
          return navService.navigateReplaceTo("/login", "unauthorized");
        }
        showAlert(
          context: key.currentContext,
          title: "Ubah Kata Sandi Error",
          body: e.toString().replaceAll("Exception : ", "")
        );
      }
    }
  }

  void doChangeProfile(GlobalKey<FormState> key) async {
    if (key.currentState.validate()) {
      key.currentState.save();
      setLoading(true);
      try {
        var result = await repo.updateProfile(_province.value, _district.value, _name.value, _user.value.customerEmail, _phone.value, _address.value, _image64.value);
        setLoading(false);
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
        print("Change Profile : " + e.toString());
        if (e.toString().contains("Unauthorized")) {
          sessions.clear();
          return navService.navigateReplaceTo("/login", "unauthorized");
        }
        showAlert(
          context: key.currentContext,
          title: "Ubah Profil Error",
          body: e.toString().replaceAll("Exception : ", "")
        );
      }
    }
  }

  void changeAvatar(ImageSource source) async {
    if (source != null) {
      var img = await ImagePicker.pickImage(source: source, imageQuality: 40);
      if (img != null) {
        List<int> imageBytes = img.readAsBytesSync();
        String base64Image = CryptoUtils.bytesToBase64(imageBytes);
        _image64.sink.add("data:image/jpeg;base64,$base64Image");
        _images.sink.add(img);
      }
    }
  }

}