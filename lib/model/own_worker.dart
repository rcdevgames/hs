// To parse this JSON data, do
//
//     final ownWorkers = ownWorkersFromJson(jsonString);

import 'dart:convert';

List<OwnWorkers> ownWorkersFromJson(String str) => new List<OwnWorkers>.from(json.decode(str).map((x) => OwnWorkers.fromJson(x)));

String ownWorkersToJson(List<OwnWorkers> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class OwnWorkers {
    int idCworker;
    int idCustomer;
    int idWorker;
    bool cworkerActive;
    DateTime cworkerStart;
    int idOrder;
    String idTrans;
    String workerName;
    String workerEmail;
    String workerPhone;
    String workerHandphone;
    String workerAddress;
    DateTime workerBirthdate;
    String workerRating;
    String workerSalary;
    String workerDesc;
    String workerPath;
    String districtName;
    String provinceName;
    String transAttempt;
    int workerAge;
    String workerProfile;
    String workerSalaryFormatted;
    bool requestReject;
    String categoryDesc;
    dynamic rejectReason;
    dynamic rejectReasonUploaded;

    OwnWorkers({
        this.idCworker,
        this.idCustomer,
        this.idWorker,
        this.cworkerActive,
        this.cworkerStart,
        this.idOrder,
        this.idTrans,
        this.workerName,
        this.workerEmail,
        this.workerPhone,
        this.workerHandphone,
        this.workerAddress,
        this.workerBirthdate,
        this.workerRating,
        this.workerSalary,
        this.workerDesc,
        this.workerPath,
        this.districtName,
        this.provinceName,
        this.transAttempt,
        this.workerAge,
        this.workerProfile,
        this.workerSalaryFormatted,
        this.requestReject,
        this.categoryDesc,
        this.rejectReason,
        this.rejectReasonUploaded,
    });

    factory OwnWorkers.fromJson(Map<String, dynamic> json) => new OwnWorkers(
        idCworker: json["id_cworker"],
        idCustomer: json["id_customer"],
        idWorker: json["id_worker"],
        cworkerActive: json["cworker_active"],
        cworkerStart: DateTime.parse(json["cworker_start"]),
        idOrder: json["id_order"],
        idTrans: json["id_trans"],
        workerName: json["worker_name"],
        workerEmail: json["worker_email"],
        workerPhone: json["worker_phone"],
        workerHandphone: json["worker_handphone"],
        workerAddress: json["worker_address"],
        workerBirthdate: DateTime.parse(json["worker_birthdate"]),
        workerRating: json["worker_rating"],
        workerSalary: json["worker_salary"],
        workerDesc: json["worker_desc"] == null ? null : json["worker_desc"],
        workerPath: json["worker_path"],
        districtName: json["district_name"],
        provinceName: json["province_name"],
        transAttempt: json["trans_attempt"],
        workerAge: json["worker_age"],
        workerProfile: json["worker_profile"],
        workerSalaryFormatted: json["worker_salary_formatted"],
        requestReject: json["request_reject"],
        categoryDesc: json["category_desc"],
        rejectReason: json["reject_reason"],
        rejectReasonUploaded: json["reject_reason_uploaded"],
    );

    Map<String, dynamic> toJson() => {
        "id_cworker": idCworker,
        "id_customer": idCustomer,
        "id_worker": idWorker,
        "cworker_active": cworkerActive,
        "cworker_start": cworkerStart.toIso8601String(),
        "id_order": idOrder,
        "id_trans": idTrans,
        "worker_name": workerName,
        "worker_email": workerEmail,
        "worker_phone": workerPhone,
        "worker_handphone": workerHandphone,
        "worker_address": workerAddress,
        "worker_birthdate": "${workerBirthdate.year.toString().padLeft(4, '0')}-${workerBirthdate.month.toString().padLeft(2, '0')}-${workerBirthdate.day.toString().padLeft(2, '0')}",
        "worker_rating": workerRating,
        "worker_salary": workerSalary,
        "worker_desc": workerDesc == null ? null : workerDesc,
        "worker_path": workerPath,
        "district_name": districtName,
        "province_name": provinceName,
        "trans_attempt": transAttempt,
        "worker_age": workerAge,
        "worker_profile": workerProfile,
        "worker_salary_formatted": workerSalaryFormatted,
        "request_reject": requestReject,
        "category_desc": categoryDesc,
        "reject_reason": rejectReason,
        "reject_reason_uploaded": rejectReasonUploaded,
    };
}
