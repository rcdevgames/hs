// To parse this JSON data, do
//
//     final complaintSingle = complaintSingleFromJson(jsonString);

import 'dart:convert';

ComplaintSingle complaintSingleFromJson(String str) => ComplaintSingle.fromJson(json.decode(str));

String complaintSingleToJson(ComplaintSingle data) => json.encode(data.toJson());

class ComplaintSingle {
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

    ComplaintSingle({
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

    factory ComplaintSingle.fromJson(Map<String, dynamic> json) => new ComplaintSingle(
        idComplaint: json["id_complaint"],
        complaintId: json["complaint_id"],
        complaintTitle: json["complaint_title"],
        complaintContent: json["complaint_content"],
        complaintStatus: json["complaint_status"],
        complaintCreated: DateTime.parse(json["complaint_created"]),
        complaintUpdated: DateTime.parse(json["complaint_updated"]),
        complaintHide: json["complaint_hide"],
        ccatTitle: json["ccat_title"],
        replies: new List<Reply>.from(json["replies"].map((x) => Reply.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id_complaint": idComplaint,
        "complaint_id": complaintId,
        "complaint_title": complaintTitle,
        "complaint_content": complaintContent,
        "complaint_status": complaintStatus,
        "complaint_created": complaintCreated.toIso8601String(),
        "complaint_updated": complaintUpdated.toIso8601String(),
        "complaint_hide": complaintHide,
        "ccat_title": ccatTitle,
        "replies": new List<dynamic>.from(replies.map((x) => x.toJson())),
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

    factory Reply.fromJson(Map<String, dynamic> json) => new Reply(
        idCreply: json["id_creply"],
        idComplaint: json["id_complaint"],
        id: json["id_"],
        complaintType: json["complaint_type"],
        complaintContent: json["complaint_content"],
        complaintCreated: DateTime.parse(json["complaint_created"]),
        author: json["author"],
    );

    Map<String, dynamic> toJson() => {
        "id_creply": idCreply,
        "id_complaint": idComplaint,
        "id_": id,
        "complaint_type": complaintType,
        "complaint_content": complaintContent,
        "complaint_created": complaintCreated.toIso8601String(),
        "author": author,
    };
}
