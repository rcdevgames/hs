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
    String categoryDesc;
    String categoryPpSalary;
    int idWorker;
    String workerName;
    String workerRating;
    String workerSalary;
    bool wmoreStayIn;
    bool workerSingleApp;
    String workerSalaryDaily;
    String provinceName;
    String districtName;
    bool workerOnlineRegist;
    int workerAge;
    String workerProfile;
    String admPrice;

    Datum({
        this.categoryDesc,
        this.categoryPpSalary,
        this.idWorker,
        this.workerName,
        this.workerRating,
        this.workerSalary,
        this.wmoreStayIn,
        this.workerSingleApp,
        this.workerSalaryDaily,
        this.provinceName,
        this.districtName,
        this.workerOnlineRegist,
        this.workerAge,
        this.workerProfile,
        this.admPrice,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        categoryDesc: json["category_desc"] == null ? null : json["category_desc"],
        categoryPpSalary: json["category_pp_salary"] == null ? null : json["category_pp_salary"],
        idWorker: json["id_worker"] == null ? null : json["id_worker"],
        workerName: json["worker_name"] == null ? null : json["worker_name"],
        workerRating: json["worker_rating"] == null ? null : json["worker_rating"],
        workerSalary: json["worker_salary"] == null ? null : json["worker_salary"],
        wmoreStayIn: json["wmore_stay_in"] == null ? null : json["wmore_stay_in"],
        workerSingleApp: json["worker_single_app"] == null ? null : json["worker_single_app"],
        workerSalaryDaily: json["worker_salary_daily"] == null ? null : json["worker_salary_daily"],
        provinceName: json["province_name"] == null ? null : json["province_name"],
        districtName: json["district_name"] == null ? null : json["district_name"],
        workerOnlineRegist: json["worker_online_regist"] == null ? null : json["worker_online_regist"],
        workerAge: json["worker_age"] == null ? null : json["worker_age"],
        workerProfile: json["worker_profile"] == null ? null : json["worker_profile"],
        admPrice: json["adm_price"] == null ? null : json["adm_price"],
    );

    Map<String, dynamic> toJson() => {
        "category_desc": categoryDesc == null ? null : categoryDesc,
        "category_pp_salary": categoryPpSalary == null ? null : categoryPpSalary,
        "id_worker": idWorker == null ? null : idWorker,
        "worker_name": workerName == null ? null : workerName,
        "worker_rating": workerRating == null ? null : workerRating,
        "worker_salary": workerSalary == null ? null : workerSalary,
        "wmore_stay_in": wmoreStayIn == null ? null : wmoreStayIn,
        "worker_single_app": workerSingleApp == null ? null : workerSingleApp,
        "worker_salary_daily": workerSalaryDaily == null ? null : workerSalaryDaily,
        "province_name": provinceName == null ? null : provinceName,
        "district_name": districtName == null ? null : districtName,
        "worker_online_regist": workerOnlineRegist == null ? null : workerOnlineRegist,
        "worker_age": workerAge == null ? null : workerAge,
        "worker_profile": workerProfile == null ? null : workerProfile,
        "adm_price": admPrice == null ? null : admPrice,
    };
}
