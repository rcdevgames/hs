import 'package:flutter/foundation.dart';
import 'package:housesolutions/model/category.dart';
import 'package:housesolutions/util/api.dart';

class CategoryProvider {
  Future<List<Categories>> fetchCategory() async {
    final response = await api.get("/getCategory");

    if (response.statusCode == 200) {
      return compute(categoriesFromJson, api.getContent(response.body));
    } else {
      throw Exception(api.getContent(response.body));
    }
  }
}