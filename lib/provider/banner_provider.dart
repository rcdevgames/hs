import 'package:flutter/foundation.dart';
import 'package:housesolutions/model/banner.dart';
import 'package:housesolutions/util/api.dart';

class BannerProvider {
  Future<List<Banners>> fetchBanner() async {
    final response = await api.get("/getBanner");

    if (response.statusCode == 200) {
      return compute(bannersFromJson, api.getContent(response.body));
    } else {
      throw Exception(api.getContent(response.body));
    }
  }
}