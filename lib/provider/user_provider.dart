import 'package:flutter/foundation.dart';
import 'package:housesolutions/model/user_model.dart';
import 'package:housesolutions/util/api.dart';

class UserProvider {
  Future<User> getCustomer() async {
    final response = await api.get("/me", auth: true);

    if (response.statusCode == 200) {
      print(response.body);
      return compute(userFromJson, api.getContent(response.body));
    } else if(response.statusCode == 401) {
      throw Exception("Unauthorized");
    } else {
      throw Exception(api.getContent(response.body));
    }
  }

  Future<String> updateProfile(int idProvince, int idDistrict, String name, String email, String handphone, String address, String image) async {
    Map<String, dynamic> body_post = {};
    if(idProvince != null) body_post["id_province"] = idProvince;
    if(idDistrict != null) body_post["id_district"] = idDistrict;
    if(name != null) body_post["customer_name"] = name;
    if(handphone != null) body_post["customer_handphone"] = handphone;
    if(address != null) body_post["customer_address"] = address;
    if(image != null) body_post["customer_image"] = image;

    final response = await api.post("/customer/profile", auth: true, body: body_post);

    if (response.statusCode == 200 || response.statusCode == 201) { 
      return api.getContent(response.body);
    } else if(response.statusCode == 401) {
      throw Exception("Unauthorized");
    } else {
      throw Exception(api.getContent(response.body));
    }
  }
}