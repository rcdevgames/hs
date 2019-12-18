import 'dart:convert';

import 'package:device_id/device_id.dart';
import 'package:flutter/foundation.dart';
import 'package:housesolutions/model/facebook.dart';
import 'package:housesolutions/model/login.dart';
import 'package:housesolutions/util/api.dart';
import 'package:housesolutions/util/session.dart';

class AuthProvider {
  Future<bool> checkLogin(String email) async {
    final response = await api.post("/customer/checkLogin", body: {
      "customer_email" : email,
      "device_id" : await DeviceId.getID
    });
    
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body)["message"];
    }else {
      throw Exception(api.getContent(response.body));
    }
  }

  Future<bool> doLogin(String email, String password) async {
    final response = await api.post("/customer/login", body: {
      "customer_email" : email,
      "customer_password" : password,
      "loggin_type" : "manual",
      "device_id" : await DeviceId.getID,
      "device_firestore" : await sessions.load("fcm")
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = await compute(loginFromJson, api.getContent(response.body));
      sessions.save("auth", api.getContent(response.body));
      sessions.save("token", data.accessToken);
      return true;
    }else {
      throw Exception(api.getContent(response.body));
    }
  }

  Future<bool> doLoginSocmed(String email, String appId, String via) async {
    final response = await api.post("/customer/login", body: {
      "customer_email" : email,
      "app_id" : appId,
      "loggin_type" : via,
      "device_id" : await DeviceId.getID,
      "device_firestore" : await sessions.load("fcm")
    });
    
    if (response.statusCode == 200 || response.statusCode == 201) {
      sessions.save("auth_customer", api.getContent(response.body));
      var data = await compute(loginFromJson, api.getContent(response.body));
      sessions.save("token", data.accessToken);
      return true;
    } else {
      throw Exception(api.getContent(response.body));
    }
  }

  Future<Facebook> userFacebook(String token) async {
    print(token);
    final response = await api.getPure("https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${token}");
    
    if (response.statusCode == 200 || response.statusCode == 201) {
      return compute(facebookFromJson, response.body);
    } else {
      throw Exception(api.getContent(response.body));
    }
  }

  Future<String> doRegister(num idDistrict, num idProvince, String name, String email, String password, String phone, String address, DateTime birthdate, int category) async {
    final response = await api.post("/customer/regist", body: {
      "id_province" : idProvince,
      "id_district" : idDistrict,
      "customer_name" : name,
      "customer_email" : email,
      "customer_phone" : phone,
      "customer_handphone" : phone,
      "customer_address" : address,
      "customer_password" : password,
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body)['message'];
    } else {
      throw Exception(api.getContent(response.body));
    }
  }

  Future<String> logout() async {
    final response = await api.post("/customer/logout", auth: true, body: {
      "device_id" : await DeviceId.getID
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body)['message'];
    } else if(response.statusCode == 401) {
      throw Exception("Unauthorized");
    } else {
      throw Exception(api.getContent(response.body));
    }
  }

  Future<String> forgotPassword(String email, bool iscustomer) async {
    final response = await api.post("/customer/forgotPassword", body: {"customer_email" : email});

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body)['message'];
    } else {
      throw Exception(api.getContent(response.body));
    }
  }

  Future<String> changePassword(String oldPassword, String newPassword) async {
    final response = await api.post("/customer/changePassword", auth: true, body: {
      "customer_old_password" : oldPassword,
      "customer_password" : newPassword
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body)['message'];
    } else if(response.statusCode == 401) {
      throw Exception("Unauthorized");
    } else {
      throw Exception(api.getContent(response.body));
    }
  }
}