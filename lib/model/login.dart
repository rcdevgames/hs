// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
    int idCustomer;
    int idProvince;
    int idDistrict;
    String customerName;
    String customerEmail;
    String customerAddress;
    String customerHandphone;
    bool customerActive;
    String customerImage;
    String customerGoogleId;
    dynamic customerFacebookId;
    dynamic customerLinkVerification;
    dynamic customerTncApprovement;
    String customerRegistSource;
    String provinceName;
    String districtName;
    String accessToken;

    Login({
        this.idCustomer,
        this.idProvince,
        this.idDistrict,
        this.customerName,
        this.customerEmail,
        this.customerAddress,
        this.customerHandphone,
        this.customerActive,
        this.customerImage,
        this.customerGoogleId,
        this.customerFacebookId,
        this.customerLinkVerification,
        this.customerTncApprovement,
        this.customerRegistSource,
        this.provinceName,
        this.districtName,
        this.accessToken,
    });

    factory Login.fromJson(Map<String, dynamic> json) => Login(
        idCustomer: json["id_customer"] == null ? null : json["id_customer"],
        idProvince: json["id_province"] == null ? null : json["id_province"],
        idDistrict: json["id_district"] == null ? null : json["id_district"],
        customerName: json["customer_name"] == null ? null : json["customer_name"],
        customerEmail: json["customer_email"] == null ? null : json["customer_email"],
        customerAddress: json["customer_address"] == null ? null : json["customer_address"],
        customerHandphone: json["customer_handphone"] == null ? null : json["customer_handphone"],
        customerActive: json["customer_active"] == null ? null : json["customer_active"],
        customerImage: json["customer_image"] == null ? null : json["customer_image"],
        customerGoogleId: json["customer_google_id"] == null ? null : json["customer_google_id"],
        customerFacebookId: json["customer_facebook_id"],
        customerLinkVerification: json["customer_link_verification"],
        customerTncApprovement: json["customer_tnc_approvement"],
        customerRegistSource: json["customer_regist_source"] == null ? null : json["customer_regist_source"],
        provinceName: json["province_name"] == null ? null : json["province_name"],
        districtName: json["district_name"] == null ? null : json["district_name"],
        accessToken: json["accessToken"] == null ? null : json["accessToken"],
    );

    Map<String, dynamic> toJson() => {
        "id_customer": idCustomer == null ? null : idCustomer,
        "id_province": idProvince == null ? null : idProvince,
        "id_district": idDistrict == null ? null : idDistrict,
        "customer_name": customerName == null ? null : customerName,
        "customer_email": customerEmail == null ? null : customerEmail,
        "customer_address": customerAddress == null ? null : customerAddress,
        "customer_handphone": customerHandphone == null ? null : customerHandphone,
        "customer_active": customerActive == null ? null : customerActive,
        "customer_image": customerImage == null ? null : customerImage,
        "customer_google_id": customerGoogleId == null ? null : customerGoogleId,
        "customer_facebook_id": customerFacebookId,
        "customer_link_verification": customerLinkVerification,
        "customer_tnc_approvement": customerTncApprovement,
        "customer_regist_source": customerRegistSource == null ? null : customerRegistSource,
        "province_name": provinceName == null ? null : provinceName,
        "district_name": districtName == null ? null : districtName,
        "accessToken": accessToken == null ? null : accessToken,
    };
}
