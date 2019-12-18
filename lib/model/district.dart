// To parse this JSON data, do
//
//     final district = districtFromJson(jsonString);

import 'dart:convert';

List<District> districtFromJson(String str) => new List<District>.from(json.decode(str).map((x) => District.fromJson(x)));

String districtToJson(List<District> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class District {
    int idDistrict;
    String districtName;

    District({
        this.idDistrict,
        this.districtName,
    });

    factory District.fromJson(Map<String, dynamic> json) => new District(
        idDistrict: json["id_district"],
        districtName: json["district_name"],
    );

    Map<String, dynamic> toJson() => {
        "id_district": idDistrict,
        "district_name": districtName,
    };
}
