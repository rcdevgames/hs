import 'package:flutter/foundation.dart' as prefix0;
import 'package:housesolutions/model/bank.dart';
import 'package:housesolutions/model/my_worker.dart';
import 'package:housesolutions/model/order_result.dart';
import 'package:housesolutions/model/own_worker.dart';
import 'package:housesolutions/model/payment.dart';
import 'package:housesolutions/model/payment_detail.dart';
import 'package:housesolutions/model/summary.dart';
import 'package:housesolutions/model/transaction.dart';
import 'package:housesolutions/util/api.dart';

class OrderProvider {
  Future<Summary> getSummary() async {
    final response = await api.get("/customer/summary_v2", auth: true);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return prefix0.compute(summaryFromJson, api.getContent(response.body));
    } else if(response.statusCode == 401) {
      throw Exception("Unauthorized");
    } else {
      throw Exception(api.getContent(response.body));
    }
  }

  Future<List<Payment>> fetchPayment() async {
    final response = await api.get("/customer/listRequest_v2", auth: true);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return prefix0.compute(paymentFromJson, api.getContent(response.body));
    } else if(response.statusCode == 401) {
      throw Exception("Unauthorized");
    }else{
      throw Exception(api.getContent(response.body));
    }
  }
  Future<PaymentDetail> getPayment(int id) async {
    final response = await api.get("/customer/listRequest_v2", endpoint: id.toString(), auth: true);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return prefix0.compute(paymentDetailFromJson, api.getContent(response.body));
    } else if(response.statusCode == 401) {
      throw Exception("Unauthorized");
    }else{
      throw Exception(api.getContent(response.body));
    }
  }

  Future<List<OwnWorkers>> fetchMyWorkers() async {
    final response = await api.get("/customer/listWorker_v2", auth: true);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return prefix0.compute(ownWorkersFromJson, api.getContent(response.body));
    } else if(response.statusCode == 401) {
      throw Exception("Unauthorized");
    } else {
      throw Exception(api.getContent(response.body));
    }
  }

  Future<MyWorker> getMyWorker(int id) async {
    final response = await api.get("/customer/listWorker_v2", endpoint: id.toString(), auth: true);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return prefix0.compute(myWorkerFromJson, api.getContent(response.body));
    } else if(response.statusCode == 401) {
      throw Exception("Unauthorized");
    } else {
      throw Exception(api.getContent(response.body));
    }
  }

  Future<OrderResult> requestWorker(int idWorker, int idCategory, int total_day, String payment_method) async {
    final response = await api.post("/customer/requestPayment_v2", auth: true, body: {
      "id_worker" : idWorker,
      "id_category" : idCategory,
      "total_day": total_day,
      "trans_payment_method": payment_method
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      return prefix0.compute(orderResultFromJson, api.getContent(response.body));
    } else if(response.statusCode == 401) {
      throw Exception("Unauthorized");
    } else {
      throw Exception(api.getContent(response.body));
    }
  }

  Future<String> uploadApproval(int idTrans, String image64) async {
    final response = await api.post("/customer/uploadApprovement_v2", auth: true, body: {
      "id_trans" : idTrans,
      "image" : "data:image/jpeg;base64,$image64"
    });

    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return api.getContent(response.body);
    } else if(response.statusCode == 401) {
      throw Exception("Unauthorized");
    } else {
      throw Exception(api.getContent(response.body));
    }
  }

  Future<String> changeWorker(int idTrans, int idWorker, String reason) async {
    print({
      "id_trans" : idTrans,
      "id_worker" : idWorker,
      "reject_reason": reason
    });
    final response = await api.post("/customer/requestReject_v2", auth: true, body: {
      "id_trans" : idTrans,
      "id_worker" : idWorker,
      "reject_reason": reason
    });

    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return api.getContent(response.body);
    } else if(response.statusCode == 401) {
      throw Exception("Unauthorized");
    } else {
      throw Exception(api.getContent(response.body));
    }
  }

  Future<List<Transaction>> fetchWorkerOrder() async {
    final response = await api.get("/worker/booking_v2", auth: true);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return prefix0.compute(transactionFromJson, api.getContent(response.body));
    } else if(response.statusCode == 401) {
      throw Exception("Unauthorized");
    }else{
      throw Exception(api.getContent(response.body));
    }
  }

  Future<List<Bank>> fetchBank() async {
    final response = await api.get("/bank");

    if (response.statusCode == 200 || response.statusCode == 201) {
      return prefix0.compute(bankFromJson, api.getContent(response.body));
    } else if(response.statusCode == 401) {
      throw Exception("Unauthorized");
    } else {
      throw Exception(api.getContent(response.body));
    }
  }

  Future<String> setArrivedWorker(int idTrans) async {
    final response = await api.get("/customer/setArrived/$idTrans");
    if (response.statusCode == 200 || response.statusCode == 201) {
      return api.getContent(response.body);
    } else if(response.statusCode == 401) {
      throw Exception("Unauthorized");
    } else {
      throw Exception(api.getContent(response.body));
    }
  }
}