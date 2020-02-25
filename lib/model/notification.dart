// To parse this JSON data, do
//
//     final notifications = notificationsFromJson(jsonString);

import 'dart:convert';

List<Notifications> notificationsFromJson(String str) => List<Notifications>.from(json.decode(str).map((x) => Notifications.fromJson(x)));

String notificationsToJson(List<Notifications> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Notifications {
    String notifContent;
    String noticeId;
    DateTime createdAt;
    String notifImage;
    String createdAtFormatted;

    Notifications({
        this.notifContent,
        this.noticeId,
        this.createdAt,
        this.notifImage,
        this.createdAtFormatted,
    });

    factory Notifications.fromJson(Map<String, dynamic> json) => Notifications(
        notifContent: json["notif_content"] == null ? null : json["notif_content"],
        noticeId: json["notice_id"] == null ? null : json["notice_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        notifImage: json["notif_image"] == null ? null : json["notif_image"],
        createdAtFormatted: json["created_at_formatted"] == null ? null : json["created_at_formatted"],
    );

    Map<String, dynamic> toJson() => {
        "notif_content": notifContent == null ? null : notifContent,
        "notice_id": noticeId == null ? null : noticeId,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "notif_image": notifImage == null ? null : notifImage,
        "created_at_formatted": createdAtFormatted == null ? null : createdAtFormatted,
    };
}
