// To parse this JSON data, do
//
//     final fcmResponse = fcmResponseFromJson(jsonString);

import 'dart:convert';

FcmResponse fcmResponseFromJson(String str) => FcmResponse.fromJson(json.decode(str));

String fcmResponseToJson(FcmResponse data) => json.encode(data.toJson());

class FcmResponse {
    Notification notification;
    Data data;

    FcmResponse({
        this.notification,
        this.data,
    });

    factory FcmResponse.fromJson(Map<String, dynamic> json) => FcmResponse(
        notification: json["notification"] == null ? null : Notification.fromJson(json["notification"]),
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "notification": notification == null ? null : notification.toJson(),
        "data": data == null ? null : data.toJson(),
    };
}

class Data {
    String group;

    Data({
        this.group,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        group: json["group"] == null ? null : json["group"],
    );

    Map<String, dynamic> toJson() => {
        "group": group == null ? null : group,
    };
}

class Notification {
    String title;
    String body;

    Notification({
        this.title,
        this.body,
    });

    factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        title: json["title"] == null ? null : json["title"],
        body: json["body"] == null ? null : json["body"],
    );

    Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "body": body == null ? null : body,
    };
}
