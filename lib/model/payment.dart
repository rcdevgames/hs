// To parse this JSON data, do
//
//     final payment = paymentFromJson(jsonString);

import 'dart:convert';

List<Payment> paymentFromJson(String str) => new List<Payment>.from(json.decode(str).map((x) => Payment.fromJson(x)));

String paymentToJson(List<Payment> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class Payment {
    int idTrans;
    int idCustomer;
    int idPacket;
    int idCategory;
    String transStatus;
    String transApprovalImage;
    DateTime transApprovalUploaded;
    DateTime transApprovedDate;
    DateTime transCreated;
    DateTime transUpdated;
    String transId;
    String transAttempt;
    String packetPrice;
    String categoryDesc;
    String invoice;
    List<Detail> detail;

    Payment({
        this.idTrans,
        this.idCustomer,
        this.idPacket,
        this.idCategory,
        this.transStatus,
        this.transApprovalImage,
        this.transApprovalUploaded,
        this.transApprovedDate,
        this.transCreated,
        this.transUpdated,
        this.transId,
        this.transAttempt,
        this.packetPrice,
        this.categoryDesc,
        this.invoice,
        this.detail,
    });

    factory Payment.fromJson(Map<String, dynamic> json) => new Payment(
        idTrans: json["id_trans"],
        idCustomer: json["id_customer"],
        idPacket: json["id_packet"],
        idCategory: json["id_category"],
        transStatus: json["trans_status"],
        transApprovalImage: json["trans_approval_image"],
        transApprovalUploaded: json["trans_approval_uploaded"] == null ? null : DateTime.parse(json["trans_approval_uploaded"]),
        transApprovedDate: json["trans_approved_date"] == null ? null : DateTime.parse(json["trans_approved_date"]),
        transCreated: json["trans_created"] == null ? null : DateTime.parse(json["trans_created"]),
        transUpdated: json["trans_updated"] == null ? null : DateTime.parse(json["trans_updated"]),
        transId: json["trans_id"],
        transAttempt: json["trans_attempt"],
        packetPrice: json["packet_price"],
        categoryDesc: json["category_desc"],
        invoice: json["invoice"],
        detail: new List<Detail>.from(json["detail"].map((x) => Detail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id_trans": idTrans,
        "id_customer": idCustomer,
        "id_packet": idPacket,
        "id_category": idCategory,
        "trans_status": transStatus,
        "trans_approval_image": transApprovalImage,
        "trans_approval_uploaded": transApprovalUploaded.toIso8601String(),
        "trans_approved_date": transApprovedDate.toIso8601String(),
        "trans_created": transCreated.toIso8601String(),
        "trans_updated": transUpdated.toIso8601String(),
        "trans_id": transId,
        "trans_attempt": transAttempt,
        "packet_price": packetPrice,
        "category_desc": categoryDesc,
        "invoice": invoice,
        "detail": new List<dynamic>.from(detail.map((x) => x.toJson())),
    };
}

class Detail {
    int idTworker;
    int idTrans;
    String tworkerStatus;
    String tworkerRejectReason;
    DateTime tworkerRejectCreated;
    DateTime tworkerDealCreated;
    DateTime tworkerCreated;
    int idWorker;
    String workerName;
    String workerPhone;
    String workerEmail;
    String workerHandphone;
    String workerAddress;
    String workerRating;
    String workerSalary;
    String workerDesc;
    DateTime workerBirthdate;
    String districtName;
    String provinceName;
    int workerAge;
    String workerProfile;
    String workerSalaryFormatted;

    Detail({
        this.idTworker,
        this.idTrans,
        this.tworkerStatus,
        this.tworkerRejectReason,
        this.tworkerRejectCreated,
        this.tworkerDealCreated,
        this.tworkerCreated,
        this.idWorker,
        this.workerName,
        this.workerPhone,
        this.workerEmail,
        this.workerHandphone,
        this.workerAddress,
        this.workerRating,
        this.workerSalary,
        this.workerDesc,
        this.workerBirthdate,
        this.districtName,
        this.provinceName,
        this.workerAge,
        this.workerProfile,
        this.workerSalaryFormatted,
    });

    factory Detail.fromJson(Map<String, dynamic> json) => new Detail(
        idTworker: json["id_tworker"],
        idTrans: json["id_trans"],
        tworkerStatus: json["tworker_status"],
        tworkerRejectReason: json["tworker_reject_reason"] == null ? null : json["tworker_reject_reason"],
        tworkerRejectCreated: json["tworker_reject_created"] == null ? null : DateTime.parse(json["tworker_reject_created"]),
        tworkerDealCreated: json["tworker_deal_created"] == null ? null : DateTime.parse(json["tworker_deal_created"]),
        tworkerCreated: DateTime.parse(json["tworker_created"]),
        idWorker: json["id_worker"],
        workerName: json["worker_name"],
        workerPhone: json["worker_phone"] == null ? null : json["worker_phone"],
        workerEmail: json["worker_email"] == null ? null : json["worker_email"],
        workerHandphone: json["worker_handphone"] == null ? null : json["worker_handphone"],
        workerAddress: json["worker_address"] == null ? null : json["worker_address"],
        workerRating: json["worker_rating"],
        workerSalary: json["worker_salary"],
        workerDesc: json["worker_desc"] == null ? null : json["worker_desc"],
        workerBirthdate: DateTime.parse(json["worker_birthdate"]),
        districtName: json["district_name"],
        provinceName: json["province_name"],
        workerAge: json["worker_age"],
        workerProfile: json["worker_profile"],
        workerSalaryFormatted: json["worker_salary_formatted"],
    );

    Map<String, dynamic> toJson() => {
        "id_tworker": idTworker,
        "id_trans": idTrans,
        "tworker_status": tworkerStatus,
        "tworker_reject_reason": tworkerRejectReason == null ? null : tworkerRejectReason,
        "tworker_reject_created": tworkerRejectCreated == null ? null : tworkerRejectCreated.toIso8601String(),
        "tworker_deal_created": tworkerDealCreated,
        "tworker_created": tworkerCreated.toIso8601String(),
        "id_worker": idWorker,
        "worker_name": workerName,
        "worker_phone": workerPhone == null ? null : workerPhone,
        "worker_email": workerEmail == null ? null : workerEmail,
        "worker_handphone": workerHandphone == null ? null : workerHandphone,
        "worker_address": workerAddress == null ? null : workerAddress,
        "worker_rating": workerRating,
        "worker_salary": workerSalary,
        "worker_desc": workerDesc == null ? null : workerDesc,
        "worker_birthdate": "${workerBirthdate.year.toString().padLeft(4, '0')}-${workerBirthdate.month.toString().padLeft(2, '0')}-${workerBirthdate.day.toString().padLeft(2, '0')}",
        "district_name": districtName,
        "province_name": provinceName,
        "worker_age": workerAge,
        "worker_profile": workerProfile,
        "worker_salary_formatted": workerSalaryFormatted,
    };
}
