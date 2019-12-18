import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:housesolutions/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Sessions {
  SharedPreferences prefs;

  Future<bool> checkAuth() async {
    prefs = await SharedPreferences.getInstance();
    // await prefs.setString("token", "a22dfeeaf7396e1a1d1e12408a6347fe80f51bfa");
    // await prefs.setString("auth_customer", '{"id_customer":372,"id_province":31,"id_district":3172,"customer_name":"thomas malau","customer_email":"thomasmalau72@gmail.com","customer_address":"jl.hanafi perumahan janur vilage blok D2","customer_handphone":"0823471234512","customer_active":true,"customer_image":null,"customer_google_id":"100636798361852171639","customer_facebook_id":"DI008","customer_link_verification":null,"customer_tnc_approvement":null,"province_name":"DKI JAKARTA","district_name":"KOTA JAKARTA TIMUR","accessToken":"a22dfeeaf7396e1a1d1e12408a6347fe80f51bfa"}');

    var res = await prefs.getString("token");
    if (res == null) return false;
    return true;
  }

  save(String key, String data) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString(key, data);
  }

  clear() async {
    prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Future<String> load(String key) async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  remove(String key) async {
    prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  Future<User> loadUser() async {
    prefs = await SharedPreferences.getInstance();
    return compute(userFromJson, prefs.getString("auth"));
  }
}

final sessions = Sessions();