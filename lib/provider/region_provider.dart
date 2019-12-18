import 'package:flutter/foundation.dart';
import 'package:housesolutions/model/district.dart';
import 'package:housesolutions/model/province.dart';
import 'package:housesolutions/util/all_translation.dart';
import 'package:housesolutions/util/api.dart';

class RegionProvider {
  Future<List<Province>> fetchProvince() async {
    final response = await api.get("/getProvince?lang=${allTranslations.currentLanguage}");

    if (response.statusCode == 200) {
      print(response.body);
      return compute(provinceFromJson, response.body);
    } else {
      throw Exception(api.getContent(response.body));
    }
  }

  Future<List<District>> fetchDistrict(num idProvince) async {
    final response = await api.get("/getDistrict/$idProvince?lang=${allTranslations.currentLanguage}");

    if (response.statusCode == 200) {
      print(response.body);
      return compute(districtFromJson, response.body);
    } else {
      throw Exception(api.getContent(response.body));
    }
  }
}