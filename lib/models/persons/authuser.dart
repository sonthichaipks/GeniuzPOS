// To parse this JSON data, do
//
//     final authUser = authUserFromJson(jsonString);

import 'dart:convert';

AuthUser authUserFromJson(String str) => AuthUser.fromJson(json.decode(str));

String authUserToJson(AuthUser data) => json.encode(data.toJson());

class AuthUser {
    AuthUser({
        this.id,
        this.firstName,
        this.lastName,
        this.username,
        this.jwtToken,
    });

    int id;
    String firstName;
    String lastName;
    String username;
    String jwtToken;

    factory AuthUser.fromJson(Map<String, dynamic> json) => AuthUser(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        username: json["username"],
        jwtToken: json["jwtToken"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "username": username,
        "jwtToken": jwtToken,
    };
}
