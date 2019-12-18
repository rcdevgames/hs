// To parse this JSON data, do
//
//     final categories = categoriesFromJson(jsonString);

import 'dart:convert';

List<Categories> categoriesFromJson(String str) => new List<Categories>.from(json.decode(str).map((x) => Categories.fromJson(x)));

String categoriesToJson(List<Categories> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class Categories {
    int idCategory;
    int idPacket;
    String categoryDesc;
    String categoryImage;
    String categoryPos;
    String packetPrice;
    String packetDesc;
    String slug;

    Categories({
        this.idCategory,
        this.idPacket,
        this.categoryDesc,
        this.categoryImage,
        this.categoryPos,
        this.packetPrice,
        this.packetDesc,
        this.slug,
    });

    factory Categories.fromJson(Map<String, dynamic> json) => new Categories(
        idCategory: json["id_category"],
        idPacket: json["id_packet"],
        categoryDesc: json["category_desc"],
        categoryImage: json["category_image"],
        categoryPos: json["category_pos"],
        packetPrice: json["packet_price"],
        packetDesc: json["packet_desc"],
        slug: json["slug"],
    );

    Map<String, dynamic> toJson() => {
        "id_category": idCategory,
        "id_packet": idPacket,
        "category_desc": categoryDesc,
        "category_image": categoryImage,
        "category_pos": categoryPos,
        "packet_price": packetPrice,
        "packet_desc": packetDesc,
        "slug": slug,
    };
}
