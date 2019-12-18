// To parse this JSON data, do
//
//     final summary = summaryFromJson(jsonString);

import 'dart:convert';

Summary summaryFromJson(String str) => Summary.fromJson(json.decode(str));

String summaryToJson(Summary data) => json.encode(data.toJson());

class Summary {
    int countTrans;
    int attempt;
    int countWorker;
    List<DetailAttempt> detailAttempt;

    Summary({
        this.countTrans,
        this.attempt,
        this.countWorker,
        this.detailAttempt,
    });

    factory Summary.fromJson(Map<String, dynamic> json) => new Summary(
        countTrans: json["countTrans"],
        attempt: json["attempt"],
        countWorker: json["countWorker"],
        detailAttempt: new List<DetailAttempt>.from(json["detail_attempt"].map((x) => DetailAttempt.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "countTrans": countTrans,
        "attempt": attempt,
        "countWorker": countWorker,
        "detail_attempt": new List<dynamic>.from(detailAttempt.map((x) => x.toJson())),
    };
}

class DetailAttempt {
    int idCategory;
    String categoryDesc;
    int attempt;

    DetailAttempt({
        this.idCategory,
        this.categoryDesc,
        this.attempt,
    });

    factory DetailAttempt.fromJson(Map<String, dynamic> json) => new DetailAttempt(
        idCategory: json["id_category"],
        categoryDesc: json["category_desc"],
        attempt: json["attempt"],
    );

    Map<String, dynamic> toJson() => {
        "id_category": idCategory,
        "category_desc": categoryDesc,
        "attempt": attempt,
    };
}
