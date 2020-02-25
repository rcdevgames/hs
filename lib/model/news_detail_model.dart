// To parse this JSON data, do
//
//     final newsDetail = newsDetailFromJson(jsonString);

import 'dart:convert';

NewsDetail newsDetailFromJson(String str) => NewsDetail.fromJson(json.decode(str));

String newsDetailToJson(NewsDetail data) => json.encode(data.toJson());

class NewsDetail {
    String idNews;
    String idCategory;
    String idUser;
    String newsTitle;
    String newsSlug;
    String newsBanner;
    String newsContent;
    String newsYoutube;
    String newsLang;
    String newsPublish;
    String newsHide;
    DateTime newsCreated;
    DateTime newsUpdated;
    String userFullname;
    String userPhoto;
    String userBio;
    String categoryTitle;
    List<Comment> comments;

    NewsDetail({
        this.idNews,
        this.idCategory,
        this.idUser,
        this.newsTitle,
        this.newsSlug,
        this.newsBanner,
        this.newsContent,
        this.newsYoutube,
        this.newsLang,
        this.newsPublish,
        this.newsHide,
        this.newsCreated,
        this.newsUpdated,
        this.userFullname,
        this.userPhoto,
        this.userBio,
        this.categoryTitle,
        this.comments,
    });

    factory NewsDetail.fromJson(Map<String, dynamic> json) => NewsDetail(
        idNews: json["id_news"] == null ? null : json["id_news"],
        idCategory: json["id_category"] == null ? null : json["id_category"],
        idUser: json["id_user"] == null ? null : json["id_user"],
        newsTitle: json["news_title"] == null ? null : json["news_title"],
        newsSlug: json["news_slug"] == null ? null : json["news_slug"],
        newsBanner: json["news_banner"] == null ? null : json["news_banner"],
        newsContent: json["news_content"] == null ? null : json["news_content"],
        newsYoutube: json["news_youtube"] == null ? null : json["news_youtube"],
        newsLang: json["news_lang"] == null ? null : json["news_lang"],
        newsPublish: json["news_publish"] == null ? null : json["news_publish"],
        newsHide: json["news_hide"] == null ? null : json["news_hide"],
        newsCreated: json["news_created"] == null ? null : DateTime.parse(json["news_created"]),
        newsUpdated: json["news_updated"] == null ? null : DateTime.parse(json["news_updated"]),
        userFullname: json["user_fullname"] == null ? null : json["user_fullname"],
        userPhoto: json["user_photo"] == null ? null : json["user_photo"],
        userBio: json["user_bio"] == null ? null : json["user_bio"],
        categoryTitle: json["category_title"] == null ? null : json["category_title"],
        comments: json["comments"] == null ? null : List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id_news": idNews == null ? null : idNews,
        "id_category": idCategory == null ? null : idCategory,
        "id_user": idUser == null ? null : idUser,
        "news_title": newsTitle == null ? null : newsTitle,
        "news_slug": newsSlug == null ? null : newsSlug,
        "news_banner": newsBanner == null ? null : newsBanner,
        "news_content": newsContent == null ? null : newsContent,
        "news_youtube": newsYoutube == null ? null : newsYoutube,
        "news_lang": newsLang == null ? null : newsLang,
        "news_publish": newsPublish == null ? null : newsPublish,
        "news_hide": newsHide == null ? null : newsHide,
        "news_created": newsCreated == null ? null : newsCreated.toIso8601String(),
        "news_updated": newsUpdated == null ? null : newsUpdated.toIso8601String(),
        "user_fullname": userFullname == null ? null : userFullname,
        "user_photo": userPhoto == null ? null : userPhoto,
        "user_bio": userBio == null ? null : userBio,
        "category_title": categoryTitle == null ? null : categoryTitle,
        "comments": comments == null ? null : List<dynamic>.from(comments.map((x) => x.toJson())),
    };
}

class Comment {
    String idNcomment;
    String idNews;
    String id;
    String ncommentType;
    String ncommentName;
    String ncommentPhoto;
    String ncommentContent;
    String ncommentPublish;
    String ncommentHide;
    DateTime ncommentCreated;
    List<SubComment> subComment;

