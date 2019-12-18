// To parse this JSON data, do
//
//     final province = provinceFromJson(jsonString);

import 'dart:convert';

List<Province> provinceFromJson(String str) => new List<Province>.from(json.decode(str).map((x) => Province.fromJson(x)));

String provinceToJson(List<Province> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class Province {
    int idProvince;
    String provinceName;

    Province({
        this.idProvince,
        this.provinceName,
    });

    factory Province.fromJson(Map<String, dynamic> json) => new Province(
        idProvince: json["id_province"],
        provinceName: json["province_name"],
    );

    Map<String, dynamic> toJson() => {
        "id_province": idProvince,
        "province_name": provinceName,
    };
}
