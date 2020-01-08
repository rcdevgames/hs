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
    bool workerOnlineRegist;
    String workerSalaryDaily;
    String provinceName;
    String districtName;
    int workerAge;
    bool paid;
    String workerProfile;
    String categoryDesc;
    String categoryPpSalary;
    WorkerMore workerMore;
    List<WorkerCertificate> workerCertificate;
    List<String> workerPlacement;
    List<String> workerSkills;
    String admPrice;

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
        this.workerOnlineRegist,
        this.workerSalaryDaily,
        this.provinceName,
        this.districtName,
        this.workerAge,
        this.paid,
        this.workerProfile,
        this.categoryDesc,
        this.categoryPpSalary,
        this.workerMore,
        this.workerCertificate,
        this.workerPlacement,
        this.workerSkills,
        this.admPrice,
    });

    factory Worker.fromJson(Map<String, dynamic> json) => Worker(
        idWorker: json["id_worker"] == null ? null : json["id_worker"],
        idProvince: json["id_province"] == null ? null : json["id_province"],
        idDistrict: json["id_district"] == null ? null : json["id_district"],
        workerName: json["worker_name"] == null ? null : json["worker_name"],
        workerRating: json["worker_rating"] == null ? null : json["worker_rating"],
        workerSalary: json["worker_salary"] == null ? null : json["worker_salary"],
        workerDesc: json["worker_desc"] == null ? null : json["worker_desc"],
        workerWeight: json["worker_weight"] == null ? null : json["worker_weight"],
        workerHeight: json["worker_height"] == null ? null : json["worker_height"],
        workerOnlineRegist: json["worker_online_regist"] == null ? null : json["worker_online_regist"],
        workerSalaryDaily: json["worker_salary_daily"] == null ? null : json["worker_salary_daily"],
        provinceName: json["province_name"] == null ? null : json["province_name"],
        districtName: json["district_name"] == null ? null : json["district_name"],
        workerAge: json["worker_age"] == null ? null : json["worker_age"],
        paid: json["paid"] == null ? null : json["paid"],
        workerProfile: json["worker_profile"] == null ? null : json["worker_profile"],
        categoryDesc: json["category_desc"] == null ? null : json["category_desc"],
        categoryPpSalary: json["category_pp_salary"] == null ? null : json["category_pp_salary"],
        workerMore: json["worker_more"] == null ? null : WorkerMore.fromJson(json["worker_more"]),
        workerCertificate: json["worker_certificate"] == null ? null : List<WorkerCertificate>.from(json["worker_certificate"].map((x) => WorkerCertificate.fromJson(x))),
        workerPlacement: json["worker_placement"] == null ? null : List<String>.from(json["worker_placement"].map((x) => x)),
        workerSkills: json["worker_skills"] == null ? null : List<String>.from(json["worker_skills"].map((x) => x)),
        admPrice: json["adm_price"] == null ? null : json["adm_price"],
    );

    Map<String, dynamic> toJson() => {
        "id_worker": idWorker == null ? null : idWorker,
        "id_province": idProvince == null ? null : idProvince,
        "id_district": idDistrict == null ? null : idDistrict,
        "worker_name": workerName == null ? null : workerName,
        "worker_rating": workerRating == null ? null : workerRating,
        "worker_salary": workerSalary == null ? null : workerSalary,
        "worker_desc": workerDesc == null ? null : workerDesc,
        "worker_weight": workerWeight == null ? null : workerWeight,
        "worker_height": workerHeight == null ? null : workerHeight,
        "worker_online_regist": workerOnlineRegist == null ? null : workerOnlineRegist,
        "worker_salary_daily": workerSalaryDaily == null ? null : workerSalaryDaily,
        "province_name": provinceName == null ? null : provinceName,
        "district_name": districtName == null ? null : districtName,
        "worker_age": workerAge == null ? null : workerAge,
        "paid": paid == null ? null : paid,
        "worker_profile": workerProfile == null ? null : workerProfile,
        "category_desc": categoryDesc == null ? null : categoryDesc,
        "category_pp_salary": categoryPpSalary == null ? null : categoryPpSalary,
        "worker_more": workerMore == null ? null : workerMore.toJson(),
        "worker_certificate": workerCertificate == null ? null : List<dynamic>.from(workerCertificate.map((x) => x.toJson())),
        "worker_placement": workerPlacement == null ? null : List<dynamic>.from(workerPlacement.map((x) => x)),
        "worker_skills": workerSkills == null ? null : List<dynamic>.from(workerSkills.map((x) => x)),
        "adm_price": admPrice == null ? null : admPrice,
    };
}

