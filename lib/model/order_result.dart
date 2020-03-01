// To parse this JSON data, do
//
//     final orderResult = orderResultFromJson(jsonString);

import 'dart:convert';

OrderResult orderResultFromJson(String str) => OrderResult.fromJson(json.decode(str));

String orderResultToJson(OrderResult data) => json.encode(data.toJson());

class OrderResult {
    String transId;
    String message;

    OrderResult({
        this.transId,
        this.message,
    });

    factory OrderResult.fromJson(Map<String, dynamic> json) => OrderResult(
        transId: json["transId"] == null ? null : json["transId"],
        message: json["message"] == null ? null : json["message"],
    );

    Map<String, dynamic> toJson() => {
        "transId": transId == null ? null : transId,
        "message": message == null ? null : message,
    };
}
