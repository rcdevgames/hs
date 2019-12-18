import 'dart:convert';

import 'package:housesolutions/util/api.dart';

class ConfigProvider {
  Future<String> getTNC() async {
    final response = await api.get("/config");

    if (response.statusCode == 200) {
      final Map<String, dynamic> result = jsonDecode(response.body)['message'];
      return result.containsKey("config_term_condition") ? result["config_term_condition"]:null;
    } else {
      throw Exception(api.getContent(response.body));
    }
  }
  Future<String> getPaymentInstruction() async {
    final response = await api.get("/config");

    if (response.statusCode == 200) {
      final Map<String, dynamic> result = jsonDecode(response.body)['message'];
      return result.containsKey("config_how_to_pay") ? result["config_how_to_pay"]:null;
    } else {
      throw Exception(api.getContent(response.body));
    }
  }
}