class WorkerCertificate {
    String certificateTitle;
    String certificateImage;

    WorkerCertificate({
        this.certificateTitle,
        this.certificateImage,
    });

    factory WorkerCertificate.fromJson(Map<String, dynamic> json) => WorkerCertificate(
        certificateTitle: json["certificate_title"] == null ? null : json["certificate_title"],
        certificateImage: json["certificate_image"] == null ? null : json["certificate_image"],
    );

    Map<String, dynamic> toJson() => {
        "certificate_title": certificateTitle == null ? null : certificateTitle,
        "certificate_image": certificateImage == null ? null : certificateImage,
    };
}

class WorkerMore {
    bool wmoreStayIn;
    String wmoreChildren;
    String wmoreStatus;
    String wmoreReligion;
    bool wmoreAbroadEx;
    dynamic wmoreLanguage;
    String wmorePhobia;
    bool wmoreWorked;
    dynamic wmoreWorkedDesc;
    bool wmorePork;
    bool wmoreAfraidDog;
    String wmoreTribe;
    String wmoreChildlike;
    String wmoreDriving;
    dynamic wmoreAlergic;
    bool wmoreHappyChild;
    bool wmoreReadyWork;
    bool wmoreAggrement;
    bool wmoreSicknessVehicle;
    dynamic wmoreFacebook;
    dynamic wmoreInstagram;
    dynamic wmoreOthers;
    dynamic wmoreWorkExp;
    dynamic wmoreSkillDesc;
    dynamic wmoreSim;
    dynamic wmoreCertificate;
    dynamic wmoreLegalOthers;
    String wmoreRiding;

    WorkerMore({
        this.wmoreStayIn,
        this.wmoreChildren,
        this.wmoreStatus,
        this.wmoreReligion,
        this.wmoreAbroadEx,
        this.wmoreLanguage,
        this.wmorePhobia,
        this.wmoreWorked,
        this.wmoreWorkedDesc,
        this.wmorePork,
        this.wmoreAfraidDog,
        this.wmoreTribe,
        this.wmoreChildlike,
        this.wmoreDriving,
        this.wmoreAlergic,
        this.wmoreHappyChild,
        this.wmoreReadyWork,
        this.wmoreAggrement,
        this.wmoreSicknessVehicle,
        this.wmoreFacebook,
        this.wmoreInstagram,
        this.wmoreOthers,
        this.wmoreWorkExp,
        this.wmoreSkillDesc,
        this.wmoreSim,
        this.wmoreCertificate,
        this.wmoreLegalOthers,
        this.wmoreRiding,
    });

