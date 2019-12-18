import 'package:flutter/foundation.dart';
import 'package:housesolutions/model/promote.dart';
import 'package:housesolutions/util/api.dart';

class PromoteProvider {
  Future<List<Promote>> fetchPromote() async {
    final response = await api.get("/getPromote");

    if (response.statusCode == 200) {
      return compute(promoteFromJson, api.getContent(response.body));
    } else {
      throw Exception(api.getContent(response.body));
    }
  }
}