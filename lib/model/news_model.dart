// To parse this JSON data, do
//
//     final news = newsFromJson(jsonString);

import 'dart:convert';

List<News> newsFromJson(String str) => List<News>.from(json.decode(str).map((x) => News.fromJson(x)));

String newsToJson(List<News> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class News {
    String idNews;
    String idUser;
    String newsTitle;
    String newsSlug;
    String newsBanner;
    DateTime newsCreated;
    String userFullname;
    String categoryTitle;
    String viewed;

    News({
        this.idNews,
        this.idUser,
        this.newsTitle,
        this.newsSlug,
        this.newsBanner,
        this.newsCreated,
        this.userFullname,
        this.categoryTitle,
        this.viewed,
    });

    factory News.fromJson(Map<String, dynamic> json) => News(
        idNews: json["id_news"] == null ? null : json["id_news"],
        idUser: json["id_user"] == null ? null : json["id_user"],
        newsTitle: json["news_title"] == null ? null : json["news_title"],
        newsSlug: json["news_slug"] == null ? null : json["news_slug"],
        newsBanner: json["news_banner"] == null ? null : json["news_banner"],
        newsCreated: json["news_created"] == null ? null : DateTime.parse(json["news_created"]),
        userFullname: json["user_fullname"] == null ? null : json["user_fullname"],
        categoryTitle: json["category_title"] == null ? null : json["category_title"],
        viewed: json["viewed"] == null ? null : json["viewed"],
    );

    Map<String, dynamic> toJson() => {
        "id_news": idNews == null ? null : idNews,
        "id_user": idUser == null ? null : idUser,
        "news_title": newsTitle == null ? null : newsTitle,
        "news_slug": newsSlug == null ? null : newsSlug,
        "news_banner": newsBanner == null ? null : newsBanner,
        "news_created": newsCreated == null ? null : newsCreated.toIso8601String(),
        "user_fullname": userFullname == null ? null : userFullname,
        "category_title": categoryTitle == null ? null : categoryTitle,
        "viewed": viewed == null ? null : viewed,
    };
}
