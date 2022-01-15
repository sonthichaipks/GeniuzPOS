// To parse this JSON data, do
//
//     final salesman = salesmanFromJson(jsonString);

import 'dart:convert';

List<Salesman> salesmanFromJson(String str) =>
    List<Salesman>.from(json.decode(str).map((x) => Salesman.fromJson(x)));

String salesmanToJson(List<Salesman> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Salesman {
  Salesman({
    this.id,
    this.salesmanId,
    this.salesmanGroup,
    this.salesmanName,
    this.createBy,
    this.createDate,
    this.updateBy,
    this.lastUpdate,
  });

  int id;
  String salesmanId;
  String salesmanGroup;
  String salesmanName;
  String createBy;
  DateTime createDate;
  String updateBy;
  DateTime lastUpdate;

  factory Salesman.fromJson(Map<String, dynamic> json) => Salesman(
        id: json["id"],
        salesmanId: json["salesmanId"],
        salesmanGroup: json["salesmanGroup"],
        salesmanName: json["salesmanName"],
        createBy: json["createBy"],
        createDate: DateTime.parse(json["createDate"]),
        updateBy: json["updateBy"],
        lastUpdate: DateTime.parse(json["lastUpdate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "salesmanId": salesmanId,
        "salesmanGroup": salesmanGroup,
        "salesmanName": salesmanName,
        "createBy": createBy,
        "createDate": createDate.toIso8601String(),
        "updateBy": updateBy,
        "lastUpdate": lastUpdate.toIso8601String(),
      };
}
