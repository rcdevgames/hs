import 'package:flutter/foundation.dart';
import 'package:housesolutions/model/complaint.dart';
import 'package:housesolutions/model/complaint_category.dart';
import 'package:housesolutions/model/complant_single.dart';
import 'package:housesolutions/util/api.dart';

class ComplaintProvider {
  Future<List<Complaint>> fetchComplaints() async {
    final response = await api.get("/complaint_list", auth: true);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return compute(complaintFromJson, api.getContent(response.body));
    } else if(response.statusCode == 401) {
      throw Exception("Unauthorized");
    } else {
      throw Exception(api.getContent(response.body));
    }
  }
  Future<ComplaintSingle> getComplaint(int id) async {
    final response = await api.get("/complaint_list", auth: true, endpoint: id.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      return compute(complaintSingleFromJson, api.getContent(response.body));
    } else if(response.statusCode == 401) {
      throw Exception("Unauthorized");
    } else {
      throw Exception(api.getContent(response.body));
    }
  }
  Future<List<ComplaintCategory>> fetchComplaintCategories() async {
    final response = await api.get("/complaint_cat", auth: true);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return compute(complaintCategoryFromJson, api.getContent(response.body));
    } else if(response.statusCode == 401) {
      throw Exception("Unauthorized");
    } else {
      throw Exception(api.getContent(response.body));
    }
  }
  Future createComplaint(int id_category, String title, String message) async {
    final response = await api.post("/complaint", auth: true, body: {
      "id_ccat" : id_category,
      "complaint_title" : title,
      "complaint_content" : message
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      return api.getContent(response.body);
    } else if(response.statusCode == 401) {
      throw Exception("Unauthorized");
    } else {
      throw Exception(api.getContent(response.body));
    }
  }
  Future replyComplaint(int id_complaint, String message) async{
    final response = await api.post("/complaint_reply", auth: true, body: {
      "id_complaint" : id_complaint,
	    "complaint_content" : message
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      return api.getContent(response.body);
    } else if(response.statusCode == 401) {
      throw Exception("Unauthorized");
    } else {
      throw Exception(api.getContent(response.body));
    }
  }
}