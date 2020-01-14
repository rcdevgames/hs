// To parse this JSON data, do
//
//     final paymentDetail = paymentDetailFromJson(jsonString);

import 'dart:convert';

PaymentDetail paymentDetailFromJson(String str) => PaymentDetail.fromJson(json.decode(str));

String paymentDetailToJson(PaymentDetail data) => json.encode(data.toJson());

class PaymentDetail {
    int idTrans;
    int idCustomer;
    int idPacket;
    int idCategory;
    String transStatus;
    String transApprovalImage;
    dynamic transApprovalUploaded;
    dynamic transApprovedDate;
    String transCreated;
    String transUpdated;
    String transId;
    String transAttempt;
    bool transRejectAdmin;
    bool transCreatedAdmin;
    dynamic transMidCallback;
    bool transHide;
    String transTotalDay;
    String transAdmPrice;
    String transPaymentMethod;
    String packetPrice;
    String categoryDesc;
    String invoice;
    List<Detail> detail;

    PaymentDetail({
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
        this.transRejectAdmin,
        this.transCreatedAdmin,
        this.transMidCallback,
        this.transHide,
        this.transTotalDay,
        this.transAdmPrice,
        this.transPaymentMethod,
        this.packetPrice,
        this.categoryDesc,
        this.invoice,
        this.detail,
    });

    factory PaymentDetail.fromJson(Map<String, dynamic> json) => PaymentDetail(
        idTrans: json["id_trans"] == null ? null : json["id_trans"],
        idCustomer: json["id_customer"] == null ? null : json["id_customer"],
        idPacket: json["id_packet"] == null ? null : json["id_packet"],
        idCategory: json["id_category"] == null ? null : json["id_category"],
        transStatus: json["trans_status"] == null ? null : json["trans_status"],
        transApprovalImage: json["trans_approval_image"] == null ? null : json["trans_approval_image"],
        transApprovalUploaded: json["trans_approval_uploaded"],
        transApprovedDate: json["trans_approved_date"],
        transCreated: json["trans_created"] == null ? null : json["trans_created"],
        transUpdated: json["trans_updated"] == null ? null : json["trans_updated"],
        transId: json["trans_id"] == null ? null : json["trans_id"],
        transAttempt: json["trans_attempt"] == null ? null : json["trans_attempt"],
        transRejectAdmin: json["trans_reject_admin"] == null ? null : json["trans_reject_admin"],
        transCreatedAdmin: json["trans_created_admin"] == null ? null : json["trans_created_admin"],
        transMidCallback: json["trans_mid_callback"],
        transHide: json["trans_hide"] == null ? null : json["trans_hide"],
        transTotalDay: json["trans_total_day"] == null ? null : json["trans_total_day"],
        transAdmPrice: json["trans_adm_price"] == null ? null : json["trans_adm_price"],
        transPaymentMethod: json["trans_payment_method"] == null ? null : json["trans_payment_method"],
        packetPrice: json["packet_price"] == null ? null : json["packet_price"],
        categoryDesc: json["category_desc"] == null ? null : json["category_desc"],
        invoice: json["invoice"] == null ? null : json["invoice"],
        detail: json["detail"] == null ? null : List<Detail>.from(json["detail"].map((x) => Detail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id_trans": idTrans == null ? null : idTrans,
        "id_customer": idCustomer == null ? null : idCustomer,
        "id_packet": idPacket == null ? null : idPacket,
        "id_category": idCategory == null ? null : idCategory,
        "trans_status": transStatus == null ? null : transStatus,
        "trans_approval_image": transApprovalImage == null ? null : transApprovalImage,
        "trans_approval_uploaded": transApprovalUploaded,
        "trans_approved_date": transApprovedDate,
        "trans_created": transCreated == null ? null : transCreated,
        "trans_updated": transUpdated == null ? null : transUpdated,
        "trans_id": transId == null ? null : transId,
        "trans_attempt": transAttempt == null ? null : transAttempt,
        "trans_reject_admin": transRejectAdmin == null ? null : transRejectAdmin,
        "trans_created_admin": transCreatedAdmin == null ? null : transCreatedAdmin,
        "trans_mid_callback": transMidCallback,
        "trans_hide": transHide == null ? null : transHide,
        "trans_total_day": transTotalDay == null ? null : transTotalDay,
        "trans_adm_price": transAdmPrice == null ? null : transAdmPrice,
        "trans_payment_method": transPaymentMethod == null ? null : transPaymentMethod,
        "packet_price": packetPrice == null ? null : packetPrice,
        "category_desc": categoryDesc == null ? null : categoryDesc,
        "invoice": invoice == null ? null : invoice,
        "detail": detail == null ? null : List<dynamic>.from(detail.map((x) => x.toJson())),
    };
}

class Detail {
    int idTworker;
    int idTrans;
    String tworkerStatus;
    dynamic tworkerRejectReason;
    dynamic tworkerRejectCreated;
    dynamic tworkerDealCreated;
    String tworkerCreated;
    int idWorker;
    String workerName;
    dynamic workerPhone;
    dynamic workerEmail;
    dynamic workerHandphone;
    dynamic workerAddress;
    String workerRating;
    String workerSalary;
    String workerDesc;
    DateTime workerBirthdate;
    String workerSalaryDaily;
    bool workerOnlineRegist;
    String districtName;
    String provinceName;
    int workerAge;
    String workerProfile;
    String workerSalaryFormatted;
    bool wmoreStayIn;

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
        this.workerSalaryDaily,
        this.workerOnlineRegist,
        this.districtName,
        this.provinceName,
        this.workerAge,
        this.workerProfile,
        this.workerSalaryFormatted,
        this.wmoreStayIn,
    });

    factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        idTworker: json["id_tworker"] == null ? null : json["id_tworker"],
        idTrans: json["id_trans"] == null ? null : json["id_trans"],
        tworkerStatus: json["tworker_status"] == null ? null : json["tworker_status"],
        tworkerRejectReason: json["tworker_reject_reason"],
        tworkerRejectCreated: json["tworker_reject_created"],
        tworkerDealCreated: json["tworker_deal_created"],
        tworkerCreated: json["tworker_created"] == null ? null : json["tworker_created"],
        idWorker: json["id_worker"] == null ? null : json["id_worker"],
        workerName: json["worker_name"] == null ? null : json["worker_name"],
        workerPhone: json["worker_phone"],
        workerEmail: json["worker_email"],
        workerHandphone: json["worker_handphone"],
        workerAddress: json["worker_address"],
        workerRating: json["worker_rating"] == null ? null : json["worker_rating"],
        workerSalary: json["worker_salary"] == null ? null : json["worker_salary"],
        workerDesc: json["worker_desc"] == null ? null : json["worker_desc"],
        workerBirthdate: json["worker_birthdate"] == null ? null : DateTime.parse(json["worker_birthdate"]),
        workerSalaryDaily: json["worker_salary_daily"] == null ? null : json["worker_salary_daily"],
        workerOnlineRegist: json["worker_online_regist"] == null ? null : json["worker_online_regist"],
        districtName: json["district_name"] == null ? null : json["district_name"],
        provinceName: json["province_name"] == null ? null : json["province_name"],
        workerAge: json["worker_age"] == null ? null : json["worker_age"],
        workerProfile: json["worker_profile"] == null ? null : json["worker_profile"],
        workerSalaryFormatted: json["worker_salary_formatted"] == null ? null : json["worker_salary_formatted"],
        wmoreStayIn: json["wmore_stay_in"] == null ? null : json["wmore_stay_in"],
    );

    Map<String, dynamic> toJson() => {
        "id_tworker": idTworker == null ? null : idTworker,
        "id_trans": idTrans == null ? null : idTrans,
        "tworker_status": tworkerStatus == null ? null : tworkerStatus,
        "tworker_reject_reason": tworkerRejectReason,
        "tworker_reject_created": tworkerRejectCreated,
        "tworker_deal_created": tworkerDealCreated,
        "tworker_created": tworkerCreated == null ? null : tworkerCreated,
        "id_worker": idWorker == null ? null : idWorker,
        "worker_name": workerName == null ? null : workerName,
        "worker_phone": workerPhone,
        "worker_email": workerEmail,
        "worker_handphone": workerHandphone,
        "worker_address": workerAddress,
        "worker_rating": workerRating == null ? null : workerRating,
        "worker_salary": workerSalary == null ? null : workerSalary,
        "worker_desc": workerDesc == null ? null : workerDesc,
        "worker_birthdate": workerBirthdate == null ? null : "${workerBirthdate.year.toString().padLeft(4, '0')}-${workerBirthdate.month.toString().padLeft(2, '0')}-${workerBirthdate.day.toString().padLeft(2, '0')}",
        "worker_salary_daily": workerSalaryDaily == null ? null : workerSalaryDaily,
        "worker_online_regist": workerOnlineRegist == null ? null : workerOnlineRegist,
        "district_name": districtName == null ? null : districtName,
        "province_name": provinceName == null ? null : provinceName,
        "worker_age": workerAge == null ? null : workerAge,
        "worker_profile": workerProfile == null ? null : workerProfile,
        "worker_salary_formatted": workerSalaryFormatted == null ? null : workerSalaryFormatted,
        "wmore_stay_in": wmoreStayIn == null ? null : wmoreStayIn,
    };
}
