import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:housesolutions/model/job_inform_model.dart';
import 'package:housesolutions/util/api.dart';

class JobProvider {
  Future<List<JobInform>> fetchJobList() async {
    final response = await api.get("/customer/list_job", auth: true);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return compute(jobInformFromJson, api.getContent(response.body));
    }else if(response.statusCode == 401) {
      throw Exception("Unauthorized");
    }else {
      var error = jsonDecode(response.body) as Map<String, dynamic>;
      throw Exception(error['message']);
    }
  }

  Future<String> createJob(int id_category, String title, String desc, String placement) async {
    final response = await api.post("/customer/create_job", auth: true, body: {
      "id_category" : id_category,
      "job_title" : title,
      "job_desc" : desc,
      "job_placement" : placement
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      return api.getContent(response.body);
    }else if(response.statusCode == 401) {
      throw Exception("Unauthorized");
    }else {
      var error = jsonDecode(response.body) as Map<String, dynamic>;
      throw Exception(error['message']);
    }
  }

  Future<String> statusJob(int id, bool active) async {
    final response = await api.post("/customer/status_job", auth: true, body: {
      "id_job" : id,
      "job_status" : active ? "active":"not-active",
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      return api.getContent(response.body);
    }else if(response.statusCode == 401) {
      throw Exception("Unauthorized");
    }else {
      var error = jsonDecode(response.body) as Map<String, dynamic>;
      throw Exception(error['message']);
    }
  }
  
}