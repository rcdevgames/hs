// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'dart:convert';

List<Order> orderFromJson(String str) => new List<Order>.from(json.decode(str).map((x) => Order.fromJson(x)));

String orderToJson(List<Order> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class Order {
    int idOrder;
    int idCustomer;
    int idWorker;
    String orderNumber;
    String orderStatus;
    bool orderPaid;
    String createdAt;
    String ohistoryDesc;
    String workerName;
    String workerHandphone;
    String workerAddress;
    String provinceName;
    String districtName;
    String workerProfile;
    String categoryDesc;
    List<Detail> details;

    Order({
        this.idOrder,
        this.idCustomer,
        this.idWorker,
        this.orderNumber,
        this.orderStatus,
        this.orderPaid,
        this.createdAt,
        this.ohistoryDesc,
        this.workerName,
        this.workerHandphone,
        this.workerAddress,
        this.provinceName,
        this.districtName,
        this.workerProfile,
        this.categoryDesc,
        this.details,
    });

    factory Order.fromJson(Map<String, dynamic> json) => new Order(
        idOrder: json["id_order"],
        idCustomer: json["id_customer"],
        idWorker: json["id_worker"],
        orderNumber: json["order_number"],
        orderStatus: json["order_status"],
        orderPaid: json["order_paid"],
        createdAt: json["created_at"],
        ohistoryDesc: json["ohistory_desc"],
        workerName: json["worker_name"],
        workerHandphone: json["worker_handphone"],
        workerAddress: json["worker_address"],
        provinceName: json["province_name"],
        districtName: json["district_name"],
        workerProfile: json["worker_profile"],
        categoryDesc: json["category_desc"],
        details: new List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id_order": idOrder,
        "id_customer": idCustomer,
        "id_worker": idWorker,
        "order_number": orderNumber,
        "order_status": orderStatus,
        "order_paid": orderPaid,
        "created_at": createdAt,
        "ohistory_desc": ohistoryDesc,
        "worker_name": workerName,
        "worker_handphone": workerHandphone,
        "worker_address": workerAddress,
        "province_name": provinceName,
        "district_name": districtName,
        "worker_profile": workerProfile,
        "category_desc": categoryDesc,
        "details": new List<dynamic>.from(details.map((x) => x.toJson())),
    };
}

class Detail {
    String orderPrice;
    bool orderPaid;
    String orderDue;
    String orderPriceFormatted;
    String orderPaidAt;

    Detail({
        this.orderPrice,
        this.orderPaid,
        this.orderDue,
        this.orderPriceFormatted,
        this.orderPaidAt,
    });

    factory Detail.fromJson(Map<String, dynamic> json) => new Detail(
        orderPrice: json["order_price"],
        orderPaid: json["order_paid"],
        orderDue: json["order_due"],
        orderPriceFormatted: json["order_price_formatted"],
        orderPaidAt: json["order_paid_at"],
    );

    Map<String, dynamic> toJson() => {
        "order_price": orderPrice,
        "order_paid": orderPaid,
        "order_due": orderDue,
        "order_price_formatted": orderPriceFormatted,
        "order_paid_at": orderPaidAt,
    };
}
