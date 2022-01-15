// To parse this JSON data, do
//
//     final vatExCluded = vatExCludedFromJson(jsonString);

import 'dart:convert';

List<VatExCluded> vatExCludedFromJson(String str) => List<VatExCluded>.from(
    json.decode(str).map((x) => VatExCluded.fromJson(x)));

String vatExCludedToJson(List<VatExCluded> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VatExCluded {
  VatExCluded({
    this.id,
    this.docNo,
    this.exSales,
    this.alloDisc,
    this.netSales,
    this.vatBillExClude,
    this.vatCharge,
  });

  int id;
  String docNo;
  double exSales;
  double alloDisc;
  double netSales;
  double vatBillExClude;
  double vatCharge;

  factory VatExCluded.fromJson(Map<String, dynamic> json) => VatExCluded(
        id: json["id"],
        docNo: json["docNo"],
        exSales: (json["exSales"] == null ? 0.0 : json["exSales"])
            as double, //.toDouble(),
        alloDisc: (json["alloDisc"] == null ? 0.0 : json["alloDisc"])
            as double, // json["AlloDisc"].toDouble(),
        netSales: (json["netSales"] == null ? 0.0 : json["netSales"])
            as double, //json["NetSales"].toDouble(),
        vatBillExClude:
            (json["vatBillExClude"] == null ? 0.0 : json["vatBillExClude"])
                as double, //json["VatBillExClude"].toDouble(),
        vatCharge: (json["vatCharge"] == null ? 0.0 : json["vatCharge"])
            as double, //json["VatCharge"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "docNo": docNo,
        "exSales": exSales,
        "alloDisc": alloDisc,
        "netSales": netSales,
        "vatBillExClude": vatBillExClude,
        "vatCharge": vatCharge,
      };
}
