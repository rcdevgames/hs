import 'package:flutter/foundation.dart';
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