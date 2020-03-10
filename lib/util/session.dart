import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:housesolutions/model/user_model.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class Sessions {
  final storage = new FlutterSecureStorage();
  StreamingSharedPreferences preferences;

  initStreamSession() async {
    preferences = await StreamingSharedPreferences.instance;
  }

  Future<bool> checkAuth() async {
    // await prefs.setString("token", "a22dfeeaf7396e1a1d1e12408a6347fe80f51bfa");
    // await prefs.setString("auth_customer", '{"id_customer":372,"id_province":31,"id_district":3172,"customer_name":"thomas malau","customer_email":"thomasmalau72@gmail.com","customer_address":"jl.hanafi perumahan janur vilage blok D2","customer_handphone":"0823471234512","customer_active":true,"customer_image":null,"customer_google_id":"100636798361852171639","customer_facebook_id":"DI008","customer_link_verification":null,"customer_tnc_approvement":null,"province_name":"DKI JAKARTA","district_name":"KOTA JAKARTA TIMUR","accessToken":"a22dfeeaf7396e1a1d1e12408a6347fe80f51bfa"}');

    var res = await storage.read(key: "token");
    if (res == null) return false;
    return true;
  }

  save(String key, String data) async {
    storage.write(key: key, value: data);
  }

  clear() async {
    storage.deleteAll();
  }

  Future<String> load(String key) async {
    return storage.read(key: key);
  }

  remove(String key) async {
    storage.delete(key: key);
  }

  Future<User> loadUser() async {
    return compute(userFromJson, await storage.read(key: "auth"));
  }

  Future setBadgesCount(String key, int value) async {
    var data = await storage.read(key: key);
    preferences.setInt(key, (data != null ? int.parse(data) : 0) + value);
  }

  Preference<int> getBadgesCount(String key) {
    return preferences.getInt(key, defaultValue: 0);
  }
  
  Future clearBadgesCount(String key) async {
    preferences.setInt(key, 0);
  }
}

final sessions = Sessions();