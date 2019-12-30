import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:housesolutions/model/search_worker.dart';
import 'package:housesolutions/model/worker.dart';
import 'package:housesolutions/util/api.dart';

class ProductProvider {
  Future<SearchWorker> fetchSearchWorkers(int idCategory, int idProvince, int idDistrict, int page, int startSalary, int endSalary, num startRating, num endRating, String stayIn, String regular) async {
    final response = await api.post("search_v2", ver: "", auth: true, body: {
      "id_category" : idCategory == null ? "all":idCategory,
      "id_province" : idProvince == null ? "all":idProvince,
      "id_district" : idDistrict == null ? []:[idDistrict],
      "salary_from" : startSalary,
      "salary_until" : endSalary,
      "rating_from" : startRating,
      "rating_until" : endRating,
      "stay_in" : stayIn,
	    "regular" : regular,
      "page" : page,
      "limit" : 10
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (jsonDecode(response.body)['message'] is List<dynamic>) {
        return compute(searchWorkerFromJson, jsonEncode(SearchWorker.fromJson({
          "page": 1,
          "limit": 10,
          "paging": 1,
          "data": []
        })));
      }else if(response.statusCode == 401) {
        throw Exception("Unauthorized");
      }
      return compute(searchWorkerFromJson, api.getContent(response.body));
    } else {
      throw Exception(api.getContent(response.body));
    }
  }

  Future<Worker> getWorker(int idWorker) async {
    final response = await api.get("/customer/worker/$idWorker", auth: true);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return compute(workerFromJson, api.getContent(response.body));
    }else if(response.statusCode == 401) {
      throw Exception("Unauthorized");
    } else {
      throw Exception(api.getContent(response.body));
    }
  }
}