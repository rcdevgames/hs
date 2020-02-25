import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:housesolutions/model/notice_model.dart';
import 'package:housesolutions/model/notification.dart';
import 'package:housesolutions/util/api.dart';

class NotificationProvider {
  Future<List<Notifications>> fetchNotification() async {
    final response = await api.get("/getNotif", auth: true);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return compute(notificationsFromJson, api.getContent(response.body));
    } else if(response.statusCode == 401) {
      throw Exception("Unauthorized");
    } else {
      throw Exception(api.getContent(response.body));
    }
  }

  Future<Notice> getNoticeDetail(int id) async {
    final response = await api.get("/getNotice", auth: true, endpoint: "$id/");

    if (response.statusCode == 200 || response.statusCode == 201) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return compute(noticeFromJson, jsonEncode(data['message']));
    }else if(response.statusCode == 401) {
      throw Exception("Unauthorized");
    } else {
      print(response.body);
      var error = jsonDecode(response.body) as Map<String, dynamic>;
      throw Exception(error['message']);
    }
  }

  Future pushFCM(List<String> to, String title, String message) async {
    final response = await api.FCM({
      "registration_ids" : to,
      "priority" : "high",
      "notification" : {
        "title" : title,
        "body" : message,
        "sound": "default",
          "icon": "app_icon"
      }
    });
  }
}