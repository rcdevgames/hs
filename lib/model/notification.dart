// To parse this JSON data, do
//
//     final notifications = notificationsFromJson(jsonString);

import 'dart:convert';

List<Notifications> notificationsFromJson(String str) => new List<Notifications>.from(json.decode(str).map((x) => Notifications.fromJson(x)));

String notificationsToJson(List<Notifications> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class Notifications {
    String notifContent;
    DateTime createdAt;
    String createdAtFormatted;

    Notifications({
        this.notifContent,
        this.createdAt,
        this.createdAtFormatted,
    });

    factory Notifications.fromJson(Map<String, dynamic> json) => new Notifications(
        notifContent: json["notif_content"],
        createdAt: DateTime.parse(json["created_at"]),
        createdAtFormatted: json["created_at_formatted"],
    );

    Map<String, dynamic> toJson() => {
        "notif_content": notifContent,
        "created_at": "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
        "created_at_formatted": createdAtFormatted,
    };
}
