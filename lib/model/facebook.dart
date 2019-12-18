// To parse this JSON data, do
//
//     final facebook = facebookFromJson(jsonString);

import 'dart:convert';

Facebook facebookFromJson(String str) => Facebook.fromJson(json.decode(str));

String facebookToJson(Facebook data) => json.encode(data.toJson());

class Facebook {
    String name;
    String firstName;
    String lastName;
    String email;
    String id;

    Facebook({
        this.name,
        this.firstName,
        this.lastName,
        this.email,
        this.id,
    });

    factory Facebook.fromJson(Map<String, dynamic> json) => new Facebook(
        name: json["name"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "id": id,
    };
}
