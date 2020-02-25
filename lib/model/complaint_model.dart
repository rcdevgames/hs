// To parse this JSON data, do
//
//     final complaints = complaintsFromJson(jsonString);

import 'dart:convert';

List<Complaints> complaintsFromJson(String str) => List<Complaints>.from(json.decode(str).map((x) => Complaints.fromJson(x)));
Complaints complaintFromJson(String str) => Complaints.fromJson(json.decode(str));

String complaintsToJson(List<Complaints> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Complaints {
    int idComplaint;
    String complaintId;
    String complaintTitle;
    String complaintContent;
    String complaintStatus;
    DateTime complaintCreated;
    DateTime complaintUpdated;
    bool complaintHide;
    String ccatTitle;
    List<Reply> replies;

    Complaints({
        this.idComplaint,
        this.complaintId,
        this.complaintTitle,
        this.complaintContent,
        this.complaintStatus,
        this.complaintCreated,
        this.complaintUpdated,
        this.complaintHide,
        this.ccatTitle,
        this.replies,
    });

    factory Complaints.fromJson(Map<String, dynamic> json) => Complaints(
        idComplaint: json["id_complaint"] == null ? null : json["id_complaint"],
        complaintId: json["complaint_id"] == null ? null : json["complaint_id"],
        complaintTitle: json["complaint_title"] == null ? null : json["complaint_title"],
        complaintContent: json["complaint_content"] == null ? null : json["complaint_content"],
        complaintStatus: json["complaint_status"] == null ? null : json["complaint_status"],
        complaintCreated: json["complaint_created"] == null ? null : DateTime.parse(json["complaint_created"]),
        complaintUpdated: json["complaint_updated"] == null ? null : DateTime.parse(json["complaint_updated"]),
        complaintHide: json["complaint_hide"] == null ? null : json["complaint_hide"],
        ccatTitle: json["ccat_title"] == null ? null : json["ccat_title"],
        replies: json["replies"] == null ? null : List<Reply>.from(json["replies"].map((x) => Reply.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id_complaint": idComplaint == null ? null : idComplaint,
        "complaint_id": complaintId == null ? null : complaintId,
        "complaint_title": complaintTitle == null ? null : complaintTitle,
        "complaint_content": complaintContent == null ? null : complaintContent,
        "complaint_status": complaintStatus == null ? null : complaintStatus,
        "complaint_created": complaintCreated == null ? null : complaintCreated.toIso8601String(),
        "complaint_updated": complaintUpdated == null ? null : complaintUpdated.toIso8601String(),
        "complaint_hide": complaintHide == null ? null : complaintHide,
        "ccat_title": ccatTitle == null ? null : ccatTitle,
        "replies": replies == null ? null : List<dynamic>.from(replies.map((x) => x.toJson())),
    };
}

class Reply {
    int idCreply;
    int idComplaint;
    String id;
    String complaintType;
    String complaintContent;
    DateTime complaintCreated;
    String author;

    Reply({
        this.idCreply,
        this.idComplaint,
        this.id,
        this.complaintType,
        this.complaintContent,
        this.complaintCreated,
        this.author,
    });

    factory Reply.fromJson(Map<String, dynamic> json) => Reply(
        idCreply: json["id_creply"] == null ? null : json["id_creply"],
        idComplaint: json["id_complaint"] == null ? null : json["id_complaint"],
        id: json["id_"] == null ? null : json["id_"],
        complaintType: json["complaint_type"] == null ? null : json["complaint_type"],
        complaintContent: json["complaint_content"] == null ? null : json["complaint_content"],
        complaintCreated: json["complaint_created"] == null ? null : DateTime.parse(json["complaint_created"]),
        author: json["author"] == null ? null : json["author"],
    );

    Map<String, dynamic> toJson() => {
        "id_creply": idCreply == null ? null : idCreply,
        "id_complaint": idComplaint == null ? null : idComplaint,
        "id_": id == null ? null : id,
        "complaint_type": complaintType == null ? null : complaintType,
        "complaint_content": complaintContent == null ? null : complaintContent,
        "complaint_created": complaintCreated == null ? null : complaintCreated.toIso8601String(),
        "author": author == null ? null : author,
    };
}