    Comment({
        this.idNcomment,
        this.idNews,
        this.id,
        this.ncommentType,
        this.ncommentName,
        this.ncommentPhoto,
        this.ncommentContent,
        this.ncommentPublish,
        this.ncommentHide,
        this.ncommentCreated,
        this.subComment,
    });

    factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        idNcomment: json["id_ncomment"] == null ? null : json["id_ncomment"],
        idNews: json["id_news"] == null ? null : json["id_news"],
        id: json["id_"] == null ? null : json["id_"],
        ncommentType: json["ncomment_type"] == null ? null : json["ncomment_type"],
        ncommentName: json["ncomment_name"] == null ? null : json["ncomment_name"],
        ncommentPhoto: json["ncomment_photo"] == null ? null : json["ncomment_photo"],
        ncommentContent: json["ncomment_content"] == null ? null : json["ncomment_content"],
        ncommentPublish: json["ncomment_publish"] == null ? null : json["ncomment_publish"],
        ncommentHide: json["ncomment_hide"] == null ? null : json["ncomment_hide"],
        ncommentCreated: json["ncomment_created"] == null ? null : DateTime.parse(json["ncomment_created"]),
        subComment: json["sub_comment"] == null ? null : List<SubComment>.from(json["sub_comment"].map((x) => SubComment.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id_ncomment": idNcomment == null ? null : idNcomment,
        "id_news": idNews == null ? null : idNews,
        "id_": id == null ? null : id,
        "ncomment_type": ncommentType == null ? null : ncommentType,
        "ncomment_name": ncommentName == null ? null : ncommentName,
        "ncomment_photo": ncommentPhoto == null ? null : ncommentPhoto,
        "ncomment_content": ncommentContent == null ? null : ncommentContent,
        "ncomment_publish": ncommentPublish == null ? null : ncommentPublish,
        "ncomment_hide": ncommentHide == null ? null : ncommentHide,
        "ncomment_created": ncommentCreated == null ? null : ncommentCreated.toIso8601String(),
        "sub_comment": subComment == null ? null : List<dynamic>.from(subComment.map((x) => x.toJson())),
    };
}

class SubComment {
    String idScomment;
    String idNcomment;
    String idNews;
    String id;
    String scommentType;
    String scommentName;
    String scommentPhoto;
    String scommentContent;
    String scommentPublish;
    String scommentHide;
    DateTime scommentCreated;

    SubComment({
        this.idScomment,
        this.idNcomment,
        this.idNews,
        this.id,
        this.scommentType,
        this.scommentName,
        this.scommentPhoto,
        this.scommentContent,
        this.scommentPublish,
        this.scommentHide,
        this.scommentCreated,
    });

    factory SubComment.fromJson(Map<String, dynamic> json) => SubComment(
        idScomment: json["id_scomment"] == null ? null : json["id_scomment"],
        idNcomment: json["id_ncomment"] == null ? null : json["id_ncomment"],
        idNews: json["id_news"] == null ? null : json["id_news"],
        id: json["id_"] == null ? null : json["id_"],
        scommentType: json["scomment_type"] == null ? null : json["scomment_type"],
        scommentName: json["scomment_name"] == null ? null : json["scomment_name"],
        scommentPhoto: json["scomment_photo"] == null ? null : json["scomment_photo"],
        scommentContent: json["scomment_content"] == null ? null : json["scomment_content"],
        scommentPublish: json["scomment_publish"] == null ? null : json["scomment_publish"],
        scommentHide: json["scomment_hide"] == null ? null : json["scomment_hide"],
        scommentCreated: json["scomment_created"] == null ? null : DateTime.parse(json["scomment_created"]),
    );

    Map<String, dynamic> toJson() => {
        "id_scomment": idScomment == null ? null : idScomment,
        "id_ncomment": idNcomment == null ? null : idNcomment,
        "id_news": idNews == null ? null : idNews,
        "id_": id == null ? null : id,
        "scomment_type": scommentType == null ? null : scommentType,
        "scomment_name": scommentName == null ? null : scommentName,
        "scomment_photo": scommentPhoto == null ? null : scommentPhoto,
        "scomment_content": scommentContent == null ? null : scommentContent,
        "scomment_publish": scommentPublish == null ? null : scommentPublish,
        "scomment_hide": scommentHide == null ? null : scommentHide,
        "scomment_created": scommentCreated == null ? null : scommentCreated.toIso8601String(),
    };
}
