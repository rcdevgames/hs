// To parse this JSON data, do
//
//     final notice = noticeFromJson(jsonString);

import 'dart:convert';

Notice noticeFromJson(String str) => Notice.fromJson(json.decode(str));

String noticeToJson(Notice data) => json.encode(data.toJson());

class Notice {
    int idNotice;
    String noticeTitle;
    String noticeDesc;
    String noticeImage;
    String noticeUserId;
    DateTime noticeCreated;
    bool noticeHide;
    bool noticePublish;
    bool noticeCustomer;
    String createdAtFormatted;

    Notice({
        this.idNotice,
        this.noticeTitle,
        this.noticeDesc,
        this.noticeImage,
        this.noticeUserId,
        this.noticeCreated,
        this.noticeHide,
        this.noticePublish,
        this.noticeCustomer,
        this.createdAtFormatted,
    });

    factory Notice.fromJson(Map<String, dynamic> json) => Notice(
        idNotice: json["id_notice"] == null ? null : json["id_notice"],
        noticeTitle: json["notice_title"] == null ? null : json["notice_title"],
        noticeDesc: json["notice_desc"] == null ? null : json["notice_desc"],
        noticeImage: json["notice_image"] == null ? null : json["notice_image"],
        noticeUserId: json["notice_user_id"] == null ? null : json["notice_user_id"],
        noticeCreated: json["notice_created"] == null ? null : DateTime.parse(json["notice_created"]),
        noticeHide: json["notice_hide"] == null ? null : json["notice_hide"],
        noticePublish: json["notice_publish"] == null ? null : json["notice_publish"],
        noticeCustomer: json["notice_customer"] == null ? null : json["notice_customer"],
        createdAtFormatted: json["created_at_formatted"] == null ? null : json["created_at_formatted"],
    );

    Map<String, dynamic> toJson() => {
        "id_notice": idNotice == null ? null : idNotice,
        "notice_title": noticeTitle == null ? null : noticeTitle,
        "notice_desc": noticeDesc == null ? null : noticeDesc,
        "notice_image": noticeImage == null ? null : noticeImage,
        "notice_user_id": noticeUserId == null ? null : noticeUserId,
        "notice_created": noticeCreated == null ? null : noticeCreated.toIso8601String(),
        "notice_hide": noticeHide == null ? null : noticeHide,
        "notice_publish": noticePublish == null ? null : noticePublish,
        "notice_customer": noticeCustomer == null ? null : noticeCustomer,
        "created_at_formatted": createdAtFormatted == null ? null : createdAtFormatted,
    };
}
