// To parse this JSON data, do
//
//     final banners = bannersFromJson(jsonString);

import 'dart:convert';

List<Banners> bannersFromJson(String str) => List<Banners>.from(json.decode(str).map((x) => Banners.fromJson(x)));

String bannersToJson(List<Banners> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Banners {
    int idBanner;
    String bannerTitle;
    String bannerImage;
    String categoryDesc;
    String categorySlug;
    int idCategory;

    Banners({
        this.idBanner,
        this.bannerTitle,
        this.bannerImage,
        this.categoryDesc,
        this.categorySlug,
        this.idCategory,
    });

    factory Banners.fromJson(Map<String, dynamic> json) => Banners(
        idBanner: json["id_banner"],
        bannerTitle: json["banner_title"],
        bannerImage: json["banner_image"],
        categoryDesc: json["category_desc"] == null ? null : json["category_desc"],
        categorySlug: json["category_slug"] == null ? null : json["category_slug"],
        idCategory: json["id_category"] == null ? null : json["id_category"],
    );

    Map<String, dynamic> toJson() => {
        "id_banner": idBanner,
        "banner_title": bannerTitle,
        "banner_image": bannerImage,
        "category_desc": categoryDesc == null ? null : categoryDesc,
        "category_slug": categorySlug == null ? null : categorySlug,
        "id_category": idCategory == null ? null : idCategory,
    };
}