    factory WorkerMore.fromJson(Map<String, dynamic> json) => WorkerMore(
        wmoreStayIn: json["wmore_stay_in"] == null ? null : json["wmore_stay_in"],
        wmoreChildren: json["wmore_children"] == null ? null : json["wmore_children"],
        wmoreStatus: json["wmore_status"] == null ? null : json["wmore_status"],
        wmoreReligion: json["wmore_religion"] == null ? null : json["wmore_religion"],
        wmoreAbroadEx: json["wmore_abroad_ex"] == null ? null : json["wmore_abroad_ex"],
        wmoreLanguage: json["wmore_language"],
        wmorePhobia: json["wmore_phobia"] == null ? null : json["wmore_phobia"],
        wmoreWorked: json["wmore_worked"] == null ? null : json["wmore_worked"],
        wmoreWorkedDesc: json["wmore_worked_desc"],
        wmorePork: json["wmore_pork"] == null ? null : json["wmore_pork"],
        wmoreAfraidDog: json["wmore_afraid_dog"] == null ? null : json["wmore_afraid_dog"],
        wmoreTribe: json["wmore_tribe"] == null ? null : json["wmore_tribe"],
        wmoreChildlike: json["wmore_childlike"] == null ? null : json["wmore_childlike"],
        wmoreDriving: json["wmore_driving"] == null ? null : json["wmore_driving"],
        wmoreAlergic: json["wmore_alergic"],
        wmoreHappyChild: json["wmore_happy_child"] == null ? null : json["wmore_happy_child"],
        wmoreReadyWork: json["wmore_ready_work"] == null ? null : json["wmore_ready_work"],
        wmoreAggrement: json["wmore_aggrement"] == null ? null : json["wmore_aggrement"],
        wmoreSicknessVehicle: json["wmore_sickness_vehicle"] == null ? null : json["wmore_sickness_vehicle"],
        wmoreFacebook: json["wmore_facebook"],
        wmoreInstagram: json["wmore_instagram"],
        wmoreOthers: json["wmore_others"],
        wmoreWorkExp: json["wmore_work_exp"],
        wmoreSkillDesc: json["wmore_skill_desc"],
        wmoreSim: json["wmore_sim"],
        wmoreCertificate: json["wmore_certificate"],
        wmoreLegalOthers: json["wmore_legal_others"],
        wmoreRiding: json["wmore_riding"] == null ? null : json["wmore_riding"],
    );

    Map<String, dynamic> toJson() => {
        "wmore_stay_in": wmoreStayIn == null ? null : wmoreStayIn,
        "wmore_children": wmoreChildren == null ? null : wmoreChildren,
        "wmore_status": wmoreStatus == null ? null : wmoreStatus,
        "wmore_religion": wmoreReligion == null ? null : wmoreReligion,
        "wmore_abroad_ex": wmoreAbroadEx == null ? null : wmoreAbroadEx,
        "wmore_language": wmoreLanguage,
        "wmore_phobia": wmorePhobia == null ? null : wmorePhobia,
        "wmore_worked": wmoreWorked == null ? null : wmoreWorked,
        "wmore_worked_desc": wmoreWorkedDesc,
        "wmore_pork": wmorePork == null ? null : wmorePork,
        "wmore_afraid_dog": wmoreAfraidDog == null ? null : wmoreAfraidDog,
        "wmore_tribe": wmoreTribe == null ? null : wmoreTribe,
        "wmore_childlike": wmoreChildlike == null ? null : wmoreChildlike,
        "wmore_driving": wmoreDriving == null ? null : wmoreDriving,
        "wmore_alergic": wmoreAlergic,
        "wmore_happy_child": wmoreHappyChild == null ? null : wmoreHappyChild,
        "wmore_ready_work": wmoreReadyWork == null ? null : wmoreReadyWork,
        "wmore_aggrement": wmoreAggrement == null ? null : wmoreAggrement,
        "wmore_sickness_vehicle": wmoreSicknessVehicle == null ? null : wmoreSicknessVehicle,
        "wmore_facebook": wmoreFacebook,
        "wmore_instagram": wmoreInstagram,
        "wmore_others": wmoreOthers,
        "wmore_work_exp": wmoreWorkExp,
        "wmore_skill_desc": wmoreSkillDesc,
        "wmore_sim": wmoreSim,
        "wmore_certificate": wmoreCertificate,
        "wmore_legal_others": wmoreLegalOthers,
        "wmore_riding": wmoreRiding == null ? null : wmoreRiding,
    };
}
