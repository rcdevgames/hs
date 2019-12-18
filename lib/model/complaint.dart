// To parse this JSON data, do
//
//     final complaint = complaintFromJson(jsonString);

import 'dart:convert';

List<Complaint> complaintFromJson(String str) => new List<Complaint>.from(json.decode(str).map((x) => Complaint.fromJson(x)));

String complaintToJson(List<Complaint> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class Complaint {
    int idComplaint;
    String complaintId;
    String complaintTitle;
    String complaintContent;
    String complaintStatus;
    DateTime complaintCreated;
    DateTime complaintUpdated;
    bool complaintHide;
    String ccatTitle;

    Complaint({
        this.idComplaint,
        this.complaintId,
        this.complaintTitle,
        this.complaintContent,
        this.complaintStatus,
        this.complaintCreated,
        this.complaintUpdated,
        this.complaintHide,
        this.ccatTitle,
    });

    factory Complaint.fromJson(Map<String, dynamic> json) => new Complaint(
        idComplaint: json["id_complaint"],
        complaintId: json["complaint_id"],
        complaintTitle: json["complaint_title"],
        complaintContent: json["complaint_content"],
        complaintStatus: json["complaint_status"],
        complaintCreated: DateTime.parse(json["complaint_created"]),
        complaintUpdated: DateTime.parse(json["complaint_updated"]),
        complaintHide: json["complaint_hide"],
        ccatTitle: json["ccat_title"],
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
    };
}
