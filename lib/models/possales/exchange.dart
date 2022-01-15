// To parse this JSON data, do
//
//     final vexchange = vexchangeFromJson(jsonString);

import 'dart:convert';

List<Vexchange> vexchangeFromJson(String str) =>
    List<Vexchange>.from(json.decode(str).map((x) => Vexchange.fromJson(x)));

String vexchangeToJson(List<Vexchange> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Vexchange {
  Vexchange({
    this.id,
    this.currencyCode,
    this.currencyName,
    this.effectiveDate,
    this.exchangeRate,
  });

  int id;
  String currencyCode;
  String currencyName;
  DateTime effectiveDate;
  double exchangeRate;

  factory Vexchange.fromJson(Map<String, dynamic> json) => Vexchange(
        id: json["id"],
        currencyCode: json["currencyCode"],
        currencyName: json["currencyName"],
        effectiveDate: DateTime.parse(json["effectiveDate"]),
        exchangeRate: json["exchangeRate"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "currencyCode": currencyCode,
        "currencyName": currencyName,
        "effectiveDate": effectiveDate.toIso8601String(),
        "exchangeRate": exchangeRate,
      };
}
