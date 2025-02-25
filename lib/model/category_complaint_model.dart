// To parse this JSON data, do
//
//     final complaintCategory = complaintCategoryFromJson(jsonString);

import 'dart:convert';

List<ComplaintCategory> complaintCategoryFromJson(String str) => List<ComplaintCategory>.from(json.decode(str).map((x) => ComplaintCategory.fromJson(x)));

String complaintCategoryToJson(List<ComplaintCategory> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ComplaintCategory {
    int idCcat;
    String ccatTitle;

    ComplaintCategory({
        this.idCcat,
        this.ccatTitle,
    });

    factory ComplaintCategory.fromJson(Map<String, dynamic> json) => ComplaintCategory(
        idCcat: json["id_ccat"] == null ? null : json["id_ccat"],
        ccatTitle: json["ccat_title"] == null ? null : json["ccat_title"],
    );

    Map<String, dynamic> toJson() => {
        "id_ccat": idCcat == null ? null : idCcat,
        "ccat_title": ccatTitle == null ? null : ccatTitle,
    };
}
