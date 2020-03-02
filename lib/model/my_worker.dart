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
    String workerSalaryDaily;
    String workerDesc;
    String workerPath;
    String workerWeight;
    String workerHeight;
    bool wmoreStayIn;
    dynamic workerLat;
    dynamic workerLong;
    bool onlineRegist;
    String districtName;
    String provinceName;
    String transAttempt;
    int totalDay;
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
        this.workerSalaryDaily,
        this.workerDesc,
        this.workerPath,
        this.workerWeight,
        this.workerHeight,
        this.wmoreStayIn,
        this.workerLat,
        this.workerLong,
        this.onlineRegist,
        this.districtName,
        this.provinceName,
        this.transAttempt,
        this.totalDay,
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

    factory MyWorker.fromJson(Map<String, dynamic> json) => MyWorker(
        idCworker: json["id_cworker"] == null ? null : json["id_cworker"],
        idCustomer: json["id_customer"] == null ? null : json["id_customer"],
        idWorker: json["id_worker"] == null ? null : json["id_worker"],
        cworkerActive: json["cworker_active"] == null ? null : json["cworker_active"],
        cworkerStart: json["cworker_start"] == null ? null : DateTime.parse(json["cworker_start"]),
        idOrder: json["id_order"] == null ? null : json["id_order"],
        idTrans: json["id_trans"] == null ? null : json["id_trans"],
        workerName: json["worker_name"] == null ? null : json["worker_name"],
        workerEmail: json["worker_email"] == null ? null : json["worker_email"],
        workerPhone: json["worker_phone"] == null ? null : json["worker_phone"],
        workerHandphone: json["worker_handphone"] == null ? null : json["worker_handphone"],
        workerAddress: json["worker_address"] == null ? null : json["worker_address"],
        workerBirthdate: json["worker_birthdate"] == null ? null : DateTime.parse(json["worker_birthdate"]),
        workerRating: json["worker_rating"] == null ? null : json["worker_rating"],
        workerSalary: json["worker_salary"] == null ? null : json["worker_salary"],
        workerSalaryDaily: json["worker_salary_daily"] == null ? null : json["worker_salary_daily"],
        workerDesc: json["worker_desc"] == null ? null : json["worker_desc"],
        workerPath: json["worker_path"] == null ? null : json["worker_path"],
        workerWeight: json["worker_weight"] == null ? null : json["worker_weight"],
        workerHeight: json["worker_height"] == null ? null : json["worker_height"],
        wmoreStayIn: json["wmore_stay_in"] == null ? null : json["wmore_stay_in"],
        workerLat: json["worker_lat"],
        workerLong: json["worker_long"],
        onlineRegist: json["online_regist"] == null ? null : json["online_regist"],
        districtName: json["district_name"] == null ? null : json["district_name"],
        provinceName: json["province_name"] == null ? null : json["province_name"],
        transAttempt: json["trans_attempt"] == null ? null : json["trans_attempt"],
        totalDay: json["totalDay"] == null ? null : json["totalDay"],
        workerAge: json["worker_age"] == null ? null : json["worker_age"],
        workerProfile: json["worker_profile"] == null ? null : json["worker_profile"],
        workerSalaryFormatted: json["worker_salary_formatted"] == null ? null : json["worker_salary_formatted"],
        requestReject: json["request_reject"] == null ? null : json["request_reject"],
        categoryDesc: json["category_desc"] == null ? null : json["category_desc"],
        rejectReason: json["reject_reason"],
        rejectReasonUploaded: json["reject_reason_uploaded"],
        workerMore: json["worker_more"] == null ? null : WorkerMore.fromJson(json["worker_more"]),
        workerPhotos: json["worker_photos"] == null ? null : List<WorkerPhoto>.from(json["worker_photos"].map((x) => WorkerPhoto.fromJson(x))),
        workerCertificate: json["worker_certificate"] == null ? null : List<WorkerCertificate>.from(json["worker_certificate"].map((x) => WorkerCertificate.fromJson(x))),
        workerPlacement: json["worker_placement"] == null ? null : List<String>.from(json["worker_placement"].map((x) => x)),
        workerSkills: json["worker_skills"] == null ? null : List<String>.from(json["worker_skills"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id_cworker": idCworker == null ? null : idCworker,
        "id_customer": idCustomer == null ? null : idCustomer,
        "id_worker": idWorker == null ? null : idWorker,
        "cworker_active": cworkerActive == null ? null : cworkerActive,
        "cworker_start": cworkerStart == null ? null : cworkerStart.toIso8601String(),
        "id_order": idOrder == null ? null : idOrder,
        "id_trans": idTrans == null ? null : idTrans,
        "worker_name": workerName == null ? null : workerName,
        "worker_email": workerEmail == null ? null : workerEmail,
        "worker_phone": workerPhone == null ? null : workerPhone,
        "worker_handphone": workerHandphone == null ? null : workerHandphone,
        "worker_address": workerAddress == null ? null : workerAddress,
        "worker_birthdate": workerBirthdate == null ? null : "${workerBirthdate.year.toString().padLeft(4, '0')}-${workerBirthdate.month.toString().padLeft(2, '0')}-${workerBirthdate.day.toString().padLeft(2, '0')}",
        "worker_rating": workerRating == null ? null : workerRating,
        "worker_salary": workerSalary == null ? null : workerSalary,
        "worker_salary_daily": workerSalaryDaily == null ? null : workerSalaryDaily,
        "worker_desc": workerDesc == null ? null : workerDesc,
        "worker_path": workerPath == null ? null : workerPath,
        "worker_weight": workerWeight == null ? null : workerWeight,
        "worker_height": workerHeight == null ? null : workerHeight,
        "wmore_stay_in": wmoreStayIn == null ? null : wmoreStayIn,
        "worker_lat": workerLat,
        "worker_long": workerLong,
        "online_regist": onlineRegist == null ? null : onlineRegist,
        "district_name": districtName == null ? null : districtName,
        "province_name": provinceName == null ? null : provinceName,
        "trans_attempt": transAttempt == null ? null : transAttempt,
        "totalDay": totalDay == null ? null : totalDay,
        "worker_age": workerAge == null ? null : workerAge,
        "worker_profile": workerProfile == null ? null : workerProfile,
        "worker_salary_formatted": workerSalaryFormatted == null ? null : workerSalaryFormatted,
        "request_reject": requestReject == null ? null : requestReject,
        "category_desc": categoryDesc == null ? null : categoryDesc,
        "reject_reason": rejectReason,
        "reject_reason_uploaded": rejectReasonUploaded,
        "worker_more": workerMore == null ? null : workerMore.toJson(),
        "worker_photos": workerPhotos == null ? null : List<dynamic>.from(workerPhotos.map((x) => x.toJson())),
        "worker_certificate": workerCertificate == null ? null : List<dynamic>.from(workerCertificate.map((x) => x.toJson())),
        "worker_placement": workerPlacement == null ? null : List<dynamic>.from(workerPlacement.map((x) => x)),
        "worker_skills": workerSkills == null ? null : List<dynamic>.from(workerSkills.map((x) => x)),
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
    dynamic wmorePhobia;
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
        wmorePhobia: json["wmore_phobia"],
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
        "wmore_phobia": wmorePhobia,
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

class WorkerPhoto {
    String title;
    String image;

    WorkerPhoto({
        this.title,
        this.image,
    });

    factory WorkerPhoto.fromJson(Map<String, dynamic> json) => WorkerPhoto(
        title: json["title"] == null ? null : json["title"],
        image: json["image"] == null ? null : json["image"],
    );

    Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "image": image == null ? null : image,
    };
}
