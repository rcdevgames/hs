// To parse this JSON data, do
//
//     final searchWorker = searchWorkerFromJson(jsonString);

import 'dart:convert';

SearchWorker searchWorkerFromJson(String str) => SearchWorker.fromJson(json.decode(str));

String searchWorkerToJson(SearchWorker data) => json.encode(data.toJson());

class SearchWorker {
    int page;
    int limit;
    int paging;
    List<Datum> data;

    SearchWorker({
        this.page,
        this.limit,
        this.paging,
        this.data,
    });

    factory SearchWorker.fromJson(Map<String, dynamic> json) => SearchWorker(
        page: json["page"] == null ? null : json["page"],
        limit: json["limit"] == null ? null : json["limit"],
        paging: json["paging"] == null ? null : json["paging"],
        data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "page": page == null ? null : page,
        "limit": limit == null ? null : limit,
        "paging": paging == null ? null : paging,
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    // int idCategory;
    String categoryDesc;
    int idWorker;
    // int idProvince;
    // int idDistrict;
    String workerName;
    String workerRating;
    // String workerDesc;
    String workerSalary;
    // String workerSlug;
    String provinceName;
    String districtName;
    int workerAge;
    String workerProfile;
    bool stayIn;

    Datum({
        // this.idCategory,
        this.categoryDesc,
        this.idWorker,
        // this.idProvince,
        // this.idDistrict,
        this.workerName,
        this.workerRating,
        // this.workerDesc,
        this.workerSalary,
        // this.workerSlug,
        this.provinceName,
        this.districtName,
        this.workerAge,
        this.workerProfile,
        this.stayIn,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        // idCategory: json["id_category"] == null ? null : json["id_category"],
        categoryDesc: json["category_desc"] == null ? null : json["category_desc"],
        idWorker: json["id_worker"] == null ? null : json["id_worker"],
        // idProvince: json["id_province"] == null ? null : json["id_province"],
        // idDistrict: json["id_district"] == null ? null : json["id_district"],
        workerName: json["worker_name"] == null ? null : json["worker_name"],
        workerRating: json["worker_rating"] == null ? null : json["worker_rating"],
        // workerDesc: json["worker_desc"] == null ? null : json["worker_desc"],
        workerSalary: json["worker_salary"] == null ? null : json["worker_salary"],
        // workerSlug: json["worker_slug"] == null ? null : json["worker_slug"],
        provinceName: json["province_name"] == null ? null : json["province_name"],
        districtName: json["district_name"] == null ? null : json["district_name"],
        workerAge: json["worker_age"] == null ? null : json["worker_age"],
        workerProfile: json["worker_profile"] == null ? null : json["worker_profile"],
        stayIn: json["stay_in"] == null ? null : json["stay_in"],
    );

    Map<String, dynamic> toJson() => {
        // // "id_category": idCategory == null ? null : idCategory,
        "category_desc": categoryDesc == null ? null : categoryDesc,
        "id_worker": idWorker == null ? null : idWorker,
        // "id_province": idProvince == null ? null : idProvince,
        // "id_district": idDistrict == null ? null : idDistrict,
        "worker_name": workerName == null ? null : workerName,
        "worker_rating": workerRating == null ? null : workerRating,
        // "worker_desc": workerDesc == null ? null : workerDesc,
        "worker_salary": workerSalary == null ? null : workerSalary,
        // "worker_slug": workerSlug == null ? null : workerSlug,
        "province_name": provinceName == null ? null : provinceName,
        "district_name": districtName == null ? null : districtName,
        "worker_age": workerAge == null ? null : workerAge,
        "worker_profile": workerProfile == null ? null : workerProfile,
        "stay_in": stayIn == null ? null : stayIn,
    };
}
