// To parse this JSON data, do
//
//     final categoryNews = categoryNewsFromJson(jsonString);

import 'dart:convert';

List<CategoryNews> categoryNewsFromJson(String str) => List<CategoryNews>.from(json.decode(str).map((x) => CategoryNews.fromJson(x)));

String categoryNewsToJson(List<CategoryNews> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryNews {
    String idCategory;
    String categoryTitle;
    String categoryDesc;
    String categoryImage;

    CategoryNews({
        this.idCategory,
        this.categoryTitle,
        this.categoryDesc,
        this.categoryImage,
    });

    factory CategoryNews.fromJson(Map<String, dynamic> json) => CategoryNews(
        idCategory: json["id_category"] == null ? null : json["id_category"],
        categoryTitle: json["category_title"] == null ? null : json["category_title"],
        categoryDesc: json["category_desc"] == null ? null : json["category_desc"],
        categoryImage: json["category_image"] == null ? null : json["category_image"],
    );

    Map<String, dynamic> toJson() => {
        "id_category": idCategory == null ? null : idCategory,
        "category_title": categoryTitle == null ? null : categoryTitle,
        "category_desc": categoryDesc == null ? null : categoryDesc,
        "category_image": categoryImage == null ? null : categoryImage,
    };
}
