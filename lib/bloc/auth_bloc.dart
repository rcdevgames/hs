import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:housesolutions/model/district.dart';
import 'package:housesolutions/model/province.dart';
import 'package:housesolutions/provider/repository.dart';
import 'package:housesolutions/util/nav_service.dart';
import 'package:rxdart/rxdart.dart';

enum Socmed {
  google, facebbok
}

class AuthBloc extends BlocBase {
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _password_conf = BehaviorSubject<String>();
  final _address = BehaviorSubject<String>();
  final _phone = BehaviorSubject<String>();
  final _name = BehaviorSubject<String>();
  final _tnc = BehaviorSubject<String>();
  final _loading = BehaviorSubject<bool>.seeded(false);
  final _provinces = BehaviorSubject<List<Province>>();
  final _districts = BehaviorSubject<List<District>>();
  final _province = BehaviorSubject<int>();
  final _district = BehaviorSubject<int>();
  final _hint = BehaviorSubject<bool>.seeded(false);
  final _agreement = BehaviorSubject<bool>.seeded(false);

  @override
  void dispose() { 
    super.dispose();
    _email.close();
    _password.close();
    _password_conf.close();
    _address.close();
    _phone.close();
    _name.close();
    _loading.close();
    _provinces.close();
    _districts.close();
    _province.close();
    _district.close();
    _hint.close();
    _tnc.close();
    _agreement.close();
  }

  void reset() {

  }

  //Getter
  Stream<bool> get isLoading => _loading.stream;
  Stream<List<Province>> get getProvinces => _provinces.stream;
  Stream<List<District>> get getDistricts => _districts.stream;
  Stream<int> get getProvince => _province.stream;
  Stream<int> get getDistrict => _district.stream;
  Stream<bool> get getHint => _hint.stream;
  Stream<String> get getTNC => _tnc.stream;
  Stream<bool> get getAgreement => _agreement.stream;

  //Setter
  Function(String) get setEmail => _email.sink.add;
  Function(String) get setPassword => _password.sink.add;
  Function(String) get setPasswordConf => _password_conf.sink.add;
  Function(String) get setAddress => _address.sink.add;
  Function(String) get setPhone => _phone.sink.add;
  Function(String) get setName => _name.sink.add;
  Function(bool) get setLoading => _loading.sink.add;
  Function(int) get setProvince => _province.sink.add;
  Function(int) get setDistrict => _district.sink.add;
  Function(bool) get setHint => _hint.sink.add;
  Function(String) get setTNC => _tnc.sink.add;
  Function(bool) get setAgreement => _agreement.sink.add;

  //Function
  Future fetchTNC() async {
    try {
      setTNC(await repo.getTNC());
    } catch (e) {
      print("TNC : " + e.toString());
      _tnc.sink.addError(e.toString().replaceAll("Exception: ", ""));
    }
  }

  Future fetchProvince() async {
    try {
      _provinces.sink.add(await repo.fetchProvince());
    } catch (e) {
      print("Province : " + e.toString());
    }
  }
  
  Future fetchDistrict(int idProvince) async {
    try {
      _districts.sink.add(await repo.fetchDistrict(idProvince));
    } catch (e) {
      print("District : " + e.toString());
    }
  }

  void openAgreement(bool val) {
    if (!val) {
      navService.navigateTo("/");
    }else{
      setAgreement(!val);
    }
  }

  void doLogin(GlobalKey<FormState> key) async {
    if (key.currentState.validate()) {
      key.currentState.save();
      setLoading(true);
      try {
        var result = await repo.doLogin(_email.value, _password.value);
        setLoading(false);
        if (result) {
          return navService.navigateReplaceTo("/main");
        }
        showAlert(
          context: key.currentContext,
          title: "Login Error",
          body: "Gagal login, silakan hubungi admin kami."
        );
      } catch (e) {
        setLoading(false);
        print("Login : " + e.toString());
        showAlert(
          context: key.currentContext,
          title: "Login Error",
          body: e.toString().replaceAll("Exception: ", "")
        );
      }
    }
  }

  void doRegister(GlobalKey<FormState> key) async {
    if (key.currentState.validate()) {
      key.currentState.save();
      setLoading(true);
      try {
        var result = await repo.doRegister(_district.value, _province.value, _name.value, _email.value, _password.value, _phone.value, _address.value);
        setLoading(false);
        showAlert(
          context: key.currentContext,
          title: "Registrasi Berhasil",
          body: result,
          actions: [
            AlertAction(
              text: "Confirm",
              onPressed: () => doLogin(key)
            )
          ]
        );
      } catch (e) {
        setLoading(false);
        print("Registrasi : " + e.toString());
        showAlert(
          context: key.currentContext,
          title: "Registrasi Error",
          body: e.toString().replaceAll("Exception: ", "")
        );
      }
    }
  }

  void doForgotPassword(GlobalKey<FormState> key) async {
    if (key.currentState.validate()) {
      key.currentState.save();
      setLoading(true);
      try {
        var result = await repo.forgotPassword(_email.value);
        setLoading(false);

        showAlert(
          context: key.currentContext,
          title: "Lupa Password Berhasil",
          body: result,
          actions: [
            AlertAction(
              text: "Confirm",
              onPressed: () => navService.navigatePop()
            )
          ]
        );
      } catch (e) {
        setLoading(false);
        print("Lupa Password : " + e.toString());
        showAlert(
          context: key.currentContext,
          title: "Lupa Password Error",
          body: e.toString().replaceAll("Exception: ", "")
        );
      }
    }
  }

  void doLoginSocmed(BuildContext context, Socmed loginBy) async {
    setLoading(true);
    try {
      if (loginBy == Socmed.google) {
        GoogleSignIn _googleSignIn = GoogleSignIn(
          scopes: [
            'email',
            'https://www.googleapis.com/auth/contacts.readonly',
          ],
        );

        var result = await _googleSignIn.signIn();
        if (result != null) {
          var login = await repo.doLoginSocmed(result.email, result.id, "google");
          if (login) {
            setLoading(false);
            return navService.navigateReplaceTo("/main");
          }
        }
        setLoading(false);
        showAlert(
          context: context,
          title: "Login Socmed Error",
          body: "Gagal login via Google, silakan hubungi admin kami."
        );
      }else {
        FacebookLogin facebookLogin = FacebookLogin();
        var result = await facebookLogin.logIn(["email"]);
        if (result.status == FacebookLoginStatus.loggedIn) {
          var facebookUser = await repo.userFacebook(result.accessToken.token);
          var login = await repo.doLoginSocmed(facebookUser.email, facebookUser.id, "facebook");
          if (login) {
            setLoading(false);
            return navService.navigateReplaceTo("/main");
          }
        }
        setLoading(false);
        showAlert(
          context: context,
          title: "Login Socmed Error",
          body: "Gagal login via Facebook, silakan hubungi admin kami."
        );
      }
    } catch (e) {
      setLoading(false);
      print("Login Socmed : " + e.toString());
      showAlert(
        context: context,
        title: "Login Socmed Error",
        body: e.toString().replaceAll("Exception: ", "")
      );
    }
  }  

}