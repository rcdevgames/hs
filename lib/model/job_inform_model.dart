// To parse this JSON data, do
//
//     final jobInform = jobInformFromJson(jsonString);

import 'dart:convert';

List<JobInform> jobInformFromJson(String str) => List<JobInform>.from(json.decode(str).map((x) => JobInform.fromJson(x)));

String jobInformToJson(List<JobInform> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JobInform {
    int idJob;
    int idCustomer;
    int idCategory;
    String jobTitle;
    String jobDesc;
    String jobPlacement;
    bool jobClosed;
    bool jobHide;
    DateTime jobCreated;
    String customerName;
    String customerPhone;
    String customerAddress;
    String customerProvince;
    String customerDistrict;
    String categoryName;
    List<Pekerja> workers;

    JobInform({
        this.idJob,
        this.idCustomer,
        this.idCategory,
        this.jobTitle,
        this.jobDesc,
        this.jobPlacement,
        this.jobClosed,
        this.jobHide,
        this.jobCreated,
        this.customerName,
        this.customerPhone,
        this.customerAddress,
        this.customerProvince,
        this.customerDistrict,
        this.categoryName,
        this.workers,
    });

    factory JobInform.fromJson(Map<String, dynamic> json) => JobInform(
        idJob: json["id_job"] == null ? null : json["id_job"],
        idCustomer: json["id_customer"] == null ? null : json["id_customer"],
        idCategory: json["id_category"] == null ? null : json["id_category"],
        jobTitle: json["job_title"] == null ? null : json["job_title"],
        jobDesc: json["job_desc"] == null ? null : json["job_desc"],
        jobPlacement: json["job_placement"] == null ? null : json["job_placement"],
        jobClosed: json["job_closed"] == null ? null : json["job_closed"],
        jobHide: json["job_hide"] == null ? null : json["job_hide"],
        jobCreated: json["job_created"] == null ? null : DateTime.parse(json["job_created"]),
        customerName: json["customer_name"] == null ? null : json["customer_name"],
        customerPhone: json["customer_phone"] == null ? null : json["customer_phone"],
        customerAddress: json["customer_address"] == null ? null : json["customer_address"],
        customerProvince: json["customer_province"] == null ? null : json["customer_province"],
        customerDistrict: json["customer_district"] == null ? null : json["customer_district"],
        categoryName: json["category_name"] == null ? null : json["category_name"],
        workers: json["workers"] == null ? null : List<Pekerja>.from(json["workers"].map((x) => Pekerja.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id_job": idJob == null ? null : idJob,
        "id_customer": idCustomer == null ? null : idCustomer,
        "id_category": idCategory == null ? null : idCategory,
        "job_title": jobTitle == null ? null : jobTitle,
        "job_desc": jobDesc == null ? null : jobDesc,
        "job_placement": jobPlacement == null ? null : jobPlacement,
        "job_closed": jobClosed == null ? null : jobClosed,
        "job_hide": jobHide == null ? null : jobHide,
        "job_created": jobCreated == null ? null : jobCreated.toIso8601String(),
        "customer_name": customerName == null ? null : customerName,
        "customer_phone": customerPhone == null ? null : customerPhone,
        "customer_address": customerAddress == null ? null : customerAddress,
        "customer_province": customerProvince == null ? null : customerProvince,
        "customer_district": customerDistrict == null ? null : customerDistrict,
        "category_name": categoryName == null ? null : categoryName,
        "workers": workers == null ? null : List<dynamic>.from(workers.map((x) => x.toJson())),
    };
}

class Pekerja {
    int idJres;
    int idJob;
    int idWorker;
    String jresNote;
    DateTime jresCreated;
    String workerName;
    String workerRating;
    String workerSalary;
    String workerWeight;
    String workerHeight;
    String workerImage;
    int workerAge;

    Pekerja({
        this.idJres,
        this.idJob,
        this.idWorker,
        this.jresNote,
        this.jresCreated,
        this.workerName,
        this.workerRating,
        this.workerSalary,
        this.workerWeight,
        this.workerHeight,
        this.workerImage,
        this.workerAge,
    });

    factory Pekerja.fromJson(Map<String, dynamic> json) => Pekerja(
        idJres: json["id_jres"] == null ? null : json["id_jres"],
        idJob: json["id_job"] == null ? null : json["id_job"],
        idWorker: json["id_worker"] == null ? null : json["id_worker"],
        jresNote: json["jres_note"] == null ? null : json["jres_note"],
        jresCreated: json["jres_created"] == null ? null : DateTime.parse(json["jres_created"]),
        workerName: json["worker_name"] == null ? null : json["worker_name"],
        workerRating: json["worker_rating"] == null ? null : json["worker_rating"],
        workerSalary: json["worker_salary"] == null ? null : json["worker_salary"],
        workerWeight: json["worker_weight"] == null ? null : json["worker_weight"].toString(),
        workerHeight: json["worker_height"] == null ? null : json["worker_height"].toString(),
        workerImage: json["worker_image"] == null ? null : json["worker_image"],
        workerAge: json["worker_age"] == null ? null : json["worker_age"],
    );

    Map<String, dynamic> toJson() => {
        "id_jres": idJres == null ? null : idJres,
        "id_job": idJob == null ? null : idJob,
        "id_worker": idWorker == null ? null : idWorker,
        "jres_note": jresNote == null ? null : jresNote,
        "jres_created": jresCreated == null ? null : jresCreated.toIso8601String(),
        "worker_name": workerName == null ? null : workerName,
        "worker_rating": workerRating == null ? null : workerRating,
        "worker_salary": workerSalary == null ? null : workerSalary,
        "worker_weight": workerWeight == null ? null : workerWeight,
        "worker_height": workerHeight == null ? null : workerHeight,
        "worker_image": workerImage == null ? null : workerImage,
        "worker_age": workerAge == null ? null : workerAge,
    };
}
