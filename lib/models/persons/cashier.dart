// To parse this JSON data, do
//
//     final authUser = authUserFromJson(jsonString);

import 'dart:convert';

Cashier cashierFromJson(String str) => Cashier.fromJson(json.decode(str));

String cashierToJson(Cashier data) => json.encode(data.toJson());

class Cashier {
  Cashier({
    this.cashierId,
    this.cashierName,
    this.cashierPassword,
    this.cashierLevel,
  });

  String cashierId;
  String cashierName;
  String cashierPassword;
  int cashierLevel;

  factory Cashier.fromJson(Map<String, dynamic> json) => Cashier(
        cashierId: json["cashierId"],
        cashierName: json["cashierName"],
        cashierPassword: json["cashierPassword"],
        cashierLevel: json["cashierLevel"].toInt(),
      );

  Map<String, dynamic> toJson() => {
        "cashierId": cashierId,
        "cashierName": cashierName,
        "cashierPassword": cashierPassword,
        "cashierLevel": cashierLevel,
      };
}
