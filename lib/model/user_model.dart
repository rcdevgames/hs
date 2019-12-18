// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    int idCustomer;
    int idProvince;
    int idDistrict;
    String customerName;
    String customerEmail;
    String customerAddress;
    String customerPassword;
    String customerHandphone;
    bool customerActive;
    String customerImage;
    DateTime createdAt;
    String customerGoogleId;
    dynamic customerFacebookId;
    dynamic customerTncApprovement;
    String customerRegistSource;
    String provinceName;
    String districtName;
    String type;

    User({
        this.idCustomer,
        this.idProvince,
        this.idDistrict,
        this.customerName,
        this.customerEmail,
        this.customerAddress,
        this.customerPassword,
        this.customerHandphone,
        this.customerActive,
        this.customerImage,
        this.createdAt,
        this.customerGoogleId,
        this.customerFacebookId,
        this.customerTncApprovement,
        this.customerRegistSource,
        this.provinceName,
        this.districtName,
        this.type,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        idCustomer: json["id_customer"] == null ? null : json["id_customer"],
        idProvince: json["id_province"] == null ? null : json["id_province"],
        idDistrict: json["id_district"] == null ? null : json["id_district"],
        customerName: json["customer_name"] == null ? null : json["customer_name"],
        customerEmail: json["customer_email"] == null ? null : json["customer_email"],
        customerAddress: json["customer_address"] == null ? null : json["customer_address"],
        customerPassword: json["customer_password"] == null ? null : json["customer_password"],
        customerHandphone: json["customer_handphone"] == null ? null : json["customer_handphone"],
        customerActive: json["customer_active"] == null ? null : json["customer_active"],
        customerImage: json["customer_image"] == null ? null : json["customer_image"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        customerGoogleId: json["customer_google_id"] == null ? null : json["customer_google_id"],
        customerFacebookId: json["customer_facebook_id"],
        customerTncApprovement: json["customer_tnc_approvement"],
        customerRegistSource: json["customer_regist_source"] == null ? null : json["customer_regist_source"],
        provinceName: json["province_name"] == null ? null : json["province_name"],
        districtName: json["district_name"] == null ? null : json["district_name"],
        type: json["type"] == null ? null : json["type"],
    );

    Map<String, dynamic> toJson() => {
        "id_customer": idCustomer == null ? null : idCustomer,
        "id_province": idProvince == null ? null : idProvince,
        "id_district": idDistrict == null ? null : idDistrict,
        "customer_name": customerName == null ? null : customerName,
        "customer_email": customerEmail == null ? null : customerEmail,
        "customer_address": customerAddress == null ? null : customerAddress,
        "customer_password": customerPassword == null ? null : customerPassword,
        "customer_handphone": customerHandphone == null ? null : customerHandphone,
        "customer_active": customerActive == null ? null : customerActive,
        "customer_image": customerImage == null ? null : customerImage,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "customer_google_id": customerGoogleId == null ? null : customerGoogleId,
        "customer_facebook_id": customerFacebookId,
        "customer_tnc_approvement": customerTncApprovement,
        "customer_regist_source": customerRegistSource == null ? null : customerRegistSource,
        "province_name": provinceName == null ? null : provinceName,
        "district_name": districtName == null ? null : districtName,
        "type": type == null ? null : type,
    };
}
