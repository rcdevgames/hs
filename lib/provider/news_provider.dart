import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:housesolutions/model/category_news_model.dart';
import 'package:housesolutions/model/news_model.dart';
import 'package:housesolutions/model/category_news_model.dart';
import 'package:housesolutions/model/news_detail_model.dart';
import 'package:housesolutions/model/news_model.dart';
import 'package:housesolutions/util/api.dart';
import 'package:housesolutions/util/session.dart';

class NewsProvider {
  Future<List<CategoryNews>> fetchCategoryNews() async {
    final response = await api.get("/worker/article_category", auth: true);

    if (response.statusCode == 200 || response.statusCode == 201) {
      String data = jsonEncode(jsonDecode(response.body)['message']);
      return compute(categoryNewsFromJson, data);
    }else if(response.statusCode == 401) {
      throw Exception("Unauthorized");
    }else {
      var error = jsonDecode(response.body) as Map<String, dynamic>;
      throw Exception(error['message']);
    }
  }

  Future<List<News>> fetchNews(int id, int page) async {
    final response = await api.post("/worker/articles", auth: true, body: {
      "id_category": id, 
      "limit": 5,
      "page": page
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      String data = jsonEncode(jsonDecode(response.body)['message']);
      return compute(newsFromJson, data);
    }else if(response.statusCode == 401) {
      throw Exception("Unauthorized");
    }else {
      var error = jsonDecode(response.body) as Map<String, dynamic>;
      throw Exception(error['message']);
    }
  }

  Future<NewsDetail> getDetailNews(String slug) async {
    final response = await api.get("/worker/article/$slug", auth: true);

    if (response.statusCode == 200 || response.statusCode == 201) {
      String data = jsonEncode(jsonDecode(response.body)['message']);
      return compute(newsDetailFromJson, data);
    }else if(response.statusCode == 401) {
      throw Exception("Unauthorized");
    }else {
      var error = jsonDecode(response.body) as Map<String, dynamic>;
      throw Exception(error['message']);
    }
  }
  
  Future<String> doComment(int id, String message) async {
    final response = await api.post("/worker/add_comment", auth: true, body: {
      "id_news": id, 
      "ncomment_content": message
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

  Future<String> doSubComment(int id, int idComment, String message) async {
    final response = await api.post("/worker/add_subcomment", auth: true, body: {
      "id_news": id, 
      "id_ncomment": idComment,
      "scomment_content": message
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