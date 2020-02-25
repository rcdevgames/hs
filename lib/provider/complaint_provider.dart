import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:housesolutions/model/category_complaint_model.dart';
import 'package:housesolutions/model/complaint_model.dart';
import 'package:housesolutions/util/api.dart';
import 'package:housesolutions/util/session.dart';

class ComplaintProvider {
  Future<List<ComplaintCategory>> fetchComplaintCategory() async {
    final response = await api.get("/complaint_cat", auth: true);

    if (response.statusCode == 200 || response.statusCode == 201) {
      String data = jsonEncode(jsonDecode(response.body)['message']);
      return compute(complaintCategoryFromJson, data);
    }else if(response.statusCode == 401) {
      throw Exception("Unauthorized");
    }else {
      var error = jsonDecode(response.body) as Map<String, dynamic>;
      throw Exception(error['message']);
    }
  }

  Future<List<Complaints>> fetchComplaint() async {
    final response = await api.get("/complaint_list", auth: true);

    if (response.statusCode == 200 || response.statusCode == 201) {
      String data = jsonEncode(jsonDecode(response.body)['message']);
      return compute(complaintsFromJson, data);
    }else if(response.statusCode == 401) {
      throw Exception("Unauthorized");
    }else {
      var error = jsonDecode(response.body) as Map<String, dynamic>;
      throw Exception(error['message']);
    }
  }

  Future<Complaints> getComplaint(int id) async {
    final response = await api.get("/complaint_list", auth: true, endpoints: "$id");

    if (response.statusCode == 200 || response.statusCode == 201) {
      String data = jsonEncode(jsonDecode(response.body)['message']);
      return compute(complaintFromJson, data);
    }else if(response.statusCode == 401) {
      throw Exception("Unauthorized");
    }else {
      var error = jsonDecode(response.body) as Map<String, dynamic>;
      throw Exception(error['message']);
    }
  }

  Future<String> createComplaint(int id_category, String title, String message) async {
    final response = await api.post("/complaint", auth: true, body: {
      "id_ccat" : id_category,
      "complaint_title" : title,
      "complaint_content" : message
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      String data = jsonEncode(jsonDecode(response.body)['message']);
      return data;
    }else if(response.statusCode == 401) {
      throw Exception("Unauthorized");
    }else {
      var error = jsonDecode(response.body) as Map<String, dynamic>;
      throw Exception(error['message']);
    }
  }
  
  Future<String> replyComplaint(int id, String message) async {
    final response = await api.post("/complaint_reply", auth: true, body: {
      "id_complaint" : id,
	    "complaint_content" : message
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      String data = jsonEncode(jsonDecode(response.body)['message']);
      return data;
    }else if(response.statusCode == 401) {
      throw Exception("Unauthorized");
    }else {
      var error = jsonDecode(response.body) as Map<String, dynamic>;
      throw Exception(error['message']);
    }
  }
}