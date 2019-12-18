// To parse this JSON data, do
//
//     final transaction = transactionFromJson(jsonString);

import 'dart:convert';

List<Transaction> transactionFromJson(String str) => new List<Transaction>.from(json.decode(str).map((x) => Transaction.fromJson(x)));

String transactionToJson(List<Transaction> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class Transaction {
    int idTrans;
    int idCustomer;
    int idPacket;
    String transStatus;
    String transApprovalImage;
    String transApprovalUploaded;
    String transApprovedDate;
    String transCreated;
    String transUpdated;
    String transId;
    String transAttempt;
    String idCategory;
    String packetPrice;
    List<Detail> detail;

    Transaction({
        this.idTrans,
        this.idCustomer,
        this.idPacket,
        this.transStatus,
        this.transApprovalImage,
        this.transApprovalUploaded,
        this.transApprovedDate,
        this.transCreated,
        this.transUpdated,
        this.transId,
        this.transAttempt,
        this.idCategory,
        this.packetPrice,
        this.detail,
    });

    factory Transaction.fromJson(Map<String, dynamic> json) => new Transaction(
        idTrans: json["id_trans"],
        idCustomer: json["id_customer"],
        idPacket: json["id_packet"],
        transStatus: json["trans_status"],
        transApprovalImage: json["trans_approval_image"],
        transApprovalUploaded: json["trans_approval_uploaded"],
        transApprovedDate: json["trans_approved_date"],
        transCreated: json["trans_created"],
        transUpdated: json["trans_updated"],
        transId: json["trans_id"],
        transAttempt: json["trans_attempt"],
        idCategory: json["id_category"],
        packetPrice: json["packet_price"],
        detail: new List<Detail>.from(json["detail"].map((x) => Detail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id_trans": idTrans,
        "id_customer": idCustomer,
        "id_packet": idPacket,
        "trans_status": transStatus,
        "trans_approval_image": transApprovalImage,
        "trans_approval_uploaded": transApprovalUploaded,
        "trans_approved_date": transApprovedDate,
        "trans_created": transCreated,
        "trans_updated": transUpdated,
        "trans_id": transId,
        "trans_attempt": transAttempt,
        "id_category": idCategory,
        "packet_price": packetPrice,
        "detail": new List<dynamic>.from(detail.map((x) => x.toJson())),
    };
}

class Detail {
    int idTworker;
    int idTrans;
    int idWorker;
    String tworkerStatus;
    String tworkerRejectReason;
    String tworkerRejectCreated;
    dynamic tworkerDealCreated;
    String tworkerCreated;
    String workerName;
    dynamic workerPhone;
    dynamic workerEmail;
    dynamic workerHandphone;
    dynamic workerAddress;
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
        this.idWorker,
        this.tworkerStatus,
        this.tworkerRejectReason,
        this.tworkerRejectCreated,
        this.tworkerDealCreated,
        this.tworkerCreated,
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
        idWorker: json["id_worker"],
        tworkerStatus: json["tworker_status"],
        tworkerRejectReason: json["tworker_reject_reason"],
        tworkerRejectCreated: json["tworker_reject_created"],
        tworkerDealCreated: json["tworker_deal_created"],
        tworkerCreated: json["tworker_created"],
        workerName: json["worker_name"],
        workerPhone: json["worker_phone"],
        workerEmail: json["worker_email"],
        workerHandphone: json["worker_handphone"],
        workerAddress: json["worker_address"],
        workerRating: json["worker_rating"],
        workerSalary: json["worker_salary"],
        workerDesc: json["worker_desc"],
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
        "id_worker": idWorker,
        "tworker_status": tworkerStatus,
        "tworker_reject_reason": tworkerRejectReason,
        "tworker_reject_created": tworkerRejectCreated,
        "tworker_deal_created": tworkerDealCreated,
        "tworker_created": tworkerCreated,
        "worker_name": workerName,
        "worker_phone": workerPhone,
        "worker_email": workerEmail,
        "worker_handphone": workerHandphone,
        "worker_address": workerAddress,
        "worker_rating": workerRating,
        "worker_salary": workerSalary,
        "worker_desc": workerDesc,
        "worker_birthdate": "${workerBirthdate.year.toString().padLeft(4, '0')}-${workerBirthdate.month.toString().padLeft(2, '0')}-${workerBirthdate.day.toString().padLeft(2, '0')}",
        "district_name": districtName,
        "province_name": provinceName,
        "worker_age": workerAge,
        "worker_profile": workerProfile,
        "worker_salary_formatted": workerSalaryFormatted,
    };
}
