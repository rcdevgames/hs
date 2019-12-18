// To parse this JSON data, do
//
//     final worker = workerFromJson(jsonString);

import 'dart:convert';

Worker workerFromJson(String str) => Worker.fromJson(json.decode(str));

String workerToJson(Worker data) => json.encode(data.toJson());

class Worker {
    int idWorker;
    int idProvince;
    int idDistrict;
    String workerName;
    String workerRating;
    String workerSalary;
    String workerDesc;
    String workerWeight;
    String workerHeight;
    String provinceName;
    String districtName;
    int workerAge;
    bool paid;
    String workerProfile;
    String categoryDesc;
    WorkerMore workerMore;
    List<WorkerCertificate> workerCertificate;
    List<String> workerPlacement;
    List<String> workerSkills;

    Worker({
        this.idWorker,
        this.idProvince,
        this.idDistrict,
        this.workerName,
        this.workerRating,
        this.workerSalary,
        this.workerDesc,
        this.workerWeight,
        this.workerHeight,
        this.provinceName,
        this.districtName,
        this.workerAge,
        this.paid,
        this.workerProfile,
        this.categoryDesc,
        this.workerMore,
        this.workerCertificate,
        this.workerPlacement,
        this.workerSkills,
    });

    factory Worker.fromJson(Map<String, dynamic> json) => new Worker(
        idWorker: json["id_worker"],
        idProvince: json["id_province"],
        idDistrict: json["id_district"],
        workerName: json["worker_name"],
        workerRating: json["worker_rating"],
        workerSalary: json["worker_salary"],
        workerDesc: json["worker_desc"],
        workerWeight: json["worker_weight"],
        workerHeight: json["worker_height"],
        provinceName: json["province_name"],
        districtName: json["district_name"],
        workerAge: json["worker_age"],
        paid: json["paid"],
        workerProfile: json["worker_profile"],
        categoryDesc: json["category_desc"],
        workerMore: WorkerMore.fromJson(json["worker_more"]),
        workerCertificate: new List<WorkerCertificate>.from(json["worker_certificate"].map((x) => WorkerCertificate.fromJson(x))),
        workerPlacement: new List<String>.from(json["worker_placement"].map((x) => x)),
        workerSkills: new List<String>.from(json["worker_skills"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id_worker": idWorker,
        "id_province": idProvince,
        "id_district": idDistrict,
        "worker_name": workerName,
        "worker_rating": workerRating,
        "worker_salary": workerSalary,
        "worker_desc": workerDesc,
        "worker_weight": workerWeight,
        "worker_height": workerHeight,
        "province_name": provinceName,
        "district_name": districtName,
        "worker_age": workerAge,
        "paid": paid,
        "worker_profile": workerProfile,
        "category_desc": categoryDesc,
        "worker_more": workerMore.toJson(),
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
