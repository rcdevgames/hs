// To parse this JSON data, do
//
//     final myWorker = myWorkerFromJson(jsonString);

import 'dart:convert';

MyWorker myWorkerFromJson(String str) => MyWorker.fromJson(json.decode(str));

String myWorkerToJson(MyWorker data) => json.encode(data.toJson());

class MyWorker {
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
    String workerWeight;
    String workerHeight;
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
    WorkerMore workerMore;
    List<WorkerPhoto> workerPhotos;
    List<WorkerCertificate> workerCertificate;
    List<String> workerPlacement;
    List<String> workerSkills;

    MyWorker({
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
        this.workerWeight,
        this.workerHeight,
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
        this.workerMore,
        this.workerPhotos,
        this.workerCertificate,
        this.workerPlacement,
        this.workerSkills,
    });

    factory MyWorker.fromJson(Map<String, dynamic> json) => new MyWorker(
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
        workerDesc: json["worker_desc"],
        workerPath: json["worker_path"],
        workerWeight: json["worker_weight"],
        workerHeight: json["worker_height"],
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
        workerMore: WorkerMore.fromJson(json["worker_more"]),
        workerPhotos: new List<WorkerPhoto>.from(json["worker_photos"].map((x) => WorkerPhoto.fromJson(x))),
        workerCertificate: new List<WorkerCertificate>.from(json["worker_certificate"].map((x) => WorkerCertificate.fromJson(x))),
        workerPlacement: new List<String>.from(json["worker_placement"].map((x) => x)),
        workerSkills: new List<String>.from(json["worker_skills"].map((x) => x)),
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
        "worker_desc": workerDesc,
        "worker_path": workerPath,
        "worker_weight": workerWeight,
        "worker_height": workerHeight,
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
        "worker_more": workerMore.toJson(),
        "worker_photos": new List<dynamic>.from(workerPhotos.map((x) => x.toJson())),
        "worker_certificate": new List<dynamic>.from(workerCertificate.map((x) => x.toJson())),
        "worker_placement": new List<dynamic>.from(workerPlacement.map((x) => x)),
        "worker_skills": new List<dynamic>.from(workerSkills.map((x) => x)),
    };
}

class WorkerCertificate {
    String certificateTitle;
    String certificateImage;

    WorkerCertificate({
        this.certificateTitle,
        this.certificateImage,
    });

    factory WorkerCertificate.fromJson(Map<String, dynamic> json) => new WorkerCertificate(
        certificateTitle: json["certificate_title"],
        certificateImage: json["certificate_image"],
    );

    Map<String, dynamic> toJson() => {
        "certificate_title": certificateTitle,
        "certificate_image": certificateImage,
    };
}

class WorkerMore {
    bool wmoreStayIn;
    String wmoreChildren;
    String wmoreStatus;
    String wmoreReligion;
    bool wmoreAbroadEx;
    String wmoreLanguage;
    String wmorePhobia;

    WorkerMore({
        this.wmoreStayIn,
        this.wmoreChildren,
        this.wmoreStatus,
        this.wmoreReligion,
        this.wmoreAbroadEx,
        this.wmoreLanguage,
        this.wmorePhobia,
    });

    factory WorkerMore.fromJson(Map<String, dynamic> json) => new WorkerMore(
        wmoreStayIn: json["wmore_stay_in"],
        wmoreChildren: json["wmore_children"].toString(),
        wmoreStatus: json["wmore_status"],
        wmoreReligion: json["wmore_religion"],
        wmoreAbroadEx: json["wmore_abroad_ex"],
        wmoreLanguage: json["wmore_language"],
        wmorePhobia: json["wmore_phobia"],
    );

    Map<String, dynamic> toJson() => {
        "wmore_stay_in": wmoreStayIn,
        "wmore_children": wmoreChildren,
        "wmore_status": wmoreStatus,
        "wmore_religion": wmoreReligion,
        "wmore_abroad_ex": wmoreAbroadEx,
        "wmore_language": wmoreLanguage,
        "wmore_phobia": wmorePhobia,
    };
}

class WorkerPhoto {
    String title;
    String image;

    WorkerPhoto({
        this.title,
        this.image,
    });

    factory WorkerPhoto.fromJson(Map<String, dynamic> json) => new WorkerPhoto(
        title: json["title"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "image": image,
    };
}
