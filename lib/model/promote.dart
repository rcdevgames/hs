// To parse this JSON data, do
//
//     final promote = promoteFromJson(jsonString);

import 'dart:convert';

List<Promote> promoteFromJson(String str) => List<Promote>.from(json.decode(str).map((x) => Promote.fromJson(x)));

String promoteToJson(List<Promote> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Promote {
    int idPromote;
    String promoteTitle;
    String promoteBanner;
    String promoteContent;
    String promoteCreated;

    Promote({
        this.idPromote,
        this.promoteTitle,
        this.promoteBanner,
        this.promoteContent,
        this.promoteCreated,
    });

    factory Promote.fromJson(Map<String, dynamic> json) => Promote(
        idPromote: json["id_promote"],
        promoteTitle: json["promote_title"],
        promoteBanner: json["promote_banner"],
        promoteContent: json["promote_content"],
        promoteCreated: json["promote_created"],
    );

    Map<String, dynamic> toJson() => {
        "id_promote": idPromote,
        "promote_title": promoteTitle,
        "promote_banner": promoteBanner,
        "promote_content": promoteContent,
        "promote_created": promoteCreated,
    };
}
